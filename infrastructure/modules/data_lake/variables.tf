variable "prefix" {
  type        = string
  description = "Naming prefix"
}

variable "env" {
  type        = string
  description = "Environment (dev/prod)"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name"
  default     = null  # Optional
}

variable "containers" {
  type        = list(string)
  description = "List of container names"
  default     = ["raw", "processed", "forecasts"]
}
