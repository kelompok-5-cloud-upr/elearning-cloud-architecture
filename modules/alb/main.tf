# 1. Security Group untuk ALB (Boleh menerima internet port 80/443)
resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = var.vpc_id

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
}

# 2. Target Group (Pintu masuk ke app_server)
resource "aws_lb_target_group" "tg" {
  name     = "elearning-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check { path = "/" }
}

# 3. Mendaftarkan App Server ke Target Group
resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.app_server_id
  port             = 80
}

# 4. Application Load Balancer (ALB)
resource "aws_lb" "alb" {
  name               = "elearning-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnets
}

# 5. Listener (Aturan Routing port 80 ke Target Group)
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}