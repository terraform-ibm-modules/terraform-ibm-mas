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

# variable "resource_group" {
#   type        = string
#   description = "Resource group to provision the cluster in"
#   default     = null
# }


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
