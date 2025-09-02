resource "azurerm_virtual_network" "this" {
  name      = "vNet-${var.project}-${var.environment}"
  location  = var.location

  address_space = var.address_space

  resource_group_name = "rg-${var.project}-${var.environment}"

  tags = merge(var.tags, { service = "vNet" })
}
resource "azurerm_subnet" "this" {
  name = "subvNet-${var.project}-${var.environment}"

  resource_group_name = azurerm_virtual_network.this.resource_group_name

  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes  = var.address_prefixes
}

module "delete_lock" {
  source = "../management_delete_lock"

  prefix          = "vNet"
  subscription_id = var.subscription_id
  environment     = var.environment
  location        = var.location
  project         = var.project

  scope_id = azurerm_virtual_network.this.id

  tags = {
    service = "vNet"
  }
}

module "delete_lock" {
  source = "../management_delete_lock"

  prefix          = "subvNet"
  subscription_id = var.subscription_id
  environment     = var.environment
  location        = var.location
  project         = var.project

  scope_id = azurerm_subnet.this.id

  tags = {
    service = "vNet"
  }
}