output "id" {
  value       = join("", azurerm_databricks_workspace.example.*.id)
  description = "Specifies the resource id of the Workspace."
}


