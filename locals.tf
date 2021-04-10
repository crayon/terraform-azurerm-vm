locals {
  windows_vm      = var.source_image_reference.offer == "WindowsServer" ? 1 : 0
  linux_vm        = var.source_image_reference.offer != "WindowsServer" ? 1 : 0
  linux_admin_ssh = lookup(var.admin_user, "ssh_key", null) != null ? true : false

  network_interface_ids = var.network_interface_ids != null ? var.network_interface_ids : [for ni in azurerm_network_interface.machine : ni.id]
}
