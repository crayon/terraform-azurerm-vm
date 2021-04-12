# Changelog

## v1.3.0
- #15 Availability zone
- #13 Added support for both managed boot diagnostics, and bring your own storage account
- #17 Support for setting timezones on Windows servers

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