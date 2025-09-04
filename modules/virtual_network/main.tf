resource "azurerm_virtual_network" "this" {
  name      = "vNet-${var.prefix}-${var.environment}"
  location  = var.location

  address_space = var.address_space

  resource_group_name = "rg-${var.prefix}-${var.environment}"



  tags = merge(var.tags, { service = "vNet" })
}
resource "azurerm_subnet" "this" {
  name = "subvNet-${var.prefix}-${var.environment}"

  resource_group_name = azurerm_virtual_network.this.resource_group_name

  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes  = var.address_prefixes


}

module "management_delete_lock" {
  source = "../management_delete_lock"

  
  prefix = var.prefix
  environment = var.environment
  scope_id = azurerm_virtual_network.this.id

  subscription_id = var.subscription_id
  location = var.location

  tags = merge(var.tags, { service = "vNet_delete_lock" })
}

module "management_delete_lock" {
  source = "../management_delete_lock"

  
  prefix = var.prefix
  environment = var.environment
  scope_id = azurerm_subnet.this.id

  subscription_id = var.subscription_id
  location = var.location

  tags = merge(var.tags, { service = "SubVNet_delete_lock" })
}