resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = "rg-${var.project}-${var.environment}"

  dns_prefix = "aksAnyway"

  default_node_pool {
    name = "nodepool"

    node_count = var.node_count
    vm_size = var.vm_size

    node_public_ip_enabled = var.public_ip
  }

  network_profile {
    network_plugin    = var.network_plugin
    ip_versions       = var.ip_versions
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(var.tags, { "service" = "aks", "networking " = "dual-stack" })
}

module "delete_lock" {
  source = "../management_delete_lock"

  prefix          = "aks"
  subscription_id = var.subscription_id
  environment     = var.environment
  location        = var.location
  project         = var.project

  scope_id = azurerm_kubernetes_cluster.this.id

  tags = {}
}

module "monitor_diagnostic_setting" {
  source = "../monitor_diagnostic_setting"

  prefix          = "aks"
  subscription_id = var.subscription_id
  environment     = var.environment
  location        = var.location
  project         = var.project

  log_destination = var.log_destination.storage_account_id
  logs = var.logs
  metrics = var.metrics
  target_resource_id = azurerm_kubernetes_cluster.this.id

  tags = {}
}