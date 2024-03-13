data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null
}

resource "time_sleep" "wait_300_seconds" {
  create_duration = "300s"
  depends_on = [helm_release.maximo_operator_catalog]
}

resource "helm_release" "maximo_operator_catalog" {

  set {
    name  = "mas_entitlement_key"
    type  = "string"
    value = base64encode(var.mas_entitlement_key)
  }

  set {
    name  = "mas_license"
    type  = "string"
    value = base64encode(var.mas_license)
  }
  
   name             = "maximo-operator-catalog-helm-release"
  chart            = "${path.module}/chart/deploy-mas"
  create_namespace = false
  timeout          = 300
  # dependency_update = true
  # force_update      = false
  force_update               = true
  cleanup_on_fail            = true
  wait                       = true
  recreate_pods              = true
  disable_openapi_validation = false


}

resource "null_resource" "install_verify" {

provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "${path.module}/scripts/installVerify.sh"
	environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
  depends_on = [time_sleep.wait_300_seconds]
}

data "external" "maximo_admin_url" {

  program    = ["/bin/bash", "${path.module}/scripts/getAdminURL.sh"]
  query = {
    KUBECONFIG   = data.ibm_container_cluster_config.cluster_config.config_file_path
  }
  depends_on = [null_resource.install_verify]
}