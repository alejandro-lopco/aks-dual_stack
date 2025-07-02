resource "azurerm_virtual_network" "this" {
  name      = "vNet-${var.project}-${var.location}-${var.environment}"
  location  = var.location

  address_space = var.address_space

  subnet = {
    name              = "subvNet-${var.project}-${var.location}-${var.environment}"
    address_prefixes  = var.address_prefixes
  }

  resource_group_name = "rg-${var.project}-${var.location}-${var.environment}"

  tags = merge(var.tags, { "service" = "vNet" })

  depends_on = [ 
    azurerm_resource_group
  ]
}