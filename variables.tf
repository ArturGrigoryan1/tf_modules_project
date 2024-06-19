#######s3 variables#######
variable "only_s3" {
    type = bool
    description = "this is only s3 bucket"
  
}

variable "s3_website_hosting" {
    type = bool
    description = "this is s3 bucket static website"  
}

variable "s3_with_cloudfront" {
    type = bool
    description = "this is s3 bucket with cloudfront"
}

variable "bucket_name" {
  type = string
  description = "bucket unique name"
  default = "my-tf-test-bucket111121232153132335"
}

variable "force_destroy" {
    type = bool
    description = "bucket can be destroyed without error"
    default = false
}

variable "publicIP" {
    description = "public IP adress"  
    type = string
    default = "195.8.50.36"
}

variable "folder_object" {
    description = "download files folders for s3"
    default = "./Source_file"  
}

variable "files_object" {
    description = "download files for s3"
    default = "**"  
}

variable "object_content_encoding" {
    default = "utf-8"
}

#######cloudfront variables#######

variable "only_cf" {
    description = "cf with your s3 bucket"
    type = bool
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
    description = "target_origin_id //ex//aws_s3_bucket.main.bucket"  
    default = ""
}

variable "domain_name" {
    description = "domain_name //ex//aws_s3_bucket.main.bucket_regional_domain_name"  
    default = ""
}

variable "bucket_arn" {
    description = "bucket_arn //ex//aws_s3_bucket.main.arn"
    default = ""
}

variable "bucket_id" {
    description = "bucket_id //ex//aws_s3_bucket.main.id"
    default = ""
  
}
variable "module_bucket_name" {
    description = "s3 bucket name"
    default = ""
}

#######lambda_function variables#######

variable "create_lambda_function" {
    type = bool
    description = "create lambda function"
}

variable "lf_source_dir" {
	type = string
	default = "./Modules/Lambda_function_module/python/"
	description = "Source directory of target file containing Lambda function"
}

variable "lf_output_path" {
	type = string
	default = "./Modules/Lambda_function_module/python/main.zip"
	description = "Output zip file "
}

variable "lf_function_name" {
    type = string
    default = "Lambda-Function"
}

variable "lf_handler" {
    type = string
    default = "main.lambda_handler"  
    description = "name of your file + . + name of handler function"
}

variable "lf_runtime_lang" {
	type = string
	default = "python3.8"
	description = "Type and version of the runtime language"
}

#######Security group variables#######
variable "attach_VPC_and_security_group" {
    type = bool
    description = "value"  
}


variable "sg_ingress_port" {
    default =  [
        22,
        80
    ]   
}

variable "sg_ingress_protocol" {
    default = ["tcp", "tcp"]  
}

variable "sg_ingress_cidr_blocks" {
    default = ["0.0.0.0/0","0.0.0.0/0"]  
}

variable "sg_egress_cidr_blocks" {
    default = ["0.0.0.0/0"]  
}

variable "sg_egress_protocol" {
    default = ["-1"]  
}

#######VPC variables#######

variable "create_VPC" {
    type = bool
    description = "Create VPC"  
}

variable "vpc_cidr" {
    default = "10.0.0.0/16" 
}

variable "vpc_env" {
    default = "dev"   
}

variable "vpc_public_subnet_ciders" {
    default = [
        "10.0.1.0/24",
        "10.0.2.0/24"
    ]
}

variable "vpc_private_subnet_ciders" {
    default = [
        "10.0.11.0/24",
        "10.0.22.0/24"
    ]
}

variable "vpc_db_subnet_ciders" {
    default = [
        "10.0.111.0/24",
        "10.0.122.0/24"
    ]
}

variable "vpc_availability_zones" {
    default =   ["eu-central-1a","eu-central-1b","eu-central-1c"]
}
#######Load balancer variables#######

variable "create_load_balancer" {
    type = bool  
}

variable "attach_VPC_and_load_balancer" {
    type = bool
}

variable "lb_name" {
    type = string
    description = "name of load balancer"
    default = "alb"
}

variable "lb_security_group_id" {
    description = "your security droup id"
    default = ""
}
variable "lb_public_subnet_ids" {
    type = list(string)
    default = ["10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24"]
}
variable "lb_vpc_id" {
    description = "your VPC id"
    default = ""
}
variable "lb_tg_name" {
    type = string
    description = "name of target group"
    default = "tg"
}

variable "lb_tg_port" {
    default = 80  
}

