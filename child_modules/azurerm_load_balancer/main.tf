# azurerm "load_balancer" "lb" {
#   for_each = var.loadbalancers

#   name                = each.value.lb_name
#   location            = each.value.location
#   resource_group_name = each.value.resource_group_name

#   sku {
#     name = "Standard"
#   }

#   frontend_ip_configuration {
#     name                 = "LoadBalancerFrontEnd"
#     public_ip_address_id = azurerm_public_ip.pip[each.key].id
#   }
# }