output "aws_vpc_id" {
  value = aws_vpc.vpc.id
}

output "aws_vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}