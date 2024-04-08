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
  default     = "ca-tor"
}

variable "mas_instance_id" {
  type        = string
  description = "Enter the MAS instance Id"
  nullable    = false
  default     = "natinst1"
}

variable "mas_workspace_id" {
  type        = string
  description = "Enter the MAS instance Id"
  nullable    = false
  default     = "wrkid1"
}


variable "deployment_flavour" {
  type        = string
  description = "Enter core for just MAS Core and enter manage for MAS Core+Manage"
  nullable    = false
  default     = "core"
}

variable "cluster_id" {
  type        = string
  description = "Id of the target IBM Cloud OpenShift Cluster"
  nullable    = false
  default     = "masubda8-workload-cluster"
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
