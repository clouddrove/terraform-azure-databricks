## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autotermination\_minutes | Set a minutes to auto terminate cluster if it's unhealthy. | `number` | `20` | no |
| cluster\_enable | Set to false to prevent the databricks cluster from creating it's resources. | `bool` | `false` | no |
| cluster\_profile | The profile that Cluster will be contain. Possible values are 'singleNode' and 'multiNode' | `string` | `""` | no |
| enable | Set to false to prevent the module from creating any resources. | `bool` | `false` | no |
| enable\_autoscale | Set to false to not enable the Autoscale feature from the cluster. | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| label\_order | Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] . | `list(any)` | `[]` | no |
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `""` | no |
| managed\_resource\_group\_name | Managed Resource Group name to create Resource group by provided name. | `string` | `""` | no |
| managedby | Managed By e.g. Clouddrove , Anmol Nagpal | `string` | `""` | no |
| max\_workers | Set a Ammount of maximum workers that needs to be created among with Databricks Cluster. | `number` | n/a | yes |
| min\_workers | Set a Ammount of minimum workers that needs to be created among with Databricks Cluster. | `number` | n/a | yes |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| network\_security\_group\_rules\_required | Does the data plane (clusters) to control plane communication happen over private link endpoint only or publicly? Possible values AllRules, NoAzureDatabricksRules or NoAzureServiceRules. Required when public\_network\_access\_enabled is set to false. | `string` | `""` | no |
| no\_public\_ip | Select true to disble public IP. | `string` | `""` | no |
| num\_workers | Set a Ammount of workers that needs to be created among with Databricks Cluster. | `number` | `0` | no |
| private\_subnet\_name | Private Subnet Name to attach with databricks. | `string` | `""` | no |
| private\_subnet\_network\_security\_group\_association\_id | Private subnet Network security group association ID of the Virtual Network to attach with databricks. | `string` | `""` | no |
| public\_network\_access\_enabled | Set to false to disable public Network access to the databricks. | `bool` | n/a | yes |
| public\_subnet\_name | Public Subnet Name to attach with databricks. | `string` | `""` | no |
| public\_subnet\_network\_security\_group\_association\_id | Public subnet Network security group association ID of the Virtual Network to attach with databricks. | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `""` | no |
| resource\_group\_name | The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | `string` | `""` | no |
| sku | The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial. | `string` | `""` | no |
| spark\_version | Enter the Spark version to to create the Databricks's Cluster. | `string` | `null` | no |
| storage\_account\_name | Storage account name to attach with databricks. | `string` | `""` | no |
| virtual\_network\_id | Id of the Virtual Network to attach with databricks. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Specifies the resource id of the Workspace. |

