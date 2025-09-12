module "resource_naming" {
  source = "../resource_naming"
}

resource "azurerm_mssql_server" "this" {
  name = "${var.sql_server_name}${module.resource_naming.prefix}"

  resource_group_name = var.resource_group_name
  location            = var.location

  version                      = var.server_version

  administrator_login          = var.administrator_login.password.login_username
  administrator_login_password = var.administrator_login.password.login_password

  minimum_tls_version = var.minimum_tls_version

  public_network_access_enabled        = var.public_network_access_enabled
  outbound_network_restriction_enabled = var.outbound_network_restriction_enabled

  dynamic "azuread_administrator" {
    for_each = var.administrator_login.entra_id != null ? [var.administrator_login.entra_id] : []

    content {
      azuread_authentication_only = azuread_administrator.value.administrator_login.entra_id_authentication_only
      login_username              = azuread_administrator.value.administrator_login.login_username
      object_id                   = azuread_administrator.value.administrator_login.object_id
      tenant_id                   = azuread_administrator.value.administrator_login.tenant_id
    }
  }

  tags = merge(var.tags, { service = "sql" })
}

resource "azurerm_mssql_database" "this" {
  name                 = "${var.sql_db_name}${module.resource_naming.prefix}"

  server_id            = azurerm_mssql_server.this.id
  
  collation            = var.collation
  license_type         = var.license_type
  max_size_gb          = var.max_size_gb
  sku_name             = var.sku_name
  enclave_type         = var.enclave_type
  zone_redundant       = var.zone_redundant
  storage_account_type = var.storage_account_type

  tags = merge(var.tags, { service = "sqldb" })
}
