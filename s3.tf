module "s3" {
  source  = "github.com/champ-oss/terraform-aws-s3.git?ref=v1.0.47-a8485d3"
  git     = substr(var.git, 0, 60)
  name    = var.name
  protect = var.protect
  tags    = merge({ Name = var.git }, local.tags, var.tags)
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = module.s3.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}


# cloudfront s3 bucket policy
resource "aws_s3_bucket_policy" "this" {
  bucket = module.s3.bucket
  policy = data.aws_iam_policy_document.this.json
}