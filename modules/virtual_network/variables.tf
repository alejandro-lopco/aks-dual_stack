variable "vnet_name" {
  type = string
}
variable "address_space" {
  type        = list(string)

  description = "Espacio IPV4 para la red del dev center"
}
variable "address_prefixes" {
  type        = list(string)
  
  description = "Espacio IPV4 para la subred del dev center"
}
variable "service_delegations" {
  type = list(object({
    name         = string
    service_name = string
    actions      = list(string)
  }))

  description = "Listado de delegaciones que encargar a la subred"
  default     = []
}