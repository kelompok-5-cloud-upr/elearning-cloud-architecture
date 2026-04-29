variable "private_subnet_ids" {
  description = "Daftar ID subnet privat untuk RDS"
  type        = list(string)
}

variable "db_sg_id" {
  description = "ID Security Group untuk Database"
  type        = string
}