module "resource_naming" {
  source = "../resource_naming"
}

resource "azurerm_virtual_network" "this" {
  name      = var.vnet_name
  location  = var.location

  address_space = var.address_space

  resource_group_name = var.resource_group_name



  tags = merge(var.tags, { service = "vNet" })
}
resource "azurerm_subnet" "this" {
  name = "subvNet-${azurerm_virtual_network.this.name}"

  resource_group_name = azurerm_virtual_network.this.resource_group_name

  virtual_network_name  = azurerm_virtual_network.this.name
  address_prefixes      = var.address_prefixes

  dynamic "delegation" {
    for_each = var.service_delegations != null ? var.service_delegations : []

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_name
        actions = delegation.value.actions
      }
    }
  }
}

module "management_delete_lock" {
  source = "../management_delete_lock"

  mgmtlock_name       = "vnet_mgmtlock${module.resource_naming.prefix}"
  resource_group_name = var.resource_group_name  

  environment = var.environment
  scope_id    = azurerm_virtual_network.this.id

  subscription_id = var.subscription_id
  location        = var.location

  tags = merge(var.tags, { service = "delete_lock" })
}