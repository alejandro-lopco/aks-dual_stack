variable "prefix" {
  type = string
  description = "Prefijo del recurso a monitorizar"
}
variable "target_resource_id" {
  type = string
  description = "ID del recurso a monitorizar"
}
variable "log_destination" {
  type = object({
    log_analytics_workspace_id = optional(string, null)
    storage_account_id = optional(string, null)
  })
  description = "Destino a donde se mandarán las logs, debe tener mínimo uno configurado"

  validation {
    condition = (var.log_destination.log_analytics_workspace_id != null || var.log_destination.storage_account_id != null)
    error_message = "No hay ningún destino configurado"
  }
}
variable "logs" {
  type = list(string)
  description = "Categoría de logs que se van a monitorizar"
}
variable "metrics" {
  type = list(string)
  description = "Métricas que se recogeran dentro de cada categoría"
}