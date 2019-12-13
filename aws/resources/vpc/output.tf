output "aws_vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The private IP address of the main server instance."
}
output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}
output "private_route_tables" {
  value = aws_route_table.private.*.id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}

output "public_route_table" {
  value = aws_route_table.public.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "nat_eips" {
  value = aws_eip.nat_eips.*.public_ip
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "aws_nat_gateway" {
  value = aws_nat_gateway.nats.*.id
}

