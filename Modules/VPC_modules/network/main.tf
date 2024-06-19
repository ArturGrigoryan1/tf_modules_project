resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.env}-vpc"
    }  
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.env}-igw"
    }  
}


#Public subnets and routing
resource "aws_subnet" "public_subnets" {
    count = length(var.public_subnet_ciders)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.public_subnet_ciders, count.index)  
    availability_zone = element(var.availability_zones, count.index)
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.env}-public-${count.index + 1}"
    }
}

resource "aws_route_table" "public_subnets" {
    vpc_id = aws_vpc.main.id  
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
    route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
    }
    tags = {
        Name = "${var.env}-route-public-subnets"
    }
}

resource "aws_route_table_association" "public_routes" {
    count = length(aws_subnet.public_subnets[*].id)
    route_table_id = aws_route_table.public_subnets.id
    subnet_id = element(aws_subnet.public_subnets[*].id, count.index)  
}

#NAT gateways with elastic IP
resource "aws_eip" "nat" {
    count = length(var.private_subnet_ciders)
    domain = "vpc"
    tags = {
      Name = "${var.env}-nat-gw-${count.index + 1}"
    }
}

resource "aws_nat_gateway" "nat" {
    count = length(var.private_subnet_ciders)
    allocation_id = aws_eip.nat[count.index].id
    subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
    tags = {
      Name = "${var.env}-nat-gw-${count.index + 1}"
    }
}

#Private subnets and routing
resource "aws_subnet" "private_subnets" {
    count = length(var.private_subnet_ciders)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.private_subnet_ciders, count.index)  
    tags = {
      Name = "${var.env}-private-${count.index + 1}"
    }
}

resource "aws_route_table" "private_subnets" {
    count = length(var.private_subnet_ciders)
    vpc_id = aws_vpc.main.id  
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat[count.index].id
    }
    route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
    }
    tags = {
        Name = "${var.env}-route-private-subnet-${count.index + 1}"
    }
}

resource "aws_route_table_association" "private_routes" {
    count = length(aws_subnet.private_subnets[*].id)
    route_table_id = aws_route_table.private_subnets[count.index].id
    subnet_id = element(aws_subnet.private_subnets[*].id, count.index)  
}



#DB subnets and routing
resource "aws_subnet" "db_subnets" {
    count = length(var.db_subnet_ciders)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.db_subnet_ciders, count.index)  
    tags = {
      Name = "${var.env}-db-${count.index + 1}"
    }
}
resource "aws_route_table" "db_subnets" {
    count = length(var.db_subnet_ciders)
    vpc_id = aws_vpc.main.id  
    route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
    }
    tags = {
        Name = "${var.env}-route-db-subnet-${count.index + 1}"
    }
}
resource "aws_route_table_association" "db_routes" {
    count = length(aws_subnet.db_subnets[*].id)
    route_table_id = aws_route_table.db_subnets[count.index].id
    subnet_id = element(aws_subnet.db_subnets[*].id, count.index)  
}
