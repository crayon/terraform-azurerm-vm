resource "azurerm_virtual_machine_extension" "adjoin" {
  for_each = var.adds_join != null ? { "ADDS" = "true" } : {}
  # for_each             = { for ext in var.adds_join : ext.domain_name => ext }
  name                 = format("%s-adjoin", var.name)
  virtual_machine_id   = var.source_image_reference.offer == "WindowsServer" ? azurerm_windows_virtual_machine.machine[0].id : azurerm_linux_virtual_machine.machine[0].id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"

  settings           = <<SETTINGS
    {
        "Name": "${var.adds_join.domain_name}",
        "User": "${var.adds_join.username}",
        "OUPath": "${var.adds_join.ou_path}",
        "Restart": "${var.adds_join.restart}",
        "Options": "${var.adds_join.options}"
    }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
      "Password": "${var.adds_join.password}"
    }
  PROTECTED_SETTINGS

}
