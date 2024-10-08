Maximo Application Suite on Existing Red Hat OpenShift Cluster module

Requirements

| Name | Version | |------|---------| |  terraform | >= 1.3.0, <1.7.0 | |  helm | 2.13.1 | |  ibm | 1.64.2 | |  kubernetes | 2.29.0 |

Providers

| Name | Version | |------|---------| |  ibm | 1.64.2 |

Modules

| Name | Source | Version | |------|--------|---------| |  existing\_cluster | ../../ | n/a |

Resources

| Name | Type | |------|------| | ibm_container_cluster_config.cluster_config | data source |

Inputs

| Name | Description | Type | Default | Required | |------|-------------|------|---------|:--------:| |  cluster\_config\_endpoint\_type | Specify which type of endpoint to use for for cluster config access: 'default', 'private', 'vpe', 'link'. 'default' value will use the default endpoint of the cluster. | string | "default" | no | |  cluster\_id | Enter Id of the target IBM Cloud Red Hat OpenShift Cluster | string | n/a | yes | |  contact\_email | Enter the email ID for Data Reporter Operator | string | n/a | yes | |  contact\_firstname | Enter your first name to be used in Data Reporter Operator | string | n/a | yes | |  contact\_lastname | Enter your last name to be used in Data Reporter Operator | string | n/a | yes | |  deployment\_flavor | Enter core for Maximo Application Suite Core deployment and enter manage for Maximo Application Suite Core+Manage deployment. Maximo Application Suite Core is deployed by using the MongoDB Community edition and Maximo Manage is deployed with internal Db2 on Red Hat OpenShift cluster. | string | n/a | yes | |  entitlement\_key | Enter entitlement key to access IBM Image registry. For more information, see Entitlement Keys You can use an existing secret in Secrets Manager or add your entitlement key directly. | string | n/a | yes | |  ibmcloud\_api\_key | Enter the IBM Cloud APIkey that's associated with this IBM Cloud account | string | n/a | yes | |  mas\_instance\_id | Enter the Maximo Application Suite instance Id. It can be any instance name lesser than 8 characters in length such as inst1 | string | n/a | yes | |  mas\_license | Enter Maximo Application Suite License file content. For more information, see IBM Support - Licensing You can use an existing secret in Secrets Manager or add your entitlement key directly. | string | n/a | yes | |  mas\_workspace\_id | Enter the Maximo Application Suite workspace Id | string | "wrkid1" | no | |  mas\_workspace\_name | Enter the Maximo Application Suite workspace name | string | "wrkns1" | no | |  pipeline\_storage\_class | Enter the storage class for pipeline. Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | string | "ibmc-vpc-block-retain-10iops-tier" | no | |  region | Enter region of the target IBM Cloud Red Hat OpenShift Cluster | string | n/a | yes | |  storage\_class\_rwo | Enter the storage class (read-write once). Default value is ibmc-vpc-block-retain-10iops-tier. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | string | "ibmc-vpc-block-retain-10iops-tier" | no | |  storage\_class\_rwx | Enter the storage class (read-write many). Enter file storage class for DB2. Default value is ibmc-vpc-file-500-iops. Make sure this storage class is present under Storage > StorageClasses section on your Red Hat OpenShift cluster section. | string | "ibmc-vpc-file-500-iops" | no |

Outputs

| Name | Description | |------|-------------| |  maximo\_admin\_url | Admin URL of MAS/Manage application is | <!-- END_TF_DOCS -->
