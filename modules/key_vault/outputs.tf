output "id" {
  value = azurerm_resource_group.this.id
}

output "name" {
  value = azurerm_resource_group.this.name
}

output "location" {
  value = var.location
}
output "Encryption Enabled" {
  value = var.enabled_for_disk_encryption
}
output "Purge Protection Enabled" {
  value = var.purge_protection_enabled
}
output "Soft Delete Retention" {
  value = var.soft_delete_retention_days
}
output "RBAC Enabled" {
  value = var.enable_rbac_authorization
}
output "Deployment Enabled" {
  value = var.enabled_for_deployment
}
output "Template Deployment Enabled" {
  value = var.enabled_for_template_deployment
}
# Access policy
output "Certifacate Perms" {
  value = var.certificate_permissions
}
output "Key Perms" {
  value = var.key_permissions
}
output "Secret Perms" {
  value = var.secret_permissions
}
output "Storage Perms" {
  value = var.storage_permissions
}
