resource "azurerm_managed_disk" "data_disk" {
  for_each = { for d in var.data_disks : d.name => d }

  name                      = each.value.name
  location                  = var.location
  resource_group_name       = var.resource_group
  storage_account_type      = each.value.storage_account_type
  create_option             = title(each.value.create_option)
  disk_size_gb              = each.value.disk_size_gb
  zone                      = [var.availability_zone]
  disk_encryption_set_id    = lookup(each.value.additional_settings, "disk_encryption_set_id", null)

  # If create_option is anything other than Empty,
  # we need to define the supporting attribute.
  source_resource_id = contains(["copy", "restore"], lower(each.value.create_option)) ? each.value.additional_settings.source_resource_id : null
  source_uri         = lower(each.value.create_option) == "import" ? each.value.additional_settings.source_uri : null
  image_reference_id = lower(each.value.create_option) == "fromimage" ? each.value.additional_settings.image_reference_id : null

  tags = var.tags
}
resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  for_each           = { for d in var.data_disks : d.name => d }
  managed_disk_id    = azurerm_managed_disk.data_disk[tostring(each.value.name)].id
  virtual_machine_id = local.os_type == "windows" ? azurerm_windows_virtual_machine.machine[0].id : azurerm_linux_virtual_machine.machine[0].id
  lun                = each.value.lun
  caching            = each.value.caching
}
