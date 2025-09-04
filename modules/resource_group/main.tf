resource "azurerm_resource_group" "this" {
  name      = "rg-${var.prefix}-${var.environment}"
  location  = var.location

  tags = merge(var.tags, { "service" = "rg" })
}