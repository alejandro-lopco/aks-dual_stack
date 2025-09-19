output "id" {
  value = azurerm_application_gateway.this.id
}
output "name" {
  value = azurerm_application_gateway.this.name
}
output "location" {
  value = azurerm_application_gateway.this.location
}
output "ip_config" {
  value = azurerm_application_gateway.this.gateway_ip_configuration
}
output "application_gateway_resources" {
  value = azurerm_application_gateway.this
}