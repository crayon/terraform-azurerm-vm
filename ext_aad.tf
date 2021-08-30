resource "azurerm_virtual_machine_extension" "azure_ad_join" {
  count = var.azure_ad_join ? 1 : 0
  name = "AADLoginForWindows"
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  publisher = "Microsoft.Azure.ActiveDirectory"
  type = "AADLoginForWindows"
  type_handler_version = "1.0"

  tags                         = var.tags
}