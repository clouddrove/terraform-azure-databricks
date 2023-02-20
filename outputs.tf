output "id" {
  value       = join("", azurerm_databricks_workspace.main.*.id)
  description = "Specifies the resource id of the Workspace."
}


