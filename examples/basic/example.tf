provider "azurerm" {
  features {}
  subscription_id = "000000-11111-1223-XXX-XXXXXXXXXX"
}

provider "databricks" {
  azure_workspace_resource_id = module.databricks.id
}

module "databricks" {
  source                                               = "../../"
  name                                                 = "app"
  environment                                          = "test"
  label_order                                          = ["name", "environment"]
  enable                                               = true
  resource_group_name                                  = "test"
  location                                             = "test"
  sku                                                  = "trial"
  network_security_group_rules_required                = "AllRules"
  public_network_access_enabled                        = true
  managed_resource_group_name                          = "databricks-resource-group"
  virtual_network_id                                   = "133212"
  public_subnet_name                                   = "133212"
  private_subnet_name                                  = "133212"
  public_subnet_network_security_group_association_id  = "133212"
  private_subnet_network_security_group_association_id = "133212"
  no_public_ip                                         = false
  storage_account_name                                 = "databrickstestingcd"

  cluster_enable          = true
  autotermination_minutes = 20
  # spark_version = "11.3.x-scala2.12" # Enter manual spark version or will choose latest spark version
  # num_workers             = 0  # Required when enable_autoscale is false

  enable_autoscale = true
  min_workers      = 1
  max_workers      = 2

  cluster_profile = "multiNode"
}
