########################################################################################################################
# Outputs
########################################################################################################################

output "pipeline_execution_status" {
  description = "Status of pipeline execution is"
  value       = local.pipeline_execution_status
}

output "maximo_admin_url" {
  description = "Admin URL of MAS/Manage application is"
  value       = local.maximo_admin_url
}

