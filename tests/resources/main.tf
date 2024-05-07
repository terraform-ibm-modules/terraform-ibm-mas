##############################################################################
# SLZ OCP
##############################################################################

data "ibm_container_cluster_versions" "cluster_versions" {
}

module "landing_zone" {
  source   = "terraform-ibm-modules/landing-zone/ibm//patterns//roks//module"
  version  = "5.21.0"
  region   = var.region
  prefix   = var.prefix
  tags     = var.resource_tags
  override = true
}
