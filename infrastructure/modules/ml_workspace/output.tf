output "workspace_id" {
  value = azurerm_machine_learning_workspace.workspace.id
}

output "app_insights_id" {
  value = azurerm_application_insights.ml_insights.id
}

output "key_vault_id" {
  value = azurerm_key_vault.ml_kv.id
}
