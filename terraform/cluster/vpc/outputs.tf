output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.public.cidr_block
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "private_subnet_cidr_block" {
  value = aws_subnet.private.cidr_block
}