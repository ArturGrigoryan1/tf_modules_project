variable "vpc_cidr" {
    default = "10.0.0.0/16" 
}

variable "env" {
    default = "dev"   
}

variable "public_subnet_ciders" {
    default = [
        "10.0.1.0/24",
        "10.0.2.0/24"
    ]
}

variable "private_subnet_ciders" {
    default = [
        "10.0.11.0/24",
        "10.0.22.0/24"
    ]
}

variable "db_subnet_ciders" {
    default = [
        "10.0.111.0/24",
        "10.0.122.0/24"
    ]
}

variable "availability_zones" {
    default =   ["eu-central-1a","eu-central-1b","eu-central-1c"]
}