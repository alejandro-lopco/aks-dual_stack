output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "name" {
  value = azurerm_virtual_network.this.name
}

output "location" {
  value = var.location
}

output "subvNet_id" {
  value = azurerm_subnet.this.id
}
