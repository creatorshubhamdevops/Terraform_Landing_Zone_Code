data "azurerm_key_vault" "kv" {

  name                = "kvshubhamdemo123"
  resource_group_name = "rg-pearce"
}


resource "random_password" "vm_password" {

  for_each = var.keyvaults_secrets

  length  = each.value.length
  special = each.value.special
}


resource "azurerm_key_vault_secret" "vm_Secrets" {
  depends_on = [ random_password.vm_password ]

  for_each = var.keyvaults_secrets

  name         = each.value.secret_name
  value        = resource.random_password.vm_password[each.key].result
  key_vault_id = data.azurerm_key_vault.kv.id
  content_type = "text/plain"
}