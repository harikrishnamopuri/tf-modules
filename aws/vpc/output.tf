output "aws_vpc_id" {
  value       = aws_vpc.main.id
  description = "The private IP address of the main server instance."
}
