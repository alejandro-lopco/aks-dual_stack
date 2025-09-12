variable "logicapp_name" {
  type = string
}
variable "vnet_name" {
  type    = string

  default = "vNet-Anyway"
}
variable "sv_name" {
  type    = string

  default = "svAnyway3D2025"
}
variable "logic_app_version" {
  type        = string

  default     = "latest"
  description = "Versión a utilizar"
}
variable "https_only" {
  type        = bool

  default     = true
  description = "Habilitar únicamente tráfico HTTPS"
}
variable "site_config" {
  type = object({
    always_on = optional(bool, false)

    http2_enabled = optional(bool, true)

    runtime_scale_monitoring_enabled  = optional(bool, true)
    use_32_bit_worker_process         = optional(bool, false)
    dotnet_framework_version          = optional(string, "v4.0")

    ftps_state = optional(string, "Disabled")

    health_check_path = optional(string)

    min_tls_version     = optional(string, "1.2")
    websockets_enabled  = optional(bool, false)
  })

  default = {}
  description = "Objeto con la configuración de la logic app"
}
variable "public_network_access" {
  type        = string

  default     = "Enabled"
  description = "Habilitar el acceso desde redes públicas a la Logic App"
}
variable "app_settings" {
  type        = map(string)

  default     = {}
  description = "Lista clave-valor con variables de entorno"
}