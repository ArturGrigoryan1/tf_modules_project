resource "aws_security_group" "my-sg" {
    name = "Allow_some_ports"
    description = "Allow ssh and http inbound traffic"
    vpc_id = var.sg_vpc_cidr

    tags = {
      Name = "allow_http"
    }
    
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count = length(var.ingress_port)
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = element(var.ingress_cidr_blocks,count.index)
  from_port         = element(var.ingress_port,count.index)
  ip_protocol       = element(var.ingress_protocol,count.index)
  to_port           = element(var.ingress_port,count.index)
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  count = length(var.egress_cidr_blocks)
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = element(var.egress_cidr_blocks,count.index)
  ip_protocol       = element(var.egress_protocol,count.index)
}