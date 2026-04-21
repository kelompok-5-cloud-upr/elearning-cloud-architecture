# PERENCANAAN FINAL PROJECT CLOUD COMPUTING
## IMPLEMENTASI ARSITEKTUR CLOUD HIGH-AVAILABILITY UNTUK PLATFORM E-LEARNING

**Disusun Oleh Kelompok 2:**
* **Erina Ekanova Safitri** (2330105030017)
* **Tyara Rahmidasari** (2330105030021)
* **Nur Haniatin Jannah** (2330105030023)

**Dosen Pengampu:** Septian Geges, S.Kom., M.Kom.
**Jurusan Teknik Informatika, Fakultas Teknik, Universitas Palangka Raya 2026**

---

## BAB I PENDAHULUAN

### 1.1 Latar Belakang dan Tujuan Proyek
Seiring dengan meningkatnya kebutuhan akan sistem manajemen pembelajaran digital, sebuah platform *e-learning* dituntut untuk memiliki keandalan tinggi (*high availability*) dan kemampuan skala dinamis (*scalability*). Seringkali, *server* akademik mengalami *downtime* pada saat periode krusial seperti ujian semester atau pengumpulan tugas akhir akibat lonjakan *traffic* yang tidak terprediksi.

Oleh karena itu, proyek ini bertujuan untuk merancang dan mengimplementasikan arsitektur *cloud* berbasis **Microsoft Azure** untuk platform *e-learning*. Dengan memanfaatkan fitur **Virtual Machine Scale Sets** dan distribusi beban kerja melalui **Azure Application Gateway**, sistem ini dirancang untuk dapat menangani fluktuasi akses pengguna secara efisien dan tetap stabil tanpa mengorbankan efisiensi biaya. Selain itu, aspek keamanan data menjadi prioritas utama dengan penerapan redundansi penyimpanan guna menjamin ketersediaan materi instruksional setiap saat.

### 1.2 Spesifikasi dan Fungsionalitas Layanan Cloud
Proyek ini mengintegrasikan layanan-layanan utama dari Microsoft Azure untuk membangun infrastruktur yang kokoh:

| Kategori | Layanan Azure | Fungsi Spesifik |
| :--- | :--- | :--- |
| **Networking** | Azure DNS & CDN | Mengelola domain sistem dan mempercepat distribusi materi kuliah (video/gambar) ke mahasiswa. |
| **Traffic Management**| Azure App Gateway | Sebagai *Load Balancer* Layer 7 untuk mendistribusikan trafik secara merata ke dua unit server (VM). |
| **Compute** | **Azure Virtual Machines**| **2 Unit Instance** (B1s) yang menjalankan logika aplikasi secara paralel demi menjaga stabilitas sistem (*High Availability*). |
| **Database** | Azure DB for MySQL | Menyimpan data profil mahasiswa, dosen, dan rekam jejak nilai dalam basis data terkelola. |
| **Storage** | **Azure Blob Storage** | Menyimpan file materi kuliah dengan konfigurasi **Geo-Redundant (GRS)** untuk keamanan data maksimal terhadap bencana. |
| **Security** | Azure AD B2C | Mengelola sistem login dan registrasi mahasiswa secara terpusat dan aman. |

---

## 1.3 Rencana Anggaran Biaya (RAB)
Estimasi biaya dirancang dengan mengoptimalkan program **Azure for Students**. Berikut adalah rincian biaya operasional bulanan:

| Komponen Layanan | Detail Penggunaan | Estimasi Biaya/Bulan (IDR) |
| :--- | :--- | :--- |
| **Azure Virtual Machines** | 2 Unit B1s (Unit ke-2 memotong kredit gratis) | ± Rp 125.000 |
| **Azure App Gateway** | Standar V2 (Traffic Management redundant) | ± Rp 280.000 |
| **Azure Database for MySQL** | Flexible Server B1ms (Free Tier Eligible) | Rp 0 |
| **Azure Blob Storage** | 5 GB dengan fitur **GRS (Redundant)** | ± Rp 15.000 |
| **Azure DNS & AD B2C** | 1 Hosted Zone & Maksimal 50.000 MAU | ± Rp 8.500 |
| **TOTAL ESTIMASI** | **Memotong Saldo Kredit Azure Mahasiswa $100** | **± Rp 428.500** |

---

## 1.4 Perencanaan Manajemen Akses dan Keamanan (RBAC)
Pada lingkungan Microsoft Azure, sistem keamanan dirancang menerapkan prinsip *Least Privilege* menggunakan *Role-Based Access Control*:

| Entitas (Identitas) | Role / Peran Akses Azure | Justifikasi Operasional |
| :--- | :--- | :--- |
| **VM Managed Identity** | **Storage Blob Data Reader** | Mengizinkan kedua *Virtual Machine* untuk membaca materi pelajaran (video/dokumen) secara langsung dan aman dari *Container* Blob Storage. |
| **VM Managed Identity** | **Monitoring Metrics Publisher** | Memberikan otorisasi kepada *Virtual Machine* untuk secara otomatis mengirimkan log performa dan status kesehatan *server* ke layanan Azure Monitor. |
| **Tim DevOps** | **Contributor** | Memberikan hak akses penuh bagi *engineer* untuk membangun, mengelola, dan mengaudit seluruh sumber daya infrastruktur (VM, Database, Storage) tanpa memiliki hak untuk mengubah kepemilikan tagihan/langganan. |

---

## 1.5 Struktur Tim dan Pembagian Tugas
Seluruh koordinasi *source code* dan dokumentasi infrastruktur dikelola terpusat melalui *repository* GitHub dengan mengaktifkan fitur *Branch Protection*.

| Nama Anggota | Peran (Role) | Tanggung Jawab Utama |
| :--- | :--- | :--- |
| **Erina Ekanova Safitri** <br> *(2330105030017)* | **DevOps & Security** | Melakukan inisialisasi manajemen versi menggunakan Git, menyusun skrip infrastruktur IaC untuk Azure (menggunakan *provider azurerm* Terraform), dan mengonfigurasi kebijakan keamanan RBAC. |
| **Tyara Rahmidasari** <br> *(2330105030021)* | **Cloud Architect** | Merancang desain topologi *High-Availability* di dalam Azure Virtual Network, merumuskan estimasi Rencana Anggaran Biaya (RAB), dan memastikan integrasi layanan berjalan lancar. |
| **Nur Haniatin Jannah** <br> *(2330105030023)* | **Backend/App Dev** | Mengembangkan logika utama *source code* aplikasi *e-learning*, mendesain skema tabel untuk Azure Database for MySQL, dan menyusun dokumentasi integrasi API. |
