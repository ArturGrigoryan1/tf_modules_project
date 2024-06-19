# tf_modules_project
With this project you can create the following modules
-S3 bucket
-Cloudfront
-Lambda function
-VPC 
-Load balancer
-Auto scaling group
-EC2 instance

You can connect them together and create
-Only S3 bucket
-S3 website hosting
-S3 with cloudfront
-Only floudfront
-Lambda function
-VPC
-Attach VPC and security group
-Load balancer
-Attach VPC and load balancer
-Auto scaling group 
-Attach auto scaling group and load balancer
-EC2 instance
-attach VPC and EC2

Usage

module "example" {
    source = "git@github.com:ArturGrigoryan1/tf_modules_project.git"
    only_s3 = false
    s3_website_hosting = false
    s3_with_cloudfront = false
    only_cf = false
    create_lambda_function = false
    create_VPC = true
    attach_VPC_and_security_group = true
    create_load_balancer = true
    attach_VPC_and_load_balancer = true
    create_auto_scaling_group = true
    attach_auto_scaling_group_and_load_balancer = true
    create_EC2 = true
    attach_EC2_and_VPC = true
}



