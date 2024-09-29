##############################################################################
# SLZ OCP
##############################################################################

module "landing_zone" {
  source   = "terraform-ibm-modules/landing-zone/ibm//patterns//roks//module"
  version  = "6.0.3"
  region   = var.region
  prefix   = var.prefix
  tags     = var.resource_tags
  override = true
  # GHA runtime has no access to private
  verify_cluster_network_readiness    = false
  use_ibm_cloud_private_api_endpoints = false
}
