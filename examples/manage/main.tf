########################################################################################################################
# MAS Manage on an existing Openshift cluster
########################################################################################################################

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null # null represents default
}

module "mas_manage" {
  source                       = "../.."
  cluster_id                   = var.cluster_id
  region                       = var.region
  mas_entitlement_key          = var.mas_entitlement_key
  ibmcloud_api_key             = var.ibmcloud_api_key
  mas_license                  = var.mas_license
  sls_license_id               = var.sls_license_id
  deployment_flavour           = var.deployment_flavour
  mas_instance_id              = var.mas_instance_id
  uds_contact_email            = var.uds_contact_email
  uds_contact_firstname        = var.uds_contact_firstname
  uds_contact_lastname         = var.uds_contact_lastname
  cluster_config_endpoint_type = var.cluster_config_endpoint_type
}

locals {
  maximo_admin_url          = module.mas_manage.maximo_admin_url
  pipeline_execution_status = module.mas_manage.pipeline_execution_status
}
