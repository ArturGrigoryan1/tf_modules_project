output "bucket_id" {
    value = aws_s3_bucket.my_bucket.id
}

output "bucket_arn" {
    value = aws_s3_bucket.my_bucket.arn  
}

output "aws_s3_bucket_name" {
    value = aws_s3_bucket.my_bucket.bucket  
}

output "domain_name" {
    value = aws_s3_bucket.my_bucket.bucket_regional_domain_name  
}

output "target_origin_id" {
    value = aws_s3_bucket.my_bucket.bucket
}