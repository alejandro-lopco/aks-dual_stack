variable "sv_name" {
  type    = string

  default = "svAnyway3D2025"
}
variable "site_config" {
  type = object({
      always_on = optional(bool, true)

      api_definition_url    = optional(string)
      api_management_api_id = optional(string)

      app_command_line = optional(string)

      container_registry_use_managed_identity       = optional(bool,false)
      container_registry_managed_identity_client_id = optional(string)
       
      default_documents = optional(list(string))

      ftps_state                        = optional(string, "Disabled")
      health_check_path                 = optional(string)
      health_check_eviction_time_in_min = optional(number)

      http2_enabled = optional(bool, true)

      ip_restriction_default_action = optional(string, "Allow")

      load_balancing_mode = optional(string, "LeastRequests")

      local_mysql_enabled = optional(bool, false)

      managed_pipeline_mode = optional(string, "Integrated")

      minimum_tls_version = optional(string, "1.2")

      remote_debugging_enabled = optional(bool, false)
      remote_debugging_version = optional(string, "VS2022")

      use_32_bit_worker = optional(bool, false)

      vnet_route_all_enabled  = optional(bool, false)
      websockets_enabled      = optional(bool, false)

      worker_count = optional(number, 1)
  })

  default     = {}
  description = "Objeto coteniendo los valores de configuración del sitio"
}
variable "application_stack" {
  type = object({
    current_stack = optional(string)

    docker_image_name         = optional(string)
    docker_registry_url       = optional(string)
    docker_registry_username  = optional(string)
    docker_registry_password  = optional(string)

    dotnet_version      = optional(string)
    dotnet_core_version = optional(string)

    tomcat_version = optional(string)

    java_version                  = optional(string)
    java_embedded_server_enabled  = optional(bool)

    node_version = optional(string)

    php_version = optional(string)

    python = optional(bool, false)
  })

  default     = {}
  description = "Objeto coteniendo los valores de configuración del stack de la aplicación" 
}
variable "ip_restriction" {
  type = list(object({
    name = optional(string)

    action      = optional(string, "Deny")
    ip_address  = optional(string)
    priority    = optional(number)

    service_tag = optional(string)

    virtual_network_subnet_id = optional(string)

    description = optional(string)
  }))

  default     = []
  description = "listado de objetos con datos de restricciones de IP"
}
variable "auth_settings" {
  type = object({
    enabled = bool

    additional_login_parameters     = optional(map(string))
    allowed_external_redirect_urls  = optional(list(string))

    default_provider  = optional(string)
    issuer            = optional(string)

    runtime_version = optional(string)

    token_store_enabled           = optional(bool, false)
    token_refresh_extension_hours = optional(number, 72)

    unauthenticated_client_action = optional(string)
  })

  default     = {enabled = false}
  description = "Objeto coteniendo los valores de configuración de autenticación"
}
variable "active_directory" {
  type = object({
    client_id         = string
    allowed_audiences = optional(list(string))
  })

  default     = null
  description = "Objeto coteniendo los valores de configuración de AD"
}
variable "auth_settings_v2" {
  type = object({
    auth_enabled = optional(bool, false)

    runtime_version   = optional(string, "~1")
    config_file_path  = optional(string)

    require_authentication = optional(bool)
    unauthenticated_action = optional(string, "RedirectToLoginPage")

    default_provider  = optional(string)
    excluded_paths    = optional(list(string))

    require_https         = optional(bool, true)
    http_route_api_prefix = optional(string, "/.auth")

    forward_proxy_convention                = optional(string, "NoProxy")
    forward_proxy_custom_scheme_header_name = optional(string)
  })

  default     = null
  description = "Objeto coteniendo los valores de configuración de Autentificación V2"
}
variable "active_directory_v2" {
  type = object({
    client_id             = string
    tenant_auth_endpoint  = string

    client_secret_setting_name            = optional(string)
    client_secret_certificate_thumbprint  = optional(string)

    jwt_allowed_groups              = optional(list(string))
    jwt_allowed_client_applications = optional(list(string))

    www_authentication_disabled = optional(bool, false)

    allowed_groups      = optional(list(string))
    allowed_identities  = optional(list(string))
    allowed_audiences   = optional(list(string))
  })

  default     = null
  description = "Objeto coteniendo los valores de configuración de AD_V2"
}
variable "login" {
  type = object({
    logout_endpoint = optional(string)
    
    token_store_enabled           = optional(bool, false)
    token_refresh_extension_time  = optional(number, 72)
    token_store_path              = optional(string)
    token_store_sas_setting_name  = optional(string)

    preserve_url_fragments_for_logins = optional(bool, false)
    allowed_external_redirect_urls    = optional(list(string))

    cookie_expiration_convention  = optional(string, "Fixed")
    cookie_expiration_time        = optional(string, "08:00:00")

    validate_nonce        = optional(bool , true)
    nonce_expiration_time = optional(string, "00:05:00")
  })

  default     = {}
  description = "Objeto coteniendo los valores de configuración de login"
}
variable "storage_account" {
  type = object({
    name        = string
    share_name  = string

    access_key    = string
    account_name  = string

    type = string

    mount_path = optional(string)
  })
  
  default     = null
  description = "Objeto coteniendo los valores de configuración de Storage Account"
}
