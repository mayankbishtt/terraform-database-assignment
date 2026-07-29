variable "vpc_id" {}

variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {}

variable "alb_security_group_id" {}