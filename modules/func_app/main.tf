module "rg" {
  source = "../resource_group"

  subscription_id = var.subscription_id
  location        = var.location
  prefix          = var.prefix  
}
module "vNet" {
  source = "../virtual_network"

  subscription_id = var.subscription_id
  location        = var.location
  prefix          = var.prefix

  address_space = ["10.0.0.0/16"]
  address_prefixes = ["10.0.1.0/24"]

  # Delegación para permitir la conexión de la subred
  service_delegations = [ 
    {
      name         = "delegation-func-app",
      service_name = "Microsoft.Web/serverFarms",
      actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
    } 
  ]
}
module "kv" {
  source = "../key_vault"

  subscription_id = var.subscription_id
  location        = var.location
  prefix          = var.prefix
}
module "stoAcc" {
  source = "../storage_account"

  subscription_id = var.subscription_id
  location        = var.location
  prefix          = var.prefix
}
module "sv" {
  source = "../service_plan"

  subscription_id = var.subscription_id
  location        = var.location
  prefix          = var.prefix
}

resource "azurerm_windows_function_app" "this" {
  name                          = "func-${var.prefix}-${var.environment}-AlejandroLopco"
  location                      = var.location
  resource_group_name           = data.azurerm_resource_group.this.name
  service_plan_id               = module.sv.id
  storage_account_name          = module.stoAcc.name

  https_only = var.https_only
  ftp_publish_basic_authentication_enabled       = var.ftp_publish_basic_authentication_enabled
  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled

  site_config {
    api_definition_url                     = var.site_config.api_definition_url
    app_command_line                       = var.site_config.app_command_line
    app_scale_limit                        = var.site_config.app_scale_limit
    application_insights_connection_string = var.site_config.application_insights_connection_string
    application_insights_key               = var.site_config.application_insights_key

    dynamic "application_stack" {
      for_each = var.site_config.application_stack != null ? [var.site_config.application_stack] : []

      content {
        dotnet_version              = application_stack.value.dotnet_version
        use_dotnet_isolated_runtime = application_stack.value.use_dotnet_isolated_runtime
        java_version                = application_stack.value.java_version
        node_version                = application_stack.value.node_version
        powershell_core_version     = application_stack.value.powershell_core_version
        use_custom_runtime          = application_stack.value.use_custom_runtime
      }
    }

    dynamic "cors" {
      for_each = var.site_config.cors != null ? [var.site_config.cors] : []

      content {
        allowed_origins     = cors.value.allowed_origins
        support_credentials = cors.value.support_credentials
      }
    }

    elastic_instance_minimum          = var.site_config.elastic_instance_minimum
    http2_enabled                     = var.site_config.http2_enabled
    health_check_eviction_time_in_min = var.site_config.health_check_eviction_time_in_min
    health_check_path                 = var.site_config.health_check_path
    minimum_tls_version               = var.site_config.minimum_tls_version
    pre_warmed_instance_count         = var.site_config.pre_warmed_instance_count
    remote_debugging_enabled          = var.site_config.remote_debugging_enabled
    remote_debugging_version          = var.site_config.remote_debugging_version
    runtime_scale_monitoring_enabled  = var.site_config.runtime_scale_monitoring_enabled
    worker_count                      = var.site_config.worker_count
    use_32_bit_worker                 = var.site_config.use_32_bit_worker
  }

  public_network_access_enabled = var.public_network_access_enabled

  virtual_network_subnet_id = module.vNet.subvNet_id

  tags = merge(var.tags, { "service" = "wFuncApp" })
}

module "management_delete_lock" {
  source = "../management_delete_lock"

  
  prefix = var.prefix
  environment = var.environment
  scope_id = azurerm_windows_function_app.this.id

  subscription_id = var.subscription_id
  location = var.location

  tags = merge(var.tags, { service = "funcApp_delete_lock" })
}