# Azure Virtual Machine

This module is for creating and maintaining the lifecycle of an Azure Virtual Machine, bringing together all the resources needed from the machine itself to network interface, backup, logging, Azure AD and Traditional AD joining, and data disks.

So far it supports most scenarios like manual set up or getting an image from the marketplace, or even bringing your own VHD.

Even though we set descriptions for all the input variables, there are logic in this module that we can't really describe in just a few words. This is why we are adding this supplemental documentation.

>This document is still a work in progress. If anything is unclear, feel free to add an issue to this repository. Some sections might be empty as a reminder to @crayon/terraform-maintainers to update it.

## Join to domain

### Azure AD

### Active Directory

## Data disks

Data disks can be defined as a list of objects, that require certain attributes. All the attributes need to be filled.

| Name | Type | Description |
| ---- | ---- | ----------- |
| `name` | string | The name of the disk |
| `storage_account_type` | string | The type of storage to use for the managed disk. Possible values are `Standard_LRS`, `Premium_LRS`, `StandardSSD_LRS` or `UltraSSD_LRS`. |
| `create_option` | string | Can be set to `Empty` only at the moment. See [issue #21](https://github.com/crayon/terraform-azurerm-vm/issues/21) for more info. |
| `caching` | string | Specifies the caching requirements for this Data Disk. Possible values include `None`, `ReadOnly` and `ReadWrite`. |
| `lun` | number | The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created. |
| `disk_size_gb` | number | Specifies the size of the managed disk to create in gigabytes. If create_option is `Copy` or `FromImage`, then the value must be equal to or greater than the source's size. The size can only be increased. |

**Usage example:**

```hcl
module "vm" {
  source = "crayon/vm/azurerm"
  version = "1.10.0"

  ## Removed other input variables for better readability

  data_disks = [
    {
      name                 = "data01"
      storage_account_type = "Standard_LRS"
      create_option        = "Empty"
      caching              = "None"
      lun                  = 10
      disk_size_gb         = 1024
    },
    {
      name                 = "data02"
      storage_account_type = "StandardSSD_LRS"
      create_option        = "Empty"
      caching              = "ReadWrite"
      lun                  = 11
      disk_size_gb         = 500
    }
  ]
}
```
