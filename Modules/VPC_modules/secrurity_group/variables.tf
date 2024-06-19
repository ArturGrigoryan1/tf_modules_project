variable "sg_vpc_cidr" {
    default = "192.168.0.0/16" 
}

variable "ingress_port" {
    default =  [
        22,
        80
    ]   
}

variable "ingress_protocol" {
    default = ["tcp", "tcp"]  
}

variable "ingress_cidr_blocks" {
    default = ["0.0.0.0/0","0.0.0.0/0"]  
}

variable "egress_cidr_blocks" {
    default = ["0.0.0.0/0"]  
}

variable "egress_protocol" {
    default = ["-1"]  
}




