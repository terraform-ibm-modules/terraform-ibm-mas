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
  default     = "au-syd"
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
}
