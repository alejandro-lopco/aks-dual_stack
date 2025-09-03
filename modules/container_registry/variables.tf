variable "acr_sku" {
  type = string

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "SKU no reconocido"
  }

  description = "Tipo de SKU utilazado para el ACE"
  default     = "Basic"
}
variable "admin_enabled" {
  type        = bool
  description = "Creación de un usuario de Administrados"
  default     = false
}
variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Habilitar la conexión desde redes públicas"
}
variable "quarantine_policy_enabled" {
  type        = bool
  default     = false
  description = "Habilitar la política de Cuarentena"
}
variable "retention_policy_in_days" {
  type        = number
  default     = null
  description = "Tiempo limite para elimicación de imágenes con tags desactualizadas"
}
variable "trust_policy_enabled" {
  type        = bool
  default     = false
  description = "Habilitar la Trust Policy"
}
variable "zone_redundancy_enabled" {
  type        = bool
  default     = false
  description = "Habilitar la redundancia de Zonas de Disponibilidad"
}
variable "export_policy_enabled" {
  type        = bool
  default     = true
  description = "Habilitar la política de exportación, para desactivar requiere tener var.public_network_access_enabled en False"
}
variable "anonymous_pull_enabled" {
  type        = bool
  default     = false
  description = "Habilitar la descarga de imagenes de usuarios no autenticados"
}
variable "data_endpoint_enabled" {
  type        = bool
  default     = false  
  description = "Habilitar endpoints de datos dedicados para el ACR, requiere Premium SKU"
}
variable "network_rule_bypass_option" {
  type = string

  validation {
    condition = contains(["None", "AzureServices"], var.network_rule_bypass_option)
    error_message = "Bypass no reconocido"
  }

  default     = "AzureServices"
  description = "Habilitar el paso al ACR a servicios de Azure"
}
