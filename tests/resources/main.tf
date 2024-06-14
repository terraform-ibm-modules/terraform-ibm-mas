##############################################################################
# SLZ OCP
##############################################################################

module "landing_zone" {
  source                       = "terraform-ibm-modules/landing-zone/ibm//patterns//roks//module"
  version                      = "5.24.5"
  region                       = var.region
  prefix                       = var.prefix
  tags                         = var.resource_tags
  cluster_force_delete_storage = true # delete sotrage created by tests
  override                     = true
}
