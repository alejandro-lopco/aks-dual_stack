variable "account_tier" {
  type = string
  description = "Defina la Tier de la storage account, únicas opciones válidas son 'Standard' y 'Premium'"

  validation {
    condition     = contains(["Standard", "Premium"])
    error_message = "Tier no reconocida"
  }
}
variable "account_replication_type" {
  type = string
  description = "Defina el tipo de replicación de la storage account, únicas opciones válidas son 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS' y 'RAGZRS'"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"])
    error_message = "Tipo de replicación no reconocido"
  }
}
variable "https_traffic" {
  type = bool
  description = "Permitir únicamente el tráfico por HTTPS"
}
variable "public_access" {
  type = bool
  description = "Permitir el acceso desde el exterior"
}