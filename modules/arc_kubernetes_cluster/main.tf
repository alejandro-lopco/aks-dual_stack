data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

resource "azuread_application" "this" {
  display_name = "${var.arc_kubernetes_cluster_name}-sp"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "this" {
  client_id                    = azuread_application.this.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.id
}

resource "azurerm_role_assignment" "this" {
  scope                = data.azurerm_subscription.current.id
  principal_id         = azuread_service_principal.this.object_id
  role_definition_name = "Contributor"
}

resource "azurerm_arc_kubernetes_cluster" "this" {
  name                         = var.arc_kubernetes_cluster_name
  
  resource_group_name          = var.resource_group_name
  location                     = var.location

  agent_public_key_certificate = filebase64(var.agent_public_key_certificate)

  identity {
    type = "SystemAssigned"
  }

  tags = merge(var.tags, { service = "aks", type = "Azure Arc" })
}
