terraform {
  backend "s3" {}
}

provider "aws" {
  region = "us-east-2"
}

data "aws_region" "current" {}

data "aws_vpcs" "this" {
  tags = {
    purpose = "vega"
  }
}

data "aws_subnets" "this" {
  tags = {
    purpose = "vega"
    Type    = "Private"
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.this.ids[0]]
  }
}
data "aws_route53_zone" "this" {
  name = "oss.champtest.net."
}

module "this" {
  source             = "../../"
  vpc_id             = data.aws_vpcs.this.ids[0]
  zone_id =  data.aws_route53_zone.this.zone_id
}