data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null
}

#Wait for Redhat Openshift Pipelines operator to get installed & to pipeline to get started
resource "time_sleep" "wait_500_seconds" {
  create_duration = "500s"
  depends_on = [helm_release.maximo_helm_release]
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
  
  name             = "maximo-helm-release"
  chart            = "${path.module}/chart/deploy-mas"
  create_namespace = false
  timeout          = 1200
  # dependency_update = true
  # force_update      = false
  force_update               = true
  cleanup_on_fail            = true
  wait                       = true
  recreate_pods              = true
  disable_openapi_validation = false

}

#Verify the pipeline install status & get the the data on pipeline success status or in case of failure, get the data on failed task.
data "external" "install_verify" {

  program    = ["python3", "${path.module}/scripts/installVerify.py", "${var.deployment_flavour}", "${var.mas_instance_id}"]
  query = {
    KUBECONFIG   = data.ibm_container_cluster_config.cluster_config.config_file_path
  }
depends_on = [time_sleep.wait_500_seconds]

}

#Get the maximo admin URL if the deployment is successful.
data "external" "maximo_admin_url" {

  program    = ["python3", "${path.module}/scripts/getAdminURL.py", "${var.deployment_flavour}", "${var.mas_instance_id}", "${var.mas_workspace_id}"]
  query = {
    KUBECONFIG   = data.ibm_container_cluster_config.cluster_config.config_file_path
  }
depends_on = [data.external.install_verify]
}