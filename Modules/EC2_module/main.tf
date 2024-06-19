/*terraform {
  required_providers {
    aws = {
      version = ">=5.0.0"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  
}
*/
data "aws_ami" "Latest_Ubuntu_22" {
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
}

resource "aws_instance" "my_instance" {
    count = var.ec2_count
    ami                         = data.aws_ami.Latest_Ubuntu_22.id
    instance_type               = var.instance_type
    associate_public_ip_address = var.associate_public_ip_address
    availability_zone           = var.availability_zone
    subnet_id                   = var.subnet_id #aws_subnet.public.id
    vpc_security_group_ids      = var.vpc_security_group_ids #[aws_security_group.my-sg.id]
    user_data                   = var.user_data_filepath
    key_name                    = var.key_name #aws_key_pair.ec2.key_name
}