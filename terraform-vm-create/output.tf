# Output para o ID da VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

# Output para o ID da Sub-rede
output "subnet_id" {
  description = "The ID of the Subnet"
  value       = aws_subnet.my_subnet.id
}

# Output para o ID do Security Group
output "security_group_id" {
  description = "The ID of the Security Group"
  value       = aws_security_group.myhomelab_sg.id
}

# Output para o endereço público da instância EC2
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.my_instance.public_ip
}

# Output para o ID da instância EC2
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.my_instance.id
}

# Output para o ID da zona DNS
output "dns_zone_id" {
  description = "The ID of the DNS Zone"
  value       = aws_route53_zone.myhomelab_zone.zone_id
}

# Output para o nome da zona DNS
output "dns_zone_name" {
  description = "The name of the DNS Zone"
  value       = aws_route53_zone.myhomelab_zone.name
}

