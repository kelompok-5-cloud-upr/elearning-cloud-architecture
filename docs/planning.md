# PERENCANAAN FINAL PROJECT CLOUD COMPUTING
## IMPLEMENTASI ARSITEKTUR CLOUD HIGH-AVAILABILITY UNTUK PLATFORM E-LEARNING

**Disusun Oleh Kelompok 5:**
* **Erina Ekanova Safitri** (2330105030017)
* **Tyara Rahmidasari** (2330105030021)
* **Nur Haniatin Jannah** (2330105030023)

**Dosen Pengampu:** Septian Geges, S.Kom., M.Kom.
**Jurusan Teknik Informatika, Fakultas Teknik, Universitas Palangka Raya 2026**

---

## BAB I PENDAHULUAN

### 1.1 Latar Belakang dan Tujuan Proyek
Seiring meningkatnya kebutuhan sistem manajemen pembelajaran digital, platform *e-learning* dituntut memiliki keandalan tinggi (*high availability*) dan kemampuan skala dinamis (*scalability*). *Server* akademik sering mengalami *downtime* pada periode krusial akibat lonjakan *traffic* yang tidak terprediksi. Proyek ini bertujuan merancang dan mengimplementasikan arsitektur *cloud* berbasis **Amazon Web Services (AWS)** untuk platform *e-learning*. Dengan memanfaatkan 2 buah *instance* komputasi dan distribusi beban kerja melalui *Application Load Balancer*, sistem dirancang untuk menangani fluktuasi akses mahasiswa secara efisien.

### 1.2 Spesifikasi dan Fungsionalitas Layanan Cloud
Proyek ini mengintegrasikan 7 layanan utama dari ekosistem AWS:

| Kategori | Layanan AWS | Fungsi Spesifik dalam Sistem E-Learning |
| :--- | :--- | :--- |
| **Networking** | Amazon Route 53 & CloudFront | Mengelola DNS sistem dan bertindak sebagai CDN untuk mempercepat waktu muat halaman portal. |
| **Traffic Management** | Application Load Balancer (ALB) | Mendistribusikan *traffic* HTTP/HTTPS secara merata ke dua *instance server* EC2. |
| **Compute** | **Amazon EC2** | **2 Unit Instance** (t2.micro) yang memproses logika *backend* secara paralel untuk mencegah *overload*. |
| **Database** | Amazon RDS (MySQL) | Manajemen basis data terkelola untuk menyimpan profil, mata kuliah, dan nilai. |
| **Storage** | **Amazon S3** | Menyimpan materi kuliah dengan konfigurasi **Cross-Region Replication** sebagai redundansi pencegah kehilangan data. |
| **Security** | Amazon Cognito | Infrastruktur manajemen identitas untuk registrasi dan autentikasi pengguna. |

---

## 1.3 Rencana Anggaran Biaya (RAB)
Proyek ini dirancang dengan menyeimbangkan pemanfaatan **AWS Free Tier** dan kebutuhan *High Availability*. Berikut estimasi operasional bulanan:

| Komponen Layanan | Spesifikasi Penggunaan | Estimasi Biaya/Bulan (IDR) |
| :--- | :--- | :--- |
| **Amazon EC2** | **2 Unit** t2.micro (Linux). 1 Unit masuk *Free Tier* (750 Jam), 1 Unit dikenakan tarif standar. | ± Rp 135.000 |
| **Application Load Balancer** | 1 ALB (Penggunaan 730 jam/bulan) | ± Rp 250.000 |
| **Amazon RDS** | db.t2.micro (MySQL) - *Free Tier* | Rp 0 |
| **Amazon S3** | 5 GB Standard dengan **Replikasi Redundansi** | ± Rp 15.000 |
| **Amazon Cognito** | Maksimal 50.000 MAU - *Free Tier* | Rp 0 |
| **Amazon Route 53** | 1 Hosted Zone untuk *domain* | ± Rp 8.000 |
| **TOTAL ESTIMASI** | | **± Rp 408.000** |

---

## 1.4 Perencanaan Manajemen Akses dan Keamanan (IAM)
Konfigurasi hak akses didefinisikan ketat sesuai prinsip *Least Privilege*:

| Entitas | Role / Policy Akses | Justifikasi Operasional |
| :--- | :--- | :--- |
| **EC2 Profile** | `AmazonS3ReadOnlyAccess` | Mengizinkan *server* EC2 membaca materi pelajaran langsung dari *bucket* S3. |
| **EC2 Profile** | `CloudWatchAgentServerPolicy` | Mengizinkan EC2 mengirimkan log dan metrik performa ke CloudWatch. |
| **Tim DevOps** | `AdministratorAccess` | Hak akses penuh untuk merancang dan audit seluruh sumber daya infrastruktur. |

---

## 1.5 Struktur Tim dan Pembagian Tugas
| Nama Anggota | Peran (Role) | Tanggung Jawab Utama |
| :--- | :--- | :--- |
| **Erina Ekanova Safitri** | DevOps & Security | Inisialisasi Git, skrip Terraform (AWS *provider*), Security Group, dan IAM. |
| **Tyara Rahmidasari** | Cloud Architect | Desain topologi AWS *High Availability*, RAB, dan integrasi layanan. |
| **Nur Haniatin Jannah** | Backend/App Dev | Logika aplikasi, skema *database*, dan dokumentasi API. |
