output "machine_id" {
  description = "The object ID for the virtual machine."
  value       = local.os_type != "windows" ? azurerm_linux_virtual_machine.machine[0].id : azurerm_windows_virtual_machine.machine[0].id
}
output "os_type" {
  description = "The OS used on this virtual machine."
  value       = title(local.os_type)
}
