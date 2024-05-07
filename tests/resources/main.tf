##############################################################################
# SLZ OCP
##############################################################################

data "ibm_container_cluster_versions" "cluster_versions" {
}

locals {
  default_ocp_version = "${data.ibm_container_cluster_versions.cluster_versions.default_openshift_version}_openshift"
  ocp_version         = var.ocp_version == null || var.ocp_version == "default" ? local.default_ocp_version : "${var.ocp_version}_openshift"
}

module "landing_zone" {
  source   = "terraform-ibm-modules/landing-zone/ibm//patterns//roks//module"
  version  = "5.21.0"
  region   = var.region
  prefix   = var.prefix
  tags     = var.resource_tags
  override = true
}
