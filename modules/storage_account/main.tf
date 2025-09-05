resource "azurerm_storage_account" "this" {
  name                = "stoacc${var.prefix}${var.environment}"
  resource_group_name = "rg-${var.prefix}-${var.environment}"
  location            = var.location

  account_tier = var.account_tier
  account_replication_type = var.account_replication_type

  https_traffic_only_enabled = var.https_traffic
  public_network_access_enabled = var.public_access



  tags = {
    env   = var.environment
  }
}

module "management_delete_lock" {
  source = "../management_delete_lock"

  
  prefix = var.prefix
  environment = var.environment
  scope_id = azurerm_storage_account.this.id

  subscription_id = var.subscription_id
  location = var.location

  tags = merge(var.tags, { service = "stoAcc_delete_lock" })
}