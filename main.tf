locals {
  # sleep times definition
  # sleep_time_catalog_create  = "60s"
  # sleep_time_operator_create = "120s"

  # helm chart names
  #maximo_chart                 = "ibm-operator-catalog"

  # validation of ws_liberty_operator_target_namespace - if null the value of ws_liberty_operator_namespace must be equal to "openshift-operators" https://www.ibm.com/docs/en/was-liberty/core?topic=operator-installing-red-hat-openshift-cli#in-t-cli__install-op-cli__title__1
  #default_liberty_operator_namespace = "openshift-operators"

}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  config_dir      = "${path.module}/kubeconfig"
  endpoint_type   = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null
}

resource "helm_release" "maximo_operator_catalog" {

  set {
    name  = "mas_entitlement_key"
    type  = "string"
    value = var.mas_entitlement_key
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
