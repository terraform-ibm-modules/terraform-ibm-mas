// Tests in this file are NOT run in the PR pipeline. They are run in the continuous testing pipeline along with the ones in pr_test.go
package test

import (
	"fmt"
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

func TestRunDACore(t *testing.T) {
	t.Parallel()
	options, preReqOptions, setupErr := setupOptions(t, "core", solutionExistingCluster, coreTFVars)
	if setupErr != nil {
		assert.True(t, setupErr == nil, "Setup DA core failed")
		return
	}

	defer func() {
		// Check if "DO_NOT_DESTROY_ON_FAILURE" is set
		envVal, _ := os.LookupEnv("DO_NOT_DESTROY_ON_FAILURE")

		// Do not destroy if tests failed and "DO_NOT_DESTROY_ON_FAILURE" is true
		if options.Testing.Failed() && strings.ToLower(envVal) == "true" {
			fmt.Println("Terratest failed. Debug the Test and delete resources manually.")
		} else {
			// Temp workaround for https://github.ibm.com/GoldenEye/issues/issues/10743
			address := fmt.Sprintf("module.landing_zone.module.landing_zone.module.cluster[\"%s-workload-cluster\"].ibm_container_vpc_worker_pool.pool[\"default\"]", options.Prefix)
			terraform.RunTerraformCommand(t, preReqOptions, "state", "rm", address)
			terraform.Destroy(t, preReqOptions)
		}
	}()

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")

	expectedOutputs := []string{"maximo_admin_url"}
	missingOutputs, outputErr := testhelper.ValidateTerraformOutputs(options.LastTestTerraformOutputs, expectedOutputs...)
	assert.Empty(t, outputErr, fmt.Sprintf("Missing expected outputs: %s", missingOutputs))
	assert.True(t, strings.HasPrefix(options.LastTestTerraformOutputs["maximo_admin_url"].(string), "https://admin.inst"), "maximo_admin_url should start with https://admin.inst")

}
