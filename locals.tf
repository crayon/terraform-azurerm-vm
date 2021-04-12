locals {
  linux_admin_ssh = lookup(var.admin_user, "ssh_key", null) != null ? true : false

  network_interface_ids = var.network_interface_ids != null ? var.network_interface_ids : [for ni in azurerm_network_interface.machine : ni.id]

  vm_id = var.source_image_reference.offer != "WindowsServer" ? azurerm_linux_virtual_machine.machine[0].id : azurerm_windows_virtual_machine.machine[0].id
}
