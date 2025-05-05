output "storage_account_id" {
  value = azurerm_storage_account.datalake.id
}

output "containers" {
  value = azurerm_storage_data_lake_gen2_filesystem.containers
}
