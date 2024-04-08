########################################################################################################################
# Outputs
########################################################################################################################

output "maximo_admin_url" {
  description = "Admin URL of MAS/Manage application is"
  value       = data.external.get_admin_url.result.admin_url
}

output "pipeline_execution_status" {
  description = "Status of pipeline execution is"
  value       = data.external.get_pipeline_result.result.PipelineRunStatus
}
