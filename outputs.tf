output "id" {
  value       = try(azurerm_databricks_workspace.main[*].id, null)
  description = "Specifies the resource id of the Workspace."
}
