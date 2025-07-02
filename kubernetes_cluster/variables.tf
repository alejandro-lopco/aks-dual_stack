variable "network_plugin" {
  type = string
  description = "AKS network plugin"

  validation {
    condition     = contains(["kubenet", "azure", null], lower(var.network_plugin))
    error_message = "Network Plugin no reconocido"
  }
}
variable "ip_versions" {
  type = list(string)

  default = [ "IPv4" ]
}
variable "node_count" {
  type = number
  description = "Cantidad de nodos a utilizar"
}
variable "vm_size" {
  type = string
  description = "tipo de VM en la correrá el cluster"
}
variable "public_ip" {
  type = bool
  description = "Otorgar una IP pública al cluster"
}