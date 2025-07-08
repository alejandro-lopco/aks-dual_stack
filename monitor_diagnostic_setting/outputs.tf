output "monitor_diagnostic_setting_id" {
  value = azurerm_monitor_diagnostic_setting.this.id
}
output "monitor_diagnostic_setting_storage_acc" {
  value = azurerm_monitor_diagnostic_setting.this.storage_account_id
}
output "monitor_diagnostic_setting_workspace" {
  value = azurerm_monitor_diagnostic_setting.this.log_analytics_workspace_id
}
output "monitor_diagnostic_setting_enabled_logs" {
  value = azurerm_monitor_diagnostic_setting.this.enabled_log
}