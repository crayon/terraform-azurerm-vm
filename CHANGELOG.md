# Changelog

## v1.2.0
- #4 Add the possibility to create a network interface through the module
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