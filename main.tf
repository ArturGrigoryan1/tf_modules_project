locals {
    only_bucket = var.only_s3
    stat_website = var.s3_website_hosting
    bucket_with_cf = var.s3_with_cloudfront
}

module "s3_b" {
    count = local.only_bucket || local.stat_website || local.bucket_with_cf ? 1 : 0
    source = "./Modules/S3_modules"
    web_or_cf = local.only_bucket == true ? false : true 
    bucket_name = var.bucket_name
    force_destroy = var.force_destroy
    publicIP = var.publicIP
    folder_object = var.folder_object
    files_object = var.files_object
    object_content_encoding = var.object_content_encoding
}

module "bucket_with_cf" {
    count = local.bucket_with_cf || var.only_cf ? 1 : 0 
    source = "./Modules/Cloudfront_modules"
    bucket_name = local.bucket_with_cf ? module.s3_b[0].aws_s3_bucket_name : var.module_bucket_name
    target_origin_id = local.bucket_with_cf ? module.s3_b[0].target_origin_id : var.target_origin_id
    domain_name = local.bucket_with_cf ? module.s3_b[0].domain_name : var.domain_name
    bucket_arn = local.bucket_with_cf ? module.s3_b[0].bucket_arn : var.bucket_arn
    bucket_id = local.bucket_with_cf ? module.s3_b[0].bucket_id : var.bucket_id
    cf_root_object = var.cf_root_object
    cf_allowed_methods = var.cf_allowed_methods
    cf_cached_methods = var.cf_cached_methods
    cf_viewer_protocol_policy = var.cf_viewer_protocol_policy
    cf_cache_policy_id = var.cf_cache_policy_id
    cf_max_ttl = var.cf_max_ttl
    cf_default_ttl = var.cf_default_ttl
    cf_min_ttl = var.cf_min_ttl
    cf_restriction_type = var.cf_restriction_type
    cf_restriction_locations = var.cf_restriction_locations
}


module "create_lambda" {
    count = var.create_lambda_function ? 1 : 0
    source = "./Modules/Lambda_function_module"
    source_dir = var.lf_source_dir
    output_path = var.lf_output_path
    function_name = var.lf_function_name
    handler = var.lf_handler
    runtime_lang = var.lf_runtime_lang
}

module "create_VPC" {
    count = var.create_VPC ? 1 : 0  
    source = "./Modules/VPC_modules/network"
    vpc_cidr = var.vpc_cidr
    env = var.vpc_env
    public_subnet_ciders = var.vpc_public_subnet_ciders
    private_subnet_ciders = var.vpc_private_subnet_ciders
    db_subnet_ciders = var.vpc_db_subnet_ciders
    availability_zones = var.vpc_availability_zones
}

module "secrurity_group" {
    count = var.attach_VPC_and_security_group || var.attach_VPC_and_load_balancer ? 1 : 0
    source = "./Modules/VPC_modules/secrurity_group"
    sg_vpc_cidr = module.create_VPC[0].vpc_id
    ingress_port = var.sg_ingress_port
    ingress_cidr_blocks = var.sg_ingress_cidr_blocks
    ingress_protocol = var.sg_ingress_protocol
    egress_cidr_blocks = var.sg_egress_cidr_blocks
    egress_protocol = var.sg_egress_protocol
    
}

module "load_balancer" {
    count = var.create_load_balancer ? 1 : 0
    source = "./Modules/Load_balancer"
    lb_name = var.lb_name
    security_group_id = var.attach_VPC_and_load_balancer && var.create_VPC ? module.secrurity_group[0].security_group_id : var.lb_security_group_id
    public_subnet_ids = var.attach_VPC_and_load_balancer && var.create_VPC ? module.create_VPC[0].public_subnet_ids : var.lb_public_subnet_ids
    vpc_id = var.attach_VPC_and_load_balancer && var.create_VPC ? module.create_VPC[0].vpc_id : var.lb_vpc_id
    tg_name = var.lb_tg_name
    tg_port = var.lb_tg_port
    tg_protocol = var.lb_tg_protocol
    tg_hch_enabled = var.lb_tg_hch_enabled
    tg_hch_interval = var.lb_tg_hch_interval
    tg_hch_path = var.lb_tg_hch_path
    tg_hch_timeout = var.lb_tg_hch_timeout
    tg_hch_matcher = var.lb_tg_hch_matcher
    tg_hch_healthy_threshold = var.lb_tg_hch_healthy_threshold
    tg_hch_unhealthy_threshold = var.lb_tg_hch_unhealthy_threshold
}


module "autoscaling_group" {
    count = var.create_auto_scaling_group || var.attach_auto_scaling_group_and_load_balancer ? 1 : 0
    source = "./Modules/Auto_scaling_group_module"
    name_prefix = var.asg_name_prefix
    instance_type = var.asg_instance_type
    associate_pub_ip = var.asg_associate_pub_ip
    vpc_security_group_ids = var.attach_auto_scaling_group_and_load_balancer ? module.load_balancer[0].alb_security_group_id : var.asg_vpc_security_group_ids
    hibernation = var.asg_hibernation
    monitoring = var.asg_monitoring
    key_algorithm = var.asg_key_algorithm
    rsa_bits = var.asg_rsa_bits
    key_name = var.asg_key_name
    key_file = var.asg_key_file
    max_size = var.asg_max_size
    min_size = var.asg_min_size
    desired_capacity = var.asg_desired_capacity
    asg_health_check_type = var.asg_health_check_type
    lb_subnets = var.attach_auto_scaling_group_and_load_balancer ? module.load_balancer[0].alb_subnets : var.asg_lb_subnets
    availability_zones = var.attach_auto_scaling_group_and_load_balancer ? null : var.asg_availability_zones
   
    scale_up_and_down = var.asg_scale_up_and_down
    scale_up_scaling_adjustment = var.asg_scale_up_scaling_adjustment
    scale_up_cooldown = var.asg_scale_up_cooldown
    scale_up_evaluation_periods = var.asg_scale_up_evaluation_periods
    scale_up_metric_name = var.asg_scale_up_metric_name
    scale_up_namespace = var.asg_scale_up_namespace
    scale_up_period = var.asg_scale_up_period
    scale_up_threshold = var.asg_scale_up_threshold
    scale_down_scaling_adjustment = var.asg_scale_down_scaling_adjustment
    scale_down_cooldown = var.asg_scale_down_cooldown
    scale_down_evaluation_periods = var.asg_scale_down_evaluation_periods
    scale_down_metric_name = var.asg_scale_down_metric_name
    scale_down_namespace = var.asg_scale_down_namespace
    scale_down_period = var.asg_scale_down_period
    scale_down_threshold = var.asg_scale_down_threshold
}

module "create_ec2" {
    count = var.create_EC2 ? 1 : 0
    source = "./Modules/EC2_module"
    ec2_count = var.ec2_count
    instance_type = var.ec2_instance_type
    ami = var.ec2_ami
    associate_public_ip_address = var.ec2_associate_public_ip_address
    subnet_id = var.attach_EC2_and_VPC ? module.create_VPC[0].public_subnet_ids[0] : var.ec2_subnet_id
    availability_zone = var.ec2_availability_zone
    vpc_security_group_ids = var.attach_EC2_and_VPC && var.attach_VPC_and_security_group && var.create_VPC ? [module.secrurity_group[0].security_group_id] : var.ec2_vpc_security_group_ids
    user_data_filepath = var.ec2_user_data_filepath
    key_name = var.ec2_key_name
}
















