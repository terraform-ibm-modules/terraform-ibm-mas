########################################################################################################################
# Outputs
########################################################################################################################

output "maximo_admin_url" {
  description = "Admin URL of MAS/Manage application is"
  value       = module.existing_cluster.maximo_admin_url
}
