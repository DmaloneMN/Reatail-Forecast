resource "azurerm_storage_account" "datalake" {
  name                     = "${var.prefix}${var.env}datalake"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true # Enable Data Lake Gen2

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = var.allowed_subnet_ids
    ip_rules                   = var.allowed_ips
  }

  tags = merge(var.tags, {
    "WAF-Pillar" = "Security"
  })
}

resource "azurerm_storage_data_lake_gen2_filesystem" "containers" {
  for_each           = toset(["raw", "processed", "forecasts", "ml-models"])
  name               = each.key
  storage_account_id = azurerm_storage_account.datalake.id
}
