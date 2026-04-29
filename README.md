# E-Learning Cloud Platform - Universitas Palangka Raya

Repositori ini berisi perencanaan arsitektur, *Infrastructure as Code* (IaC), dan dokumentasi untuk pengembangan platform e-learning. Proyek ini merupakan Final Project Cloud Computing yang diimplementasikan menggunakan **Amazon Web Services (AWS)**.

## 🏗 Arsitektur Sistem (High-Availability)
Sistem ini dirancang untuk memiliki keandalan tinggi dan toleransi kesalahan (*fault tolerance*) guna mengatasi lonjakan trafik saat ujian mahasiswa.

![Arsitektur Cloud E-Learning](docs/architecture.png)

Topologi dibangun di dalam **AWS Virtual Private Cloud (VPC)** dengan komponen utama:
* **Frontend/Backend Compute:** 2 Unit Amazon EC2 & Application Load Balancer (ALB)
* **Database Tier:** Amazon RDS untuk MySQL
* **Storage & CDN:** Amazon S3 (Cross-Region Replication) & Amazon CloudFront
* **Authentication & DNS:** Amazon Cognito & Amazon Route 53

## 📂 Struktur Direktori
* `/app` - *Source code* aplikasi *e-learning* (Node.js/PHP).
* `/docs` - Dokumentasi arsitektur visual (`architecture.png`) dan laporan dokumen perencanaan teknis (`planning.md`).
* `/terraform` - Skrip Terraform (`main.tf`, `variables.tf`) dengan menggunakan *provider aws*.

## 👥 Tim Pengembang (Kelompok 5)
| Nama | NIM | Peran (Role) |
| :--- | :--- | :--- |
| **Erina Ekanova Safitri** | 2330105030017 | DevOps & Security Engineer |
| **Tyara Rahmidasari** | 2330105030021 | Cloud Architect |
| **Nur Haniatin Jannah** | 2330105030023 | Backend/App Developer |

**Dosen Pengampu:** Septian Geges, S.Kom., M.Kom.
