# Maximo Application Suite on Existing Red Hat OpenShift Cluster module

[![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-mas?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-mas/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

<!-- Add a description of module(s) in this repo -->
Use this module to install Maximo Application Suite on your existing Red Hat OpenShift Cluster.

For more information about the Maximo Application Suite refer to the official documentation available [here](https://www.ibm.com/docs/en/mas-cd)


<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-mas](#terraform-ibm-mas)
* [Examples](./examples)
    * [<!-- Update the title -->](./examples/basic)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->


<!--
If this repo contains any reference architectures, uncomment the heading below and links to them.
(Usually in the `/reference-architectures` directory.)
See "Reference architecture" in Authoring Guidelines in the public documentation at
https://terraform-ibm-modules.github.io/documentation/#/implementation-guidelines?id=reference-architecture
-->

## Reference architectures

[Maximo Application Suite Deployable Architecture](https://raw.githubusercontent.com/terraform-ibm-modules/terraform-ibm-mas/main/reference-architecture/mas_deployable_architecure.svg)

<!-- This heading should always match the name of the root level module (aka the repo name) -->
## terraform-ibm-mas

### Usage

You can use the modular design of this module to provision Maximo Application Suite Core offering or Maximo Application Suite Core + Manage offering.
Include a provider block and a copy of the [variables.tf](https://github.com/terraform-ibm-modules/terraform-ibm-mas/blob/main/variables.tf) file.

module "existing_cluster" {

  source                       = "terraform-ibm-modules/terraform-ibm-mas"
  cluster_id                   = var.cluster_id
  deployment_flavor           = var.deployment_flavor
  mas_entitlement_key          = var.mas_entitlement_key
  mas_instance_id              = var.mas_instance_id
  mas_license                  = var.mas_license
  sls_license_id               = var.sls_license_id
  uds_contact_email            = var.uds_contact_email
  uds_contact_firstname        = var.uds_contact_firstname
  uds_contact_lastname         = var.uds_contact_lastname
  cluster_config_endpoint_type = var.cluster_config_endpoint_type
  mas_workspace_id             = var.mas_workspace_id
  mas_workspace_name           = var.mas_workspace_name
  pipeline_storage_class       = var.pipeline_storage_class
  storage_class_rwo            = var.storage_class_rwo
  storage_class_rwx            = var.storage_class_rwx

}

### Required IAM access policies

You need Administrator role to perform deployment of Maixmo Application Suite on an existing Openshift cluster.

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, <1.7.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.8.0, <3.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.59.0, < 2.0.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.0.0, <2.5.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.1, < 4.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [helm_release.maximo_helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [null_resource.install_verify](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.maximo_admin_url](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [ibm_container_cluster_config.cluster_config](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/data-sources/container_cluster_config) | data source |
| [local_file.admin_url](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_config_endpoint_type"></a> [cluster\_config\_endpoint\_type](#input\_cluster\_config\_endpoint\_type) | Specify which type of endpoint to use for for cluster config access: 'default', 'private', 'vpe', 'link'. 'default' value will use the default endpoint of the cluster. | `string` | `"default"` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | Enter Id of the target IBM Cloud Red Hat OpenShift cluster. This cluster ID can be found under the Red Hat OpenShift clusters section. | `string` | n/a | yes |
| <a name="input_contact_email"></a> [contact\_email](#input\_contact\_email) | Enter the email ID for Data Reporter Operator | `string` | n/a | yes |
| <a name="input_contact_firstname"></a> [contact\_firstname](#input\_contact\_firstname) | Enter your first name to be used in Data Reporter Operator | `string` | n/a | yes |
| <a name="input_contact_lastname"></a> [contact\_lastname](#input\_contact\_lastname) | Enter your last name to be used in Data Reporter Operator | `string` | n/a | yes |
| <a name="input_deployment_flavor"></a> [deployment\_flavor](#input\_deployment\_flavor) | Enter core for Maximo Application Suite Core deployment and enter manage for Maximo Application Suite Core+Manage deployment. Maximo Application Suite Core is deployed by using the MongoDB Community edition and Maximo Manage is deployed with internal Db2 on Red Hat OpenShift cluster. | `string` | n/a | yes |
| <a name="input_entitlement_key"></a> [entitlement\_key](#input\_entitlement\_key) | Enter entitlement key to access IBM Image registry. For more information, see [Entitlement Keys](https://myibm.ibm.com/products-services/containerlibrary) You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_mas_instance_id"></a> [mas\_instance\_id](#input\_mas\_instance\_id) | Enter the Maximo Application Suite instance Id. It can be any instance name lesser than 8 characters in length such as inst1 | `string` | n/a | yes |
| <a name="input_mas_license"></a> [mas\_license](#input\_mas\_license) | Enter Maximo Application Suite License file content. For more information, see [IBM Support - Licensing](https://www.ibm.com/support/pages/ibm-support-licensing-start-page) You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_mas_workspace_id"></a> [mas\_workspace\_id](#input\_mas\_workspace\_id) | Enter the Maximo Application Suite workspace Id. | `string` | `"wrkid1"` | no |
| <a name="input_mas_workspace_name"></a> [mas\_workspace\_name](#input\_mas\_workspace\_name) | Enter the Maximo Application Suite workspace name | `string` | `"wrkns1"` | no |
| <a name="input_pipeline_storage_class"></a> [pipeline\_storage\_class](#input\_pipeline\_storage\_class) | Enter the storage class for pipeline. Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |
| <a name="input_sls_license_id"></a> [sls\_license\_id](#input\_sls\_license\_id) | Enter Suite License Server license ID. A unique 12-character hexadecimal value in the first line of your Maximo Application Suite license key file. For example, SERVER sls-rlks-0.rlks 0242ac110002 27000, where the 12-character hexadecimal value is 0242ac110002. You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_storage_class_rwo"></a> [storage\_class\_rwo](#input\_storage\_class\_rwo) | Enter the storage class (read-write once). Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |
| <a name="input_storage_class_rwx"></a> [storage\_class\_rwx](#input\_storage\_class\_rwx) | Enter the storage class (read-write many). Enter file storage class for DB2. Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_maximo_admin_url"></a> [maximo\_admin\_url](#output\_maximo\_admin\_url) | Admin URL of MAS/Manage application |
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
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.8.0, <3.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.59.0, < 2.0.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.0.0, <2.5.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.1, < 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.8.0, <3.0.0 |
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | >= 1.59.0, < 2.0.0 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.0.0, <2.5.1 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.2.1, < 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.maximo_helm_release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [null_resource.install_verify](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.maximo_admin_url](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [ibm_container_cluster_config.cluster_config](https://registry.terraform.io/providers/ibm-cloud/ibm/latest/docs/data-sources/container_cluster_config) | data source |
| [local_file.admin_url](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_config_endpoint_type"></a> [cluster\_config\_endpoint\_type](#input\_cluster\_config\_endpoint\_type) | Specify which type of endpoint to use for for cluster config access: 'default', 'private', 'vpe', 'link'. 'default' value will use the default endpoint of the cluster. | `string` | `"default"` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | Enter Id of the target IBM Cloud Red Hat OpenShift cluster. This cluster ID can be found under the Red Hat OpenShift clusters section. | `string` | n/a | yes |
| <a name="input_contact_email"></a> [contact\_email](#input\_contact\_email) | Enter the email ID for Data Reporter Operator | `string` | n/a | yes |
| <a name="input_contact_firstname"></a> [contact\_firstname](#input\_contact\_firstname) | Enter your first name to be used in Data Reporter Operator | `string` | n/a | yes |
| <a name="input_contact_lastname"></a> [contact\_lastname](#input\_contact\_lastname) | Enter your last name to be used in Data Reporter Operator | `string` | n/a | yes |
| <a name="input_deployment_flavor"></a> [deployment\_flavor](#input\_deployment\_flavor) | Enter core for Maximo Application Suite Core deployment and enter manage for Maximo Application Suite Core+Manage deployment. Maximo Application Suite Core is deployed by using the MongoDB Community edition and Maximo Manage is deployed with internal Db2 on Red Hat OpenShift cluster. | `string` | n/a | yes |
| <a name="input_entitlement_key"></a> [entitlement\_key](#input\_entitlement\_key) | Enter entitlement key to access IBM Image registry. For more information, see [Entitlement Keys](https://myibm.ibm.com/products-services/containerlibrary) You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_mas_instance_id"></a> [mas\_instance\_id](#input\_mas\_instance\_id) | Enter the Maximo Application Suite instance Id. It can be any instance name lesser than 8 characters in length such as inst1 | `string` | n/a | yes |
| <a name="input_mas_license"></a> [mas\_license](#input\_mas\_license) | Enter Maximo Application Suite License file content. For more information, see [IBM Support - Licensing](https://www.ibm.com/support/pages/ibm-support-licensing-start-page) You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_mas_workspace_id"></a> [mas\_workspace\_id](#input\_mas\_workspace\_id) | Enter the Maximo Application Suite workspace Id. | `string` | `"wrkid1"` | no |
| <a name="input_mas_workspace_name"></a> [mas\_workspace\_name](#input\_mas\_workspace\_name) | Enter the Maximo Application Suite workspace name | `string` | `"wrkns1"` | no |
| <a name="input_pipeline_storage_class"></a> [pipeline\_storage\_class](#input\_pipeline\_storage\_class) | Enter the storage class for pipeline. Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |
| <a name="input_sls_license_id"></a> [sls\_license\_id](#input\_sls\_license\_id) | Enter Suite License Server license ID. A unique 12-character hexadecimal value in the first line of your Maximo Application Suite license key file. For example, SERVER sls-rlks-0.rlks 0242ac110002 27000, where the 12-character hexadecimal value is 0242ac110002. You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_storage_class_rwo"></a> [storage\_class\_rwo](#input\_storage\_class\_rwo) | Enter the storage class (read-write once). Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |
| <a name="input_storage_class_rwx"></a> [storage\_class\_rwx](#input\_storage\_class\_rwx) | Enter the storage class (read-write many). Enter file storage class for DB2. Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_maximo_admin_url"></a> [maximo\_admin\_url](#output\_maximo\_admin\_url) | Admin URL of MAS/Manage application |
<!-- END_TF_DOCS -->
