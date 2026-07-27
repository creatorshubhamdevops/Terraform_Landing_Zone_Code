data "azurerm_subnet" "subnets" {
  for_each = var.bastions

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
}

data "azurerm_public_ip" "pips" {
  
  for_each = var.bastions

  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_bastion_host" "bastions" {
  depends_on = [data.azurerm_subnet.subnets, data.azurerm_public_ip.pips]
  
  for_each = var.bastions

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  ip_configuration {
    name                 = each.value.name
    subnet_id            = data.azurerm_subnet.subnets[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pips[each.key].id
  }
}
