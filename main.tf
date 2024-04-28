data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null
}

#Deploy helm chart to install selected deployment offerings namely, MAS Core or MAS Core+Manage
resource "helm_release" "maximo_helm_release" {

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
    name  = "storage_class_rwo"
    type  = "string"
    value = var.storage_class_rwo
  }

  set {
    name  = "storage_class_rwx"
    type  = "string"
    value = var.storage_class_rwx
  }

  set {
    name  = "pipeline_storage_class"
    type  = "string"
    value = var.pipeline_storage_class
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

  name                       = "maximo-helm-release"
  chart                      = "${path.module}/chart/deploy-mas"
  create_namespace           = false
  timeout                    = 1200
  force_update               = true
  cleanup_on_fail            = true
  wait                       = true
  recreate_pods              = true
  disable_openapi_validation = false

}

#Verify the pipeline install status & get the the data on pipeline success status or in case of failure, get the data on failed task.
resource "null_resource" "install_verify" {  
  triggers = {
    always_run = timestamp()
  }
provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "${path.module}/scripts/installVerify.sh ${var.deployment_flavour} ${var.mas_instance_id}"
	environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
 depends_on      = [helm_release.maximo_helm_release]
}


resource "null_resource" "maximo_admin_url" {  
  triggers = {
    always_run = timestamp()
  }
provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "${path.module}/scripts/getAdminURL.sh ${var.deployment_flavour} ${var.mas_instance_id}"
	environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }
  depends_on = [null_resource.install_verify]
}

locals {
  pipeline_status_file = "${path.module}/result.txt"
}

locals {
  admin_url_file = "${path.module}/url.txt"
}

data "local_file" "admin_url" {
  depends_on = [null_resource.maximo_admin_url]
  filename = local.admin_url_file  
}

data "local_file" "pipeline_status" {
  depends_on = [null_resource.maximo_admin_url]
  filename = local.pipeline_status_file 
}
