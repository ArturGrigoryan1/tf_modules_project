resource "aws_instance" "my_instance" {
    count = var.ec2_count
    ami                         = var.ami
    instance_type               = var.instance_type
    associate_public_ip_address = var.associate_public_ip_address
    availability_zone           = var.availability_zone
    subnet_id                   = var.subnet_id #aws_subnet.public.id
    vpc_security_group_ids      = var.vpc_security_group_ids #[aws_security_group.my-sg.id]
    user_data                   = var.user_data_filepath
    key_name                    = var.key_name #aws_key_pair.ec2.key_name
}
