variable "enabled_for_disk_encryption" {
  type = bool

  default = false
  description = "Habilitar la encriptración del disco"
}
variable "purge_protection_enabled" {
  type = bool

  default = true
  description = "Protección de eliminación"
}
variable "soft_delete_retention_days" {
  type = number

  default = 7
  description = "Tiempo de retención de archivos eliminados"
}
variable "enable_rbac_authorization" {
  type = bool

  default = false
  description = "Habilitar credenciales basados en Role Access Based Control"
}
variable "enabled_for_deployment" {
  type = bool

  default = true
  description = "Habilitar VMs recoger credenciales"
}
variable "enabled_for_template_deployment" {
  type = bool

  default = true
  description = "Habiliar a Azure Resource Manager recoger credenciales"  
}
variable "sku_name" {
  type = string
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "SKU no permitido/reconocido"
  }

  default = "standard"
  description = "Tipo de SKU de almacenamiento"
}
variable "certificate_permissions" {
  type = list(string)

  default = null
  description = "Listado de permisos de certificado"
}
variable "key_permissions" {
  type = list(string)

  default = null
  description = "Listado de permisos de clave"
}
variable "secret_permissions" {
  type = list(string)

  default = null
  description = "Listado de permisos de secretos"
}
variable "storage_permissions" {
  type = list(string)

  default = null
  description = "Listado de permisos de almacenamiento"
}
