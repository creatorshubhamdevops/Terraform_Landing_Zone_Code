variable "vms" {
  type = map(object({
    nic_name             = string
    location             = string
    resource_group_name  = string
    subnet_name          = string
    virtual_network_name = string
    vm_name              = string
    size                 = string
    admin_username       = string
    secret_name          = string
  }))
}