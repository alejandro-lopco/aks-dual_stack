module "resource_naming" {
  source = "../resource_naming"
}
module "rg" {
  source = "../resource_group"

  resource_group_name = var.resource_group_name
  subscription_id     = var.subscription_id
  location            = var.location
}

resource "azurerm_container_registry" "this" {
  name                = "${var.acr_name}${module.resource_naming.prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku = var.acr_sku

  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  quarantine_policy_enabled     = var.quarantine_policy_enabled
  retention_policy_in_days      = var.retention_policy_in_days
  trust_policy_enabled          = var.trust_policy_enabled
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  export_policy_enabled         = var.export_policy_enabled 
  anonymous_pull_enabled        = var.anonymous_pull_enabled 
  data_endpoint_enabled         = var.data_endpoint_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option

  identity {
    type = "SystemAssigned"
  }



  tags = merge(var.tags, { service = "acr" })
}

module "management_delete_lock" {
  source = "../management_delete_lock"

  mgmtlock_name       = "ACR_mgmtlock${module.resource_naming.prefix}"
  resource_group_name = var.resource_group_name

  environment         = var.environment
  scope_id            = azurerm_container_registry.this.id

  subscription_id = var.subscription_id
  location        = var.location

  tags = merge(var.tags, { service = "acr_delete_lock" })
}