output "EC2_PUBLIC_IP" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app.public_ip
}

output "SSH_COMMAND" {
  description = "SSH command (replace /path/to/key.pem with your local PEM path)"
  value       = "ssh -i /path/to/key.pem ubuntu@${aws_instance.app.public_ip}"
}
