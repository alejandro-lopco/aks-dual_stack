output "location" {
  value = azurerm_key_vault.this.location
}
output "sku" {
  value = azurerm_key_vault.this.sku_name
}
output "encryptionEnabled" {
  value = azurerm_key_vault.this.enabled_for_disk_encryption
}
output "purgeProtectionEnabled" {
  value = azurerm_key_vault.this.purge_protection_enabled
}
output "softDeleteRetention" {
  value = azurerm_key_vault.this.soft_delete_retention_days
}
output "RBACEnabled" {
  value = azurerm_key_vault.this.enable_rbac_authorization
}
output "deploymentEnabled" {
  value = azurerm_key_vault.this.enabled_for_deployment
}
output "templateDeploymentEnabled" {
  value = azurerm_key_vault.this.enabled_for_template_deployment
}
# Access policy
output "certifacatePerms" {
  value = azurerm_key_vault_access_policy.this.certificate_permissions
}
output "keyPerms" {
  value = azurerm_key_vault_access_policy.this.key_permissions
}
output "secretPerms" {
  value = azurerm_key_vault_access_policy.this.secret_permissions
}
output "storagePerms" {
  value = azurerm_key_vault_access_policy.this.storage_permissions
}
