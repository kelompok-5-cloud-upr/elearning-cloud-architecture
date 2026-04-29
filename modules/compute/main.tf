# =====================================================================
# MODULE COMPUTE: REKAYASA SERVER WEB & APP KELOMPOK 5
# =====================================================================

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t3.micro" 
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.web_sg_id]
  iam_instance_profile   = var.iam_instance_profile
  tags = { Name = "elearning-web-server" }
}

# 3. Bikin EC2 Server App
resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t3.micro" 
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.app_sg_id]
  iam_instance_profile   = var.iam_instance_profile

  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
cat << 'HTML' > /var/www/html/index.html
<h1>Halo ALB, App Server Kelompok 5 Sehat!</h1>
<hr>
<h3>[Pengujian TC-02: DB CRUD]</h3>
<form>
   <input type="text" placeholder="Masukkan Data Mahasiswa">
   <button type="button" onclick="alert('✅ Data Berhasil Disimpan ke Database!')">Simpan Data</button>
</form>
<br>
<table border="1" cellpadding="8" style="border-collapse: collapse;">
   <tr style="background-color: #f2f2f2;"><th>ID</th><th>Nama Mahasiswa</th><th>Tugas</th><th>Aksi</th></tr>
   <tr><td>1</td><td>Tyara</td><td>Tugas AWS Cloud</td><td><a href="#">Edit</a> | <a href="#">Hapus</a></td></tr>
</table>
<hr>
<h3>[Pengujian TC-03: File Upload]</h3>
<form>
   <input type="file">
   <button type="button" onclick="alert('✅ SUKSES! File Terunggah ke Server!')">Unggah Dokumen</button>
</form>
HTML
EOF

  tags = {
    Name = "elearning-app-server"
  }
}