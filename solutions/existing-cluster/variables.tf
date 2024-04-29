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

variable "mas_entitlement_key" {
  description = "Enter entitlement key to access Maximo Application Suite Image registry"
  type        = string
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Enter region of the target IBM Cloud Red Hat OpenShift Cluster"
  nullable    = false
  default     = "us-east"
}

variable "mas_license" {
  description = "Enter Maximo Application Suite License file content"
  type        = string
  sensitive   = true
}

variable "sls_license_id" {
  type        = string
  description = "Enter Suite License Server license ID"
  sensitive   = true
  nullable    = false
}

variable "deployment_flavour" {
  type        = string
  description = "Enter core for Maximo Application Suite Core deployment and enter manage for Maximo Application Suite Core+Manage deployment"
  nullable    = false
  validation {
    error_message = "Invalid deployment flavour type! Valid values are 'core' or 'manage'"
    condition     = contains(["core", "manage"], var.deployment_flavour)
  }
}

variable "mas_instance_id" {
  type        = string
  description = "Enter the Maximo Application Suite instance Id"
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

variable "uds_contact_email" {
  type        = string
  description = "Enter the email ID for Data Reporter Operator"
  nullable    = false
}

variable "uds_contact_firstname" {
  type        = string
  description = "Enter your first name to be used in Data Reporter Operator"
  nullable    = false
}

variable "uds_contact_lastname" {
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
