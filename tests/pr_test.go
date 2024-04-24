// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"fmt"
	"github.com/IBM/go-sdk-core/v5/core"
	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/common"
	"log"
	"os"
	"strings"
	"testing"

	"github.com/IBM/secrets-manager-go-sdk/v2/secretsmanagerv2"
	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const solutuionExistingCluster = "solutions/existing-cluster"
const resourceGroup = "geretain-test-mas"

// Define a struct with fields that match the structure of the YAML data
const yamlLocation = "../common-dev-assets/common-go-assets/common-permanent-resources.yaml"

var permanentResources map[string]interface{}

var defaultTFVars = map[string]interface{}{
	"deployment_flavour":           "core",
	"mas_instance_id":              "mas-inst",
	"region":                       "us-south",
	"uds_contact_email":            "test@ibm.com",
	"uds_contact_firstname":        "John",
	"uds_contact_lastname":         "Doe",
	"cluster_config_endpoint_type": "public",
}

// TestMain will be run before any parallel tests, used to read data from yaml for use with tests
func TestMain(m *testing.M) {

	var err error
	permanentResources, err = common.LoadMapFromYaml(yamlLocation)
	if err != nil {
		log.Fatal(err)
	}

	os.Exit(m.Run())
}

func setupOptions(t *testing.T, prefix string, dir string, terraformVars map[string]interface{}) (options *testhelper.TestOptions, preReqTfOptions *terraform.Options, err error) {

	options = &testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  dir,
		ResourceGroup: resourceGroup,
		Prefix:        fmt.Sprintf("%s-%s", prefix, strings.ToLower(random.UniqueId())),
		TerraformVars: terraformVars,
	}
	masEntitlementKey, masEntitlementKeyErr := GetSecretsManagerKey( // pragma: allowlist secret
		permanentResources["secretsManagerGuid"].(string),
		permanentResources["secretsManagerRegion"].(string),
		permanentResources["masEntitlementKeySecretId"].(string),
	)

	if !assert.NoError(t, masEntitlementKeyErr) {
		t.Error("TestProjectsFullTest Failed - mas_entitlement_key not found in secrets manager")
		panic(masEntitlementKeyErr)
	}

	masLicense, masLicenseKeyErr := GetSecretsManagerKey( // pragma: allowlist secret
		permanentResources["secretsManagerGuid"].(string),
		permanentResources["secretsManagerRegion"].(string),
		permanentResources["masLicenseSecretId"].(string),
	)
	if !assert.NoError(t, masLicenseKeyErr) {
		t.Error("TestProjectsFullTest Failed - mas_license not found in secrets manager")
		panic(masLicenseKeyErr)
	}

	slsLicenseId, masLicenseErr := GetSecretsManagerKey( // pragma: allowlist secret
		permanentResources["secretsManagerGuid"].(string),
		permanentResources["secretsManagerRegion"].(string),
		permanentResources["masSlsLicenseIdSecretId"].(string),
	)
	if !assert.NoError(t, masLicenseErr) {
		t.Error("TestProjectsFullTest Failed - sls_license_id not found in secrets manager")
		panic(masLicenseErr)
	}
	options.TerraformVars["mas_entitlement_key"] = masEntitlementKey
	options.TerraformVars["mas_license"] = masLicense
	options.TerraformVars["sls_license_id"] = slsLicenseId

	// Deploy Pre-requisite resources

	realTerraformDir := "./resources"
	tempTerraformDir, _ := files.CopyTerraformFolderToTemp(realTerraformDir, options.Prefix)

	// Verify ibmcloud_api_key variable is set
	checkVariable := "TF_VAR_ibmcloud_api_key"
	val, present := os.LookupEnv(checkVariable)
	require.True(t, present, checkVariable+" environment variable not set")
	require.NotEqual(t, "", val, checkVariable+" environment variable is empty")

	logger.Log(t, "Tempdir: ", tempTerraformDir)
	existingTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: tempTerraformDir,
		Vars: map[string]interface{}{
			"resource_group": resourceGroup,
			"prefix":         options.Prefix,
			"region":         defaultTFVars["region"],
		},
		// Set Upgrade to true to ensure latest version of providers and modules are used by terratest.
		// This is the same as setting the -upgrade=true flag with terraform.
		Upgrade: true,
	})

	terraform.WorkspaceSelectOrNew(t, existingTerraformOptions, prefix)
	_, existErr := terraform.InitAndApplyE(t, existingTerraformOptions)

	if existErr != nil {
		assert.True(t, existErr == nil, "Init and Apply of Pre-requisite resources failed")
		return nil, existingTerraformOptions, existErr
	}
	clusterId := terraform.Output(t, existingTerraformOptions, "cluster_id")
	options.TerraformVars["cluster_id"] = clusterId

	return options, existingTerraformOptions, nil
}

func TestRunDABasic(t *testing.T) {
	t.Parallel()
	options, preReqOptions, setupErr := setupOptions(t, "maximo-da", solutuionExistingCluster, defaultTFVars)
	if setupErr != nil {
		assert.True(t, setupErr == nil, "Setup DA basic failed")
		return
	}
	defer terraform.Destroy(t, preReqOptions)
	// Region is not required for DA
	delete(options.TerraformVars, "region")

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeDA(t *testing.T) {
	t.Parallel()
	t.Skip("Skipping upgrade test until solution is in the main branch")

	options, preReqOptions, setupErr := setupOptions(t, "maximo-da-upg", solutuionExistingCluster, defaultTFVars)
	if setupErr != nil {
		assert.True(t, setupErr == nil, "Setup Upgrade failed")
		return
	}
	defer terraform.Destroy(t, preReqOptions)

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}

func GetSecretsManagerKey(smId string, smRegion string, smKeyId string) (*string, error) {
	secretsManagerService, err := secretsmanagerv2.NewSecretsManagerV2(&secretsmanagerv2.SecretsManagerV2Options{
		URL: fmt.Sprintf("https://%s.%s.secrets-manager.appdomain.cloud", smId, smRegion),
		Authenticator: &core.IamAuthenticator{
			ApiKey: os.Getenv("TF_VAR_ibmcloud_api_key"),
		},
	})
	if err != nil {
		return nil, err
	}

	getSecretOptions := secretsManagerService.NewGetSecretOptions(
		smKeyId,
	)

	secret, _, err := secretsManagerService.GetSecret(getSecretOptions)
	if err != nil {
		return nil, err
	}
	return secret.(*secretsmanagerv2.ArbitrarySecret).Payload, nil
}
