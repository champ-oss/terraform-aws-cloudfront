data "aws_iam_policy_document" "this" {
  statement {
    actions = ["s3:GetObject"]
    resources = [
      module.s3.arn,
      "${module.s3.arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }

  statement {
    actions = ["s3:ListBucket"]
    resources = [
      module.s3.arn,
      "${module.s3.arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }
}
