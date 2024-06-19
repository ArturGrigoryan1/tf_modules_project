terraform {
  required_providers {
    aws = {
      version = ">=5.0.0"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  
}

data "aws_ami" "Latest_Ubuntu_22" {
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
}

module "example" {
    source = "git@github.com:ArturGrigoryan1/tf_modules_project.git"
    create_VPC = true
    attach_VPC_and_security_group = true
    create_load_balancer = true
    attach_VPC_and_load_balancer = true
    create_auto_scaling_group = true
    attach_auto_scaling_group_and_load_balancer = true
    create_EC2 = true
    attach_EC2_and_VPC = true
    ec2_ami = data.aws_ami.Latest_Ubuntu_22.id
}
