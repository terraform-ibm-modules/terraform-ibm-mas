##############################################################################
# SLZ OCP
##############################################################################

module "landing_zone" {
  source   = "terraform-ibm-modules/landing-zone/ibm//patterns//roks//module"
  version  = "5.21.0"
  region   = var.region
  prefix   = var.prefix
  tags     = var.resource_tags
  override = true
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id   = module.landing_zone.workload_cluster_id
  resource_group_id = module.landing_zone.cluster_data[format("%s-workload-cluster", var.prefix)].resource_group_id
}

# Sleep to allow RBAC sync on cluster
resource "time_sleep" "wait_operators" {
  depends_on      = [data.ibm_container_cluster_config.cluster_config]
  create_duration = "5s"
}

resource "null_resource" "confirm_network_healthy" {
  depends_on = [module.landing_zone]
  provisioner "local-exec" {
    command     = "${path.module}/scripts/confirm_network_healthy.sh"
    interpreter = ["/bin/bash", "-c"]
    environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
}
