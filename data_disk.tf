resource "azurerm_managed_disk" "data_disk" {
  for_each = { for d in var.data_disks : d.name => d }

  name                 = each.value.name
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb

  tags = var.tags
}
resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  for_each           = { for d in var.data_disks : d.name => d }
  managed_disk_id    = azurerm_managed_disk.data_disk[tostring(each.value.name)].id
  virtual_machine_id = local.os_type == "windows" ? azurerm_windows_virtual_machine.machine[0].id : azurerm_linux_virtual_machine.machine[0].id
  lun                = each.value.lun
  caching            = each.value.caching
}
