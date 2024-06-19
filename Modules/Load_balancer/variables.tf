variable "lb_name" {
    type = string
    description = "name of load balancer"
    default = "alb"
}

variable "security_group_id" {}

variable "public_subnet_ids" {
    type = list(string)
}


variable "tg_name" {
    type = string
    description = "name of target group"
    default = "tg"
}

variable "tg_port" {
    default = 80  
}

variable "tg_protocol" {
    default = "HTTP"
  
}

variable "vpc_id" {}

variable "tg_hch_enabled" {
    type = bool
    default = true  
}
variable "tg_hch_interval" {
    default = 300
}
variable "tg_hch_path" {
    default = "/"
  
}
variable "tg_hch_timeout" {
    default = 60
  
}
variable "tg_hch_matcher" {
    default = 200
}
variable "tg_hch_healthy_threshold" {
    default = 5
}
variable "tg_hch_unhealthy_threshold" {
    default = 5
}











































