##### Generic settings
variable "name" {
  description = "The name of the virtual machine."
  type        = string
}
variable "resource_group" {
  description = "The resource group the machine should be deployed to."
  type        = string
}
variable "location" {
  description = "The location in which the resource should be deployed. Defaults to the location of the resource group."
  type        = string
  default     = null
}
variable "tags" {
  description = "Tags used for the resources deployed through this module."
  type        = map(string)
  default     = null
}
##### Machine
variable "vm_size" {
  description = "The size of virtual machine, defaults to Standard_D2s_v5."
  type        = string
  default     = "Standard_D2s_v5"
}
variable "license_type" {
  description = "Specifies the type of Azure Hybrid Use Benefit which should be used for this Virtual Machine. Possible values are None, Windows_Client and Windows_Server."
  type        = string
  default     = null
}
variable "network_interface_ids" {
  description = "A list of network interface IDs used for the virtual machine."
  type        = list(string)
  default     = null
}
variable "network_interface_subnets" {
  description = "A list of subnets, for which the module will create and connect network interfaces for. Optionally, you can add public IP or define it as null."
  type = list(object({
    name                 = string
    virtual_network_name = string
    resource_group_name  = string
    public_ip_id         = string
    static_ip            = string
  }))
  default = []
}
variable "os_disk" {
  description = "Optional settings related to the OS disk."
  type = object({
    caching              = string
    storage_account_type = string
    optional_settings    = map(string)
  })
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    optional_settings    = {}
  }
}
variable "source_image_id" {
  description = "The ID of a source image. If used, it will always be chosen over source_image_reference."
  type = object({
    os  = string
    uri = string
  })
  default = {
    os  = null
    uri = null
  }
}
variable "source_image_reference" {
  description = "The source image reference block, as described in the documentation. Defaults to Ubuntu 24.04"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}
variable "data_disks" {
  description = "Any extra data disks, defined as a list of objects."
  type = list(object({
    name                          = string
    storage_account_type          = string
    create_option                 = string
    caching                       = string
    lun                           = number
    disk_size_gb                  = number
    disk_encryption_set_id        = optional(string)
    disk_access_id                = optional(string)
    public_network_access_enabled = optional(bool, true)
    network_access_policy         = optional(string)
    additional_settings           = map(string)
  }))
  default = []
}
variable "availability_zone" {
  description = "The availability zone the resources should be deployed to."
  type        = string
  default     = null
}
variable "availability_set_id" {
  description = "Specifies the ID of the Availability Set in which the Virtual Machine should exist."
  type        = string
  default     = null
}
variable "managed_boot_diagnostic" {
  description = "Enable managed boot diagnostics."
  type        = bool
  default     = true
}
variable "boot_diagnostic_storage_account" {
  description = "URI for the Storage Account which should be used to store Boot Diagnostics."
  type        = string
  default     = null
}
variable "timezone" {
  description = "Set a specific timezone, used for Windows machines only."
  type        = string
  default     = "Central Europe Standard Time"
}

variable "patch_mode" {
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are Manual, AutomaticByOS and AutomaticByPlatform. Defaults to AutomaticByPlatform"
  type        = string
  default     = "AutomaticByPlatform"
}

variable "patch_assessment_mode" {
  description = "Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault. Defaults to AutomaticByPlatform"
  type        = string
  default     = "AutomaticByPlatform"
}

variable "bypass_platform_safety_checks_on_user_schedule_enabled" {
  description = "Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false"
  type        = bool
  default     = true
}
variable "hotpatching_enabled" {
  description = "Specifies if the VM should be patched without requiring a reboot."
  type        = bool
  default     = false
}
variable "provision_vm_agent" {
  description = "Should the Azure VM Agent be provisioned on this Virtual Machine, defaults to true"
  type        = bool
  default     = true
}
variable "backup" {
  description = "Settings for creating the backup resource."
  type = object({
    resource_group_name = string
    recovery_vault_name = string
    backup_policy_id    = string
  })
  default = null
}
variable "plan" {
  description = "Used to specify a certain product plan from the Azure marketplace."
  type = object({
    name      = string
    product   = string
    publisher = string
  })
  default = null
}
##### User settings
variable "admin_user" {
  description = "Username and password, or ssh key, used for the administrator user."
  type        = map(string)
}
variable "adds_join" {
  description = "Settings used to join the computer to Active Directory."
  type = object({
    domain_name = string
    username    = string
    password    = string
    ou_path     = string
    restart     = string
    options     = number
  })
  default = null
}

variable "azure_ad_join" {
  description = "Whether to join the virtual machine to Azure Active Directory."
  type        = bool
  default     = false
}

variable "azure_monitor_agent" {
  description = "Whether to install the Azure Monitor Agent VM extension."
  type        = bool
  default     = false
}

variable "custom_data" {
  description = "Base64-Encoded Custom Data which should be used for this Virtual Machine."
  type        = string
  default     = null
}

variable "identity" {
  description = "Managed Identity which should be assigned the virtual machine."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
}

variable "computer_name" {
  description = "Hostname to use for this Virtual Machine."
  type        = string
  default     = null
}

variable "security_type" {
  description = "Select security features enabled on the virtual machine."
  type        = string
  default     = "vtpm"
  validation {
    condition     = var.security_type != null ? contains(["none", "secure_boot", "vtpm"], var.security_type) : true
    error_message = "Value must be null, 'none', 'secure_boot' or 'vtpm'."
  }
}

variable "proximity_placement_group_id" {
  description = "(Optional) The ID of the Proximity Placement Group to which this Virtual Machine should be assigned. Changing this forces a new resource to be created"
  type        = string
  default     = null
}

variable "vm_agent_platform_updates_enabled" {
  description = "Should vm agent platform updates be enabled"
  type        = bool
  default     = true
}

variable "accelerated_networking_enabled" {
  description = "Should the network interface have accelerated networking enabled"
  type        = bool
  default     = true
}

variable "encryption_at_host_enabled" {
  description = "Should the virtual machine be encrypted at host"
  type        = bool
  default     = true
}
