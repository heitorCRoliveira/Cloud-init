output "public_ip" {
  description = "Endereço IP público da instância para acesso ao Nginx"
  value       = aws_instance.web_server.public_ip
}

