resource "aws_wafv2_ip_set" "this" {
  count              = var.enable_waf ? 1 : 0
  provider           = aws.virginia
  name               = var.git
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  tags               = local.tags
  addresses          = var.addresses
}

resource "aws_wafv2_web_acl" "this" {
  count    = var.enable_waf ? 1 : 0
  provider = aws.virginia

  name  = "${var.git}-waf"
  scope = "CLOUDFRONT"
  default_action {
    block {}
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.git}-waf"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "ip-allow-list"
    priority = 1
    action {
      allow {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.this[0].arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "ip-allow-list"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "BadInputs"
      sampled_requests_enabled   = false
    }
  }
}
