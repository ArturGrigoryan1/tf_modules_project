resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.cf_root_object

  default_cache_behavior {
    allowed_methods  = var.cf_allowed_methods
    cached_methods   = var.cf_cached_methods
    target_origin_id = var.target_origin_id
    viewer_protocol_policy = var.cf_viewer_protocol_policy
    cache_policy_id = var.cf_cache_policy_id
    min_ttl                = var.cf_min_ttl
    default_ttl            = var.cf_default_ttl
    max_ttl                = var.cf_max_ttl
    
  }
  
  origin {
    domain_name              = var.domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
    origin_id                = var.target_origin_id
    
  }

  restrictions {
    geo_restriction {
      restriction_type = var.cf_restriction_type
      locations        = var.cf_restriction_locations
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  
}

resource "aws_cloudfront_origin_access_control" "main" {
  name = "s3-cloudfront-test"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"  
  signing_protocol = "sigv4"
}

data "aws_iam_policy_document" "cloudfront_access" {
  statement {
    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type = "Service"
    }

    actions = ["s3:GetObject"]
    resources = ["${var.bucket_arn}/*"]

    condition {
      test = "StringEquals"
      values = [aws_cloudfront_distribution.main.arn]
      variable = "AWS:SourceArn"
    }
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.cloudfront_access.json   
}