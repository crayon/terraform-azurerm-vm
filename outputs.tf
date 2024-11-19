output "machine_id" {
  description = "The object ID for the virtual machine."
  value       = local.os_type != "windows" ? azurerm_linux_virtual_machine.machine[0].id : azurerm_windows_virtual_machine.machine[0].id
}
output "os_type" {
  description = "The OS used on this virtual machine."
  value       = title(local.os_type)
}
output "private_ip_address" {
  description = "The primary private IP addresses assigned to the virtual machine."
  value       = local.os_type != "windows" ? azurerm_linux_virtual_machine.machine[0].private_ip_address : azurerm_windows_virtual_machine.machine[0].private_ip_address
}

output "vm" {
  value       = local.os_type != "windows" ? azurerm_linux_virtual_machine.machine[0] : azurerm_windows_virtual_machine.machine[0]
  description = "Full Virtual Machine Object Output"
}
