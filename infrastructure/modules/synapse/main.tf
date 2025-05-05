resource "azurerm_synapse_workspace" "workspace" {
  name                                 = "${var.prefix}-${var.env}-synapse"
  resource_group_name                  = var.resource_group_name
  location                            = var.location
  storage_data_lake_gen2_filesystem_id = var.datalake_filesystem_id
  sql_administrator_login              = var.sql_admin_login
  sql_administrator_login_password     = var.sql_admin_password

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_synapse_spark_pool" "spark" {
  name                 = "forecast-spark"
  synapse_workspace_id = azurerm_synapse_workspace.workspace.id
  node_size_family     = "MemoryOptimized"
  node_size            = "Small"
  node_count           = 3
}
