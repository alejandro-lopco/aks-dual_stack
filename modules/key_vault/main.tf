data "azurerm_client_config" "this" {}

resource "azurerm_key_vault" "this" {
  name                = "akv${var.prefix}${var.environment}alopco"
  location            = var.location
  resource_group_name = "rg-${var.prefix}-${var.environment}"

  tenant_id = data.azurerm_client_config.this.tenant_id
  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  purge_protection_enabled = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days
  enable_rbac_authorization = var.enable_rbac_authorization
  enabled_for_deployment = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment

  sku_name = var.sku_name

  tags = merge(var.tags, { service = "kv" })
}

module "management_delete_lock" {
  source = "../management_delete_lock"

  prefix = var.prefix
  environment = var.environment
  scope_id = azurerm_key_vault.this.id

  subscription_id = var.subscription_id
  location = var.location

  tags = merge(var.tags, { service = "delete_lock" })
}