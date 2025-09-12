module "resource_naming" {
  source = "../resource_naming"
}

module "rg" {
  source = "../resource_group"

  resource_group_name = var.resource_group_name
  subscription_id     = var.subscription_id
  location            = var.location
}

module "sv" {
  source = "../service_plan"

  sv_name             = "${var.sv_name}${module.resource_naming.prefix}"
  resource_group_name = var.resource_group_name

  subscription_id = var.subscription_id
  location        = var.location
}

resource "azurerm_windows_web_app" "this" {
  name                          = "${var.wwapp_name}-${module.resource_naming.prefix}"
  location                      = var.location
  resource_group_name           = module.rg.name
  service_plan_id               = module.sv.id

  site_config {
    always_on = var.site_config.always_on

    api_definition_url    = var.site_config.api_definition_url
    api_management_api_id = var.site_config.api_management_api_id

    app_command_line = var.site_config.app_command_line

    container_registry_use_managed_identity       = var.site_config.container_registry_use_managed_identity
    container_registry_managed_identity_client_id = var.site_config.container_registry_managed_identity_client_id
      
    default_documents = var.site_config.default_documents

    ftps_state = var.site_config.ftps_state

    health_check_path                 = var.site_config.health_check_path
    health_check_eviction_time_in_min = var.site_config.health_check_eviction_time_in_min

    http2_enabled = var.site_config.http2_enabled

    ip_restriction_default_action = var.site_config.ip_restriction_default_action

    dynamic "ip_restriction" {
      for_each = var.ip_restriction != null ? var.ip_restriction : []

      content {
        name = ip_restriction.value.name

        action      = ip_restriction.value.action
        ip_address  = ip_restriction.value.ip_address
        priority    = ip_restriction.value.priority

        service_tag = ip_restriction.value.service_tag

        virtual_network_subnet_id = ip_restriction.value.virtual_network_subnet_id

        description = ip_restriction.value.description
      }
    }

    load_balancing_mode = var.site_config.load_balancing_mode

    local_mysql_enabled = var.site_config.local_mysql_enabled

    managed_pipeline_mode = var.site_config.managed_pipeline_mode

    minimum_tls_version = var.site_config.minimum_tls_version

    remote_debugging_enabled = var.site_config.remote_debugging_enabled
    remote_debugging_version = var.site_config.remote_debugging_version

    use_32_bit_worker = var.site_config.use_32_bit_worker

    vnet_route_all_enabled  = var.site_config.vnet_route_all_enabled
    websockets_enabled      = var.site_config.websockets_enabled

    worker_count = var.site_config.worker_count

    application_stack {
      current_stack = var.application_stack.current_stack

      docker_image_name         = var.application_stack.docker_image_name
      docker_registry_url       = var.application_stack.docker_registry_url
      docker_registry_username  = var.application_stack.docker_registry_username
      docker_registry_password  = var.application_stack.docker_registry_password

      dotnet_version      = var.application_stack.dotnet_version
      dotnet_core_version = var.application_stack.dotnet_core_version

      tomcat_version = var.application_stack.tomcat_version

      java_version                  = var.application_stack.java_version
      java_embedded_server_enabled  = var.application_stack.java_embedded_server_enabled

      node_version = var.application_stack.node_version

      php_version = var.application_stack.php_version

      python = var.application_stack.python
    }
  }

  dynamic "auth_settings" {
    for_each = var.auth_settings != null ? [1] : []

    content {
      enabled = var.auth_settings.enabled

      additional_login_parameters     = var.auth_settings.additional_login_parameters
      allowed_external_redirect_urls  = var.auth_settings.allowed_external_redirect_urls

      default_provider  = var.auth_settings.default_provider
      issuer            = var.auth_settings.issuer

      runtime_version = var.auth_settings.runtime_version

      token_store_enabled           = var.auth_settings.token_store_enabled
      token_refresh_extension_hours = var.auth_settings.token_refresh_extension_hours

      unauthenticated_client_action = var.auth_settings.unauthenticated_client_action

      dynamic "active_directory" {
        for_each = var.active_directory != null ? [1] : []

        content {
          client_id         = var.active_directory.client_id
          allowed_audiences = var.active_directory.allowed_audiences         
        }
      }      
    }
  }

  dynamic "auth_settings_v2" {
    for_each = var.auth_settings_v2 != null ? [1] : []

    content {
      auth_enabled = var.auth_settings_v2.auth_enabled

      runtime_version   = var.auth_settings_v2.runtime_version
      config_file_path  = var.auth_settings_v2.config_file_path

      require_authentication = var.auth_settings_v2.require_authentication
      unauthenticated_action = var.auth_settings_v2.unauthenticated_action

      default_provider  = var.auth_settings_v2.default_provider
      excluded_paths    = var.auth_settings_v2.excluded_paths

      require_https         = var.auth_settings_v2.require_https
      http_route_api_prefix = var.auth_settings_v2.http_route_api_prefix

      forward_proxy_convention                = var.auth_settings_v2.forward_proxy_convention
      forward_proxy_custom_scheme_header_name = var.auth_settings_v2.forward_proxy_custom_scheme_header_name
        
      dynamic "active_directory_v2" {
        for_each = var.active_directory_v2 != null ? [1] : []

        content {
          client_id = var.active_directory_v2.client_id

          tenant_auth_endpoint = var.active_directory_v2.tenant_auth_endpoint

          client_secret_setting_name            = var.active_directory_v2.client_secret_setting_name
          client_secret_certificate_thumbprint  = var.active_directory_v2.client_secret_certificate_thumbprint

          jwt_allowed_groups              = var.active_directory_v2.jwt_allowed_groups
          jwt_allowed_client_applications = var.active_directory_v2.jwt_allowed_client_applications

          www_authentication_disabled = var.active_directory_v2.www_authentication_disabled

          allowed_groups      = var.active_directory_v2.allowed_groups
          allowed_identities  = var.active_directory_v2.allowed_identities
          allowed_audiences   = var.active_directory_v2.allowed_audiences  
        }
      }

      login {
        logout_endpoint = var.login.logout_endpoint
        
        token_store_enabled           = var.login.token_store_enabled
        token_refresh_extension_time  = var.login.token_refresh_extension_time
        token_store_path              = var.login.token_store_path
        token_store_sas_setting_name  = var.login.token_store_sas_setting_name

        preserve_url_fragments_for_logins = var.login.preserve_url_fragments_for_logins
        allowed_external_redirect_urls    = var.login.allowed_external_redirect_urls

        cookie_expiration_convention  = var.login.cookie_expiration_convention
        cookie_expiration_time        = var.login.cookie_expiration_time

        validate_nonce        = var.login.validate_nonce
        nonce_expiration_time = var.login.nonce_expiration_time    
      }       
    }
  }

  dynamic "storage_account" {
    for_each = var.storage_account != null ? [1] : []

    content {
      name        = storage_account.value.name
      share_name  = storage_account.value.share_name

      access_key    = storage_account.value.access_key
      account_name  = storage_account.value.account_name

      type = storage_account.value.type

      mount_path = storage_account.value.mount_path
    }
  }  
}    