variable "lb_tg_protocol" {
    default = "HTTP"
}
variable "lb_tg_hch_enabled" {
    type = bool
    default = true  
}
variable "lb_tg_hch_interval" {
    default = 300
}
variable "lb_tg_hch_path" {
    default = "/"
  
}
variable "lb_tg_hch_timeout" {
    default = 60
  
}
variable "lb_tg_hch_matcher" {
    default = 200
}
variable "lb_tg_hch_healthy_threshold" {
    default = 5
}
variable "lb_tg_hch_unhealthy_threshold" {
    default = 5
}

#######Auto scaling group variables#######

variable "create_auto_scaling_group" {
    type = bool
}
variable "attach_auto_scaling_group_and_load_balancer" {
    type = bool
}


variable "asg_name_prefix" {
    default = "launch_config"
    description = "launch template name prefix"
}
variable "asg_instance_type" {
    default = "t2.micro"
    description = "launch template instance type"  
}
variable "asg_associate_pub_ip" {
    type = bool
    default = false
    description = "Associate public id_address to instance or not"
}
variable "asg_vpc_security_group_ids" {
    default = [""]
    description = "Specifies the security groups to associate with the network interface"
}
variable "asg_hibernation" {
	type = bool
	default = false
	description = "Hibernation options of instances"
}
variable "asg_monitoring" {
    type = bool
    default = false
    description = "Monitoring for instances"
}

variable "asg_key_algorithm" {
  type        = string
  description = "Key_algorithm(rsa, ecdsa or ed25519)"
  default     = "RSA"
}
variable "asg_rsa_bits" {
  description = "Length of key with rsa_algorithm(2048,4096)"
  default     = 2048
}
variable "asg_key_name" {
	default = "priv-key"
	description = "Name of instance key"
}
variable "asg_key_file" {
	default = "key.pem"
	description = "File for storing private key"
}

variable "asg_max_size" {
    type = number    
    default = 3
    description = "Maximum size of asg"
}
variable "asg_min_size" {
    type = number    
    default = 1
    description = "Minimum size of asg"
}
variable "asg_desired_capacity" {
    type = number    
    default = 2
    description = "Desired capacity of asg"
}
variable "asg_health_check_type" {
    type = string
    default = "EC2"
}
variable "asg_lb_subnets" {
    type = list(string)
    default = [ "" ]
}
variable "asg_availability_zones" {
    type = list(string)
    default = ["eu-central-1a"]
}

variable "asg_scale_up_and_down" {
    type = bool
    default = true
    description = "Create scale up/down policy and alarm" 
}
variable "asg_scale_up_scaling_adjustment" {
    default = "1"
    description = "Increasing instance by 1 "
}
variable "asg_scale_up_cooldown" {
    default = "300"  
}
variable "asg_scale_up_evaluation_periods" {
    default = "2"  
}
variable "asg_scale_up_metric_name" {
    default = "CPUUtilization"
}
variable "asg_scale_up_namespace" {
    default = "AWS/EC2"
}
variable "asg_scale_up_period" {
    default = "120"
}
variable "asg_scale_up_threshold" {
    default = "30"
    description = "New instance will be created once CPU utilization is higher than 30 %"
}
variable "asg_scale_down_scaling_adjustment" {
    default = "-1"
    description = "Decreasing instance by 1 "
}
variable "asg_scale_down_cooldown" {
    default = "300"  
}
variable "asg_scale_down_evaluation_periods" {
    default = "2"  
}
variable "asg_scale_down_metric_name" {
    default = "CPUUtilization"
}
variable "asg_scale_down_namespace" {
    default = "AWS/EC2"
}
variable "asg_scale_down_period" {
    default = "120"
}
variable "asg_scale_down_threshold" {
    default = "5"
    description = "Instance will scale down when CPU utilization is lower than 5 %"
}

#######EC2 variables#######

variable "create_EC2" {
    type = bool
}
variable "attach_EC2_and_VPC" {
    type = bool  
}

variable "ec2_count" {
    description = "count of ec2 instances"
    type = number
    default = 2  
}
variable "ec2_instance_type" {
  description = "instance_type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_associate_public_ip_address" {
  description = "associate_public_ip_address"
  type        = bool
  default     = true
}

variable "ec2_subnet_id" {
  description = "subnet_id"
  type        = string
  default     = null
}

variable "ec2_availability_zone" {
  description = "availability_zone"
  type        = string
  default     = null
}

variable "ec2_vpc_security_group_ids" {
  description = "vpc_security_group_ids"
  default     = [""]
}

variable "ec2_user_data_filepath" {
  description = "user_data_filepath"
  type        = string
  default     = "./Modules/EC2_module/user_data.sh"
}

variable "ec2_key_name" {
  description = "key_name"
  type        = string
  default     = null
}




















