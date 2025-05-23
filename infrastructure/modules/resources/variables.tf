variable "prefix" {
  type        = string
  description = "Naming prefix"
}

variable "env" {
  type        = string
  description = "Environment (dev/prod)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
