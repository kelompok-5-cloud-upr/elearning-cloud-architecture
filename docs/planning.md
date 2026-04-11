# [cite_start]PERENCANAAN FINAL PROJECT CLOUD COMPUTING [cite: 2]
## [cite_start]IMPLEMENTASI ARSITEKTUR CLOUD HIGH-AVAILABILITY UNTUK PLATFORM E-LEARNING [cite: 3]

[cite_start]**Disusun Oleh Kelompok 2:** [cite: 4]
* [cite_start]**Erina Ekanova Safitri** (2330105030017) [cite: 5]
* [cite_start]**Tyara Rahmidasari** (2330105030021) [cite: 5]
* [cite_start]**Nur Haniatin Jannah** (2330105030023) [cite: 5]

[cite_start]**Dosen Pengampu:** Septian Geges, S.Kom., M.Kom. [cite: 6, 7]
[cite_start]**Jurusan Teknik Informatika, Fakultas Teknik, Universitas Palangka Raya 2026** [cite: 8, 9, 10]

---

## [cite_start]BAB I PENDAHULUAN [cite: 11]

### [cite_start]Latar Belakang dan Tujuan Proyek [cite: 12]
[cite_start]Seiring meningkatnya kebutuhan sistem manajemen pembelajaran digital, platform *e-learning* dituntut memiliki keandalan tinggi (*high availability*) dan kemampuan skala dinamis (*scalability*)[cite: 13]. [cite_start]*Server* akademik sering mengalami *downtime* pada periode krusial akibat lonjakan *traffic* yang tidak terprediksi[cite: 14]. [cite_start]Proyek ini bertujuan merancang dan mengimplementasikan arsitektur *cloud* berbasis Amazon Web Services (AWS) untuk platform *e-learning*[cite: 15]. [cite_start]Dengan memanfaatkan *Auto Scaling* dan *Load Balancer*, sistem dirancang untuk menangani fluktuasi akses pengguna secara efisien tanpa mengorbankan biaya[cite: 16].

### [cite_start]Spesifikasi dan Fungsionalitas Layanan Cloud [cite: 17, 18]
[cite_start]Berikut adalah detail fungsionalitas dari 7 layanan utama AWS yang diintegrasikan[cite: 19]:

| Kategori | Layanan AWS | Fungsi Spesifik dalam Sistem E-Learning |
| :--- | :--- | :--- |
| Networking & DNS | Amazon Route 53 | [cite_start]Mengelola DNS untuk merutekan *traffic* ke antarmuka aplikasi. [cite: 20] |
| Content Delivery | Amazon CloudFront | [cite_start]Bertindak sebagai CDN untuk *caching* aset statis guna mempercepat waktu muat halaman. [cite: 20] |
| Traffic Management | ALB | [cite_start]Mendistribusikan *traffic* HTTP/HTTPS secara merata ke beberapa *instance server*. [cite: 20] |
| Compute | Amazon EC2 | [cite_start]Menyediakan kapasitas komputasi elastis (*virtual server*) untuk proses *backend*. [cite: 20] |
| Database | Amazon RDS | [cite_start]Manajemen basis data relasional untuk menyimpan data transaksional (profil, nilai). [cite: 20] |
| Storage | Amazon S3 | [cite_start]Layanan *object storage* untuk menyimpan dokumen materi (PDF/PPT) dan video kuliah. [cite: 20] |
| Security & Auth | Amazon Cognito | [cite_start]Infrastruktur manajemen identitas untuk registrasi dan autentikasi pengguna. [cite: 20] |

---

## [cite_start]Rencana Anggaran Biaya (RAB) [cite: 21]
[cite_start]Proyek ini memaksimalkan penggunaan batas **AWS Free Tier** selama fase pengembangan[cite: 22]. [cite_start]Perkiraan biaya operasional bulanan adalah sebagai berikut[cite: 23]:

| Komponen Layanan | Spesifikasi Penggunaan | Keterangan | Estimasi Biaya (IDR) |
| :--- | :--- | :--- | :--- |
| Amazon EC2 | t2.micro (Linux) | *Free Tier* (750 Jam/Bulan) | [cite_start]Rp 0 [cite: 24] |
| Amazon RDS | db.t2.micro (MySQL) | *Free Tier* (750 Jam/Bulan) | [cite_start]Rp 0 [cite: 24] |
| Amazon S3 | Standard Storage 5 GB | *Free Tier* (20k Get Requests) | [cite_start]Rp 0 [cite: 24] |
| Amazon Cognito | Maksimal 50.000 MAU | *Free Tier* | [cite_start]Rp 0 [cite: 24] |
| Route 53 | 1 Hosted Zone | Kebutuhan *domain* dasar | [cite_start]± Rp 8.000 [cite: 24] |
| ALB | 1 Application Load Balancer | Penggunaan 730 jam | [cite_start]± Rp 250.000 [cite: 24] |
| **TOTAL ESTIMASI** | | | [cite_start]**± Rp 258.000** [cite: 24] |

---

## [cite_start]Perencanaan Manajemen Akses dan Keamanan (IAM) [cite: 25]
[cite_start]Konfigurasi hak akses didefinisikan ketat sesuai prinsip *Least Privilege*[cite: 26]:

| Entitas | Role / Policy Akses | Justifikasi Operasional |
| :--- | :--- | :--- |
| EC2 Profile | AmazonS3ReadOnlyAccess | [cite_start]Mengizinkan EC2 membaca materi pelajaran langsung dari *bucket* S3. [cite: 27] |
| EC2 Profile | CloudWatchAgentServerPolicy | [cite_start]Mengizinkan EC2 mengirimkan log dan metrik performa ke CloudWatch. [cite: 27] |
| Tim DevOps | AdministratorAccess | [cite_start]Hak akses penuh untuk merancang dan audit seluruh sumber daya infrastruktur. [cite: 27] |

---

## [cite_start]Struktur Tim dan Pembagian Tugas [cite: 28, 29]

| Nama Anggota | Peran (Role) | Tanggung Jawab Utama |
| :--- | :--- | :--- |
| Erina Ekanova Safitri | DevOps & Security | [cite_start]Inisialisasi Git, skrip Terraform, Security Group, dan kebijakan IAM. [cite: 30] |
| Tyara Rahmidasari | Cloud Architect | [cite_start]Desain topologi AWS, estimasi biaya, dan integrasi antar layanan. [cite: 30] |
| Nur Haniatin Jannah | Backend/App Dev | [cite_start]Logika *source code* aplikasi, skema *database*, dan dokumentasi API. [cite: 30] |
