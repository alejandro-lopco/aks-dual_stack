resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks-${var.project}-${var.location}-${var.environment}"
  location            = var.location
  resource_group_name = "rg-${var.project}-${var.location}-${var.environment}"

  default_node_pool {
    name = "node_pool-${azurerm_kubernetes_cluster.this[0].name}"

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

  depends_on = [
    azurerm_resource_group.this,
    azurerm_virtual_network.this
  ]
}