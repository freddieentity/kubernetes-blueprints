resource "aws_vpc" "cluster_vpc"{
  cidr_block = cidrsubnet("172.20.0.0/16",0,0)
  tags={
    Name="cluster_vpc"
  }
}
resource "aws_internet_gateway" "cluster_internet_gateway" {
  vpc_id = aws_vpc.cluster_vpc.id
  tags = {
    Name = "cluster_igw"
  }
}
resource "aws_route_table" "cluster_rt" {
  vpc_id = aws_vpc.cluster_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cluster_internet_gateway.id
  }
  tags = {
    Name = "cluster_rt"
  }
}
resource "aws_main_route_table_association" "cluster_rt_main" {
  vpc_id         = aws_vpc.cluster_vpc.id
  route_table_id = aws_route_table.cluster_rt.id
}
resource "aws_subnet" "cluster_subnet"{
  for_each = {us-east-1a=cidrsubnet("172.20.0.0/16",8,10),us-east-1b=cidrsubnet("172.20.0.0/16",8,20),us-east-1c=cidrsubnet("172.20.0.0/16",8,30)}
  vpc_id = aws_vpc.cluster_vpc.id
  availability_zone = each.key
  cidr_block = each.value
  map_public_ip_on_launch= true
  tags={
    Name="cluster_subnet_${each.key}"
  }
}