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

variable "storage_account_id" {
  type        = string
  description = "Storage account ID"
}

variable "app_insights_retention" {
  type        = number
  description = "Application Insights retention in days"
  default     = 90
}

variable "kv_purge_protection" {
  type        = bool
  description = "Enable Key Vault purge protection"
  default     = false # Set to true for production
}

variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}
