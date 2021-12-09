terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.82.0"
    }
  }
  required_version = ">= 1.0.6"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vm" {
  name     = "rg-vm-demo"
  location = "Norway East"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-vm-demo"
  resource_group_name = azurerm_resource_group.vm.name
  location            = azurerm_resource_group.vm.location

  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "serversubnet"
  resource_group_name  = azurerm_resource_group.vm.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

module "vm" {
  source  = "crayon/vm/azurerm"
  version = "1.11.0"

  name           = "vmdemo0001"
  resource_group = azurerm_resource_group.vm.name
  location       = azurerm_resource_group.vm.location

  network_interface_subnets = [{
    name                 = azurerm_subnet.subnet.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.vm.name
    public_ip_id         = null
    static_ip            = null
  }]

  admin_user = {
    username = "crayonadm"
    ssh_key  = file("~/.ssh/id_rsa.pub")
  }

  depends_on = [
    azurerm_resource_group.vm
  ]
}
