
# PERENCANAAN FINAL PROJECT CLOUD COMPUTING

## IMPLEMENTASI ARSITEKTUR CLOUD HIGH-AVAILABILITY UNTUK PLATFORM E-LEARNING

**Disusun Oleh Kelompok 5:**
**Erina Ekanova Safitri** (2330105030017)
**Tyara Rahmidasari** (2330105030021)
**Nur Haniatin Jannah** (2330105030023)

**Dosen Pengampu:** Septian Geges, S.Kom., M.Kom.
**Jurusan Teknik Informatika, Fakultas Teknik, Universitas Palangka Raya 2026**

---

## BAB I PENDAHULUAN

### Latar Belakang dan Tujuan Proyek

Seiring meningkatnya kebutuhan sistem manajemen pembelajaran digital, platform *e-learning* dituntut memiliki keandalan tinggi (*high availability*) dan kemampuan skala dinamis (*scalability*). *Server* akademik sering mengalami *downtime* pada periode krusial akibat lonjakan *traffic* yang tidak terprediksi. Proyek ini bertujuan merancang dan mengimplementasikan arsitektur *cloud* berbasis Amazon Web Services (AWS) untuk platform *e-learning*. Dengan memanfaatkan *Auto Scaling* dan *Load Balancer*, sistem dirancang untuk menangani fluktuasi akses pengguna secara efisien tanpa mengorbankan biaya.

### Spesifikasi dan Fungsionalitas Layanan Cloud

Berikut adalah detail fungsionalitas dari 7 layanan utama AWS yang diintegrasikan:

| Kategori           | Layanan AWS       | Fungsi Spesifik dalam Sistem E-Learning                                                |
| :----------------- | :---------------- | :------------------------------------------------------------------------------------- |
| Networking & DNS   | Amazon Route 53   | Mengelola DNS untuk merutekan *traffic* ke antarmuka aplikasi.                         |
| Content Delivery   | Amazon CloudFront | Bertindak sebagai CDN untuk *caching* aset statis guna mempercepat waktu muat halaman. |
| Traffic Management | ALB               | Mendistribusikan *traffic* HTTP/HTTPS secara merata ke beberapa *instance server*.     |
| Compute            | Amazon EC2        | Menyediakan kapasitas komputasi elastis (*virtual server*) untuk proses *backend*.     |
| Database           | Amazon RDS        | Manajemen basis data relasional untuk menyimpan data transaksional (profil, nilai).    |
| Storage            | Amazon S3         | Layanan *object storage* untuk menyimpan dokumen materi (PDF/PPT) dan video kuliah.    |
| Security & Auth    | Amazon Cognito    | Infrastruktur manajemen identitas untuk registrasi dan autentikasi pengguna.           |

---

## Rencana Anggaran Biaya (RAB)

Proyek ini memaksimalkan penggunaan batas **AWS Free Tier** selama fase pengembangan. Perkiraan biaya operasional bulanan adalah sebagai berikut:

| Komponen Layanan   | Spesifikasi Penggunaan      | Keterangan                     | Estimasi Biaya (IDR) |
| :----------------- | :-------------------------- | :----------------------------- | :------------------- |
| Amazon EC2         | t2.micro (Linux)            | *Free Tier* (750 Jam/Bulan)    | Rp 0                 |
| Amazon RDS         | db.t2.micro (MySQL)         | *Free Tier* (750 Jam/Bulan)    | Rp 0                 |
| Amazon S3          | Standard Storage 5 GB       | *Free Tier* (20k Get Requests) | Rp 0                 |
| Amazon Cognito     | Maksimal 50.000 MAU         | *Free Tier*                    | Rp 0                 |
| Route 53           | 1 Hosted Zone               | Kebutuhan *domain* dasar       | ± Rp 8.000           |
| ALB                | 1 Application Load Balancer | Penggunaan 730 jam             | ± Rp 250.000         |
| **TOTAL ESTIMASI** |                             |                                | **± Rp 258.000**     |

---

## Perencanaan Manajemen Akses dan Keamanan (IAM)

Konfigurasi hak akses didefinisikan ketat sesuai prinsip *Least Privilege*:

| Entitas     | Role / Policy Akses         | Justifikasi Operasional                                                      |
| :---------- | :-------------------------- | :--------------------------------------------------------------------------- |
| EC2 Profile | AmazonS3ReadOnlyAccess      | Mengizinkan EC2 membaca materi pelajaran langsung dari *bucket* S3.          |
| EC2 Profile | CloudWatchAgentServerPolicy | Mengizinkan EC2 mengirimkan log dan metrik performa ke CloudWatch.           |
| Tim DevOps  | AdministratorAccess         | Hak akses penuh untuk merancang dan audit seluruh sumber daya infrastruktur. |

---

## Struktur Tim dan Pembagian Tugas

| Nama Anggota          | Peran (Role)      | Tanggung Jawab Utama                                                  |
| :-------------------- | :---------------- | :-------------------------------------------------------------------- |
| Erina Ekanova Safitri | DevOps & Security | Inisialisasi Git, skrip Terraform, Security Group, dan kebijakan IAM. |
| Tyara Rahmidasari     | Cloud Architect   | Desain topologi AWS, estimasi biaya, dan integrasi antar layanan.     |
| Nur Haniatin Jannah   | Backend/App Dev   | Logika *source code* aplikasi, skema *database*, dan dokumentasi API. |
