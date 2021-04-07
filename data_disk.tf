resource "azurerm_managed_disk" "data_disk" {
  for_each             = { for d in var.data_disks : d.name => d }
  
  name                 = each.value.name
  location             = data.resource_group.rg.location
  resource_group_name  = data.resource_group.rg.name
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb

  tags = var.tags
}
resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  for_each             = { for d in var.data_disks : d.name => d }

}