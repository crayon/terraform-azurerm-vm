resource "azurerm_network_interface" "machine" {
  for_each = { for nis in var.network_interface_subnets : nis.name => nis }

  name                = format("nic-%s-%s", var.name, each.value.name)
  resource_group_name = var.resource_group
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = each.value.name
    subnet_id                     = data.azurerm_subnet.interfaces[each.value.name].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = each.value.public_ip_id
  }

  depends_on = [data.azurerm_subnet.interfaces]
}