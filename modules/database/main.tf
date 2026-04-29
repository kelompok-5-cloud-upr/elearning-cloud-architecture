# Kelompokkan subnet privat untuk lokasi database (Syarat wajib AWS: minimal 2 subnet di zona berbeda)
resource "aws_db_subnet_group" "db_group" {
  name       = "elearning-db-group"
  subnet_ids = var.private_subnet_ids

  tags = { Name = "DB Subnet Group" }
}

# Membuat RDS MySQL
resource "aws_db_instance" "mysql_db" {
  allocated_storage       = 20
  db_name                 = "elearning_db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin_upr"
  password                = "PasswordKelompok5"
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.db_group.name
  vpc_security_group_ids  = [var.db_sg_id]
  
  # Pastikan dua baris ini ada:
  backup_retention_period = 1
  apply_immediately       = true  # INI KUNCI AGAR LANGSUNG AKTIF DETIK INI JUGA
  
  tags = { Name = "elearning-mysql-db" }
}