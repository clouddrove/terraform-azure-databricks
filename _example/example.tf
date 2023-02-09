provider "azurerm" {
  features {}
}

module "resource_group" {
  source  = "clouddrove/resource-group/azure"
  version = "1.0.0"

  name        = "app"
  environment = "test"
  label_order = ["environment", "name", ]
  location    = "North Europe"
}

module "vnet" {
  source  = "clouddrove/vnet/azure"
  version = "1.0.0"

  name                = "app"
  environment         = "test"
  label_order         = ["name", "environment"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "10.0.0.0/16"
  enable_ddos_pp      = false
}

module "subnet_pub" {
  source  = "clouddrove/subnet/azure"
  version = "1.0.1"

  name                 = "app"
  environment          = "test"
  label_order          = ["name", "environment"]
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = join("", module.vnet.vnet_name)

  #subnet
  default_name_subnet = true
  subnet_names        = ["pub-subnet"]
  subnet_prefixes     = ["10.0.1.0/24"]

  delegation = {
    service_delegation = [
      {
        name    = "Microsoft.Databricks/workspaces"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
      }
    ]
  }
}

module "subnet_pvt" {
  source  = "clouddrove/subnet/azure"
  version = "1.0.1"

  name                 = "app"
  environment          = "test"
  label_order          = ["name", "environment"]
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = join("", module.vnet.vnet_name)

  #subnet
  default_name_subnet = true
  subnet_names        = ["pvt-subnet"]
  subnet_prefixes     = ["10.0.2.0/24"]

  delegation = {
    service_delegation = [
      {
        name    = "Microsoft.Databricks/workspaces"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
      }
    ]
  }
}

module "network_security_group_public" {
  depends_on              = [module.subnet_pub]
  source                  = "clouddrove/network-security-group/azure"
  version                 = "1.0.1"
  resource_group_location = module.resource_group.resource_group_location
  label_order             = ["name", "environment"]
  name                    = "app-pub"
  environment             = "test"
  subnet_ids              = module.subnet_pub.default_subnet_id
  resource_group_name     = module.resource_group.resource_group_name
}

module "network_security_group_private" {
  depends_on              = [module.subnet_pvt]
  source                  = "clouddrove/network-security-group/azure"
  version                 = "1.0.1"
  resource_group_location = module.resource_group.resource_group_location
  label_order             = ["name", "environment"]
  name                    = "app-pvt"
  environment             = "test"
  subnet_ids              = module.subnet_pvt.default_subnet_id
  resource_group_name     = module.resource_group.resource_group_name
}

module "databricks" {
  source                                               = "../"
  name                                                 = "app"
  environment                                          = "test"
  label_order                                          = ["name", "environment"]
  enable                                               = true
  resource_group_name                                  = module.resource_group.resource_group_name
  location                                             = module.resource_group.resource_group_location
  sku                                                  = "standard"
  network_security_group_rules_required                = "NoAzureDatabricksRules"
  public_network_access_enabled                        = false
  managed_resource_group_name                          = "databricks-resource-group"
  virtual_network_id                                   = module.vnet.vnet_id[0]
  public_subnet_name                                   = module.subnet_pub.default_subnet_name[0]
  private_subnet_name                                  = module.subnet_pvt.default_subnet_name[0]
  public_subnet_network_security_group_association_id  = module.network_security_group_public.id
  private_subnet_network_security_group_association_id = module.network_security_group_private.id
  no_public_ip                                         = true
  storage_account_name                                 = "databrickstestingcd"
}