variable "vnet_name" {
  type = string

  description   = "Nombre de la red virtutal para el dev center"
  default       = "vNetDevCenterAnyway3D"
}
variable "project_name" {
  type = string

  description = "Nombre del projecto"
}
variable "address_space" {
  type = list(string)

  description   = "Espacio IPV4 para la red del dev center"
  default       = ["10.0.0.0/16"]
}
variable "address_prefixes" {
  type = list(string)

  description   = "Espacio IPV4 para la subred del dev center"
  default       = ["10.0.1.0/24"]

}
variable "dev_center_name" {
  type = string

  description   = "Nombre del dev center"
}
variable "project_catalog_item_sync_enabled" {
  type = bool

  description   = "Habilitar sincronización de elementos del dev_center_catalog"
  default       = false
}
variable "image_reference_id" {
  type = string

  description = "ID de la imagén que se tomará de referencia para levantar las Dev Boxes"
}
variable "sku_name" {
  type = string

  description = "Plan SKU del la dev box"
}
