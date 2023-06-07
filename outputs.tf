output "private_subnet_ids" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group#subnet_ids"
  value       = var.private_subnet_ids
}

output "vpc_id" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#vpc_id"
  value       = var.vpc_id
}