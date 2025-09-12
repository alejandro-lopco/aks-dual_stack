module "resource_naming" {
  source = "../resource_naming"
}
module "rg" {
  source = "../resource_group"

  resource_group_name = var.resource_group_name
  subscription_id     = var.subscription_id
  location            = var.location
}
module "resource_naming" {
  source = "../resource_naming"
}
module "sv" {
  source = "../service_plan"

  sv_name             = "${var.sv_name}${module.resource_naming.prefix}"
  resource_group_name = var.resource_group_name

  subscription_id = var.subscription_id
  location        = var.location
}
module "vNet" {
  source = "../virtual_network"

  vnet_name           = "${var.vnet_name}${module.resource_naming.prefix}"
  resource_group_name = var.resource_group_name  

  subscription_id = var.subscription_id
  location        = var.location

  address_space     = ["10.0.0.0/16"]
  address_prefixes  = ["10.0.1.0/24"]

  # Delegación para permitir la conexión de la subred
  service_delegations = [ 
    {
      name         = "delegation-func-app",
      service_name = "Microsoft.Web/serverFarms",
      actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
    } 
  ]
}
module "stoAcc" {
  source = "../storage_account"

  sto_acc_name              = "${var.sv_name}${module.resource_naming.prefix}"
  resource_group_name       = var.resource_group_name

  subscription_id = var.subscription_id
  location        = var.location
}

resource "azurerm_logic_app_standard" "this" {
  name                       = "${var.logicapp_name}${module.resource_naming.prefix}"
  location                   = var.location
  resource_group_name        = module.rg.name
  app_service_plan_id        = module.sv.id
  storage_account_name       = module.stoAcc.name
  storage_account_access_key = module.stoAcc.access_key
  version                    = var.logic_app_version
  https_only                 = var.https_only

  site_config {
    always_on = var.site_config.always_on

    http2_enabled                    = var.site_config.http2_enabled
    runtime_scale_monitoring_enabled = var.site_config.runtime_scale_monitoring_enabled
    use_32_bit_worker_process        = var.site_config.use_32_bit_worker_process
    dotnet_framework_version         = var.site_config.dotnet_framework_version

    ftps_state = var.site_config.ftps_state

    health_check_path = var.site_config.health_check_path

    min_tls_version     = var.site_config.min_tls_version
    websockets_enabled  = var.site_config.websockets_enabled
  }

  public_network_access = var.public_network_access

  app_settings = var.app_settings

  virtual_network_subnet_id = try(module.vNet.subvNet_id, null)

  tags = merge(var.tags, { "service" = "logicApp" })
}
