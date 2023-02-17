output "id" {
  value       = join("", azurerm_databricks_workspace.this.*.id)
  description = "Specifies the resource id of the Workspace." 
}


