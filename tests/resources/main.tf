##############################################################################
# SLZ OCP
##############################################################################

locals {
  override_json_path = "${path.module}/override-json-file/override.json"
}

module "landing_zone" {
  source             = "terraform-ibm-modules/landing-zone/ibm//patterns//roks//module"
  version            = "5.21.1"
  region             = var.region
  prefix             = var.prefix
  tags               = var.resource_tags
  override           = true
  override_json_path = local.override_json_path
}
