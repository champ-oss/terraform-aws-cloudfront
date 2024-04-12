terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_route53_zone" "this" {
  name = "oss.champtest.net."
}

module "this" {
  source  = "../../"
  zone_id = data.aws_route53_zone.this.zone_id
  domain  = data.aws_route53_zone.this.name
}
