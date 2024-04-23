// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/common"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const coreExampleDir = "examples/core"
const resourceGroup = "geretain-test-mas"

func setupOptions(t *testing.T, prefix string, dir string, terraformVars map[string]interface{}) *testhelper.TestOptions {

	options := testhelper.TestOptionsDefaultWithVars(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  dir,
		ResourceGroup: resourceGroup,
		Prefix:        prefix,
		TerraformVars: terraformVars,
	})
	requiredVariables := common.GetRequiredEnvVars(options.Testing, []string{"MAS_ENTITLEMENT_KEY", "MAS_LICENCE_FILE", "SLS_LICENCE_ID"})
	for k, v := range requiredVariables {
		options.RequiredEnvironmentVars[k] = v
	}

	options.TerraformVars["mas_entitlement_key"] = options.RequiredEnvironmentVars["MAS_ENTITLEMENT_KEY"]
	options.TerraformVars["mas_license"] = options.RequiredEnvironmentVars["MAS_LICENCE_FILE"]
	options.TerraformVars["sls_license_id"] = options.RequiredEnvironmentVars["SLS_LICENCE_ID"]

	return options
}

func TestRunCoreExample(t *testing.T) {
	t.Parallel()
	options := setupOptions(t, "maximo-core", coreExampleDir, nil)
	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "maximo-core-upg", coreExampleDir, nil)

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
