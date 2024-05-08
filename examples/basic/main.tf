########################################################################################################################
# MAS Core on an existing Openshift cluster
########################################################################################################################

module "mas_core" {
  source                       = "../.."
  cluster_id                   = var.cluster_id
  entitlement_key              = var.entitlement_key
  mas_license                  = var.mas_license
  sls_license_id               = var.sls_license_id
  deployment_flavor            = "core"
  mas_instance_id              = "inst1"
  contact_email                = "test@ibm.com"
  contact_firstname            = "John"
  contact_lastname             = "Doe"
  cluster_config_endpoint_type = "default"
}
