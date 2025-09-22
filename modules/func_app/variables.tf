variable "funcapp_name" {
  type = string
}
variable "vnet_name" {
  type    = string

  default = "vNet-Anyway"
}
variable "address_space" {
  type = list(string)

  default     = [ "10.0.0.0/16" ]
  description = "Rango CIDR para la red"
}
variable "address_prefixes" {
  type = list(string)

  default     = [ "10.0.0.1/24" ]
  description = "Rango CIDR para la subred"
}
variable "kv_name" {
  type = string

  default = "kvAnyway3D2025"
}
variable "sto_acc_name" {
  type = string

  default = "stoaccanyway3d2025"
}
variable "sv_name" {
  type = string

  default = "svAnyway3D2025"
}
variable "https_only" {
  type = bool

  description   = "Habilitar el tráfico por HTTPS"
  default       = true
}
variable "public_network_access_enabled" {
  type = bool

  description = "Permitir el acceso desde redes públicas"
  default = false
}
variable "ftp_publish_basic_authentication_enabled" {
  type = bool

  description = "Habilitar el perfil de autenticación básica FTP"
  default = true
}
variable "webdeploy_publish_basic_authentication_enabled" {
  type = bool

  description = "Habilitar el perfil de autenticación básica WebDeploy"
  default = true
}
variable "site_config" {
  type = object({
    api_definition_url                     = optional(string)
    app_command_line                       = optional(string)
    app_scale_limit                        = optional(number)
    application_insights_connection_string = optional(string)
    application_insights_key               = optional(string)

    application_stack = optional(object({
      dotnet_version              = optional(string)
      use_dotnet_isolated_runtime = optional(bool)
      java_version                = optional(string)
      node_version                = optional(string)
      powershell_core_version     = optional(string)
      use_custom_runtime          = optional(bool)
    }))

    elastic_instance_minimum          = optional(number)
    http2_enabled                     = optional(bool, true)
    health_check_eviction_time_in_min = optional(number)
    health_check_path                 = optional(string)
    minimum_tls_version               = optional(string)
    pre_warmed_instance_count         = optional(number)
    remote_debugging_enabled          = optional(bool)
    remote_debugging_version          = optional(string)
    runtime_scale_monitoring_enabled  = optional(bool)
    use_32_bit_worker                 = optional(bool)
    worker_count                      = optional(number)
    
    cors = optional(object({
      allowed_origins     = optional(set(string))
      support_credentials = optional(bool)
    }))
  })

  description   = "Configuración del site hosteando la function app"
  default       = {}
}
variable "network_settings" {
  type = object({
    delegated_subnet_id                  = string
    subnet_id                            = string
    private_dns_zone_ids                 = set(string)
    resource_group_name_private_endpoint = optional(string)
  })

  description = "Configuración de red"
  default  = null
}
