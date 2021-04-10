resource "azurerm_network_interface" "machine" {
  for_each = { for nis in var.network_interface_subnets : nis.name => nis }

  name                = format("nic%s", each.value.name)
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = each.value.name
    subnet_id                     = data.azurerm_subnet.interfaces[each.value.name].id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [data.azurerm_subnet.interfaces]
}
