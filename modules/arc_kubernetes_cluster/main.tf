resource "azurerm_arc_kubernetes_cluster" "this" {
  name                         = var.arc_kubernetes_cluster_name
  
  resource_group_name          = var.resource_group_name
  location                     = var.location

  agent_public_key_certificate = filebase64(var.agent_public_key_certificate)

  identity {
    type = "SystemAssigned"
  }

  tags = merge(var.tags, { service = "aks", type = "azure arc" })
}