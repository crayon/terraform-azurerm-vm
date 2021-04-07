data "azurerm_resource_group" "rg" {
  name = var.resource_group
}
# data "azurerm_managed_disk" "data_disks" {
#   for_each            = { for d in var.data_disks : d.name => d }
#   name                = each.value.name
#   resource_group_name = data.azurerm_resource_group.rg.name
# }
