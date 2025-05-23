resource "azurerm_application_insights" "ml_insights" {
  name                = "${var.prefix}-${var.env}-ml-ai"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  retention_in_days   = var.app_insights_retention
  tags                = var.tags
}

resource "azurerm_key_vault" "ml_kv" {
  name                = "${replace(var.prefix, "-", "")}${var.env}mlkv" # Key Vault name rules
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  purge_protection    = var.kv_purge_protection

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
    ]
  }

  tags = var.tags
}

resource "azurerm_machine_learning_workspace" "workspace" {
  name                    = "${var.prefix}-${var.env}-mlw"
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = azurerm_application_insights.ml_insights.id
  key_vault_id            = azurerm_key_vault.ml_kv.id
  storage_account_id      = var.storage_account_id

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
