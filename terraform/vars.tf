# Common section
variable "common_delimiter" {
  description = "Delimiter used for dynamic naming"
  type        = string
  default     = "-"
}

variable "common_name" {
  description = "Name used for dynamic naming"
  type        = string
  default     = "liatrio"
}

#vpc/az/subnets
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

