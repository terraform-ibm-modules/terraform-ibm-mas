<!-- Update the title -->
# Maximo Application Suite on Existing Red Hat OpenShift Cluster module

<!--
Update status and "latest release" badges:
  1. For the status options, see https://terraform-ibm-modules.github.io/documentation/#/badge-status
  2. Update the "latest release" badge to point to the correct module's repo. Replace "terraform-ibm-module-template" in two places.
-->
[![Incubating (Not yet consumable)](https://img.shields.io/badge/status-Incubating%20(Not%20yet%20consumable)-red)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-module-template?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-module-template/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

<!-- Add a description of module(s) in this repo -->
Use this module to install Maximo Application Suite on your existing Red Hat OpenShift Cluster.

For more information about the Maximo Application Suite refer to the official documentation avaiable [here](https://www.ibm.com/docs/en/mas-cd)


<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-mas](#terraform-ibm-mas)
* [Examples](./examples)
    * [Basic example](./examples/basic)
    * [Complete example](./examples/complete)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->


<!--
If this repo contains any reference architectures, uncomment the heading below and links to them.
(Usually in the `/reference-architectures` directory.)
See "Reference architecture" in Authoring Guidelines in the public documentation at
https://terraform-ibm-modules.github.io/documentation/#/implementation-guidelines?id=reference-architecture
-->
<!-- ## Reference architectures -->


<!-- This heading should always match the name of the root level module (aka the repo name) -->
## terraform-ibm-mas

### Usage

<!--
Add an example of the use of the module in the following code block.

Use real values instead of "var.<var_name>" or other placeholder values
unless real values don't help users know what to change.
-->

```hcl

```

### Required IAM access policies

<!-- PERMISSIONS REQUIRED TO RUN MODULE
If this module requires permissions, uncomment the following block and update
the sample permissions, following the format.
Replace the sample Account and IBM Cloud service names and roles with the
information in the console at
Manage > Access (IAM) > Access groups > Access policies.
-->

<!--
You need the following permissions to run this module.

- Account Management
    - **Sample Account Service** service
        - `Editor` platform access
        - `Manager` service access
    - IAM Services
        - **Sample Cloud Service** service
            - `Administrator` platform access
-->

<!-- NO PERMISSIONS FOR MODULE
If no permissions are required for the module, uncomment the following
statement instead the previous block.
-->

<!-- No permissions are needed to run this module.-->


<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, <1.7.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | >=2.2.3, <3.0.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.8.0, <3.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.59.0, < 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.16.1, <3.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.1, < 1.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [helm_release.maximo_helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [time_sleep.wait_500_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [external_external.install_verify](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.maximo_admin_url](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [ibm_container_cluster_config.cluster_config](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/data-sources/container_cluster_config) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_config_endpoint_type"></a> [cluster\_config\_endpoint\_type](#input\_cluster\_config\_endpoint\_type) | Specify which type of endpoint to use for for cluster config access: 'default', 'private', 'vpe', 'link'. 'default' value will use the default endpoint of the cluster. | `string` | `"default"` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | Id of the target IBM Cloud OpenShift Cluster | `string` | n/a | yes |
| <a name="input_deployment_flavour"></a> [deployment\_flavour](#input\_deployment\_flavour) | Enter core for MAS Core deployment and enter manage for MAS Core+Manage deployment | `string` | n/a | yes |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | APIkey that's associated with the account to use | `string` | n/a | yes |
| <a name="input_mas_entitlement_key"></a> [mas\_entitlement\_key](#input\_mas\_entitlement\_key) | Entitlement key to access MAS Image registry | `string` | n/a | yes |
| <a name="input_mas_instance_id"></a> [mas\_instance\_id](#input\_mas\_instance\_id) | Enter the MAS instance Id | `string` | n/a | yes |
| <a name="input_mas_license"></a> [mas\_license](#input\_mas\_license) | MAS License file content | `string` | n/a | yes |
| <a name="input_mas_workspace_id"></a> [mas\_workspace\_id](#input\_mas\_workspace\_id) | Enter the workspace Id | `string` | `"wrkid1"` | no |
| <a name="input_mas_workspace_name"></a> [mas\_workspace\_name](#input\_mas\_workspace\_name) | Enter the workspace name | `string` | `"wrkns1"` | no |
| <a name="input_pipeline_storage_class"></a> [pipeline\_storage\_class](#input\_pipeline\_storage\_class) | Enter the storage class for pipeline | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region of the target IBM Cloud OpenShift Cluster | `string` | n/a | yes |
| <a name="input_sls_license_id"></a> [sls\_license\_id](#input\_sls\_license\_id) | Enter the SLS license ID | `string` | n/a | yes |
| <a name="input_storage_class_rwo"></a> [storage\_class\_rwo](#input\_storage\_class\_rwo) | Enter the storage class (read-write once) | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |
| <a name="input_storage_class_rwx"></a> [storage\_class\_rwx](#input\_storage\_class\_rwx) | Enter the storage class (read-write many). Enter file storage class for DB2. | `string` | `"ibmc-vpc-file-dp2"` | no |
| <a name="input_contact_email"></a> [contact\_email](#input\_contact\_email) | Enter the email ID for DRO | `string` | n/a | yes |
| <a name="input_contact_firstname"></a> [contact\_firstname](#input\_contact\_firstname) | Enter your first name to be used in DRO | `string` | n/a | yes |
| <a name="input_contact_lastname"></a> [contact\_lastname](#input\_contact\_lastname) | Enter your last name to be used in DRO | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_maximo_admin_url"></a> [maximo\_admin\_url](#output\_maximo\_admin\_url) | Admin URL of MAS/Manage application is |
| <a name="output_pipeline_execution_status"></a> [pipeline\_execution\_status](#output\_pipeline\_execution\_status) | Status of pipeline execution is |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, <1.7.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.13.1 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.64.2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.29.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.64.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mas_core"></a> [mas\_core](#module\_mas\_core) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [ibm_container_cluster_config.cluster_config](https://registry.terraform.io/providers/ibm-cloud/ibm/1.64.2/docs/data-sources/container_cluster_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_config_endpoint_type"></a> [cluster\_config\_endpoint\_type](#input\_cluster\_config\_endpoint\_type) | Specify which type of endpoint to use for for cluster config access: 'default', 'private', 'vpe', 'link'. 'default' value will use the default endpoint of the cluster. | `string` | `"default"` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | Enter Id of the target IBM Cloud Red Hat OpenShift Cluster | `string` | n/a | yes |
| <a name="input_contact_email"></a> [contact\_email](#input\_contact\_email) | Enter the email ID for Data Reporter Operator | `string` | n/a | yes |
| <a name="input_contact_firstname"></a> [contact\_firstname](#input\_contact\_firstname) | Enter your first name to be used in Data Reporter Operator | `string` | n/a | yes |
| <a name="input_contact_lastname"></a> [contact\_lastname](#input\_contact\_lastname) | Enter your last name to be used in Data Reporter Operator | `string` | n/a | yes |
| <a name="input_deployment_flavour"></a> [deployment\_flavour](#input\_deployment\_flavour) | Enter core for Maximo Application Suite Core deployment and enter manage for Maximo Application Suite Core+Manage deployment. Maximo Application Suite Core is deployed by using the MongoDB Community edition and Maximo Manage is deployed with internal Db2 on Red Hat OpenShift cluster. | `string` | `"core"` | no |
| <a name="input_entitlement_key"></a> [entitlement\_key](#input\_entitlement\_key) | Enter entitlement key to access IBM Image registry. For more information, see [Entitlement Keys](https://myibm.ibm.com/products-services/containerlibrary) You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | Enter the IBM Cloud APIkey that's associated with this IBM Cloud account | `string` | n/a | yes |
| <a name="input_mas_instance_id"></a> [mas\_instance\_id](#input\_mas\_instance\_id) | Enter the Maximo Application Suite instance Id. It can be any instance name lesser than 8 characters in length. For example, inst1 | `string` | n/a | yes |
| <a name="input_mas_license"></a> [mas\_license](#input\_mas\_license) | Enter Maximo Application Suite License file content. For more information, see [IBM Support - Licensing](https://www.ibm.com/support/pages/ibm-support-licensing-start-page) You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_mas_workspace_id"></a> [mas\_workspace\_id](#input\_mas\_workspace\_id) | Enter the Maximo Application Suite workspace Id | `string` | `"wrkid1"` | no |
| <a name="input_mas_workspace_name"></a> [mas\_workspace\_name](#input\_mas\_workspace\_name) | Enter the Maximo Application Suite workspace name | `string` | `"wrkns1"` | no |
| <a name="input_pipeline_storage_class"></a> [pipeline\_storage\_class](#input\_pipeline\_storage\_class) | Enter the storage class for pipeline | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |
| <a name="input_region"></a> [region](#input\_region) | Enter region of the target IBM Cloud Red Hat OpenShift Cluster | `string` | n/a | yes |
| <a name="input_sls_license_id"></a> [sls\_license\_id](#input\_sls\_license\_id) | Enter Suite License Server license ID. A unique 12-character hexadecimal value in the first line of your Maximo Application Suite license key file. For example, SERVER sls-rlks-0.rlks 0242ac110002 27000, where the 12-character hexadecimal value is 0242ac110002. You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_storage_class_rwo"></a> [storage\_class\_rwo](#input\_storage\_class\_rwo) | Enter the storage class (read-write once) | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |
| <a name="input_storage_class_rwx"></a> [storage\_class\_rwx](#input\_storage\_class\_rwx) | Enter the storage class (read-write many). Enter file storage class for DB2. | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_maximo_admin_url"></a> [maximo\_admin\_url](#output\_maximo\_admin\_url) | Admin URL of MAS/Manage application is |
<!-- END_TF_DOCS -->