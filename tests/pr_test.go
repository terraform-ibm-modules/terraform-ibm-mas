// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

// Use existing resource group
const resourceGroup = "masda-validation-testcasesrg"
const coreExampleDir = "examples/core"
const manageExampleDir = "examples/manage"

func setupOptions(t *testing.T, prefix string, dir string) *testhelper.TestOptions {
	options := testhelper.TestOptionsDefaultWithVars(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  dir,
		Prefix:        prefix,
		ResourceGroup: resourceGroup,
	})
	return options
}

func TestRunCoreExample(t *testing.T) {
	t.Parallel()
    // Verify ibmcloud_api_key variable is set
    checkVariable := "TF_VAR_ibmcloud_api_key"
    val, present := os.LookupEnv(checkVariable)
    require.True(t, present, checkVariable+" environment variable not set")
    require.NotEqual(t, "", val, checkVariable+" environment variable is empty")

	options := setupOptions(t, "maximo-core", coreExampleDir)

	output, err := options.RunTest()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunManageExample(t *testing.T) {
	t.Parallel()
    // Verify ibmcloud_api_key variable is set
    checkVariable := "TF_VAR_ibmcloud_api_key"
    val, present := os.LookupEnv(checkVariable)
    require.True(t, present, checkVariable+" environment variable not set")
    require.NotEqual(t, "", val, checkVariable+" environment variable is empty")

	options := setupOptions(t, "maximo-manage", manageExampleDir)

	output, err := options.RunTest()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}