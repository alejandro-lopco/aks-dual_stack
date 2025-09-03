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

module "management_delete_lock" {
  source = "../management_delete_lock"

  project = var.project
  prefix = var.prefix
  environment = var.environment
  scope_id = azurerm_kubernetes_cluster.this.id

  subscription_id = var.subscription_id
  location = var.location

  tags = merge(var.tags, { service = "delete_lock" })
}