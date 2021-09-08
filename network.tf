resource "azurerm_network_interface" "machine" {
  for_each = { for nis in var.network_interface_subnets : nis.name => nis }

  name                = format("nic-%s-%s", var.name, each.value.name)
  resource_group_name = var.resource_group
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                 = each.value.name
    subnet_id            = data.azurerm_subnet.interfaces[each.value.name].id
    public_ip_address_id = each.value.public_ip_id

    private_ip_address_allocation = each.value.static_ip != null ? "Static" : "Dynamic"
    private_ip_address            = each.value.static_ip != null ? each.value.static_ip : null
  }

  depends_on = [data.azurerm_subnet.interfaces]
}
