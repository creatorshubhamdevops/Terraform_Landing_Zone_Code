data "azurerm_subnet" "subnets" {
  for_each = var.vms

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
}


data "azurerm_key_vault" "keyvault" {

  name                = "kvshubhamdemo123"
  resource_group_name = "rg-pearce"
}

data "azurerm_key_vault_secret" "vm_secrets" {
  for_each = var.vms
  
  name         = each.value.secret_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_network_interface" "nics" {
  for_each = var.vms

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.subnets[each.key].id
}
}

resource "azurerm_linux_virtual_machine" "vms" {

  for_each = var.vms

  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  network_interface_ids           = [azurerm_network_interface.nics[each.key].id, ]
  disable_password_authentication = false
  admin_username                  = each.value.admin_username
  admin_password                  = data.azurerm_key_vault_secret.vm_secrets[each.key].value


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
}
}