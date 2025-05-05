variable "datalake_filesystem_id" {
  description = "ID of the Data Lake Gen2 filesystem"
  type        = string
}

variable "sql_admin_login" {
  description = "SQL admin username"
  type        = string
  sensitive   = true
}
