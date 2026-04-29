# 1. SG Web (Load Balancer)
resource "aws_security_group" "sg_web" {
  name        = "web-sg"
  description = "HTTP dari internet"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "elearning-web-sg" }
}

# 2. SG App (EC2 Server)
resource "aws_security_group" "sg_app" {
  name        = "app-sg"
  description = "Traffic dari Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "elearning-app-sg" }
}

# 3. SG DB (RDS MySQL)
resource "aws_security_group" "sg_db" {
  name        = "db-sg"
  description = "Traffic MySQL dari App Server"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    # TRIK NINJA: Kita izinkan juga dari Web Server sementara
    security_groups = [
      aws_security_group.sg_app.id,
      aws_security_group.sg_web.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "elearning-db-sg" }
}