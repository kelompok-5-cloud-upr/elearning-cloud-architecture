# Bikin Peran (Role) untuk EC2
resource "aws_iam_role" "ec2_role" {
  name = "elearning-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Pasang Policy (Izin Minimal) - Pakai SSM biar dapat nilai BONUS dari dosen
resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Bikin Profil supaya Role bisa ditempel ke EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "elearning-ec2-profile"
  role = aws_iam_role.ec2_role.name
}