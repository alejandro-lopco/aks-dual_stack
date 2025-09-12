variable "sql_server_name" {
  type = string

  description = "Nombre del servidor"
  default = "sqlserveranyway"
  
}
variable "server_version" {
  type = string

  description = "Versión de MSSQL a utilizar"
  default = "12.0"
}
variable "minimum_tls_version" {
  type = string

  description = "Versión de TLS a utilizar"
  default = "1.2"
}
variable "public_network_access_enabled" {
  type = bool

  description = "Habilitar acceso desde redes públicas"
  default = false
}
variable "outbound_network_restriction_enabled" {
  type = bool

  description = "Habilitar restricciones de tráfico al exterior"
  default = false  
}
variable "administrator_login" {
  type = object({
    entra_id = list(string)

    entra_id_authentication_only = optional(bool)

    password = optional(object({
      login_username = optional(string)
      login_password = optional(string)
    }))

    object_id       = optional(string)
    tenant_id       = optional(string)
  })

  description = "Datos de creación de usuarios de admin"
}
# Database
variable "sql_db_name" {
  type = string

  description = "Nombre de la base de datos"
  default = "dbanyway"
}
variable "collation" {
  type = string

  description = "Tipo de dataset de carácteres a utilizar"
  default = "Modern_Spanish_CI_AS"
}
variable "license_type" {
  type = string

  description = "Espicificar el tipo de licencia que se posee de MSSQL"
  default = "BasePrice"
}
variable "max_size_gb" {
  type = number

  description = "Tamaño máximos de la base de datos"
  default = 10
}
variable "sku_name" {
  type = string

  description = "SKU a utilizar para la base de datos"
  default = "S0"
}
variable "enclave_type" {
  type = string

  description = "Tipo de entorno de seguridad a utilzar en la replicación elástica"
  default = "Default"
}
variable "zone_redundant" {
  type = bool

  description = "Habilitar la replicación por zonas de disponibilidad"
  default = false
}
variable "storage_account_type" {
  type = string

  description = "Tipo de la Storage Account usado para guardar los Backups de la BBDD"
  default = "Geo"
}