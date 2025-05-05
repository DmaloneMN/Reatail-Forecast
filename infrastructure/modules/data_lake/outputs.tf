variable "prefix" {
  description = "Naming prefix"
  type        = string
}

variable "env" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "allowed_subnet_ids" {
  description = "Subnets with access"
  type        = list(string)
  default     = []
}
