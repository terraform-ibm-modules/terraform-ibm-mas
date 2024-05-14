########################################################################################################################
# Outputs
########################################################################################################################

output "prefix" {
  value       = module.landing_zone.prefix
  description = "prefix"
}

output "region" {
  value       = var.region
  description = "Region where SLZ ROKS Cluster is deployed."
}

output "cluster_data" {
  value       = module.landing_zone.cluster_data
  description = "Details of OCP cluster."
}

output "workload_cluster_id" {
  value       = module.landing_zone.workload_cluster_id
  description = "ID of the workload cluster."
}
