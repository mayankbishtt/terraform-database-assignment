variable "vpc_id" {}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {}

variable "db_name" {}

variable "db_username" {}

variable "db_password" {}

variable "backup_retention" {}

variable "deletion_protection" {}

variable "instance_class" {}