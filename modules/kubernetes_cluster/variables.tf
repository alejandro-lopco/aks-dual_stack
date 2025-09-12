variable "aks_name" {
  type = string
}
variable "network_plugin" {
  type        = string

  validation {
    condition     = contains(["kubenet", "azure", null], lower(var.network_plugin))
    error_message = "Network Plugin no reconocido"
  }

  description = "AKS network plugin"
}
variable "ip_versions" {
  type    = list(string)

  default = [ "IPv4" ]
}
variable "node_count" {
  type        = number

  description = "Cantidad de nodos a utilizar"
  default = 1
}
variable "vm_size" {
  type        = string

  description = "tipo de VM en la correrá el cluster"
}
variable "public_ip" {
  type        = bool

  description = "Otorgar una IP pública al cluster"
  default     = true
}