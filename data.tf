data "aws_iam_policy_document" "this" {
  statement {
    actions = ["s3:GetObject"]
    resources = [
      module.s3.arn,
      "${module.s3.arn}/*"
    ]
    condition {
      variable = "aws:SourceArn"
      test     = "StringEquals"
      values   = [aws_cloudfront_distribution.this.arn]
    }
  }

  statement {
    actions = ["s3:ListBucket"]
    resources = [
      module.s3.arn,
      "${module.s3.arn}/*"
    ]

    condition {
      variable = "aws:SourceArn"
      test     = "StringEquals"
      values   = [aws_cloudfront_distribution.this.arn]
    }
  }
}
