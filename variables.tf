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
  description = "The size of virtual machine, defaults to Standard_D2s_v3."
  type        = string
  default     = "Standard_D2s_v3"
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
  type        = object({
    os  = string
    uri = string
  })
  default     = {
    os  = null
    uri = null
  }
}
variable "source_image_reference" {
  description = "The source image reference block, as described in the documentation. Defaults to Ubuntu 18.04"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
variable "data_disks" {
  description = "Any extra data disks, defined as a list of objects."
  type = list(object({
    name                 = string
    storage_account_type = string
    create_option        = string
    caching              = string
    lun                  = number
    disk_size_gb         = number
  }))
  default = []
}
variable "availability_zone" {
  description = "The availability zone the resources should be deployed to."
  type        = number
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
  default     = null
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
description = "Whether to join the virtual machine to Azure Active Directory"
default = false
}
