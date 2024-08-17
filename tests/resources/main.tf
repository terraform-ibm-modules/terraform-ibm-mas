##############################################################################
# SLZ OCP
##############################################################################

module "landing_zone" {
  source   = "terraform-ibm-modules/landing-zone/ibm//patterns//roks//module"
  version  = "5.29.0"
  region   = var.region
  prefix   = var.prefix
  tags     = var.resource_tags
  override = true
}
