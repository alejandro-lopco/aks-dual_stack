output "vnet_id" {
  value = try(azurerm_virtual_network.this[0].id, null)
}

output "name" {
  value = try(azurerm_virtual_network.this[0].name, null)
}

output "location" {
  value = var.location
}

output "subvNet_id" {
  value = try(azurerm_virtual_network.this[0].subnet[0].id, null)
}