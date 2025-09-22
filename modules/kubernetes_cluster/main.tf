module "resource_naming" {
  source = "../resource_naming"
}
  
  resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.aks_name}${module.resource_naming.prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix = "aksAnyway"

  default_node_pool {
    name = var.node_pool_name

    node_count  = var.node_count
    vm_size     = var.vm_size

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
