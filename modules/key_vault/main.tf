data "azurerm_client_config" "this" {}

module "resource_naming" {
  source = "../resource_naming"
}

resource "azurerm_key_vault" "this" {
  name                = "${var.kv_name}${module.resource_naming.prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name

  tenant_id = data.azurerm_client_config.this.tenant_id

  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  purge_protection_enabled    = var.purge_protection_enabled
  soft_delete_retention_days  = var.soft_delete_retention_days
  enable_rbac_authorization   = var.enable_rbac_authorization

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment

  sku_name = var.sku_name

  tags = merge(var.tags, { service = "kv" })
}
