# Terraform version
terraform {
  required_version = ">= 1.7.8"
}
terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.112.0"
    }
  }
}