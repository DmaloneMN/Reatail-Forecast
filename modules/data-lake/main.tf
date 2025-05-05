resource "azurerm_storage_account" "datalake" {
  name                     = "orderdl${random_string.uniq.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = var.allowed_subnets
    ip_rules                   = var.allowed_ips
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(var.tags, {
    "WAF-Pillar" = "Security"
  })
}

resource "azurerm_storage_data_lake_gen2_filesystem" "containers" {
  for_each           = toset(["raw", "processed", "curated", "ml-models"])
  name               = each.key
  storage_account_id = azurerm_storage_account.datalake.id

  properties = {
    "WellArchitected" = "Optimized"
  }
}

resource "azurerm_role_assignment" "data_access" {
  for_each             = var.access_principals
  scope                = azurerm_storage_account.datalake.id
  role_definition_name = each.value.role
  principal_id         = each.value.principal_id
}
