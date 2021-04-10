resource "azurerm_windows_virtual_machine" "machine" {
  count                 = local.windows_vm
  name                  = var.name
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = var.location != null ? var.location : data.azurerm_resource_group.rg.location
  size                  = var.vm_size
  admin_username        = var.admin_user.username
  admin_password        = var.admin_user.password
  network_interface_ids = local.network_interface_ids

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }
}
