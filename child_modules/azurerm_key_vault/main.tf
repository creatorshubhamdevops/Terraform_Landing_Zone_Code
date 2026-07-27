data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  
for_each = var.keyvaults

  name                = var.keyvaults[each.key].keyvault_name
  location            = var.keyvaults[each.key].location
  resource_group_name = var.keyvaults[each.key].resource_group_name

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = "standard"

  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  # network_acls {
  #   bypass         = "AzureServices"
  #   default_action = "Deny"
  # }
}

resource "azurerm_key_vault_access_policy" "admin" {

for_each = var.keyvaults

  key_vault_id = azurerm_key_vault.kv[each.key].id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions = ["Get","Set","List","Delete", "Purge"]
}

