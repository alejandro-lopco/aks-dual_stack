resource "azurerm_resource_group" "this" {
  name      = "rg-${var.project}-${var.location}-${var.environment}"
  location  = var.location

  tags = merge(var.tags, { "service" = "rg" })
}