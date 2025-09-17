module "rn" {
  source = "../resource_naming"
}

resource "azurerm_public_ip" "this" {
  name                = "${var.public_ip_name}-${module.rn.prefix}"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku               = var.sku.sku_name
  sku_tier          = var.sku.sku_tier
  allocation_method = var.allocation_method
  domain_name_label = var.domain_name_label

  ip_version    = var.ip_version
  zones         = var.zones

  idle_timeout_in_minutes = var.idle_timeout_in_minutes

  tags = merge(var.tags, { service = "public_ip", type = "networking" })
}