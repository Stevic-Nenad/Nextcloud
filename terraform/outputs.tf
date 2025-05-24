output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets."
  value       = aws_subnet.private[*].id
}

output "availability_zones_used" {
  description = "List of Availability Zones where subnets were created."
  value       = var.availability_zones
}

output "nat_gateway_public_ips" {
  description = "List of Public IP addresses of the NAT Gateways (one per AZ)."
  value       = aws_eip.nat_eip_per_az[*].public_ip
}

output "nat_gateway_ids" {
  description = "List of IDs of the NAT Gateways (one per AZ)."
  value       = aws_nat_gateway.nat_gw_per_az[*].id
}