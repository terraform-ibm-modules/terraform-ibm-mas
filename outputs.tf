########################################################################################################################
# Outputs
########################################################################################################################

output "maximo_admin_url" {
  description = "Admin URL of MAS/Manage application"
  value       = data.local_file.admin_url_file.content
}

output "pipeline_execution_status" {
  description = "Status of pipeline execution is"
  value       = data.local_file.pipeline_status_file.content
}
