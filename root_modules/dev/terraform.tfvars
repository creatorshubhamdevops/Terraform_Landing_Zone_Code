rgs = {
  rg1 = {
    name     = "rg-pearce"
    location = "East US"
  }
}

vnets = {
  vnet1 = {
    name                = "vnet1-pearce"
    resource_group_name = "rg-pearce"
    location            = "East US"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  snet1 = {
    name                 = "frontend-subnet"
    resource_group_name  = "rg-pearce"
    virtual_network_name = "vnet1-pearce"
    address_prefixes     = ["10.0.1.0/24"]
  }

  snet2 = {
    name                 = "backend-subnet"
    resource_group_name  = "rg-pearce"
    virtual_network_name = "vnet1-pearce"
    address_prefixes     = ["10.0.2.0/24"]
  }

  snet3 = {
    name                 = "database-subnet"
    resource_group_name  = "rg-pearce"
    virtual_network_name = "vnet1-pearce"
    address_prefixes     = ["10.0.3.0/24"]
  }
  snet4 = {
    name                 = "appgateway-subnet"
    resource_group_name  = "rg-pearce"
    virtual_network_name = "vnet1-pearce"
    address_prefixes     = ["10.0.4.0/24"]
  }
  snet5 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-pearce"
    virtual_network_name = "vnet1-pearce"
    address_prefixes     = ["10.0.5.0/24"]
  }
}

pips = {
  pip1 = {
    name                = "bastion-pip"
    resource_group_name = "rg-pearce"
    location            = "East US"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  pip2 = {
    name                = "appgateway-pip"
    resource_group_name = "rg-pearce"
    location            = "East US"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

bastions = {
  bastion1 = {
    name                 = "bastion"
    location             = "East US"
    resource_group_name  = "rg-pearce"
    sku                  = "Standard"
    subnet_name          = "AzureBastionSubnet"
    virtual_network_name = "vnet1-pearce"
    pip_name             = "bastion-pip"
  }
}

vms = {
  vm1 = {
    nic_name             = "frontend-nic-1"
    location             = "eastus"
    resource_group_name  = "rg-pearce"
    subnet_name          = "frontend-subnet"
    virtual_network_name = "vnet1-pearce"
    vm_name              = "frontend-vm-1"
    size                 = "Standard_DC1ds_v3"
    admin_username       = "Shubham"
    secret_name          = "frontend-vm-1-password"
  }

  vm2 = {
    nic_name             = "frontend-nic-2"
    location             = "eastus"
    resource_group_name  = "rg-pearce"
    subnet_name          = "frontend-subnet"
    virtual_network_name = "vnet1-pearce"
    vm_name              = "frontend-vm-2"
    size                 = "Standard_DC1ds_v3"
    admin_username       = "Shubham"
    secret_name          = "frontend-vm-2-password"
  }

  vm3 = {
    nic_name             = "backend-nic-1"
    location             = "eastus"
    resource_group_name  = "rg-pearce"
    subnet_name          = "backend-subnet"
    virtual_network_name = "vnet1-pearce"
    vm_name              = "backend-vm-1"
    size                 = "Standard_DC1ds_v3"
    admin_username       = "Krivaan"
    secret_name          = "backend-vm-1-password"
  }
  vm4 = {
    nic_name             = "backend-nic-2"
    location             = "eastus"
    resource_group_name  = "rg-pearce"
    subnet_name          = "backend-subnet"
    virtual_network_name = "vnet1-pearce"
    vm_name              = "backend-vm-2"
    size                 = "Standard_DC1ds_v3"
    admin_username       = "Krivaan"
    secret_name          = "backend-vm-2-password"
  }

  vm5 = {
    nic_name             = "database-nic-1"
    location             = "eastus"
    resource_group_name  = "rg-pearce"
    subnet_name          = "database-subnet"
    virtual_network_name = "vnet1-pearce"
    vm_name              = "database-vm-1"
    size                 = "Standard_DC1ds_v3"
    admin_username       = "Krivaan"
    secret_name          = "database-vm-1-password"
  }

}

keyvaults = {
  kv1 = {
    keyvault_name       = "kvshubhamdemo123"
    location            = "eastus"
    resource_group_name = "rg-pearce"
  }
}

keyvaults_secrets = {
  kv_secret1 = {
    length      = 20
    special     = true
    secret_name = "frontend-vm-1-password"
  }

  kv_secret2 = {
    length      = 20
    special     = true
    secret_name = "frontend-vm-2-password"
  }

  kv_secret3 = {
    length      = 20
    special     = true
    secret_name = "backend-vm-1-password"
  }

  kv_secret4 = {
    length      = 20
    special     = true
    secret_name = "backend-vm-2-password"
  }

  kv_secret5 = {
    length      = 20
    special     = true
    secret_name = "database-vm-1-password"
  }
}


# trufflehog filesystem . --json > C:\Reports\trufflehog-report.json
# gitleaks dir . --report-format json --report-path ./secret.json
# gitleaks detect --source . --no-git --config .gitleaks.toml --report-format json --report-path gitleaks-report.json
# checkov -d . -o json > D:\DevOpsInsiders\Terraform\Module_lab\Root\dev\report.json
#  tflint --recursive > tflint-report.txt
# tflint --recursive --format json > tflint-report.json
# tfsec . --format json --out tfsec-report.json