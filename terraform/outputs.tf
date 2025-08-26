output "web_server_ip" {
  value = aws_instance.web.public_ip
}

output "db_server_ip" {
  value = aws_instance.db.public_ip
}
