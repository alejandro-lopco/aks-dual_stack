output "name" {
  value = azurerm_container_registry.this.name
}
output "location" {
  value = azurerm_container_registry.this.location
}
output "sku" {
  value = azurerm_container_registry.this.sku
}
output "admin_enabled" {
  value = azurerm_container_registry.this.admin_enabled
}
output "public_network_access_enabled" {
  value = azurerm_container_registry.this.public_network_access_enabled
}
output "quarantine_policy_enabled" {
  value = azurerm_container_registry.this.quarantine_policy_enabled
}
output "nretention_policy_in_daysame" {
  value = azurerm_container_registry.this.retention_policy_in_days
}
output "trust_policy_enabled" {
  value = azurerm_container_registry.this.trust_policy_enabled
}
output "zone_redundancy_enabled" {
  value = azurerm_container_registry.this.zone_redundancy_enabled
}
output "export_policy_enabled" {
  value = azurerm_container_registry.this.export_policy_enabled
}
output "anonymous_pull_enabled" {
  value = azurerm_container_registry.this.anonymous_pull_enabled
}
output "data_endpoint_enabled" {
  value = azurerm_container_registry.this.data_endpoint_enabled
}
output "network_rule_bypass_option" {
  value = azurerm_container_registry.this.network_rule_bypass_option
}
