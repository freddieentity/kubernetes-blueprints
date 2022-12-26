provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "subnet_public" {
  count                   = var.az_span
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  availability_zone       = var.availability_zone[count.index]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tenant}-${var.project}-${var.application}-public-${count.index + 1}"
  }
}

resource "aws_subnet" "subnet_private" {
  count             = var.az_span
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 100 + count.index)
  availability_zone = var.availability_zone[count.index]
  vpc_id            = aws_vpc.vpc.id

  tags = {
    Name = "${var.tenant}-${var.project}-${var.application}-private-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# resource "aws_eip" "eip_natgw" {
#     count = 1
#     vpc = true
#     depends_on = [aws_vpc.vpc]
# }

# resource "aws_nat_gateway" "natgw" {
#     count = 1
#     subnet_id = element(aws_subnet.subnet_public.*.id, count.index)
#     allocation_id = element(aws_eip.eip_natgw.*.id, count.index)  
# }

resource "aws_route_table" "rt-private-subnet" {
    count = var.az_span
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        # nat_gateway_id = element(aws_nat_gateway.natgw.*.id, 0)
        # nat_gateway_id = element(aws_nat_gateway.natgw.*.id, count.index)
    }
}

# resource "aws_route_table_association" "pvtsub-natgw" {
#   count = var.az_span
#   subnet_id = element(aws_subnet.subnet_private.*.id, count.index)
#   route_table_id = element(aws_route_table.rt-private-subnet.*.id, count.index)
# }
