resource "azurerm_linux_virtual_machine" "machine" {
  for_each              = var.source_image_reference.offer != "WindowsServer" ? { Linux = "true" } : {}
  name                  = var.name
  resource_group_name   = var.resource_group
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_user.username
  network_interface_ids = local.network_interface_ids

  # If public_key is defined in var.admin_user, we add the ssh key.
  # Otherwise, we set admin_password.
  dynamic "admin_ssh_key" {
    for_each = local.linux_admin_ssh ? ["ssh"] : []
    content {
      username   = var.admin_user.username
      public_key = var.admin_user.ssh_key
    }
  }
  disable_password_authentication = local.linux_admin_ssh ? true : false
  admin_password                  = local.linux_admin_ssh != true ? lookup(var.admin_user, "password", null) : null

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
