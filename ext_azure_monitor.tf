resource "azurerm_virtual_machine_extension" "azure_monitor_agent" {
  count                = var.azure_monitor_agent ? 1 : 0
  name                 = local.os_type == "windows" ? "AzureMonitorWindowsAgent" : "AzureMonitorLinuxAgent"
  virtual_machine_id   = local.os_type == "windows" ? azurerm_windows_virtual_machine.machine[0].id : azurerm_linux_virtual_machine.machine[0].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = local.os_type == "windows" ? "AzureMonitorWindowsAgent" : "AzureMonitorLinuxAgent"
  type_handler_version = local.os_type == "windows" ? "1.2" : "1.15"
  tags                 = var.tags
}
