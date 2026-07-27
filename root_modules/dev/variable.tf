variable "rgs" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "vnets" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
  }))
}

variable "subnets" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}

variable "pips" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string
  }))
}

variable "bastions" {
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    sku                  = string
    subnet_name          = string
    virtual_network_name = string
    pip_name             = string
  }))
}

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

variable "keyvaults" {
  type = map(object({
    keyvault_name       = string
    location            = string
    resource_group_name = string
  }))
}

variable "keyvaults_secrets" {
  type = map(object({
    secret_name = string
    length      = number
    special     = bool
  }))
}