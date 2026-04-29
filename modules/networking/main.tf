# Kotak 2: VPC dengan CIDR 10.0.0.0/16
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "elearning-vpc"
    Project = "Final Project CC"
  }
}

# Kotak 3: Subnet publik (10.0.1.0/24)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true 
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "elearning-public-subnet"
  }
}

# Kotak 4: Subnet privat (10.0.2.0/24)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "elearning-private-subnet"
  }
}

# --- TAMBAHAN UNTUK HARI 3 KOTAK 1 ---

# Membuat Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = { Name = "elearning-igw" }
}

# Membuat Route Table (Buku Petunjuk Arah ke Internet)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Menyambungkan Route Table ke Subnet Publik
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-southeast-1c"
  tags              = { Name = "elearning-private-subnet-2" }
}

# --- TAMBAHAN UNTUK ALB KOTAK 3 ---

# Membuat Subnet Publik Kedua (Syarat mutlak untuk Load Balancer)
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.4.0/24" # Pakai IP yang belum terpakai
  map_public_ip_on_launch = true 
  availability_zone       = "ap-southeast-1b" # Ditaruh di zona yang berbeda

  tags = {
    Name = "elearning-public-subnet-2"
  }
}

# Menyambungkan Subnet Publik Kedua ke Internet Gateway
resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}