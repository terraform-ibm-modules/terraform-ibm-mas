########################################################################################################################
# Outputs
########################################################################################################################

output "pipeline_execution_status" {
  description = "Status of pipeline execution is"
  value       = module.existing_cluster.pipeline_execution_status
}

output "maximo_admin_url" {
  description = "Admin URL of MAS/Manage application is"
  value       = module.existing_cluster.maximo_admin_url
}
