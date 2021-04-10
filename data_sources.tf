data "azurerm_resource_group" "rg" {
  name = var.resource_group
}
data "azurerm_subnet" "interfaces" {
  for_each = { for nis in var.network_interface_subnets : nis.name => nis }

  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
