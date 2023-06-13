variable "protect" {
  description = "Enables deletion protection on eligible resources"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Map of tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "git" {
  description = "Name of the Git repo"
  type        = string
  default     = "terraform-aws-cloudfront"
}

variable "zone_id" {
  description = "https://www.terraform.io/docs/providers/aws/r/route53_record.html#zone_id"
  type        = string
  default     = ""
}

variable "domain" {
  description = "Route53 Domain"
  type        = string
}

variable "dns_name" {
  description = "DNS name for API service"
  type        = string
  default     = var.git
}

variable "enable_waf" {
  description = "enable waf in production"
  type        = bool
  default     = false
}

variable "addresses" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set#addresses"
  type        = list(string)
  default     = []
}

variable "allowed_methods" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#allowed_methods"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
}

variable "cached_methods" {
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#cached_methods"
}

variable "viewer_protocol_policy" {
  type        = string
  default     = "redirect-to-https"
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#viewer_protocol_policy"
}

variable "default_root_object" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#default_root_object"
  type        = string
  default     = "website/index.html"
}

variable "minimum_protocol_version" {
  description = "https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#minimum_protocol_version"
  type        = string
  default     = "TLSv1.2_2019"
}

variable "name" {
  description = "name var"
  type        = string
  default     = "cloudfront"
}
