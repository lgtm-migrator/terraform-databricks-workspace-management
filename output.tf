output "databricks_host" {
  description = "databricks cluster id"
  value       = join("", databricks_cluster.cluster.*.id)
}

output "databricks_token" {
  description = "databricks token"
  value       = databricks_token.pat.id
  sensitive   = true
}

output "notebook_url" {
  description = "databricks notebook url"
  value       = { for k, v in databricks_notebook.notebook_file : k => v.url }
}

output "job_url" {
  description = "databricks job url"
  value       = { for k, v in databricks_job.databricks_job : k => v.url }
}

output "job_new_cluster_url" {
  description = "databricks new cluster job url"
  value       = { for k, v in databricks_job.databricks_new_cluster_job : k => v.url }
}

output "databricks_secret_acl" {
  description = "databricks secret acl"
  value       = databricks_secret_acl.spectators.principal
}

output "databricks_group" {
  description = "databricks group name"
  value       = databricks_group.spectators.display_name
}

output "databricks_user" {
  description = "databricks user name"
  value       = join("", databricks_user.users.*.display_name)
}

output "databricks_user_id" {
  description = "databricks user id"
  value       = join("", databricks_user.users.*.id)
}


output "databricks_group_member" {
  description = "databricks group members"
  value       = join("", databricks_group_member.group_members.*.group_id)
}

/*
output "databricks_permissions_job" {
  value = databricks_permissions.
}
*/

output "databricks_permissions_cluster" {
  description = "databricks cluster permissions"
  value       = join("", databricks_permissions.cluster.*.id)
}

output "databricks_permissions_policy" {
  description = "databricks cluster policy"
  value       = join("", databricks_permissions.policy.*.id)
}

output "databricks_permissions_pool" {
  description = "databricks instance pool permissions"
  value       = join("", databricks_permissions.pool.*.id)
}
