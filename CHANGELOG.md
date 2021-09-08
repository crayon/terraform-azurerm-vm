# Changelog

## v1.10.0

- Add patch_mode (#2)
- Add support for Static IP assignment for NICs (#15)
- Upgrade azurerm to 2.75.0 (#17)
- Upgrade required version of Terraform to 1.0.6 (#18)

## v1.9.0

- Added support for Azure AD authentication for Linux and Windows (#14), thanks @janegilring

## v1.8.0

- Added tags (#13), thanks @janegilring

## v1.6.0
Total rewrite of how we select which virtual machine resource is used, to be compatible with both `source_image_id` and `source_image_reference`.

- Add source_image_id (#8)

## v1.5.0
- Add optional settings to os_disk (#27)
- Add the 'plan' block (#26)

## v1.4.0
- #14 Added backup
- #16 Added license_type

## v1.3.1
- Fix bug with AD join
- #19 Add hostname to network interface

## v1.3.0
- #13 Added support for both managed boot diagnostics, and bring your own storage account
- #15 Availability zone
- #17 Support for setting timezones on Windows servers
- #18 Availability sets

## v1.2.0
- #4 Add the possibility to create a network interface through the module
- #10 Fix how the module decides what resource to use
- #11 Remove data.azurerm_resource_group, due to unintentional side-effects

## v1.1.0
- Added Active Directory domain join

## v1.0.1
Bug fix, logic related to location was looking for the wrong data type.

## v1.0.0
Initial version of the module, ready for testing in production.

### Major features of the first release:

- Dynamic selection of the windows_virtual_machine or linux_virtual_machine, based on source_image_reference
- On Linux machines, uses ssh_key if set explicit
- Create data disks based on a list, and attach them
