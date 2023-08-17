# Terraform module for deploying Azure VMs
A module used for deploying virtual machines in Azure.

## Requirements
| | |
|----------|----------|
|Terraform | >= 1.5.0 |
| azurerm  | = 3.67.0 |

## Example deployment

>Check out the [examples](examples/) folder for more.

```hcl
module "virtual_machine" {
  source  = "CMCS-Norway/vm/azurerm"
  version = "1.13.10"

  name                  = "vm-example"
  resource_group        = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]

  admin_user = {
    username = "crayonadm"
    ssh_key  = file("~/.ssh/id_rsa.pub")
  }

  data_disks = [{
    name                 = "disk01"
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    caching              = "ReadWrite"
    lun                  = 10
    disk_size_gb         = 50
    },
    {
      name                 = "disk02"
      storage_account_type = "Standard_LRS"
      create_option        = "Empty"
      caching              = "ReadWrite"
      lun                  = 11
      disk_size_gb         = 50
  }]
}
```
