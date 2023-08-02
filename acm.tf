module "acm" {
  source            = "github.com/champ-oss/terraform-aws-acm.git?ref=v1.0.114-1c756c3"
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
  name    = "${var.dns_name}.${var.domain}"
  zone_id = var.zone_id
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = true
  }
}
