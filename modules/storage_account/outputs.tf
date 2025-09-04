output "name" {
  value = azurerm_storage_account.this.name
}
output "id" {
  value = azurerm_storage_account.this.id
}
output "rg" {
  value = azurerm_storage_account.this.resource_group_name
}
output "tier" {
  value = azurerm_storage_account.this.account_tier
}
output "replication" {
  value = azurerm_storage_account.this.account_replication_type
}
output "https_enabled" {
  value = azurerm_storage_account.this.https_traffic_only_enabled
}
output "public_access" {
  value = azurerm_storage_account.this.public_network_access_enabled
}
