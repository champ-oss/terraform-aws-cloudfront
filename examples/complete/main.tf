terraform {
  backend "s3" {}
}

provider "aws" {
  region = "us-east-2"
}

data "aws_region" "current" {}

data "aws_route53_zone" "this" {
  name = "oss.champtest.net."
}

module "this" {
  source  = "../../"
  zone_id = data.aws_route53_zone.this.zone_id
  domain  = data.aws_route53_zone.this.name
}