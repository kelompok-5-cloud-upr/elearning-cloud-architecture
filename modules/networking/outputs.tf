output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

# Output satu subnet (untuk EC2 biasa)
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

# Output DUA subnet publik (Khusus untuk Load Balancer)
output "public_subnet_ids" {
  value = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_2.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.private_subnet.id, aws_subnet.private_subnet_2.id]
}