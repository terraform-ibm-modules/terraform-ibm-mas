########################################################################################################################
# MAS Core on an existing Openshift cluster
########################################################################################################################

module "mas_core" {
  source                       = "../.."
  cluster_id                   = var.cluster_id
  entitlement_key              = var.entitlement_key
  mas_license                  = var.mas_license
  sls_license_id               = var.sls_license_id
  deployment_flavor            = var.deployment_flavor
  mas_instance_id              = var.mas_instance_id
  contact_email                = var.contact_email
  contact_firstname            = var.contact_firstname
  contact_lastname             = var.contact_lastname
  cluster_config_endpoint_type = var.cluster_config_endpoint_type
}
