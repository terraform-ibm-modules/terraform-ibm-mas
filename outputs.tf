########################################################################################################################
# Outputs
########################################################################################################################

output "pipeline_execution_status" {
  description = "Status of pipeline execution is"
  value       = data.external.install_verify.result.PipelineRunStatus
}

output "maximo_admin_url" {
  description = "Admin URL of MAS/Manage application is"
  value       = data.external.maximo_admin_url.result.admin_url
}