########################################################################################################################
# Outputs
########################################################################################################################

output "maximo_admin_url" {
  description = "Admin URL of Manage application is"
  value       = data.external.maximo_admin_url.result.admin_url
  #value       = jsondecode(data.external.maximo_admin_url.result.admin_url)
}