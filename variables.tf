# Generic settings
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
}
# Machine
variable "vm_size" {
  description = "The size of virtual machine, defaults to Standard_D2s_v3."
  type        = string
  default     = "Standard_D2s_v3"
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
