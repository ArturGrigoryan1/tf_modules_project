variable "name_prefix" {
    default = "launch_config"
    description = "launch template name prefix"
}

variable "instance_type" {
    default = "t2.micro"
    description = "launch template instance type"  
}

variable "associate_pub_ip" {
    type = bool
    default = false
    description = "Associate public id_address to instance or not"
}

variable "vpc_security_group_ids" {
    default = [""]
    description = "Specifies the security groups to associate with the network interface"
}

variable "hibernation" {
	type = bool
	default = false
	description = "Hibernation options of instances"
}

variable "monitoring" {
    type = bool
    default = false
    description = "Monitoring for instances"
}



variable "key_algorithm" {
  type        = string
  description = "Key_algorithm(rsa, ecdsa or ed25519)"
  default     = "RSA"
}

variable "rsa_bits" {
  description = "Length of key with rsa_algorithm(2048,4096)"
  default     = 2048
}

variable "key_name" {
	default = "priv-key"
	description = "Name of instance key"
}

variable "key_file" {
	default = "key.pem"
	description = "File for storing private key"
}


variable "max_size" {
    type = number    
    default = 3
    description = "Maximum size of asg"
}
variable "min_size" {
    type = number    
    default = 1
    description = "Minimum size of asg"
}
variable "desired_capacity" {
    type = number    
    default = 2
    description = "Desired capacity of asg"
}
variable "asg_health_check_type" {
    type = string
    default = "EC2"
}
variable "lb_subnets" {
    type = list(string)
    default = [ "" ]
}

variable "availability_zones" {
    type = list(string)
    default = ["eu-central-1a"]
}


variable "scale_up_and_down" {
    type = bool
    default = true
    description = "Create scale up/down policy and alarm" 
}
variable "scale_up_scaling_adjustment" {
    default = "1"
    description = "Increasing instance by 1 "
}
variable "scale_up_cooldown" {
    default = "300"  
}
variable "scale_up_evaluation_periods" {
    default = "2"  
}
variable "scale_up_metric_name" {
    default = "CPUUtilization"
}
variable "scale_up_namespace" {
    default = "AWS/EC2"
}
variable "scale_up_period" {
    default = "120"
}
variable "scale_up_threshold" {
    default = "30"
    description = "New instance will be created once CPU utilization is higher than 30 %"
}

variable "scale_down_scaling_adjustment" {
    default = "-1"
    description = "Decreasing instance by 1 "
}
variable "scale_down_cooldown" {
    default = "300"  
}
variable "scale_down_evaluation_periods" {
    default = "2"  
}
variable "scale_down_metric_name" {
    default = "CPUUtilization"
}
variable "scale_down_namespace" {
    default = "AWS/EC2"
}
variable "scale_down_period" {
    default = "120"
}
variable "scale_down_threshold" {
    default = "5"
    description = "Instance will scale down when CPU utilization is lower than 5 %"
}










