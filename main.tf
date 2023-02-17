## Managed By : CloudDrove
## Copyright @ CloudDrove. All Right Reserved.

module "labels" {

  source  = "clouddrove/labels/azure"
  version = "1.0.0"

  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
}

resource "azurerm_databricks_workspace" "this" {

  count                                 = var.enable == true ? 1 : 0
  name                                  = format("%s-databricks", module.labels.id)
  resource_group_name                   = var.resource_group_name
  location                              = var.location
  sku                                   = var.sku
  network_security_group_rules_required = var.network_security_group_rules_required
  public_network_access_enabled         = var.public_network_access_enabled
  managed_resource_group_name           = var.managed_resource_group_name

  custom_parameters {
    virtual_network_id                                   = var.virtual_network_id
    private_subnet_name                                  = var.private_subnet_name
    public_subnet_name                                   = var.public_subnet_name
    public_subnet_network_security_group_association_id  = var.public_subnet_network_security_group_association_id
    private_subnet_network_security_group_association_id = var.private_subnet_network_security_group_association_id
    no_public_ip                                         = var.no_public_ip
    storage_account_name                                 = var.storage_account_name
  }

  depends_on = [
   module.labels 
  ]
}

data "databricks_node_type" "smallest" {
  local_disk = true

  depends_on = [
    azurerm_databricks_workspace.this
  ]
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true

  depends_on = [
    azurerm_databricks_workspace.this
  ]
}

resource "databricks_cluster" "cluster" {
  count = var.cluster_enable == true ? 1 : 0
  cluster_name = format("dbsc-%s",var.name,)

  spark_version = data.databricks_spark_version.latest_lts.id
  node_type_id  = data.databricks_node_type.smallest.id
  num_workers = var.num_workers

  autotermination_minutes = var.autotermination_minutes

  spark_conf = {
    "spark.databricks.cluster.profile" : "singleNode"
    "spark.master" : "local[*]"
  }

  depends_on = [
    azurerm_databricks_workspace.this
  ]
}