module "acm" {
  source            = "github.com/champ-oss/terraform-aws-acm.git?ref=952c6ed8c6d1d8d7e7718a17dc524f00cda02d5c"
  git               = var.git
  domain_name       = "${var.dns_name}.${var.domain}"
  create_wildcard   = false
  zone_id           = var.zone_id
  enable_validation = true
  providers = {
    aws = aws.virginia
  }
}

# creating A record for domain:
resource "aws_route53_record" "this" {
  name    = "${var.git}.${var.name}"
  zone_id = var.zone_id
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = true
  }
}
