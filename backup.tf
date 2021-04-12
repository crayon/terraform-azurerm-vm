resource "azurerm_backup_protected_vm" "machine" {
  count = var.backup != null ? 1 : 0

  resource_group_name = var.backup.resource_group_name
  recovery_vault_name = var.backup.recovery_vault_name
  backup_policy_id    = var.backup.backup_policy_id

  source_vm_id = local.vm_id
}
