variable "address_space" {
  type = list(string)

  description = "Dirección de red (IPv4 o IPv6) de la red virutal"
}
variable "address_prefixes" {
  type = list(string)
  
  description = "Dirección de red (IPv4 o IPv6) de la subred virutal"
}
variable "service_delegations" {
  type = list(object({
    name         = string
    service_name = string
    actions      = list(string)
  }))

  description = "Listado de delegaciones que encargar a la subred"
  default = []
}