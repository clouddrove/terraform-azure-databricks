#Module      : LABEL
#Description : Terraform label module variable
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "repository" {
  type        = string
  default     = ""
  description = "Terraform current module repo"
}

variable "managedby" {
  type        = string
  default     = ""
  description = "Managed By e.g. Clouddrove , Anmol Nagpal"
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "enable" {
  type        = bool
  default     = false
  description = "Set to false to prevent the module from creating any resources."
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  default     = ""
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "sku" {
  type        = string
  default     = ""
  description = "The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial."
}

variable "network_security_group_rules_required" {
  type        = string
  default     = ""
  description = "Does the data plane (clusters) to control plane communication happen over private link endpoint only or publicly? Possible values AllRules, NoAzureDatabricksRules or NoAzureServiceRules. Required when public_network_access_enabled is set to false."
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Set to false to disable public Network access to the databricks."
}

variable "managed_resource_group_name" {
  type        = string
  default     = ""
  description = "Managed Resource Group name to create Resource group by provided name."
}

variable "virtual_network_id" {
  type        = string
  default     = ""
  description = "Id of the Virtual Network to attach with databricks."
}

variable "private_subnet_name" {
  type        = string
  default     = ""
  description = "Private Subnet Name to attach with databricks."
}

variable "public_subnet_name" {
  type        = string
  default     = ""
  description = "Public Subnet Name to attach with databricks."
}

variable "public_subnet_network_security_group_association_id" {
  type        = string
  default     = ""
  description = "Public subnet Network security group association ID of the Virtual Network to attach with databricks."
}

variable "private_subnet_network_security_group_association_id" {
  type        = string
  default     = ""
  description = "Private subnet Network security group association ID of the Virtual Network to attach with databricks."
}

variable "no_public_ip" {
  type        = string
  default     = ""
  description = "Select true to disble public IP."
}

variable "storage_account_name" {
  type        = string
  default     = ""
  description = "Storage account name to attach with databricks."
}

variable "cluster_enable" {
  type        = bool
  default     = false
  description = "Set to false to prevent the databricks cluster from creating it's resources."
}

variable "autotermination_minutes" {
  type        = number
  description = "Set a minutes to auto terminate cluster if it's unhealthy."
}

variable "num_workers" {
  type        = number
  default     = 0
  description = "Set a Ammount of workers that needs to be created among with Databricks Cluster."
}

variable "enable_autoscale" {
  type        = bool
  default     = false
  description = "Set to false to not enable the Autoscale feature from the cluster."
}

variable "min_workers" {
  type        = number
  description = "Set a Ammount of minimum workers that needs to be created among with Databricks Cluster."
}

variable "max_workers" {
  type        = number
  description = "Set a Ammount of maximum workers that needs to be created among with Databricks Cluster."
}

variable "cluster_profile" {
  type        = string
  default     = ""
  description = "The profile that Cluster will be contain. Possible values are 'singleNode' and 'multiNode'"
}