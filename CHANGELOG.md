# Changelog
## v1.0.0
Initial version of the module, ready for testing in production.

### Major features of the first release:

- Dynamic selection of the windows_virtual_machine or linux_virtual_machine, based on source_image_reference
- On Linux machines, uses ssh_key if set explicit
- Create data disks based on a list, and attach them