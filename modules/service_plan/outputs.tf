output "name" {
  value = azurerm_service_plan.this.name
}
output "rg" {
  value = azurerm_service_plan.this.resource_group_name
}
output "id" {
  value = azurerm_service_plan.this.id
}
output "sku" {
  value = azurerm_service_plan.this.sku_name
}