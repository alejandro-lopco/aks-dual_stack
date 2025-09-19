variable "public_ip_name" {
  type = string

  description = "Nombre del recurso de la IP pública"
}
variable "sku" {
  type = object({
    sku_name = string
    sku_tier = string
  })

  validation {
    condition = contains(["Basic", "Standard"],var.sku.sku_name) && contains(["Regional", "Global"],var.sku.sku_tier)

    error_message = "Valores de SKU no válidos"
  }

  description = "Tipo de SKU a utilizar para la IP pública"
  default = {
    sku_name = "Standard"
    sku_tier = "Regional"
  }
}
variable "allocation_method" {
  type = string

  validation {
    condition = contains(["Static", "Dynamic"],var.allocation_method)
    
    error_message = "Método de asignación no reconocido"
  }

  description   = "Tipo de asignación de IP pública a utilizar"
  default       = "Static"
}
variable "domain_name_label" {
  type = string

  description = "nombre DNS de la IP pública"
}
variable "ip_version" {
  type = string

  validation {
    condition = contains(["IPv4", "IPv6"], var.ip_version)
    
    error_message = "Versión de IP no reconocida"
  }

  description   = "Tipo de IP a utilizar"
  default       = "IPv4"

}
variable "zones" {
  type = list(string)

  description   = "Redundancia de zonas de disponibilada"
  default       = ["1", "2", "3"]
}
variable "idle_timeout_in_minutes" {
  type = number

  description   = "Minutos hasta timeout"
  default       = 5
}