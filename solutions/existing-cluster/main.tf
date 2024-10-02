module "existing_cluster" {
  source                       = "../../"
  cluster_id                   = var.cluster_id
  deployment_flavor            = var.deployment_flavor
  entitlement_key              = var.entitlement_key
  mas_instance_id              = var.mas_instance_id
  mas_license                  = var.mas_license
  contact_email                = var.contact_email
  contact_firstname            = var.contact_firstname
  contact_lastname             = var.contact_lastname
  cluster_config_endpoint_type = var.cluster_config_endpoint_type
  mas_workspace_id             = var.mas_workspace_id
  mas_workspace_name           = var.mas_workspace_name
  pipeline_storage_class       = var.pipeline_storage_class
  storage_class_rwo            = var.storage_class_rwo
  storage_class_rwx            = var.storage_class_rwx
}
