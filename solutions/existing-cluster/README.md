# Maximo Application Suite on Existing Red Hat OpenShift Cluster module

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
| <a name="module_existing_cluster"></a> [existing\_cluster](#module\_existing\_cluster) | ../../ | n/a |

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
| <a name="input_deployment_flavor"></a> [deployment\_flavor](#input\_deployment\_flavor) | Enter core for Maximo Application Suite Core deployment and enter manage for Maximo Application Suite Core+Manage deployment. Maximo Application Suite Core is deployed by using the MongoDB Community edition and Maximo Manage is deployed with internal Db2 on Red Hat OpenShift cluster. | `string` | n/a | yes |
| <a name="input_entitlement_key"></a> [entitlement\_key](#input\_entitlement\_key) | Enter entitlement key to access IBM Image registry. For more information, see [Entitlement Keys](https://myibm.ibm.com/products-services/containerlibrary) You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | Enter the IBM Cloud APIkey that's associated with this IBM Cloud account | `string` | n/a | yes |
| <a name="input_mas_instance_id"></a> [mas\_instance\_id](#input\_mas\_instance\_id) | Enter the Maximo Application Suite instance Id. It can be any instance name lesser than 8 characters in length such as inst1 | `string` | n/a | yes |
| <a name="input_mas_license"></a> [mas\_license](#input\_mas\_license) | Enter Maximo Application Suite License file content. For more information, see [IBM Support - Licensing](https://www.ibm.com/support/pages/ibm-support-licensing-start-page) You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_mas_workspace_id"></a> [mas\_workspace\_id](#input\_mas\_workspace\_id) | Enter the Maximo Application Suite workspace Id | `string` | `"wrkid1"` | no |
| <a name="input_mas_workspace_name"></a> [mas\_workspace\_name](#input\_mas\_workspace\_name) | Enter the Maximo Application Suite workspace name | `string` | `"wrkns1"` | no |
| <a name="input_pipeline_storage_class"></a> [pipeline\_storage\_class](#input\_pipeline\_storage\_class) | Enter the storage class for pipeline. Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |
| <a name="input_region"></a> [region](#input\_region) | Enter region of the target IBM Cloud Red Hat OpenShift Cluster | `string` | n/a | yes |
| <a name="input_sls_license_id"></a> [sls\_license\_id](#input\_sls\_license\_id) | Enter Suite License Server license ID. A unique 12-character hexadecimal value in the first line of your Maximo Application Suite license key file. For example, SERVER sls-rlks-0.rlks 0242ac110002 27000, where the 12-character hexadecimal value is 0242ac110002. You can use an existing secret in Secrets Manager or add your entitlement key directly. | `string` | n/a | yes |
| <a name="input_storage_class_rwo"></a> [storage\_class\_rwo](#input\_storage\_class\_rwo) | Enter the storage class (read-write once). Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |
| <a name="input_storage_class_rwx"></a> [storage\_class\_rwx](#input\_storage\_class\_rwx) | Enter the storage class (read-write many). Enter file storage class for DB2. Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | `string` | `"ibmc-vpc-block-retain-10iops-tier"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_maximo_admin_url"></a> [maximo\_admin\_url](#output\_maximo\_admin\_url) | Admin URL of MAS/Manage application is |
<!-- END_TF_DOCS -->
