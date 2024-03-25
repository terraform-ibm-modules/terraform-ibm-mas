data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null
}

resource "time_sleep" "wait_300_seconds" {
  create_duration = "100s"
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

 set {
    name  = "sls_license_id"
    type  = "string"
    value = var.sls_license_id
  }

  set {
    name  = "deployment_flavour"
    type  = "string"
    value = var.deployment_flavour
  }

  set {
    name  = "mas_instance_id"
    type  = "string"
    value = var.mas_instance_id
  }

  set {
    name  = "mas_workspace_id"
    type  = "string"
    value = var.mas_workspace_id
  }

  set {
    name  = "mas_workspace_name"
    type  = "string"
    value = var.mas_workspace_name
  }
	
  set {
    name  = "uds_contact_email"
    type  = "string"
    value = var.uds_contact_email
  }

  set {
    name  = "uds_contact_firstname"
    type  = "string"
    value = var.uds_contact_firstname
  }

  set {
    name  = "uds_contact_lastname"
    type  = "string"
    value = var.uds_contact_lastname
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
    command     = "${path.module}/scripts/installVerify.sh ${var.deployment_flavour} ${var.mas_instance_id}"
	environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
  depends_on = [time_sleep.wait_300_seconds]
}

resource "null_resource" "admin_url" {

provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "${path.module}/scripts/getAdminURL.sh ${var.deployment_flavour} ${var.mas_instance_id} ${var.mas_workspace_id}"
	environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
  depends_on = [null_resource.install_verify]
}

data "external" "get_pipeline_result" {

  program    = ["/bin/bash", "-c", "${path.module}/scripts/getResult.sh"]
  query = {
    KUBECONFIG   = data.ibm_container_cluster_config.cluster_config.config_file_path
  }
depends_on = [null_resource.install_verify]
}

data "external" "get_admin_url" {

  program    = ["/bin/bash", "-c", "${path.module}/scripts/getURL.sh"]
  query = {
    KUBECONFIG   = data.ibm_container_cluster_config.cluster_config.config_file_path
  }
depends_on = [null_resource.admin_url]
}
