# E-Learning Cloud Platform - Universitas Palangka Raya

Repositori ini berisi perencanaan arsitektur, *Infrastructure as Code* (IaC), dan dokumentasi untuk pengembangan platform e-learning. Proyek ini merupakan Final Project Cloud Computing yang diimplementasikan menggunakan **Microsoft Azure**.

## 🏗 Arsitektur Sistem (High-Availability)
Sistem ini dirancang untuk memiliki keandalan tinggi dan toleransi kesalahan (*fault tolerance*) guna mengatasi lonjakan trafik saat ujian mahasiswa.

![Arsitektur Cloud E-Learning](docs/architecture.png)

Topologi dibangun di dalam **Azure Virtual Network (VNet)** dengan komponen utama:
* **Frontend/Backend Compute:** 2 Unit Azure Virtual Machines & Azure Application Gateway
* **Database Tier:** Azure Database for MySQL (Flexible Server)
* **Storage & CDN:** Azure Blob Storage (Geo-Redundant) & Azure CDN
* **Authentication & DNS:** Azure Active Directory B2C (Azure AD B2C) & Azure DNS

## 📂 Struktur Direktori
* `/app` - *Source code* aplikasi *e-learning* (Node.js/PHP).
* `/docs` - Dokumentasi arsitektur visual (`architecture.png`) dan laporan dokumen perencanaan teknis (`planning.md`).
* `/terraform` - Skrip Terraform (`main.tf`, `variables.tf`) dengan menggunakan *provider azurerm*.

## 👥 Tim Pengembang (Kelompok 2)
| Nama | NIM | Peran (Role) |
| :--- | :--- | :--- |
| **Erina Ekanova Safitri** | 2330105030017 | DevOps & Security |
| **Tyara Rahmidasari** | 2330105030021 | Cloud Architect |
| **Nur Haniatin Jannah** | 2330105030023 | Backend/App Dev |

**Dosen Pengampu:** Septian Geges, S.Kom., M.Kom.
