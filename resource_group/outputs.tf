output "id" {
  value = try(azurerm_resource_group.this[0].id, null)
}

output "name" {
  value = try(azurerm_resource_group.this[0].name, null)
}

output "location" {
  value = var.location
}
