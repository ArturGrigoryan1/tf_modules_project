data "aws_ami" "latest_22_ubuntu" {
    owners = ["099720109477"]
    most_recent = true
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }  
}

resource "aws_launch_template" "launch" {
    name_prefix   = var.name_prefix
    image_id      = data.aws_ami.latest_22_ubuntu.id
    instance_type = var.instance_type
    key_name = aws_key_pair.key.key_name

    network_interfaces {
      associate_public_ip_address = var.associate_pub_ip
      security_groups = var.vpc_security_group_ids
    }

    hibernation_options {
      configured = var.hibernation
    }

    monitoring {
      enabled = var.monitoring
    }

    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "launch_template"
      }
    }
    
}

resource "tls_private_key" "key_gen" {
    algorithm = var.key_algorithm
    rsa_bits = var.rsa_bits
}

resource "aws_key_pair" "key" {
    key_name = var.key_name
    public_key = tls_private_key.key_gen.public_key_openssh
}

resource "local_file" "key_file"{
    content = tls_private_key.key_gen.private_key_pem
    filename = var.key_file
}

resource "aws_autoscaling_group" "asg" {
    name                      = "asg"
    max_size                  = var.max_size
    min_size                  = var.min_size
    desired_capacity          = var.desired_capacity
    health_check_grace_period = 300
    health_check_type         = var.asg_health_check_type
    availability_zones = var.availability_zones
    vpc_zone_identifier = var.lb_subnets

    enabled_metrics = [
        "GroupMinSize",
        "GroupMaxSize",
        "GroupDesiredCapacity",
        "GroupInServiceInstances",
        "GroupTotalInstances"
    ]

    metrics_granularity = "1Minute"

    launch_template {
        id      = aws_launch_template.launch.id
        version = aws_launch_template.launch.latest_version 
    }
}


resource "aws_autoscaling_policy" "scale_up" {
    count = var.scale_up_and_down ? 1 : 0
    name                   = "asg-scale-up"
    autoscaling_group_name = aws_autoscaling_group.asg.name
    adjustment_type        = "ChangeInCapacity"
    scaling_adjustment     = var.scale_up_scaling_adjustment
    cooldown               = var.scale_up_cooldown
    policy_type            = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
    count = var.scale_up_and_down ? 1 : 0
    alarm_name          = "asg-scale-up-alarm"
    alarm_description   = "asg-scale-up-cpu-alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = var.scale_up_evaluation_periods
    metric_name         = var.scale_up_metric_name
    namespace           = var.scale_up_namespace
    period              = var.scale_up_period
    statistic           = "Average"
    threshold           = var.scale_up_threshold
    dimensions = {
        "AutoScalingGroupName" = aws_autoscaling_group.asg.name
    }
    actions_enabled = true
    alarm_actions   = [aws_autoscaling_policy.scale_up[0].arn]
}

resource "aws_autoscaling_policy" "scale_down" {
    count = var.scale_up_and_down ? 1 : 0
    name                   = "asg-scale-down"
    autoscaling_group_name = aws_autoscaling_group.asg.name
    adjustment_type        = "ChangeInCapacity"
    scaling_adjustment     = var.scale_down_scaling_adjustment 
    cooldown               = var.scale_down_cooldown
    policy_type            = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
    count = var.scale_up_and_down ? 1 : 0
    alarm_name          = "asg-scale-down-alarm"
    alarm_description   = "asg-scale-down-cpu-alarm"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods  = var.scale_down_evaluation_periods
    metric_name         = var.scale_down_metric_name
    namespace           = var.scale_down_namespace
    period              = var.scale_down_period
    statistic           = "Average"
    threshold           = var.scale_down_threshold
    dimensions = {
        "AutoScalingGroupName" = aws_autoscaling_group.asg.name
    }
    actions_enabled = true
    alarm_actions   = [aws_autoscaling_policy.scale_down[0].arn]
}









