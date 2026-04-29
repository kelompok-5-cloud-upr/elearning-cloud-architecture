terraform {
  required_providers {
    aws = { 
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
  }
  
  # Kotak 3: Remote State S3
  backend "s3" {
    bucket = "upr-elearning-tfstate-kel5"
    key    = "state/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" { 
  region = var.aws_region 
}

module "networking" { 
  source = "./modules/networking" 
}

module "security" { 
  source = "./modules/security"
  vpc_id = module.networking.vpc_id 
}

module "iam" { 
  source = "./modules/iam" 
}

module "compute" {
  source               = "./modules/compute"
  public_subnet_id     = module.networking.public_subnet_id
  private_subnet_id    = module.networking.private_subnet_ids[0]
  web_sg_id            = module.security.web_sg_id
  app_sg_id            = module.security.app_sg_id
  iam_instance_profile = module.iam.instance_profile_name
}

# Memanggil Module Storage (S3)
module "storage" {
  source = "./modules/storage"
}

module "database" {
  source             = "./modules/database"
  private_subnet_ids = module.networking.private_subnet_ids
  db_sg_id           = module.security.db_sg_id
}

module "alb" {
  source         = "./modules/alb"
  vpc_id         = module.networking.vpc_id
  
  # Sekarang kodingan ini pasti berhasil karena output-nya sudah kita buat!
  public_subnets = module.networking.public_subnet_ids 
  
  app_server_id  = module.compute.app_server_id 
}