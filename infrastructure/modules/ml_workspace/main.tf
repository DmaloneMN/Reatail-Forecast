resource "azurerm_machine_learning_workspace" "workspace" {
  name                    = "${var.prefix}-${var.env}-mlw"
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = azurerm_application_insights.insights.id
  key_vault_id            = azurerm_key_vault.kv.id
  storage_account_id       = var.storage_account_id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_machine_learning_compute_cluster" "training" {
  name                          = "cpu-cluster"
  machine_learning_workspace_id = azurerm_machine_learning_workspace.workspace.id
  vm_priority                   = "LowPriority"
  vm_size                       = "Standard_DS3_v2"
  scale_settings {
    min_node_count = 0
    max_node_count = 4
  }
}
