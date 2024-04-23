##############################################################################
# Input Variables
##############################################################################

variable "ibmcloud_api_key" {
  description = "Enter the IBM Cloud APIkey that's associated with this IBM Cloud account"
  type        = string
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "Enter a prefix used for naming resources that are created"
  default     = "mas"
}

variable "region" {
  type        = string
  description = "Enter region of the target IBM Cloud Red Hat OpenShift Cluster"
  default     = "us-south"
}

variable "resource_group" {
  type        = string
  description = "An existing resource group name to use for this example, if unset a new resource group will be created"
  default     = null
}

variable "mas_entitlement_key" {
  description = "Enter entitlement key to access Maximo Application Suite Image registry"
  type        = string
  sensitive   = true
  nullable    = false
}

variable "mas_license" {
  description = "Enter Maximo Application Suite License file content"
  type        = string
  sensitive   = true
  nullable    = false
}

variable "sls_license_id" {
  type        = string
  description = "Enter Suite License Server license ID"
  sensitive   = true
  nullable    = false
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
}
