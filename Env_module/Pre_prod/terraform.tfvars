resource_group_name = {
  rg1 = {
    name     = "rajeev-rg"
    location = "southindia"
  }
}

virtual_network_name = {
  vnet1 = {
    name                = "rajeev-vnet"
    location            = "southindia"
    resource_group_name = "rajeev-rg"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet_name = {

  subnet_1 = {
    name                 = "backend-subnet"
    resource_group_name  = "rajeev-rg"
    virtual_network_name = "rajeev-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }

  subnet_2 = {
    name                 = "frontend-subnet"
    resource_group_name  = "rajeev-rg"
    virtual_network_name = "rajeev-vnet"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

public_ip_name = {

  pip1 = {
    name                = "pip-frontend-vm"
    resource_group_name = "rajeev-rg"
    location            = "southindia"
    allocation_method   = "Static"
  }

  pip2 = {
    name                = "pip-backend-vm"
    resource_group_name = "rajeev-rg"
    location            = "southindia"
    allocation_method   = "Static"
  }
}

vms = {

  vm1 = {
    nic_name        = "frontend-vm-nic"
    location        = "southindia"
    rg_name         = "rajeev-rg"
    nic_subnet_name = "frontend-subnet"
    nic_vnet_name   = "rajeev-vnet"
    nic_pip_name    = "pip-frontend-vm"
    vm_name         = "frontend-vm"
    vm_size         = "Standard_D2s_v3"
    admin_username  = "devopsadmin"
    admin_password  = "DevOps@123"
    image_publisher = "Canonical"
    image_offer     = "0001-com-ubuntu-server-jammy"
    image_sku       = "22_04-lts"
    image_version   = "latest"
  }

  vm2 = {
    nic_name        = "backend-vm-nic"
    location        = "southindia"
    rg_name         = "rajeev-rg"
    nic_subnet_name = "backend-subnet"
    nic_vnet_name   = "rajeev-vnet"
    nic_pip_name    = "pip-backend-vm"
    vm_name         = "backend-vm"
    vm_size         = "Standard_D2s_v3"
    admin_username  = "devopsadmin"
    admin_password  = "DevOps@123"
    image_publisher = "Canonical"
    image_offer     = "0001-com-ubuntu-server-jammy"
    image_sku       = "22_04-lts"
    image_version   = "latest"
  }
}