resource "azurerm_virtual_machine_extension" "azure_ad_join" {
  count = var.azure_ad_join ? 1 : 0
  name = local.os_type == "windows" ? "AADLoginForWindows" : "AADSSHLoginForLinux"
  virtual_machine_id = local.os_type == "windows" ? azurerm_windows_virtual_machine.machine[0].id : azurerm_linux_virtual_machine.machine[0].id
  publisher = "Microsoft.Azure.ActiveDirectory"
  type = local.os_type == "windows" ? "AADLoginForWindows" : "AADSSHLoginForLinux"
  type_handler_version = "1.0"
  tags                         = var.tags
}
