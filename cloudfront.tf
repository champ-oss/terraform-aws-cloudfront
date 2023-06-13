resource "aws_cloudfront_origin_access_identity" "this" {
  protect = var.protect
  comment = "OIA for ${var.dns_name}.${var.domain}"
}

resource "aws_cloudfront_distribution" "this" {
  protect             = var.protect
  enabled             = true
  aliases             = ["${var.dns_name}.${var.domain}"]
  default_root_object = var.default_root_object
  origin {
    domain_name = module.s3.bucket_regional_domain_name
    origin_id   = module.s3.bucket
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }
  default_cache_behavior {
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    target_origin_id       = module.s3.bucket
    viewer_protocol_policy = var.viewer_protocol_policy
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  tags = merge({ Name = var.git }, local.tags, var.tags)
  viewer_certificate {
    acm_certificate_arn      = module.acm.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = var.minimum_protocol_version
  }
  web_acl_id = var.enable_waf ? aws_wafv2_web_acl.this[0].arn : null
}
