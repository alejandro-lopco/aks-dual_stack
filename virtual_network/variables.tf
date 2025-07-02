variable "address_space" {
  type = list(string)

  description = "Dirección de red (IPv4 o IPv6) de la red virutal"
}
variable "address_prefixes" {
  type = list(string)
  
  description = "Dirección de red (IPv4 o IPv6) de la subred virutal"
}