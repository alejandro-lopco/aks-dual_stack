resource "azurerm_service_plan" "this" {
  name                = "sv-${var.prefix}-${var.environment}"
  location            = var.location
  resource_group_name = "rg-${var.prefix}-${var.environment}"

  os_type             = var.os_type
  sku_name            = var.sku_name

  app_service_environment_id = var.app_service_environment_id

  worker_count              = var.worker_count
  per_site_scaling_enabled  = var.per_site_scaling_enabled
  zone_balancing_enabled    = var.zone_balancing_enabled

  #Premium SKU
  premium_plan_auto_scale_enabled   = var.premium_plan_auto_scale_enabled
  maximum_elastic_worker_count      = var.maximum_elastic_worker_count

  tags = merge(var.tags, { service = "sv" })
}