output "web_sg_id" {
  value = aws_security_group.sg_web.id
}

output "app_sg_id" {
  value = aws_security_group.sg_app.id
}

output "db_sg_id" { 
  value = aws_security_group.sg_db.id 
}