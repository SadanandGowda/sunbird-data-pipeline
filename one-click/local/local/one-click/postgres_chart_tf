resource "azurerm_postgresql_server" "postgres" {
  name                = "postgresql-server-obsrv"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku_name = "GP_Gen5_2"

  storage_mb                   = var.RDS_STORAGE
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "druid"
  administrator_login_password = "SanK@2022"
  version                      = "11"
  ssl_enforcement_enabled      = true
  depends_on = [azurerm_kubernetes_cluster.aks]
}

resource "azurerm_postgresql_database" "postgresdb" {
  name                = "druid_raw"
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgres.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

#Creation of DB for the superset
resource "azurerm_postgresql_database" "superset_db" {
  name              = "superset"
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgres.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}



resource "azurerm_postgresql_firewall_rule" "obsrv-firewall" {
  name                = "obsrv-firewall"
  resource_group_name = data.azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.postgres.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

#resource "azurerm_postgresql_virtual_network_rule" "postgres-vnet" {
#  name                                 = "postgresql-vnet-rule"
#  resource_group_name                  = data.azurerm_resource_group.rg.name
#  server_name                          = azurerm_postgresql_server.postgres.name
#  subnet_id                            = azurerm_subnet.observ-subnet.id
#  ignore_missing_vnet_service_endpoint = true
#}

#provider "postgresql"{
#  database         = "druid_raw"
#  host             = azurerm_postgresql_server.postgres.fqdn
#  username         = azurerm_postgresql_server.postgres.administrator_login
#  username         = "druid@postgresql-server-obsrv"
#  password         = azurerm_postgresql_server.postgres.administrator_login_password
#  sslmode          = "require"
#  connect_timeout  = 15
#  superuser        = false
#}

#resource "postgresql_role" "application_role" {
#  name               = "observ_role"
#  login              = true
#  password           = var.RDS_DRUID_USER_PASSWORD
#  encrypted_password = true
#  create_database    = true
#  create_role        = true
#  superuser          = false
#  skip_reassign_owned = true 
#  depends_on         = [azurerm_kubernetes_cluster.aks, azurerm_postgresql_database.postgresdb , azurerm_postgresql_firewall_rule.obsrv-firewall]
#}

#resource "postgresql_grant" "readwrite_tables" {
#  database    = var.DRUID_RDS_DB_NAME
#  role        = var.DRUID_RDS_USER
#  schema      = "public"
#  object_type = "table"
#  privileges  = ["ALL"]
#  depends_on = [postgresql_role.application_role]
#}

#resource "postgresql_grant" "readwrite_sequence" {
#  database    = var.DRUID_RDS_DB_NAME
#  role        = var.DRUID_RDS_USER
#  schema      = "public"
#  object_type = "sequence"
#  privileges  = ["ALL"]
#  depends_on = [postgresql_role.application_role]
#}

# End Druid roles and permission
