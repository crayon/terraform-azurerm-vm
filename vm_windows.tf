resource "azurerm_windows_virtual_machine" "machine" {
  count                                                  = local.os_type == "windows" ? 1 : 0
  name                                                   = var.name
  computer_name                                          = var.computer_name
  resource_group_name                                    = var.resource_group
  location                                               = var.location
  tags                                                   = var.tags
  size                                                   = var.vm_size
  license_type                                           = var.license_type
  admin_username                                         = var.admin_user.username
  admin_password                                         = var.admin_user.password
  network_interface_ids                                  = local.network_interface_ids
  patch_mode                                             = var.patch_mode
  patch_assessment_mode                                  = var.patch_assessment_mode
  hotpatching_enabled                                    = var.hotpatching_enabled
  provision_vm_agent                                     = var.provision_vm_agent
  allow_extension_operations                             = var.provision_vm_agent
  bypass_platform_safety_checks_on_user_schedule_enabled = var.bypass_platform_safety_checks_on_user_schedule_enabled
  secure_boot_enabled                                    = local.secure_boot_enabled
  vtpm_enabled                                           = local.vtpm_enabled
  proximity_placement_group_id                           = var.proximity_placement_group_id
  vm_agent_platform_updates_enabled                      = var.vm_agent_platform_updates_enabled
  encryption_at_host_enabled                             = var.encryption_at_host_enabled
  os_disk {
    caching                   = var.os_disk.caching
    storage_account_type      = var.os_disk.storage_account_type
    disk_size_gb              = lookup(var.os_disk.optional_settings, "disk_size_gb", null)
    disk_encryption_set_id    = lookup(var.os_disk.optional_settings, "disk_encryption_set_id", null)
    name                      = lookup(var.os_disk.optional_settings, "name", null)
    write_accelerator_enabled = lookup(var.os_disk.optional_settings, "write_accelerator_enabled", false)
  }

  # Boot diagnostic settings:
  # If managed boot diagnostics is set, define a null value on storage_account_uri
  # and if not, set the URI for the storage account.
  dynamic "boot_diagnostics" {
    for_each = var.managed_boot_diagnostic ? ["true"] : []
    content {
      storage_account_uri = null
    }
  }
  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostic_storage_account != null ? ["true"] : []
    content {
      storage_account_uri = var.boot_diagnostic_storage_account
    }
  }

  custom_data = var.custom_data

  dynamic "plan" {
    for_each = var.plan != null ? ["plan"] : []
    content {
      name      = var.plan.name
      product   = var.plan.product
      publisher = var.plan.publisher
    }
  }

  zone                = var.availability_zone
  availability_set_id = var.availability_set_id
  timezone            = var.timezone

  source_image_id = var.source_image_id.uri

  dynamic "source_image_reference" {
    for_each = var.source_image_id.os == null ? ["Image Reference"] : []
    content {
      publisher = var.source_image_reference.publisher
      offer     = var.source_image_reference.offer
      sku       = var.source_image_reference.sku
      version   = var.source_image_reference.version
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? ["identity"] : []
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

}
