variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vm_name" {
  description = "Virtual machine name"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
}

variable "admin_username" {
  description = "VM admin username"
  type        = string
}

variable "admin_password" {
  description = "VM admin password"
  type        = string
  sensitive   = true
}

variable "ip_configuration_name" {
  description = "ip_configuration_name"
  type        = string
}

variable "vnet_name" {
  description = "vnet_name"
  type        = string
}

variable "subnet_name" {
  description = "subnet_name"
  type        = string
}

variable "private_ip_address_allocation" {
  description = "private_ip_address_allocation"
  type        = string
}

variable "nic_name" {
  description = "nic_name"
  type        = string
}