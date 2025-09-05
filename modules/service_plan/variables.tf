variable "os_type" {
  type = string

  validation {
    condition     = contains(["Linux", "Windows", "WindowsContainer"], var.os_type)
    error_message = "SKU no reconocido"
  }

  description = "Sistema operativo del service plan"
  default = "Linux"
}
variable "sku_name" {
  type = string

  validation {
    condition     = contains(["B1", "B2", "B3", "D1", "F1", 
                                "I1", "I2", "I3", "I1v2", "I1mv2", 
                                "I2v2", "I2mv2", "I3v2", "I3mv2", 
                                "I4v2", "I4mv2", "I5v2", "I5mv2", 
                                "I6v2", "P1v2", "P2v2", "P3v2", 
                                "P0v3", "P1v3", "P2v3", "P3v3", 
                                "P1mv3", "P2mv3", "P3mv3", "P4mv3", 
                                "P5mv3", "S1", "S2", "S3", "SHARED", 
                                "EP1", "EP2", "EP3", "FC1", "WS1", 
                                "WS2", "WS3", "Y1"], var.sku_name)
    error_message = "SKU no reconocido"
  }

  description = "Tipo de SKU del service plan"
  default = "B1"
}
variable "app_service_environment_id" {
  type = string

  description = "ID de entorno en el que funcionará el service plan, requiere un Isolated SKU"
  default = null
}
variable "worker_count" {
  type = number

  description = "Número de instancias que se crearán, funciona en conjunto con zone_balancing_enabled"
  default = 1
}
variable "per_site_scaling_enabled" {
  type = bool

  description = "Habilitar el escalado por sitio físico"
  default = false
}
variable "zone_balancing_enabled" {
  type = bool

  description = "Habilitar el balanceo de carga por zonas de disponibilad, requiere un Premium, Isolated o Workflow SKUs"
  default = false
}
#Premium SKU
variable "premium_plan_auto_scale_enabled" {
  type = bool

  description = "Habilitar el plan de autoescalado premium" 
  default = false
}
variable "maximum_elastic_worker_count" {
  type = number

  description = "Número máximo de instancias que crear, requiere un Premium SKU"
  default = 1
}
