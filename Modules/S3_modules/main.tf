locals {
  content_types = {
    css = "text/css"
    html = "text/html"
    js = "application/javascript"
    json = "application/json"
    txt  = "text/plain"
    pdf = "application/pdf"
    jpeg = "image/jpeg"
    jpg = "image/jpeg"
    mp3 = "audio/mpeg"
  }
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  force_destroy = var.force_destroy

  tags = {
    Name        = "My bucket"
  }
}

 
resource "aws_s3_bucket_policy" "bucket_policy" {
  count = var.web_or_cf ? 1 : 0
  bucket = aws_s3_bucket.my_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.my_bucket.arn}/*",
          "${aws_s3_bucket.my_bucket.arn}"
        ]
        Condition: {
                "IpAddress": {
                    "aws:SourceIp": "${var.publicIP}"
                }
        } 
      }
    ]
  })
}
resource "aws_s3_object" "object" {
  for_each  = var.web_or_cf ? fileset(var.folder_object,var.files_object) : []
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = replace(each.value, var.files_object, "")
  source = "${var.folder_object}/${each.value}"
  content_type = lookup(local.content_types, element(split(".", each.value), length(split(".", each.value)) - 1), "text/plain")
  content_encoding = var.object_content_encoding
}