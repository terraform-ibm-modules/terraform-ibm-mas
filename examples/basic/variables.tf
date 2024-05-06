##############################################################################
# Input Variables
##############################################################################

variable "ibmcloud_api_key" {
  description = "Enter the IBM Cloud APIkey that's associated with this IBM Cloud account"
  type        = string
  sensitive   = true
}

variable "cluster_id" {
  type        = string
  description = "Enter Id of the target IBM Cloud Red Hat OpenShift Cluster"
  nullable    = false
}

variable "region" {
  type        = string
  description = "Enter region of the target IBM Cloud Red Hat OpenShift Cluster"
  nullable    = false
}

variable "entitlement_key" {
  description = "Enter entitlement key to access IBM Image registry. For more information, see [Entitlement Keys](https://myibm.ibm.com/products-services/containerlibrary) You can use an existing secret in Secrets Manager or add your entitlement key directly."
  type        = string
  sensitive   = true
}

variable "mas_license" {
  description = "Enter Maximo Application Suite License file content. For more information, see [IBM Support - Licensing](https://www.ibm.com/support/pages/ibm-support-licensing-start-page) You can use an existing secret in Secrets Manager or add your entitlement key directly."
  type        = string
  sensitive   = true
}

variable "sls_license_id" {
  type        = string
  description = "Enter Suite License Server license ID. A unique 12-character hexadecimal value in the first line of your Maximo Application Suite license key file. For example, SERVER sls-rlks-0.rlks 0242ac110002 27000, where the 12-character hexadecimal value is 0242ac110002. You can use an existing secret in Secrets Manager or add your entitlement key directly."
  sensitive   = true
  nullable    = false
}

variable "deployment_flavour" {
  type        = string
  description = "Enter core for Maximo Application Suite Core deployment and enter manage for Maximo Application Suite Core+Manage deployment. Maximo Application Suite Core is deployed by using the MongoDB Community edition and Maximo Manage is deployed with internal Db2 on Red Hat OpenShift cluster."
  nullable    = false
  default     = "core"
  validation {
    error_message = "Invalid deployment flavour type! Valid values are 'core' or 'manage'"
    condition     = contains(["core", "manage"], var.deployment_flavour)
  }
}

variable "mas_instance_id" {
  type        = string
  description = "Enter the Maximo Application Suite instance Id. It can be any instance name lesser than 8 characters in length. For example, inst1"
  nullable    = false
}

# tflint-ignore: terraform_unused_declarations
variable "mas_workspace_id" {
  type        = string
  description = "Enter the Maximo Application Suite workspace Id"
  default     = "wrkid1"
}

# tflint-ignore: terraform_unused_declarations
variable "mas_workspace_name" {
  type        = string
  description = "Enter the Maximo Application Suite workspace name"
  default     = "wrkns1"
}

# tflint-ignore: terraform_unused_declarations
variable "storage_class_rwo" {
  type        = string
  description = "Enter the storage class (read-write once)"
  default     = "ibmc-vpc-block-retain-10iops-tier"
}

# tflint-ignore: terraform_unused_declarations
variable "storage_class_rwx" {
  type        = string
  description = "Enter the storage class (read-write many). Enter file storage class for DB2."
  default     = "ibmc-vpc-block-retain-10iops-tier"
}

# tflint-ignore: terraform_unused_declarations
variable "pipeline_storage_class" {
  type        = string
  description = "Enter the storage class for pipeline"
  default     = "ibmc-vpc-block-retain-10iops-tier"

}

variable "contact_email" {
  type        = string
  description = "Enter the email ID for Data Reporter Operator"
  nullable    = false
}

variable "contact_firstname" {
  type        = string
  description = "Enter your first name to be used in Data Reporter Operator"
  nullable    = false
}

variable "contact_lastname" {
  type        = string
  description = "Enter your last name to be used in Data Reporter Operator"
  nullable    = false
}

variable "cluster_config_endpoint_type" {
  description = "Specify which type of endpoint to use for for cluster config access: 'default', 'private', 'vpe', 'link'. 'default' value will use the default endpoint of the cluster."
  type        = string
  default     = "default"
  nullable    = false # use default if null is passed in
  validation {
    error_message = "Invalid Endpoint Type! Valid values are 'default', 'private', 'vpe', or 'link'"
    condition     = contains(["default", "private", "vpe", "link"], var.cluster_config_endpoint_type)
  }
}
