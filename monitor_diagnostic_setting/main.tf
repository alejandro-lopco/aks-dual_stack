resource "azurerm_monitor_diagnostic_setting" "this" {
  name = "monitor-${var.prefix}-${var.project}-${var.environment}"

  target_resource_id = var.target_resource_id
  log_analytics_workspace_id = var.log_destination.log_analytics_workspace_id
  storage_account_id = var.log_destination.storage_account_id

  dynamic "enabled_log" {
    for_each = var.logs

    content {
      category = enabled_log.value
    }
  }
  
  dynamic "enabled_metric" {
    for_each = var.metrics
    
    content {
      category = enabled_metric.value
      enabled = true
    }
  }
}