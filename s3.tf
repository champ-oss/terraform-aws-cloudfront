module "s3" {
  source  = "github.com/champ-oss/terraform-aws-s3.git?ref=7eb17035fc9de643796a670c90e0c621586f894d"
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

resource "aws_s3_object" "this" {
  bucket       = module.s3.bucket
  for_each     = fileset("uploads/", "*")
  key          = "website/${each.value}"
  source       = "uploads/${each.value}"
  etag         = filemd5("uploads/${each.value}")
  content_type = "text/html"
  depends_on = [
    module.s3
  ]
}

# cloudfront s3 bucket policy
resource "aws_s3_bucket_policy" "this" {
  bucket = module.s3.bucket
  policy = data.aws_iam_policy_document.this.json
}