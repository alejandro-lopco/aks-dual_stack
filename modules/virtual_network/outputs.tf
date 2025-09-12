output "vnet_id" {
  value = azurerm_virtual_network.this.id
}
output "rg" {
  value = azurerm_virtual_network.this.resource_group_name
}
output "name" {
  value = azurerm_virtual_network.this.name
}
output "location" {
  value = var.location
}
output "subvNet_name" {
  value = azurerm_subnet.this.name
}
output "subvNet_id" {
  value = azurerm_subnet.this.id
}
