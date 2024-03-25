##############################################################################
# Input Variables
##############################################################################

variable "ibmcloud_api_key" {
  description = "APIkey that's associated with the account to use"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Cluster region"
  type        = string
  nullable    = false
}

variable "mas_instance_id" {
  type        = string
  description = "Enter the MAS instance Id"
  nullable    = false
}

variable "mas_workspace_id" {
  type        = string
  description = "Enter the workspace Id"
  nullable    = false
}

variable "mas_workspace_name" {
  type        = string
  description = "Enter the workspace name"
  nullable    = false
}

variable "deployment_flavour" {
  type        = string
  description = "Enter core for just MAS Core and enter manage for MAS Core+Manage"
  nullable    = false
}

variable "sls_license_id" {
  type        = string
  description = "Enter the SLS license ID"
  sensitive   = true
  nullable    = false
}

variable "uds_contact_email" {
  type        = string
  description = "Enter the email ID for UDS"
  nullable    = false
}

variable "uds_contact_firstname" {
  type        = string
  description = "Enter your first name to be used in UDS"
  nullable    = false
}

variable "uds_contact_lastname" {
  type        = string
  description = "Enter your last name to be used in UDS"
  nullable    = false
}

variable "mas_entitlement_key" {
  description = "Entitlement key to access MAS Image registry"
  type        = string
  sensitive   = true
}

variable "mas_license" {
  description = "MAS License file content"
  type        = string
  sensitive   = true
}

variable "cluster_id" {
  type        = string
  description = "Id of the target IBM Cloud OpenShift Cluster"
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
