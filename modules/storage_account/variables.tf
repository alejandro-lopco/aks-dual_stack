variable "sto_acc_name" {
  type = string
}
variable "account_tier" {
  type = string

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Tier no reconocida"
  }

  description = "Defina la Tier de la storage account"
  default     = "Standard"
}
variable "account_replication_type" {
  type = string

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "Tipo de replicación no reconocido"
  }

  description = "Defina el tipo de replicación de la storage account"
  default     = "LRS"
}
variable "https_traffic" {
  type        = bool

  description = "Permitir únicamente el tráfico por HTTPS"
  default     = true
}
variable "public_access" {
  type        = bool

  description = "Permitir el acceso desde redes públicas"
  default     = false
}