module "resource_naming" {
  source = "../resource_naming"
}

resource "azurerm_storage_account" "this" {
  name                = var.sto_acc_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type

  https_traffic_only_enabled    = var.https_traffic
  public_network_access_enabled = var.public_access



  tags = merge(var.tags, { service = "stoAcc" })
}
