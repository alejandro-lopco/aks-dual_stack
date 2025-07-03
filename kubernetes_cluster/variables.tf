variable "network_plugin" {
  type = string
  description = "AKS network plugin"

  validation {
    condition     = contains(["kubenet", "azure", null], lower(var.network_plugin))
    error_message = "Network Plugin no reconocido"
  }
}
variable "ip_versions" {
  type = list(string)

  default = [ "IPv4" ]
}
variable "node_count" {
  type = number
  description = "Cantidad de nodos a utilizar"
}
variable "vm_size" {
  type = string
  description = "tipo de VM en la correrá el cluster"
}
variable "public_ip" {
  type = bool
  description = "Otorgar una IP pública al cluster"
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