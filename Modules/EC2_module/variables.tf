variable "ec2_count" {
    description = "count of ec2 instances"
    type = number
    default = 2  
}
variable "ami" {
    description = "EC2 ami"
    type        = string
    default     = ""
    
}
variable "instance_type" {
  description = "instance_type"
  type        = string
  default     = "t2.micro"
}

variable "associate_public_ip_address" {
  description = "associate_public_ip_address"
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "subnet_id"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "availability_zone"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "vpc_security_group_ids"
  type        = list(string)
  default     = []
}

variable "user_data_filepath" {
  description = "user_data_filepath"
  type        = string
  default     = "user_data.sh"
}

variable "key_name" {
  description = "key_name"
  type        = string
  default     = null
}
