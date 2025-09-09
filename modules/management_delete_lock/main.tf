resource "azurerm_management_lock" "this" {
  name        = var.mgmtlock_name

  scope       = var.scope_id
  lock_level  = "CanNotDelete"
  notes       = "Este recurso esta configurado para evitar el borrado accidental"
}