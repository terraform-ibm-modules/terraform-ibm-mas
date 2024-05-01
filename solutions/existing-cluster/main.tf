module "existing_cluster" {
  source                       = "../../"
  cluster_id                   = var.cluster_id
  deployment_flavour           = var.deployment_flavour
  mas_entitlement_key          = var.mas_entitlement_key
  mas_instance_id              = var.mas_instance_id
  mas_license                  = var.mas_license
  sls_license_id               = var.sls_license_id
  uds_contact_email            = var.uds_contact_email
  uds_contact_firstname        = var.uds_contact_firstname
  uds_contact_lastname         = var.uds_contact_lastname
  cluster_config_endpoint_type = var.cluster_config_endpoint_type
  mas_workspace_id             = var.mas_workspace_id
  mas_workspace_name           = var.mas_workspace_name
  pipeline_storage_class       = var.pipeline_storage_class
  storage_class_rwo            = var.storage_class_rwo
  storage_class_rwx            = var.storage_class_rwx
}
