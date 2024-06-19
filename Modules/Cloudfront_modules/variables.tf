variable "bucket_name" {
    default = "mybucket1231231322133215312"  
}

variable "cf_root_object" {
    default = "index.html"  
}

variable "cf_allowed_methods" {
    default = ["GET", "HEAD"]  
}

variable "cf_cached_methods" {
    default = ["GET", "HEAD"]
}

variable "cf_viewer_protocol_policy" {
    default = "allow-all"  
}

variable "cf_cache_policy_id" {
    default = "658327ea-f89d-4fab-a63d-7e88639e58f6"  
}

variable "cf_min_ttl" {
    default = 0    
}

variable "cf_default_ttl" {
    default = 3600
}

variable "cf_max_ttl" {
    default = 86400  
}

variable "cf_restriction_type" {
    default = "none"
    description = "Method that you want to use to restrict distribution:none, whitelist, blacklist"
}

variable "cf_restriction_locations" {
    default = []
    description = " ISO 3166-1-alpha-2 codes for which you want: [US, CA, GB, DE] "
}

variable "target_origin_id" {
    description = "target_origin_id //aws_s3_bucket.main.bucket"  
}

variable "domain_name" {
    description = "domain_name //aws_s3_bucket.main.bucket_regional_domain_name"  
}

variable "bucket_arn" {
    description = "bucket_arn //aws_s3_bucket.main.arn"
}

variable "bucket_id" {
    description = "bucket_id //aws_s3_bucket.main.id"
  
}