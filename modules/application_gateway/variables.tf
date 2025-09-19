variable "vnet_name" {
  type = string

  description = "Nombre del recurso de la red virtual"
}
variable "public_ip_name" {
  type = string

  description = "Nombre del recurso de la IP pública"
}
variable "address_space" {
  type = list(string)

  description = "Espacio IPV4 para la red del dev center"
}
variable "address_prefixes" {
  type = list(string)
  
  description = "Espacio IPV4 para la subred del dev center"
}
variable "domain_name_label" {
  type = string

  description = "nombre DNS de la IP pública"
}
variable "gateway_name" {
  type = string

  description = "Nombre de la application gateway" 
}
variable "sku" {
  type = object({
    name        = string
    tier        = string
    capacity    = number
  })

  validation {
    condition = contains(["Basic", "Standard_v2", "WAF_v2"],var.sku.name) && contains(["Basic", "Standard_v2", "WAF_v2"],var.sku.tier)

    error_message = "Plan de SKU no reconocido"
  }

  description   = "Plan del SKU de la application gateway"
  default       = {   
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
}
variable "enable_http2" {
  type = bool

  description   = "Permitir el protocolo HTTP2"
  default       = true
}
variable "zones" {
  type     = list(string)

  description   = "Definición de las zonas de redundancia"
  default       = null
}
variable "listener" {
  type = map(object({
    name                  = string
    pip_name              = string
    pip_domain_name_label = optional(string)
    frontend_port         = number
    protocol              = string
    ssl_certificate_name  = optional(string)
    ssl_profile_name      = optional(string)
  }))

  description = "Listado de objetos con los accesos en red pública"
}
variable "backend_address_pool" {
  type = map(object({
    name         = string
    fqdns        = optional(set(string))
    ip_addresses = optional(set(string))
  }))

  description = "Listado de IP privadas"
}
variable "backend_http_settings" {
  type = map(object({
    name                  = string
    cookie_based_affinity = string
    port                  = number
    protocol              = string
    request_timeout       = optional(number)
    host_name             = optional(string)
    probe_name            = optional(string)
  }))

  description = "Configuración HTTP del listado de IP privadas"
}
variable "request_routing_rule" {
  type = map(object({
    name               = string
    priority           = number
    rule_type          = string
    http_listener_name = string
    url_path_map_name  = string
  }))

  description = "Listado de reglas para enrutar el tráfico a través de la app gateway"
}
variable "url_path_map" {
  type = map(object({
    name                               = string
    default_backend_address_pool_name  = string
    default_backend_http_settings_name = string

    path_rules = map(object({
      name                       = string
      paths                      = set(string)
      backend_address_pool_name  = optional(string)
      backend_http_settings_name = optional(string)
      rewrite_rule_set_name      = optional(string)
    }))
  }))

  description = "Listado de URL asociadas a la regla de rutas"
}
variable "rewrite_rule_set" {
  type = map(object({
    name = string

    rewrite_rule = map(object({
      name          = string
      rule_sequence = number

      url = object({
        path         = string
        query_string = string
      })
    }))
  }))

  description = "Listado de reglas para rescritura de URLs"
  default = {}
}
variable "probe" {
  type = map(object({
    name = string
    path = string

    interval            = number
    timeout             = number
    unhealthy_threshold = number

    protocol = string
    host     = string

    match = optional(object({
      status_code = set(number)
    }))
  }))

  description   = "Listado de nodos de monitorización del estado del application gateway"
  default       = {}
}
variable "ssl_certificate" {
  type = map(object({
    name                = string
    key_vault_secret_id = string
  }))

  description = "Listado de certificados SSL recogidos del key_vault"
  default     = {}
}
variable "autoscale_configuration" {
  type = object({
    min_capacity = number
    max_capacity = number
  })
  nullable = true

  description = "Configuración del autoescalado de la application gateway"
  default     = null
}
variable "ssl_profile" {
  type = map(object({
    name                                 = string
    trusted_client_certificate_names     = optional(list(string))
    verify_client_cert_issuer_dn         = optional(bool)
    verify_client_certificate_revocation = optional(string)

    ssl_policy = optional(object({
      cipher_suites        = optional(list(string))
      disabled_protocols   = optional(list(string))
      min_protocol_version = optional(string)
      policy_name          = optional(string)
      policy_type          = optional(string)
    }))
  }))
  description   = "Listado de perfiles SSL, únicos a la application gateway"
  default       = {}
}