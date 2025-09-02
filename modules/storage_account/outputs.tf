output "storage_account_id" {
  value = azurerm_storage_account.this.id
}
output "storage_account_tier" {
  value = azurerm_storage_account.this.account_tier
}
output "storage_account_replication" {
  value = azurerm_storage_account.this.account_replication_type
}
output "storage_account_https_enabled" {
  value = azurerm_storage_account.this.https_traffic_only_enabled
}
output "storage_account_public_access" {
  value = azurerm_storage_account.this.public_network_access_enabled
}
