variable "private_cloud_name" {
  type = string

  description   = "Nombre de la Nube privada"
}
variable "sku_name" {
  type = string

  validation {
    condition     = contains(["av36", "av36t", "av64", "av64t"], lower(var.sku_name))
    error_message = "SKU no reconocido"
  }

  description   = "SKU a utilizar"
}
variable "size" {
  type = number
  
  validation {
    condition = var.size >= 3 && var.size <= 16

    error_message = "El tamaño del cluster debe estar entre 3 y 16"
  }

  description = "Tamaño del cluster"
}
variable "network_subnet_cidr" {
  type = string

  description = "Rango de direcciones IP para la subred del cluster"
}
variable "internet_connection_enabled" {
  type = bool

  description   = "Habilitar la conexión a internet"
  default       = true
}
variable "nsxt_password" {
  type = string

  description = "Contraseña para el gestor VMWare NSX"
}
variable "vcenter_password" {
  type = string

  description = "Contraseña para el gestor VMWare VCenter"
}
