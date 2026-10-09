-- MySQL dump 10.13  Distrib 8.4.11, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: akreditasiinf
-- ------------------------------------------------------
-- Server version	8.4.11-0ubuntu0.26.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `data_induk_dokumen`
--

DROP TABLE IF EXISTS `data_induk_dokumen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_induk_dokumen` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ukuran` bigint unsigned DEFAULT NULL,
  `link` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diunggah_oleh` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `data_induk_dokumen_diunggah_oleh_foreign` (`diunggah_oleh`),
  KEY `data_induk_dokumen_kategori_created_at_index` (`kategori`,`created_at`),
  CONSTRAINT `data_induk_dokumen_diunggah_oleh_foreign` FOREIGN KEY (`diunggah_oleh`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_induk_dokumen`
--

LOCK TABLES `data_induk_dokumen` WRITE;
/*!40000 ALTER TABLE `data_induk_dokumen` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_induk_dokumen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dokumen`
--

DROP TABLE IF EXISTS `dokumen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dokumen` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `isi_kriteria_id` bigint unsigned NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dokumen_isi_kriteria_id_foreign` (`isi_kriteria_id`),
  CONSTRAINT `dokumen_isi_kriteria_id_foreign` FOREIGN KEY (`isi_kriteria_id`) REFERENCES `isi_kriteria` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dokumen`
--

LOCK TABLES `dokumen` WRITE;
/*!40000 ALTER TABLE `dokumen` DISABLE KEYS */;
INSERT INTO `dokumen` VALUES (88,15,'1. Kepmen no 42 a o 2025 - Ijin Univ Tiga Serangkai.pdf',NULL,'https://drive.google.com/file/d/1xrWCRLapcfARkbXsORHe9s8g-XMqNhrQ/view?usp=sharing','2026-10-07 14:43:45','2026-10-07 14:53:21'),(89,15,'2. Dokumen SPMI Universitas Tiga Serangkai-UTS',NULL,'https://drive.google.com/drive/folders/128UIhBBZbJpZjbkPXpDPUtHE8HklUNlW?usp=drive_link','2026-10-07 14:44:23','2026-10-07 14:44:23'),(90,15,'3. Peraturan Rektor Universitas Tiga Serangkai',NULL,'https://drive.google.com/drive/folders/1twNSzEMQSXRgFKhI0Jo6lSfiAT21U6K4?usp=drive_link','2026-10-07 14:45:07','2026-10-07 14:45:07'),(91,15,'4. Dokumen SPMI STMIK Sinar Nusantara',NULL,'https://drive.google.com/drive/folders/1XzaESbT0fgMVTjk1EcSkyk8HMRrZc7EP?usp=drive_link','2026-10-07 14:52:32','2026-10-07 14:52:32'),(92,15,'5. SK Perubahan Nama Prodi pada STMIK Sinar Nusantara.pdf',NULL,'https://drive.google.com/file/d/1ELoIINZ1CWcaAso5OwTDEVB4IpYlsR_H/view?usp=drive_link','2026-10-07 14:53:01','2026-10-07 14:53:01'),(93,85,'1. Dokumen Pelaksanaan SPMI',NULL,'https://drive.google.com/drive/folders/1iP2FMAIcYwHExvZocUmxJC-S0hylbLse?usp=drive_link','2026-10-07 14:57:53','2026-10-07 14:57:53'),(94,85,'2. Dokumen Kurikulum',NULL,'https://drive.google.com/drive/folders/1_-fNpeeiw2IbIgPVtXOT6cFPUhGWvJF9?usp=drive_link','2026-10-07 14:58:35','2026-10-07 14:58:35'),(95,85,'3. Jadwal Perkuliahan',NULL,'https://drive.google.com/drive/folders/1XMpgb1HOkl7ti3MMbHd-jAB8Vw9eZayv?usp=drive_link','2026-10-07 14:58:58','2026-10-07 14:58:58'),(96,85,'4. LBKD Dosen DTPR',NULL,'https://drive.google.com/drive/folders/1XdGYjkQWTZ5yM_2UR3MLOTBA28MsVmFe?usp=drive_link','2026-10-07 15:00:23','2026-10-07 15:00:23'),(97,85,'5. Pembimbing Akademik/Pembimbing Wali',NULL,'https://drive.google.com/drive/folders/1lG-k5H-ysAv2ZTM72CSdXN5pkQTFYSWy?usp=drive_link','2026-10-07 15:00:46','2026-10-07 15:00:46'),(98,85,'6. Rencana Pembelajaran Semester (RPS)',NULL,'https://drive.google.com/drive/folders/1lAy4MR3P6l3QVQJEDVAPfoJsMhN4ok9o?usp=drive_link','2026-10-07 15:01:04','2026-10-07 15:01:04'),(99,85,'7. SK Pengampu Matakuliah',NULL,'https://drive.google.com/drive/folders/1sWfTaK7KEt95TnSQwwgBSqAhm7nOH2GV?usp=drive_link','2026-10-07 15:01:27','2026-10-07 15:01:27'),(100,85,'8. Sertifikat Pendidik (Serdos)',NULL,'https://drive.google.com/drive/folders/18QfEAr1Pkuvy3WZc7TYWC502avWWGhF2?usp=drive_link','2026-10-07 15:01:46','2026-10-07 15:01:46'),(101,85,'9. Sertifikat Kompetensi, Pekerti/AA',NULL,'https://drive.google.com/drive/folders/1k80G5rzuVhGlZdweuf-MwrwStLZgPmpB?usp=drive_link','2026-10-07 15:02:05','2026-10-07 15:02:05'),(102,85,'10. Tracer Studi',NULL,'https://drive.google.com/drive/folders/1LtAeCwKBfcvGtE_LykJah_uvjkzmQZF_?usp=drive_link','2026-10-07 15:02:22','2026-10-07 15:02:22'),(103,85,'11. Tugas Akhir Mahasiswa',NULL,'https://drive.google.com/drive/folders/1BDdufI1gCKFKH8KxBDnqPeL2fGqbxuGZ?usp=drive_link','2026-10-07 15:02:59','2026-10-07 15:02:59'),(104,85,'12. SOP',NULL,'https://drive.google.com/drive/folders/1yW2fFFc_HU71V9PzHREv5TNESmH73tBo?usp=drive_link','2026-10-07 15:03:26','2026-10-07 15:03:26'),(105,85,'13. Penerimaan Mahasiswa Baru (PMB)',NULL,'https://drive.google.com/drive/folders/1pHsEJ1lN1Rjk6y2Rhgm4_IaT9Y--Wc78?usp=drive_link','2026-10-07 15:03:45','2026-10-07 15:03:45'),(106,86,'1. Tim Auditor AMI',NULL,'https://drive.google.com/drive/folders/15L_JCMfYgVjUmPMb4f4_YSBazKRC4Wcb?usp=drive_link','2026-10-07 15:04:39','2026-10-07 15:04:39'),(107,86,'2. Dokumen Audit Mutu Internal (AMI)',NULL,'https://drive.google.com/drive/folders/1YWmv9JSu8cCGFYYH00Cul6aHOwAkDOJB?usp=drive_link','2026-10-07 15:04:58','2026-10-07 15:04:58'),(108,86,'3. Dokumen Evaluasi',NULL,'https://drive.google.com/drive/folders/1UP-ogGtGm44A6vRSg_9fLUZoz-wVYIt5?usp=drive_link','2026-10-07 15:05:15','2026-10-07 15:05:15'),(109,87,'BERITA ACARA RTL 2025 - PENGENDALIAN.pdf',NULL,'https://drive.google.com/file/d/1hmbyVUuBDFtotZfT0n6lrvGUdOAk4RcF/view?usp=drive_link','2026-10-07 15:07:43','2026-10-07 15:07:43'),(110,87,'Laporan RTL 2022.pdf',NULL,'https://drive.google.com/file/d/1nrbxcp_VvKc8fBwb8-n8ntn5JMnRaOX9/view?usp=drive_link','2026-10-07 15:08:06','2026-10-07 15:08:06'),(111,87,'Laporan RTL 2023.pdf',NULL,'https://drive.google.com/file/d/17m16TPwb1WPdpzDu_C4B99N5Lm1a5TsM/view?usp=drive_link','2026-10-07 15:08:27','2026-10-07 15:08:27'),(112,87,'Laporan RTL 2024.pdf',NULL,'https://drive.google.com/file/d/1TWo8ElsOAJBBphRFtzC1Q_-P4Snklu_e/view?usp=drive_link','2026-10-07 15:08:48','2026-10-07 15:08:48'),(113,87,'Laporan RTM 2021.pdf',NULL,'https://drive.google.com/file/d/1oqxnwHnBQxRdFqRzprQvPGtSATXWbl-_/view?usp=drive_link','2026-10-07 15:09:06','2026-10-07 15:09:06'),(114,87,'Laporan RTM 2022.pdf',NULL,'https://drive.google.com/file/d/1L8TMF8xHSZfLwhL3BEIdRMB8pa9o16ei/view?usp=drive_link','2026-10-07 15:09:28','2026-10-07 15:09:28'),(115,87,'Laporan RTM 2023.pdf',NULL,'https://drive.google.com/file/d/1PF73vKTWCYmSxqbs2r8r7r0eK0UHYdDC/view?usp=drive_link','2026-10-07 15:11:11','2026-10-07 15:11:11'),(116,87,'Laporan RTM 2024.pdf',NULL,'https://drive.google.com/file/d/1NgJxAfv52mlW992ZxYtJIKwlfMyvoqL9/view?usp=drive_link','2026-10-07 15:13:01','2026-10-07 15:13:01'),(117,87,'Laporan RTM 2025.pdf',NULL,'https://drive.google.com/file/d/1ARRQahIqB_6Ey5-7fgcortBaZYuX4pFR/view?usp=drive_link','2026-10-07 15:13:24','2026-10-07 15:13:24'),(118,88,'1. Peningkatan standar dalam SPMI',NULL,'https://drive.google.com/drive/folders/1SmH0CT5wwUA2W0KM8NEnBpLroctRrghH?usp=drive_link','2026-10-07 15:15:05','2026-10-07 15:15:05'),(119,88,'2. Rapat Tinjauan Manajemen (RTM)',NULL,'https://drive.google.com/drive/folders/1r0rE30CEWlBVuliLuVUZ2zH7wlCS4bjs?usp=drive_link','2026-10-07 15:15:37','2026-10-07 15:15:37'),(120,88,'3. Rencana Tindak Lanjut (RTL)',NULL,'https://drive.google.com/drive/folders/1d7a3A7Xvf3cRjDMyGIIX0BOReLB6RhJT?usp=drive_link','2026-10-07 15:15:54','2026-10-07 15:15:54'),(121,88,'4. Dokumen Peninjauan Kurikulum Informatika 2025.pdf',NULL,'https://drive.google.com/file/d/1C5oZNlyTIZSk0dyChlT6mzNuCVGJE9O0/view?usp=drive_link','2026-10-07 15:16:20','2026-10-07 15:16:20'),(122,88,'5. Laporan IHT Artificial Intelligence.pdf',NULL,'https://drive.google.com/file/d/1tNHw8ORHpjBEWo5dPxns5W6C4giB7I2b/view?usp=drive_link','2026-10-07 15:16:40','2026-10-07 15:16:40'),(123,88,'6. Laporan Pelaksanaan PEKERTI Dosen TSU.pdf',NULL,'https://drive.google.com/file/d/1b6s4tJLNNDu4LxOXUxraSbEHugx9fiMj/view?usp=drive_link','2026-10-07 15:16:59','2026-10-07 15:16:59'),(124,88,'7. Dokumen Studi Lanjut S3',NULL,'https://drive.google.com/drive/folders/1mgJ5hUCeMl1IdLai7BHKrGcXgV51FSpH?usp=drive_link','2026-10-07 15:17:18','2026-10-07 15:17:18'),(125,88,'8. Sertifikasi Kompetensi',NULL,'https://drive.google.com/drive/folders/1k9zRR4ka4bWGC0W69KLmjXaPbKuUKT11?usp=drive_link','2026-10-07 15:17:35','2026-10-07 15:17:35'),(126,88,'9. Kontrak Mengajar/Perjanjian Kerja Dosen Internasional, Dosen Praktisi',NULL,'https://drive.google.com/drive/folders/1FHTbcDCuqcmddCLsmHRS65oG4zYExUm1?usp=drive_link','2026-10-07 15:17:51','2026-10-07 15:17:51'),(127,88,'10. Peningkatan Penulisan Proposal/Hibah Penelitian & Pengabdian',NULL,'https://drive.google.com/drive/folders/1HxEvQFbt4jj9TMe6a9zVaawpNa24htT1?usp=drive_link','2026-10-07 15:18:09','2026-10-07 15:18:09'),(128,35,'1. Dokumen Dosen Homebase',NULL,'https://drive.google.com/drive/folders/1n0_ezlFv_xWASPPR_LlHxE-y1lRVvG_7?usp=drive_link','2026-10-07 15:21:54','2026-10-07 15:21:54'),(129,35,'2. Rekapitulasi Dosen DTPS 2021-2025',NULL,'https://drive.google.com/file/d/1Tct-cmilYPR5zn5kBYDNeQoVUGIYrSNL/view?usp=drive_link','2026-10-07 15:24:46','2026-10-07 15:24:46'),(130,89,'1. Dosen Tetap Penghitung Rasio PDDikti Tahun 2024',NULL,'https://drive.google.com/drive/folders/1g8UGqee55YPyiw-8slHDKh-fv7MetYex?usp=drive_link','2026-10-07 15:29:24','2026-10-07 15:29:24'),(131,89,'2. Dosen Tetap Penghitung Rasio PDDikti Tahun 2025',NULL,'https://drive.google.com/drive/folders/1iZc914elKhdKpgjErtNfVT9cLlSa9JBQ?usp=drive_link','2026-10-07 15:29:44','2026-10-07 15:29:44'),(132,89,'3. DOKUMEN REKAPITULASI DTPR 2021-2025.pdf',NULL,'https://drive.google.com/file/d/19jF72SlVi30-yq4mDsCY0G_ClkGHCVrO/view?usp=drive_link','2026-10-07 15:30:04','2026-10-07 15:30:04'),(133,90,'1. Ijasah Dosen S3',NULL,'https://drive.google.com/drive/folders/1V7QYqTD7vzr20RL-CrzWpKfQOFRfXeKd?usp=drive_link','2026-10-07 15:30:55','2026-10-07 15:30:55'),(134,90,'2. Dosen DTPR Lanjut Studi S3',NULL,'https://drive.google.com/drive/folders/1Tvk4F49A7SXASRnKKOuDE3Cr8-KFMBoq?usp=drive_link','2026-10-07 15:31:18','2026-10-07 15:31:18'),(135,90,'3. DOKUMEN REKAPITULASI DTPR 2021-2025.pdf',NULL,'https://drive.google.com/file/d/1ZWO-8JI6ymtW4dZAvbuwOxFUNwrAE0Nx/view?usp=drive_link','2026-10-07 15:31:37','2026-10-07 15:31:37'),(136,91,'1. SK Jabatan Fungsional Akademik (Guru Besar, Lektor Kepala, Lektor)',NULL,'https://drive.google.com/drive/folders/1uQCiKz2-fQQI32TUEszkKo96SP_MvYYc?usp=drive_link','2026-10-07 15:32:04','2026-10-07 15:32:04'),(137,91,'2. DOKUMEN REKAPITULASI DTPR 2021-2025.pdf',NULL,'https://drive.google.com/file/d/19HFx_Pt6sEp1azCvicBx7Bnj5CNSQMyY/view?usp=drive_link','2026-10-07 15:32:41','2026-10-07 15:32:41'),(138,92,'1. Laporan Jumlah Lulusan & Kelulusan Tepat Waktu S1-Informatika.pdf',NULL,'https://drive.google.com/file/d/1ba_6NjQM_Aj8G6aLwSw3OyyYkdM08U0a/view?usp=drive_link','2026-10-07 15:33:20','2026-10-07 15:33:20'),(139,92,'2. Bukti Pendukung',NULL,'https://drive.google.com/drive/folders/1i5yA65JfNp-RULmK8qq0TIifFAo61Pv2?usp=drive_link','2026-10-07 15:33:40','2026-10-07 15:33:40'),(140,93,'1. Laporan Jumlah Lulusan & Kelulusan Tepat Waktu S1-Informatika.pdf',NULL,'https://drive.google.com/file/d/1svLMc4KLJvRyKv0Vw8mlSLoRXnGc01zP/view?usp=drive_link','2026-10-07 15:34:11','2026-10-07 15:34:11'),(141,93,'2. Bukti Pendukung',NULL,'https://drive.google.com/drive/folders/1nUBu9PrTJixkUimg5tesEBDL7bO_lSon?usp=drive_link','2026-10-07 15:34:29','2026-10-07 15:34:29'),(142,50,'Penelitian tahun 2025',NULL,'https://drive.google.com/drive/folders/1YNbvYZ0TAKb6fK5zayf8s5Wlk0RhS6Wt?usp=drive_link','2026-10-07 15:35:38','2026-10-07 15:35:38'),(143,50,'Rasio Penelitian DTPR Informatika.pdf',NULL,'https://drive.google.com/file/d/1tr5Nv37nMsIx2mhK6F2oZFnCdV5RHZg-/view?usp=drive_link','2026-10-07 15:36:05','2026-10-07 15:36:05'),(144,50,'DOKUMEN REKAPITULASI DTPR 2021-2025.pdf',NULL,'https://drive.google.com/file/d/1zpDkUs9JHhIiu1CpJriBBV_s7xdyrN0P/view?usp=drive_link','2026-10-07 15:36:23','2026-10-07 15:36:23'),(145,94,'Rasio Publikasi DTPR Informatika.pdf',NULL,'https://drive.google.com/file/d/1l094EY12U8h3Ry-1WB5e82SOJfSgn91B/view?usp=drive_link','2026-10-07 15:36:52','2026-10-07 15:36:52'),(146,94,'DOKUMEN REKAPITULASI DTPR 2021-2025.pdf',NULL,'https://drive.google.com/file/d/1St5LTVCJ_q2k0ADGRvmHZV4N7ZfOa5C4/view?usp=drive_link','2026-10-07 15:37:10','2026-10-07 15:37:10'),(147,84,'DOKUMEN REKAPITULASI DTPR 2021-2025.pdf',NULL,'https://drive.google.com/file/d/1MLpaKbSETJr6NOrQNUO4zRZ58ch4iguI/view?usp=drive_link','2026-10-07 15:38:26','2026-10-07 15:38:26'),(148,84,'Rasio jumlah PkM terhadap DTPR.pdf',NULL,'https://drive.google.com/file/d/13O5C7z3vXStaCBsFrdzlmHDi9ymIPtl2/view?usp=drive_link','2026-10-07 15:38:42','2026-10-07 15:38:42'),(149,84,'PkM 2024',NULL,'https://drive.google.com/drive/folders/1TR0-hXUUnGHfieE6J7SKeV4M8rfF0G7w?usp=drive_link','2026-10-07 15:38:57','2026-10-07 15:38:57'),(150,84,'PkM 2025',NULL,'https://drive.google.com/drive/folders/1TdVV_rg2s0x7_b-Bo81Q7OjSL6nLEYJz?usp=drive_link','2026-10-07 15:39:13','2026-10-07 15:39:13'),(151,65,'1. STATUTA TSU.pdf',NULL,'https://drive.google.com/file/d/19BHQ4AoNK0IYzwVAgoxfM69IbsNJBhJ0/view?usp=drive_link','2026-10-07 15:39:51','2026-10-07 15:39:51'),(152,65,'2. Struktur Organisasi dan Tata Kelola',NULL,'https://drive.google.com/drive/folders/1MhGhMp4M5OWZ_Xqnrck2PudGJK2P_Z8z?usp=drive_link','2026-10-07 15:40:08','2026-10-07 15:40:08'),(153,65,'3. Renstra & Renop',NULL,'https://drive.google.com/drive/folders/1HPvcSCJbUEfCb80N5eBoOVeo4emPukaf?usp=drive_link','2026-10-07 15:40:25','2026-10-07 15:40:25'),(154,65,'6. Buku Pedoman Akademik - Fakultas Teknik.pdf',NULL,'https://drive.google.com/file/d/1OGEHZoANhQrNvE15Namiw9yVX4dfkPa7/view?usp=drive_link','2026-10-07 15:40:44','2026-10-09 09:50:47'),(155,65,'5. SOP',NULL,'https://drive.google.com/drive/folders/1ZOeuSI09hPhdAkqJGHKMmZhN-EnT5bBV?usp=sharing','2026-10-07 17:11:35','2026-10-07 17:11:35'),(156,87,'Laporan RTL 2025',NULL,'https://drive.google.com/file/d/1tkuAi60eJP4pL-hfllhu4ek2_0SzlMPz/view?usp=drive_link','2026-10-09 09:42:50','2026-10-09 09:42:50'),(157,65,'4. Renstra & Renop',NULL,'https://drive.google.com/drive/folders/1HPvcSCJbUEfCb80N5eBoOVeo4emPukaf?usp=drive_link','2026-10-09 09:51:16','2026-10-09 09:51:16'),(158,65,'7. Laporan Tahunan Kinerja S1 Informatika',NULL,'https://drive.google.com/file/d/1_h44Anc7SeuIIKLYHZFtzC_f_Q-YUYGp/view?usp=drive_link','2026-10-09 09:51:42','2026-10-09 09:51:42'),(159,65,'8. Notulensi Rapat Prodi',NULL,'https://drive.google.com/drive/folders/1nGnHW4IXGzKJL1gZ19PGiJV91zJ48zYp?usp=drive_link','2026-10-09 09:52:06','2026-10-09 09:52:06'),(160,84,'Roadmap P2M Informatika 2025-2029.pdf',NULL,'https://drive.google.com/file/d/1CTvgKRNk6X0mllUVChjyclSlvaDsccHV/view?usp=drive_link','2026-10-09 09:56:24','2026-10-09 09:56:24'),(161,84,'PkM 2022',NULL,'https://drive.google.com/drive/folders/1VKLdQjpvudXk_A_VtiaofiJgY5uA3xP5?usp=drive_link','2026-10-09 09:57:23','2026-10-09 09:57:23'),(162,84,'PkM 2023',NULL,'https://drive.google.com/drive/folders/1UkGMHOiTPVDDs37SoOr7eFRcLRnZmhIY?usp=drive_link','2026-10-09 09:57:42','2026-10-09 09:57:42'),(163,50,'Roadmap P2M Informatika 2025-2029',NULL,'https://drive.google.com/file/d/1Rhv7jWyV-R_0Eu56zXOFDvtKCmZRvXM8/view?usp=drive_link','2026-10-09 10:01:45','2026-10-09 10:01:45'),(164,50,'Penelitian tahun 2024',NULL,'https://drive.google.com/drive/folders/1Gf-B9UREATSNwX247kSUL0K9tylJyAt3?usp=drive_link','2026-10-09 10:02:35','2026-10-09 10:02:35'),(165,50,'Penelitian tahun 2023',NULL,'https://drive.google.com/drive/folders/1c2sUcFCAvlS1QAJFryQfVO5ZnfbucJOB?usp=drive_link','2026-10-09 10:03:03','2026-10-09 10:03:03'),(166,50,'Penelitian tahun 2022',NULL,'https://drive.google.com/drive/folders/1p5cGXQJ-uHPtP8wRYwHIa-c3qF6iaSwB?usp=drive_link','2026-10-09 10:03:22','2026-10-09 10:03:22'),(167,94,'Roadmap P2M Informatika 2025-2029',NULL,'https://drive.google.com/file/d/10HXum7Odyb7KvlZoIj68-9hvrg9kIzo4/view?usp=drive_link','2026-10-09 10:06:17','2026-10-09 10:06:17'),(168,85,'14. PDDIKTI & Sevima',NULL,'https://drive.google.com/drive/folders/1vASagRAWoGqS30PJP44DJSZW-0tRUR1C?usp=drive_link','2026-10-09 11:00:51','2026-10-09 11:00:51'),(169,15,'6. SOP',NULL,'https://drive.google.com/drive/folders/1KfRnmxK_rDf5SCPO3QOPr8Ei9plcL1Sy?usp=drive_link','2026-10-09 11:23:26','2026-10-09 11:23:26'),(170,35,'3. Perencanaan Pengembangan SDM untuk Dosen TSU',NULL,'https://drive.google.com/file/d/1qsJVlqkqr_ba7BL6eoYAVARCSduV2ter/view?usp=drive_link','2026-10-09 13:52:33','2026-10-09 13:52:33'),(171,90,'4. Perencanaan Pengembangan SDM untuk Dosen TSU',NULL,'https://drive.google.com/file/d/1uUJfK6j7fUMN2od-i_1eCJI9bbkXRARQ/view?usp=drive_link','2026-10-09 13:53:56','2026-10-09 13:53:56'),(172,65,'9. Surat Keputusan Rektor Penetapan Visi, Misi, Tujuan dan Strategi Fakultas Teknik Universitas Tiga Serangkai',NULL,'https://drive.google.com/file/d/15ecy__EolyLZlBgH8MT9HqSPU1HSds_m/view?usp=drive_link','2026-10-09 14:01:14','2026-10-09 14:01:14');
/*!40000 ALTER TABLE `dokumen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `isi_kriteria`
--

DROP TABLE IF EXISTS `isi_kriteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `isi_kriteria` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kriteria_id` bigint unsigned NOT NULL,
  `butir` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `elemen_penilaian` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `narasi` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `persentase` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `isi_kriteria_kriteria_id_foreign` (`kriteria_id`),
  CONSTRAINT `isi_kriteria_kriteria_id_foreign` FOREIGN KEY (`kriteria_id`) REFERENCES `kriterias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `isi_kriteria`
--

LOCK TABLES `isi_kriteria` WRITE;
/*!40000 ALTER TABLE `isi_kriteria` DISABLE KEYS */;
INSERT INTO `isi_kriteria` VALUES (15,1,'1.A','Ketersediaan dokumen Penetapan standar dan indikatornya.','<p>Universitas Tiga Serangkai merupakan institusi hasil penggabungan antara STMIK Sinar Nusantara dan Akademi Seni dan Desain Indonesia (ASDI), sebagaimana ditetapkan melalui Keputusan Menteri Pendidikan Tinggi, Sains, dan Teknologi Nomor 42/A/O/2025 tertanggal 10 Januari 2025. Sejalan dengan transformasi kelembagaan tersebut, Program Studi S1 Informatika yang semula berada di bawah naungan STMIK Sinar Nusantara kini resmi beroperasi di bawah Fakultas Teknik Universitas Tiga Serangkai.<br />Secara historis, program studi ini mulai diselenggarakan pada tahun 2001 dengan nama Teknik Informatika (S1) berdasarkan SK Nomor 173/D/O/2001. Dalam perkembangannya, guna menyesuaikan dengan dinamika nomenklatur pendidikan tinggi, nama tersebut bertransformasi menjadi Program Studi Informatika melalui SK Nomor 890/KPT/I/2019.<br />Pasca-perubahan bentuk kelembagaan, Program Studi S1 Informatika berkomitmen melakukan penguatan tata kelola serta akselerasi pelaksanaan Tri Dharma Perguruan Tinggi, baik secara kualitas maupun kuantitas. Upaya ini diwujudkan melalui evaluasi diri berkala yang berpedoman pada Sistem Penjaminan Mutu Internal (SPMI). Kebijakan ini merupakan pengembangan dari dokumen SPMI STMIK Sinar Nusantara yang telah diperbarui menjadi Dokumen SPMI Universitas Tiga Serangkai, khususnya pada standar Tata Pamong, Tata Kelola, dan Kerja Sama.</p>\n<p>Implementasi penjaminan mutu tersebut diperkuat secara yuridis melalui pembentukan Lembaga Penjaminan Mutu (LPM) tingkat universitas berdasarkan Keputusan Rektor Nomor 038.A/SK/REK/I/2025, pengelola Unit Mutu di tingkat Fakultas dan Gugus Mutu di tingkat Prodi berdasarkan Keputusan Rektor Nomor 108.A/SK/REK/III/2025.</p>\n<p>Instrumen SPMI ditetapkan melalui Keputusan Rektor Nomor 032.A/SK/REK/X/2025 tentang Penetapan Dokumen SPMI Universitas Tiga Serangkai, yang mencakup pengesahan atas:<br />1. Kebijakan Sistem Penjaminan Mutu Internal;<br />2. Standar Sistem Penjaminan Mutu Internal;<br />2.1. Standar Pendidikan;<br />2.2. Standar Penelitian; <br />2.3. Standar Pengabdian kepada Masyarakat<br />3. Tata Cara Pendokumentasian Sistem Penjaminan Mutu Internal; <br />4. Pedoman Sistem Penjaminan Mutu Internal.</p>',100,'2026-10-05 02:03:04','2026-10-07 17:50:57'),(35,2,'2.A','Jumlah dosen tetap (homebase). \r\nJumlah minimal dosen tetap prodi (homebase) = 5.','<p>Pada tahun 2024, Program Studi S1 Informatika memiliki 10 dosen homebase dengan latar belakang keilmuan di bidang Informatika dan Komputer (INFOKOM). Dalam upaya membenahi tata kelola serta meningkatkan pelaksanaan Tri Dharma Perguruan Tinggi, baik dari aspek kualitas maupun kuantitas, program studi secara berkelanjutan melakukan penataan dan penguatan sumber daya dosen.</p>\n<p>Pada tahun 2025, jumlah dosen homebase tercatat sebanyak 9 orang, dengan seluruhnya tetap memiliki kesesuaian keilmuan di bidang INFOKOM. Penyesuaian jumlah dosen tersebut dilakukan sebagai bagian dari optimalisasi sumber daya manusia untuk mendukung efektivitas penyelenggaraan pendidikan, penelitian, dan pengabdian kepada masyarakat.</p>',0,'2026-10-05 02:21:42','2026-10-07 16:44:06'),(50,3,'3.A','Rasio jumlah judul penelitian atau penelitian terapan bidang INFOKOM terhadap jumlah DTPR per tahun.','<p>Pada TS-3 (2022), keterlibatan DTPR dalam penelitian bidang INFOKOM mulai menunjukkan kontribusi yang terukur terhadap pengembangan keilmuan program studi.<br />1. Budi Hartanto, S.Kom, M.Kom<br />2. Didik Nugroho, S.Kom, M.Kom<br />3. Sri Hariyati Fitriasih, S.Kom, M.Kom<br />Sebanyak 3 dari 15 DTPR (26,67%) terlibat dalam 4 kegiatan penelitian bidang INFOKOM. Capaian ini menjadi dasar penguatan budaya riset pada tahun-tahun berikutnya.</p>\n<p>Pada TS-2 (2023), terjadi peningkatan partisipasi DTPR dalam kegiatan penelitian bidang INFOKOM dibandingkan tahun sebelumnya.<br />1. Budi Hartanto, S.Kom, M.Kom<br />2. Iwan Ady Prabowo, S.Kom, M.Kom<br />3. Paulus Harsadi, S.Kom, M.Kom  <br />4. Dwi Remawati, S.Kom, M.Kom<br />5. Dr. Ir. Muhammad Hasbi, M.Kom<br />6. Dziky Ridhwanullah, S.Kom., M.Kom.<br />Sebanyak 6 dari 17 DTPR (35,29%) terlibat dalam 6 kegiatan penelitian bidang INFOKOM. Peningkatan ini menunjukkan adanya perkembangan positif dalam produktivitas dan keterlibatan dosen dalam penelitian.</p>\n<p>Pada TS-1 (2024), partisipasi DTPR dalam penelitian bidang INFOKOM semakin meningkat secara signifikan baik dari sisi jumlah dosen maupun jumlah penelitian.<br />1. Budi Hartanto, S.Kom, M.Kom<br />2. Didik Nugroho, S.Kom, M.Kom<br />3. Iwan Ady Prabowo, S.Kom, M.Kom<br />4. Dwi Remawati, S.Kom, M.Kom   <br />5. Sri Siswanti, S.Kom, M.Kom<br />6. Dziky Ridhwanullah, S.Kom., M.Kom.<br />7. Bayu Dwi Raharja, S.Kom, M.Kom.<br />Sebanyak 7 dari 19 DTPR (52,63%) terlibat dalam 10 kegiatan penelitian bidang INFOKOM. Capaian ini mencerminkan penguatan budaya riset serta meningkatnya komitmen dosen dalam pengembangan keilmuan.</p>\n<p>Pada TS (2025), keterlibatan DTPR dalam penelitian bidang INFOKOM menunjukkan peningkatan yang sangat signifikan dibandingkan tahun-tahun sebelumnya.<br />1. Budi Hartanto, S.Kom, M.Kom<br />2. Didik Nugroho, S.Kom, M.Kom<br />3. Hendro Wijayanto, S.Kom, M.Kom<br />4. Iwan Ady Prabowo, S.Kom, M.Kom<br />5. Paulus Harsadi, S.Kom, M.Kom  <br />6.  Sri Tomo, S.T, M.Kom <br />7. Sri Hariyati Fitriasih, S.Kom, M.Kom<br />8. Teguh Susyanto,S.Kom, M.Cs    <br />9. Sri Siswanti, S.Kom, M.Kom<br />10. Dr. Ir. Muhammad Hasbi, M.Kom<br />11. Dziky Ridhwanullah, S.Kom., M.Kom.<br />12. Bayu Dwi Raharja, S.Kom, M.Kom.<br />Sebanyak 12 dari 18 DTPR (66,67%) terlibat dalam 12 kegiatan penelitian bidang INFOKOM. Peningkatan rasio ini menunjukkan konsistensi program studi dalam mendorong produktivitas penelitian serta memperkuat daya saing akademik pada bidang INFOKOM.</p>\n<p>Rata-rata rasio jumlah judul penelitian bidang INFOKOM terhadap jumlah DTPR per tahun adalah sebesar 45,31%.</p>\n<p> </p>',0,'2026-10-05 02:42:02','2026-10-07 16:49:00'),(65,5,'5.A','Struktur Organisasi dan Tata Kelola','<p>Secara struktural, Program Studi S1 Informatika berada di bawah koordinasi Fakultas Teknik sebagai Unit Pengelola Program Studi (UPPS) di lingkungan Universitas Tiga Serangkai yang dipimpin oleh Dekan. Landasan penyelenggaraan organisasi dan tata kelola mengacu pada STATUTA Universitas Tiga Serangkai berdasarkan Keputusan Nomor 31.7/YAA.TSU/SK/I/2025. Adapun struktur organisasi, tugas pokok, fungsi, serta mekanisme koordinasi setiap unit kerja diatur dalam dokumen Organisasi dan Tata Kelola Universitas Tiga Serangkai yang disahkan melalui Keputusan Rektor Nomor 074.A/PR/REK/I/2025. Informasi terkait kelembagaan dan penyelenggaraan program studi dapat diakses melalui laman resmi Universitas Tiga Serangkai (https://tsu.ac.id/), Fakultas Teknik (https://teknik.tsu.ac.id/), dan Program Studi S1 Informatika (https://teknik.tsu.ac.id/studiInformatika).</p>\n<p>Dalam pelaksanaan tata kelola, Program Studi S1 Informatika menerapkan prinsip akuntabilitas, transparansi, efektivitas, efisiensi, dan keberlanjutan guna menjamin mutu penyelenggaraan tridharma perguruan tinggi. Seluruh proses akademik dan nonakademik dilaksanakan berdasarkan dokumen perencanaan dan pengendalian mutu yang meliputi Rencana Strategis (Renstra), Rencana Operasional (Renop), Rencana Kerja dan Anggaran Tahunan (RKAT), Pedoman Akademik, Standar Operasional Prosedur (SOP), serta kebijakan Sistem Penjaminan Mutu Internal (SPMI) yang berlaku di tingkat universitas maupun fakultas. Melalui tata kelola tersebut, Program Studi S1 Informatika berkomitmen untuk mewujudkan pengelolaan program studi yang profesional, terukur, dan berorientasi pada peningkatan mutu secara berkelanjutan.</p>',100,'2026-10-05 03:01:11','2026-10-09 09:53:43'),(84,4,'4.A','Rasio jumlah kegiatan PkM bidang INFOKOM terhadap jumlah DTPR per tahun.','<p>Pada TS-2 (2022), dari total 15 Dosen Tetap Program Studi (DTPR), sebanyak 5 dosen pada bidang INFOKOM melaksanakan kegiatan Pengabdian kepada Masyarakat (PkM) yang didanai melalui skema pendanaan mandiri, internal perguruan tinggi, maupun sumber pendanaan eksternal: <br />1. Budi Hartanto, S.Kom, M.Kom  <br />2. Yustina Retno, S.T, M.Cs <br />3.  Sri Tomo, S.T, M.Kom <br />4. Sri Hariyati Fitriasih, S.Kom, M.Kom<br />5. Dr. Ir. Muhammad Hasbi, M.Kom<br />Total kegiatan PkM pada bidang INFOKOM yang didanai pada tahun tersebut berjumlah 6 judul/kegiatan dengan rasio capaian sebesar 40%. Capaian ini menunjukkan tingkat produktivitas PkM yang sangat baik dibandingkan jumlah dosen yang ada.</p>\n<p>Pada TS-1 (2023), dari total 15 DTPR, sebanyak 4 dosen pada bidang INFOKOM melaksanakan kegiatan Pengabdian kepada Masyarakat (PkM) yang didanai melalui skema pendanaan mandiri, internal perguruan tinggi, maupun sumber pendanaan eksternal:<br />1. Budi Hartanto, S.Kom, M.Kom<br />2. Dwi Remawati, S.Kom, M.Kom<br />3. Sri Hariyati Fitriasih, S.Kom, M.Kom<br />4. Bramasto Wiryawan Y, S.T, M.MSI<br />Total kegiatan PkM bidang INFOKOM yang didanai pada tahun tersebut berjumlah 6 judul/kegiatan. Total PkM yang dihasilkan pada tahun ini sebanyak 6 pada bidang INFOKOM dengan rasio capaian sebesar 35%. Capaian ini menunjukkan tingkat produktivitas PkM yang sangat baik dibandingkan jumlah dosen yang ada.</p>\n<p>Pada TS (2024), dari total 19 DTPR, sebanyak 5 dosen pada bidang INFOKOM melaksanakan kegiatan Pengabdian kepada Masyarakat (PkM) yang didanai melalui skema pendanaan mandiri, internal perguruan tinggi, maupun sumber pendanaan eksternal:<br />1. Budi Hartanto, S.Kom, M.Kom<br />2. Sri Hariyati Fitriasih, S.Kom, M.Kom <br />3. Sri Siswanti, S.Kom, M.Kom<br />4. Bramasto Wiryawan Y, S.T, M.MSI<br />5. Bayu Dwi Raharja, S.Kom, M.Kom<br />Total kegiatan PkM bidang INFOKOM yang didanai pada tahun tersebut berjumlah 6 judul/kegiatan. Total PkM yang dihasilkan pada tahun ini sebanyak 6 pada bidang INFOKOM dengan rasio capaian sebesar 32%. Capaian ini menunjukkan tingkat produktivitas PkM yang sangat baik dibandingkan jumlah dosen yang ada.</p>\n<p>Pada TS (2025), dari total 18 DTPR, sebanyak 6 dosen pada bidang INFOKOM melaksanakan kegiatan Pengabdian kepada Masyarakat (PkM) yang didanai melalui skema pendanaan mandiri, internal perguruan tinggi, maupun sumber pendanaan eksternal:<br />1. Hendro Wijayanto, S.Kom, M.Kom<br />2. Iwan Ady Prabowo, S.Kom, M.Kom<br />3.  Sri Tomo, S.T, M.Kom <br />4. Bebas Widada, S.Si., M.Kom <br />5. Sri Hariyati Fitriasih, S.Kom, M.Kom<br />6. Wawan Laksito, S.Si, M.Kom<br />Total kegiatan PkM bidang INFOKOM yang didanai pada tahun tersebut berjumlah 6 judul/kegiatan. Total PkM yang dihasilkan pada tahun ini sebanyak 6 pada bidang INFOKOM dengan rasio capaian sebesar 33%. Capaian ini menunjukkan tingkat produktivitas PkM yang sangat baik dibandingkan jumlah dosen yang ada.</p>\n<p>Rata-rata rasio jumlah kegiatan PkM bidang INFOKOM terhadap jumlah DTPR per tahun adalah sebesar 35%.</p>',0,'2026-10-05 03:13:25','2026-10-07 16:49:52'),(85,1,'1.B','Ketersediaan dokumen bukti Pelaksanaan yang sesuai dengan Penetapan.','<p>Program Studi S1 Informatika secara konsisten mengimplementasikan budaya mutu melalui ketersediaan dokumen pelaksanaan yang selaras dengan standar dalam Sistem Penjaminan Mutu Internal (SPMI). Setiap kegiatan akademik dan nonakademik didukung oleh dokumen operasional, antara lain Rencana Pembelajaran Semester (RPS), jadwal perkuliahan, berita acara kegiatan, serta laporan penelitian dan pengabdian kepada masyarakat. Tata kelola program studi dilaksanakan berdasarkan Standar Operasional Prosedur (SOP) dan manual mutu yang terdokumentasi, sehingga seluruh proses memiliki pedoman yang jelas, terukur, dan terdokumentasi dengan baik.</p>\n<p>Pelayanan kepada mahasiswa terdokumentasi melalui catatan bimbingan akademik, laporan kegiatan kemahasiswaan, serta hasil tracer study yang menunjukkan keterkaitan antara implementasi standar mutu dengan kebutuhan mahasiswa dan alumni. Sumber daya program studi, baik dosen maupun sarana dan prasarana, didukung oleh dokumen inventarisasi, logbook penggunaan fasilitas, serta sertifikat pengembangan kompetensi dosen.</p>\n<p>Dalam pengelolaan akademik, Program Studi S1 Informatika memanfaatkan sistem informasi akademik berbasis aplikasi web (https://tsu.siakadcloud.com) sebagai sarana manajemen, pengelolaan, dan evaluasi proses pembelajaran. Peninjauan dan pengembangan kurikulum dilaksanakan secara berkala melalui kajian dan evaluasi bersama Unit Pengelola Program Studi (UPPS), Lembaga Penjaminan Mutu (LPM), dan Tim Kurikulum. Pelaksanaan pembelajaran oleh dosen pengampu dibuktikan melalui pemenuhan Laporan Beban Kinerja Dosen (LBKD) sesuai dengan ketentuan yang berlaku.</p>',100,'2026-10-06 09:47:49','2026-10-09 09:38:11'),(86,1,'1.C','Ketersediaan dokumen bukti Evaluasi.','<p>Evaluasi mencakup aspek akademik, tata kelola, layanan mahasiswa, serta pengelolaan sumber daya. Proses evaluasi dilaksanakan melalui monitoring rutin, Audit Mutu Internal (AMI), survei kepuasan, serta rapat evaluasi berkala. Hasil evaluasi didokumentasikan dalam bentuk laporan monitoring, laporan hasil audit, rekapitulasi capaian kinerja, serta rekomendasi tindak lanjut.</p>\n<p>Audit Mutu Internal (AMI) terhadap Program Studi S1 Informatika telah dilaksanakan oleh Lembaga Penjaminan Mutu (LPM). Dalam pelaksanaannya, LPM menugaskan tim auditor bersertifikat yang berasal dari dosen untuk melakukan audit atas pemenuhan standar mutu oleh program studi.</p>\n<p>Dokumen evaluasi pembelajaran dan monitoring perkuliahan terdokumentasi dalam sistem informasi akademik berbasis aplikasi web melalui https://tsu.siakadcloud.com.</p>',100,'2026-10-06 09:48:02','2026-10-09 09:38:50'),(87,1,'1.D','Ketersediaan dokumen bukti Pengendalian.','<p>Sebagai upaya pengendalian terhadap pemenuhan standar agar pelaksanaan kegiatan sesuai dengan ketentuan yang ditetapkan, setiap temuan dalam Audit Mutu Internal (AMI) disertai dengan usulan perbaikan yang harus ditindaklanjuti oleh program studi. Usulan tersebut merupakan hasil pembahasan antara auditor, audit, dan Lembaga Penjaminan Mutu (LPM). Tindak lanjut atas temuan tersebut terdokumentasi dalam Laporan AMI pada kolom Rencana Tindak Lanjut.</p>\n<p>Penanggung jawab pelaksanaan pengendalian adalah Ketua Program Studi dan Kepala Unit Pengelola Program Studi (UPPS). Hasil pelaksanaan tindak lanjut akan dimonitor kembali oleh LPM pada pelaksanaan AMI tahun 2026. Penetapan kebijakan, keputusan, dan tindakan korektif atas temuan audit dibahas dan disahkan melalui dokumen Rapat Tinjauan Manajemen (RTM) serta dituangkan dalam Rencana Tindak Lanjut (RTL).</p>',0,'2026-10-06 09:48:39','2026-10-07 16:42:01'),(88,1,'1.E','Ketersediaan dokumen bukti Peningkatan.','<p>Proses pelaksanaan PPEPP pada tahap Peningkatan dilaksanakan melalui pembahasan dalam Rapat Tinjauan Manajemen (RTM) sebagai forum evaluasi dan penetapan kebijakan strategis.</p>\n<p>1. Aspek Pembelajaran<br />Program Studi S1 Informatika telah melakukan penyelarasan Capaian Pembelajaran Lulusan (CPL) dan kurikulum agar selaras dengan visi dan misi Universitas Tiga Serangkai yang berorientasi pada penguatan kolaborasi dengan industri. Evaluasi Kurikulum 2023 menghasilkan pengembangan dan implementasi Kurikulum 2025 sebagai bentuk peningkatan mutu pembelajaran yang adaptif terhadap kebutuhan pemangku kepentingan.<br />Untuk memperkaya pengalaman belajar mahasiswa dan memastikan terjadinya transfer pengetahuan yang mutakhir, Program Studi S1 Informatika melakukan inovasi pada metode instruksional melalui penguatan kolaborasi akademik. Hal ini diwujudkan melalui penerapan skema team teaching yang melibatkan pengajar internasional  serta praktisi pakar dari industri teknologi informasi. Keterlibatan dosen internasional bertujuan untuk memberikan wawasan global dan standar akademik internasional, sementara dosen praktisi berperan dalam menjembatani kesenjangan antara teori akademik dengan kebutuhan nyata di dunia kerja.</p>\n<p>2. Aspek Sumber Daya Manusia<br />Dalam upaya peningkatan mutu, Program Studi S1 Informatika melakukan optimalisasi dan penguatan kinerja dosen homebase yang memiliki keilmuan di bidang Informatika dan Komputer (INFOKOM), khususnya dalam bidang pendidikan, penelitian, dan pengabdian kepada masyarakat. Peningkatan kinerja tersebut diwujudkan melalui penguatan publikasi ilmiah, keterlibatan dalam hibah penelitian dan pengabdian, serta pengembangan kompetensi akademik.<br />Pada tingkat fakultas, dilakukan penataan dan penguatan tenaga kependidikan untuk mendukung optimalisasi kinerja Unit Pengelola Program Studi (UPPS). Selain itu, dosen dan tenaga kependidikan secara aktif mengikuti program peningkatan kompetensi yang diselenggarakan oleh Kementerian Pendidikan Tinggi, Sains, dan Teknologi maupun lembaga terkait lainnya sebagai bagian dari pengembangan sumber daya manusia secara berkelanjutan.</p>',0,'2026-10-06 09:49:56','2026-10-09 13:57:48'),(89,2,'2.B','Rasio jumlah Dosen Penghitung Rasio yang mempunyai NUPTK terhadap jumlah mahasiswa aktif, sesuai data di PDDIKTI.','<p>Pada tahun 2024, Program Studi S1 Informatika memiliki 30 dosen tetap yang diperhitungkan dalam rasio dosen terhadap mahasiswa, dengan 19 dosen di antaranya memiliki keilmuan di bidang Informatika dan Komputer (INFOKOM). Jumlah mahasiswa pada tahun tersebut sebanyak 363 orang, sehingga rasio dosen terhadap mahasiswa adalah sebesar 1:12,1.</p>\n<p>Pada tahun 2025, jumlah dosen tetap yang diperhitungkan dalam rasio meningkat menjadi 34 orang, dengan 18 dosen memiliki keilmuan di bidang INFOKOM. Jumlah mahasiswa tercatat sebanyak 313 orang, sehingga rasio dosen terhadap mahasiswa membaik menjadi 1:9,21. Perbaikan rasio ini menunjukkan peningkatan kapasitas layanan akademik serta mendukung mutu proses pembelajaran yang lebih optimal.</p>',0,'2026-10-06 09:54:35','2026-10-07 16:44:24'),(90,2,'2.C','Persentase kualifikasi akademik Dosen Penghitung Rasio yang memiliki NUPTK yang bergelar Doktor/Doktor Terapan (bidang INFOKOM) terhadap jumlah Dosen Penghitung Rasio.','<p>Program Studi S1 Informatika memiliki 1 (satu) dosen bergelar Doktor (S3) yang sesuai dengan bidang keilmuan Informatika dan Komputer (INFOKOM), yaitu:<br />1. Dr. Ir. Muhammad Hasbi, M.Kom</p>\n<p>Selain itu, terdapat 2 (dua) dosen yang sedang menempuh pendidikan Doktoral Ilmu Komputer (S3) pada bidang yang relevan, yaitu:<br />1. Budi Hartanto, S.Kom, M.Kom<br />2. Dwi Remawati, S.Kom, M.Kom</p>\n<p>Ketersediaan dosen berkualifikasi doktor serta dosen yang sedang melanjutkan studi doktoral menunjukkan komitmen program studi dalam meningkatkan kualitas sumber daya manusia guna mendukung pelaksanaan Tri Dharma Perguruan Tinggi.</p>\n<p>Dosen bergelar Doktor bidang INFOKOM sejumlah satu orang dari sembilan belas DTPR, prosentase sama dengan 1/19 = 5,26%</p>',0,'2026-10-06 09:54:48','2026-10-07 16:44:43'),(91,2,'2.D','Jumlah Dosen Penghitung Rasio yang memiliki Jabatan Fungsional Akademik (Guru Besar, Lektor Kepala dan Lektor) yang mempunyai NUPTK saat TS.','<p>Pada TS (2024/2025)<br />Jumlah Dosen Tetap Program Studi (DTPR) sebanyak 19 dosen pada bidang INFOKOM yang telah memiliki jabatan fungsional akademik, mulai dari Lektor hingga Guru Besar, yang terdiri atas 13 dosen dengan jabatan Lektor Kepala sebanyak 3 orang, Lektor sebanyak 13 orang, dan Asisten Ahli 3 orang.   <br />Lektor (13):<br />1. Budi Hartanto, S.Kom, M.Kom<br />2. Didik Nugroho, S.Kom, M.Kom<br />3. Hendro Wijayanto, S.Kom, M.Kom<br />4. Iwan Ady Prabowo, S.Kom, M.Kom<br />5. Paulus Harsadi, S.Kom, M.Kom  <br />6. Yustina Retno, S.T, M.Cs <br />7.  Sri Tomo, S.T, M.Kom <br />8. Bebas Widada, S.Si., M.Kom <br />9. Dr. Didik Setiyadi, S.Kom, M.Kom<br />10. Dwi Remawati, S.Kom, M.Kom<br />11. Sri Hariyati Fitriasih, S.Kom, M.Kom<br />12. Sri Harjanto, S.Kom., M.Kom<br />13. Teguh Susyanto,S.Kom, M.Cs    <br />Lektor Kepala (3):<br />1. Sri Siswanti, S.Kom, M.Kom<br />2. Wawan Laksito, S.Si, M.Kom<br />3. Dr. Ir. Muhammad Hasbi, M.Kom</p>\n<p>Dari sejumlah DTPR sebanyak 19 dosen yang mempunyai jabatan Lektor adalah 13, Lektor Kepala 3 sehingga Guru Besar 0, sehingga prosentasenya = 16/19 = 84.21%.</p>',0,'2026-10-06 09:55:03','2026-10-07 16:47:46'),(92,2,'2.E','Persentase jumlah lulusan terhadap jumlah mahasiswa dalam 3 (tiga) tahun terakhir untuk Diploma, 4 (empat) tahun terakhir untuk Sarjana, 2 (lima) tahun terakhir untuk Magister, dan 3 (tiga) tahun terakhir untuk Doktor.','<p>Perhitungan indikator kelulusan dilakukan pada rentang TS sampai dengan TS-3, yaitu TS = 2024/2025, TS-1 = 2023/2024, TS-2 = 2022/2023, dan TS-3 = 2021/2022. Penghitungan didasarkan pada cohort mahasiswa baru yang masuk pada semester gasal tahun 2018, 2019, 2020, dan 2021. <br />Dari total 364 mahasiswa pada cohort tersebut, sebanyak 236 mahasiswa telah menyelesaikan studinya. <br />Dengan demikian, persentase kelulusan tercatat sebesar 236/364= 64,84%.</p>\n<p>Hasil ini menunjukkan bahwa tingkat kelulusan mahasiswa Program Studi Informatika masih memerlukan peningkatan. Oleh karena itu, program studi menempatkan capaian ini sebagai bagian dari agenda evaluasi akademik berkelanjutan. Tindak lanjut yang dilakukan mencakup penguatan fungsi dosen penasihat akademik dalam pembuatan smartplan mahasiswa, monitoring kemajuan studi, pendampingan perencanaan akademik yang lebih terstruktur, serta peningkatan koordinasi antara dosen PA, dosen pembimbing, dan mahasiswa. </p>',0,'2026-10-06 09:55:21','2026-10-07 16:48:12'),(93,2,'2.F','Persentase kelulusan tepat waktu  terhadap jumlah mahasiswa dalam 3 (tiga) tahun terakhir untuk Diploma, 4 (empat) tahun terakhir untuk Sarjana, 2 (lima) tahun terakhir untuk Magister, dan 3 (tiga) tahun terakhir untuk Doktor.','<p>Dengan perhitungan yang sama seperti pada poin e, jumlah mahasiswa pada cohort yang diamati tercatat sebanyak 364 orang, dengan 118 orang di antaranya lulus tepat waktu. Dengan demikian, persentase kelulusan tepat waktu adalah sebesar 118/364=37,40%.<br />Capaian ini menunjukkan bahwa tingkat kelulusan tepat waktu di Program Studi Informatika masih perlu ditingkatkan. Namun trend peningkatan lulusan tepat waktu dari 9% --&gt; 29% --&gt; 54% --&gt; 58% merupakan indikator keberhasilan manajemen program studi dalam melakukan intervensi akademik, baik melalui perbaikan kurikulum, efisiensi proses bimbingan tugas akhir, maupun monitoring progres mahasiswa secara berkala melalui Smart Plan Mahasiswa. Hal ini mencerminkan komitmen kuat institusi dalam memenuhi standar mutu nasional pendidikan tinggi.</p>',0,'2026-10-06 09:55:35','2026-10-07 16:48:31'),(94,3,'3.B','Rasio jumlah judul publikasi bidang INFOKOM terhadap jumlah DTPR per tahun.','<p>Pada TS-2 (2022), jumlah DTPR Program Studi S1 Informatika sebanyak 15 dosen. Dari jumlah tersebut, dosen bidang INFOKOM yang menghasilkan publikasi ilmiah adalah sebagai berikut: <br />1. Budi Hartanto, S.Kom, M.Kom  (1 publikasi)<br />2. Didik Nugroho, S.Kom, M.Kom (2 publikasi)<br />3. Hendro Wijayanto, S.Kom, M.Kom (1 publikasi)<br />4. Iwan Ady Prabowo, S.Kom, M.Kom (3 publikasi)<br />5. Paulus Harsadi, S.Kom, M.Kom  (4 publikasi)<br />6. Yustina Retno, S.T, M.Cs  (2 publikasi)<br />7. Bebas Widada, S.Si., M.Kom (1 publikasi)<br />8. Dwi Remawati, S.Kom, M.Kom (2 publikasi)<br />9. Sri Hariyati Fitriasih, S.Kom, M.Kom (4 publikasi)<br />10. Teguh Susyanto,S.Kom, M.Cs     (1 publikasi)<br />11. Sri Siswanti, S.Kom, M.Kom (6 publikasi)<br />12. Wawan Laksito, S.Si, M.Kom (3 publikasi)<br />13. Bramasto Wiryawan Y, S.T, M.MSI. (1 publikasi)<br />14. Setiyowati, S.Kom, M.Kom (1 publikasi)<br />Total publikasi yang dihasilkan pada tahun ini sebanyak 33 publikasi pada bidang INFOKOM dengan rasio capaian sebesar 220,00%. Capaian ini menunjukkan tingkat produktivitas publikasi yang sangat baik dibandingkan jumlah dosen yang ada.</p>\n<p>Pada TS-1 (2023), jumlah DTPR meningkat menjadi 17 dosen. Dosen bidang INFOKOM yang menghasilkan publikasi ilmiah adalah sebagai berikut:<br />1. Budi Hartanto, S.Kom, M.Kom (2 publikasi)<br />2. Didik Nugroho, S.Kom, M.Kom (3 publikasi)<br />3. Hendro Wijayanto, S.Kom, M.Kom (2 publikasi)<br />4. Iwan Ady Prabowo, S.Kom, M.Kom (4 publikasi)<br />5. Paulus Harsadi, S.Kom, M.Kom  (2 publikasi)<br />6. Yustina Retno, S.T, M.Cs (1 publikasi)<br />7.  Sri Tomo, S.T, M.Kom  (1 publikasi)<br />8. Bebas Widada, S.Si., M.Kom  (1 publikasi)<br />10. Dwi Remawati, S.Kom, M.Kom (4 publikasi)<br />11. Sri Hariyati Fitriasih, S.Kom, M.Kom (2 publikasi)  <br />12. Sri Siswanti, S.Kom, M.Kom (5 publikasi)<br />13. Dr. Ir. Muhammad Hasbi, M.Kom (4 publikasi)<br />14. Dziky Ridhwanullah, S.Kom., M.Kom. (1 publikasi)<br />Total publikasi yang dihasilkan sebanyak 32 publikasi pada bidang INFOKOM dengan rasio sebesar 188,24%. Hal ini menunjukkan peningkatan jumlah luaran publikasi dibandingkan tahun sebelumnya.</p>\n<p>Pada TS (2024), jumlah DTPR sebanyak 19 dosen. Dosen bidang INFOKOM yang menghasilkan publikasi adalah sebagai berikut:<br />1. Budi Hartanto, S.Kom, M.Kom (2 publikasi)<br />2. Didik Nugroho, S.Kom, M.Kom (1 publikasi)<br />3. Hendro Wijayanto, S.Kom, M.Kom (2 publikasi)<br />4. Iwan Ady Prabowo, S.Kom, M.Kom (3 publikasi)<br />5. Paulus Harsadi, S.Kom, M.Kom  (2 publikasi)<br />6. Yustina Retno, S.T, M.Cs  (2 publikasi)<br />7.  Sri Tomo, S.T, M.Kom (1 publikasi)<br />8. Bebas Widada, S.Si., M.Kom (3 publikasi)<br />9. Dr. Didik Setiyadi, S.Kom, M.Kom (4 publikasi)<br />10. Dwi Remawati, S.Kom, M.Kom (3 publikasi)<br />11. Sri Hariyati Fitriasih, S.Kom, M.Kom (2 publikasi) <br />12. Sri Siswanti, S.Kom, M.Kom (5 publikasi)<br />13. Wawan Laksito, S.Si, M.Kom (2 publikasi)<br />14. Dr. Ir. Muhammad Hasbi, M.Kom (3 publikasi)<br />15. Bayu Dwi Raharja, S.Kom, M.Kom. (1 publikasi)<br />16. Bramasto Wiryawan Y, S.T, M.MSI. (1 publikasi)<br />17. Dziky Ridhwanullah, S.Kom., M.Kom. (2 publikasi)<br />Total publikasi yang dihasilkan mencapai 39 publikasi pada bidang INFOKOM dengan rasio 205,26%. Peningkatan ini mencerminkan penguatan budaya riset dan publikasi di lingkungan program studi.</p>\n<p>Pada TS (2025), jumlah DTPR sebanyak 18 dosen. Dosen bidang INFOKOM yang menghasilkan publikasi adalah sebagai berikut:<br />1. Budi Hartanto, S.Kom, M.Kom (1 publikasi)<br />2. Didik Nugroho, S.Kom, M.Kom (2 publikasi)<br />3. Iwan Ady Prabowo, S.Kom, M.Kom  (5 publikasi)<br />4. Paulus Harsadi, S.Kom, M.Kom  (4 publikasi)<br />5. Yustina Retno, S.T, M.Cs  (1 publikasi)<br />6.  Sri Tomo, S.T, M.Kom  (1 publikasi)<br />7. Bebas Widada, S.Si., M.Kom  (2 publikasi)<br />8. Dr. Didik Setiyadi, S.Kom, M.Kom (5 publikasi)<br />9. Sri Hariyati Fitriasih, S.Kom, M.Kom (2 publikasi)   <br />10. Sri Siswanti, S.Kom, M.Kom (3 publikasi)<br />11. Wawan Laksito, S.Si, M.Kom (2 publikasi)<br />12. Dr. Ir. Muhammad Hasbi, M.Kom (1 publikasi)<br />13. Dziky Ridhwanullah, S.Kom., M.Kom. (1 publikasi) <br />Total publikasi yang dihasilkan sebanyak 26 publikasi pada bidang INFOKOM dengan rasio 144,44%. Capaian ini menunjukkan konsistensi produktivitas publikasi dosen dalam mendukung peningkatan mutu akademik dan reputasi program studi.</p>\n<p>Rata-rata rasio jumlah judul publikasi bidang INFOKOM terhadap jumlah DTPR per tahun adalah sebesar 189%</p>',0,'2026-10-06 09:57:17','2026-10-07 16:49:23');
/*!40000 ALTER TABLE `isi_kriteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kriterias`
--

DROP TABLE IF EXISTS `kriterias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kriterias` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kriterias_kode_unique` (`kode`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kriterias`
--

LOCK TABLES `kriterias` WRITE;
/*!40000 ALTER TABLE `kriterias` DISABLE KEYS */;
INSERT INTO `kriterias` VALUES (1,'C1','BUDAYA MUTU','2026-10-05 01:47:57','2026-10-05 01:47:57'),(2,'C2','RELEVANSI PENDIDIKAN','2026-10-05 01:48:12','2026-10-05 01:48:12'),(3,'C3','RELEVANSI PENELITIAN','2026-10-05 01:48:27','2026-10-05 01:48:27'),(4,'C4','RELEVANSI PENGABDIAN KEPADA MASYARAKAT','2026-10-05 01:48:46','2026-10-05 01:48:46'),(5,'C5','AKUNTABILITAS','2026-10-05 01:48:57','2026-10-05 01:48:57');
/*!40000 ALTER TABLE `kriterias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_isian`
--

DROP TABLE IF EXISTS `lkps_isian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_isian` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kunci` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nilai` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lkps_isian_kunci_unique` (`kunci`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_isian`
--

LOCK TABLES `lkps_isian` WRITE;
/*!40000 ALTER TABLE `lkps_isian` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_isian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t1a1_pimpinan`
--

DROP TABLE IF EXISTS `lkps_t1a1_pimpinan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t1a1_pimpinan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `unit_kerja` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_ketua` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `periode_jabatan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pendidikan_terakhir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jabatan_fungsional` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tupoksi` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t1a1_pimpinan`
--

LOCK TABLES `lkps_t1a1_pimpinan` WRITE;
/*!40000 ALTER TABLE `lkps_t1a1_pimpinan` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1a1_pimpinan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t1a2_sumber_dana`
--

DROP TABLE IF EXISTS `lkps_t1a2_sumber_dana`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t1a2_sumber_dana` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sumber_pendanaan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` decimal(15,2) DEFAULT NULL,
  `ts1` decimal(15,2) DEFAULT NULL,
  `ts` decimal(15,2) DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t1a2_sumber_dana`
--

LOCK TABLES `lkps_t1a2_sumber_dana` WRITE;
/*!40000 ALTER TABLE `lkps_t1a2_sumber_dana` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1a2_sumber_dana` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t1a3_penggunaan_dana`
--

DROP TABLE IF EXISTS `lkps_t1a3_penggunaan_dana`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t1a3_penggunaan_dana` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `penggunaan_dana` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` decimal(15,2) DEFAULT NULL,
  `ts1` decimal(15,2) DEFAULT NULL,
  `ts` decimal(15,2) DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t1a3_penggunaan_dana`
--

LOCK TABLES `lkps_t1a3_penggunaan_dana` WRITE;
/*!40000 ALTER TABLE `lkps_t1a3_penggunaan_dana` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1a3_penggunaan_dana` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t1a4_ewmp`
--

DROP TABLE IF EXISTS `lkps_t1a4_ewmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t1a4_ewmp` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_dtpr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sks_ps_sendiri` decimal(15,2) DEFAULT NULL,
  `sks_ps_lain` decimal(15,2) DEFAULT NULL,
  `sks_pt_lain` decimal(15,2) DEFAULT NULL,
  `sks_penelitian` decimal(15,2) DEFAULT NULL,
  `sks_pkm` decimal(15,2) DEFAULT NULL,
  `sks_manajemen_pt_sendiri` decimal(15,2) DEFAULT NULL,
  `sks_manajemen_pt_lain` decimal(15,2) DEFAULT NULL,
  `total_sks` decimal(15,2) DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t1a4_ewmp`
--

LOCK TABLES `lkps_t1a4_ewmp` WRITE;
/*!40000 ALTER TABLE `lkps_t1a4_ewmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1a4_ewmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t1a5_tendik`
--

DROP TABLE IF EXISTS `lkps_t1a5_tendik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t1a5_tendik` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `jenis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `s3` int DEFAULT NULL,
  `s2` int DEFAULT NULL,
  `s1` int DEFAULT NULL,
  `d4` int DEFAULT NULL,
  `d3` int DEFAULT NULL,
  `d2` int DEFAULT NULL,
  `d1` int DEFAULT NULL,
  `sma` int DEFAULT NULL,
  `smp` int DEFAULT NULL,
  `sd` int DEFAULT NULL,
  `unit_kerja` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t1a5_tendik`
--

LOCK TABLES `lkps_t1a5_tendik` WRITE;
/*!40000 ALTER TABLE `lkps_t1a5_tendik` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1a5_tendik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t1b_spmi`
--

DROP TABLE IF EXISTS `lkps_t1b_spmi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t1b_spmi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `unit_spmi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dokumen_spmi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `auditor_internal` int DEFAULT NULL,
  `auditor_certified` int DEFAULT NULL,
  `auditor_non_certified` int DEFAULT NULL,
  `frekuensi_audit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bukti_certified` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `laporan_audit` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t1b_spmi`
--

LOCK TABLES `lkps_t1b_spmi` WRITE;
/*!40000 ALTER TABLE `lkps_t1b_spmi` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1b_spmi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2a1_data_mahasiswa`
--

DROP TABLE IF EXISTS `lkps_t2a1_data_mahasiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2a1_data_mahasiswa` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ts` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `daya_tampung` int DEFAULT NULL,
  `pendaftar` int DEFAULT NULL,
  `pendaftar_afirmasi` int DEFAULT NULL,
  `pendaftar_kebutuhan_khusus` int DEFAULT NULL,
  `baru_reguler` int DEFAULT NULL,
  `baru_reguler_afirmasi` int DEFAULT NULL,
  `baru_reguler_kk` int DEFAULT NULL,
  `baru_rpl` int DEFAULT NULL,
  `baru_rpl_afirmasi` int DEFAULT NULL,
  `baru_rpl_kk` int DEFAULT NULL,
  `aktif_reguler` int DEFAULT NULL,
  `aktif_reguler_afirmasi` int DEFAULT NULL,
  `aktif_reguler_kk` int DEFAULT NULL,
  `aktif_rpl` int DEFAULT NULL,
  `aktif_rpl_afirmasi` int DEFAULT NULL,
  `aktif_rpl_kk` int DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2a1_data_mahasiswa`
--

LOCK TABLES `lkps_t2a1_data_mahasiswa` WRITE;
/*!40000 ALTER TABLE `lkps_t2a1_data_mahasiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2a1_data_mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2a2_asal_mahasiswa`
--

DROP TABLE IF EXISTS `lkps_t2a2_asal_mahasiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2a2_asal_mahasiswa` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` int DEFAULT NULL,
  `ts1` int DEFAULT NULL,
  `ts` int DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2a2_asal_mahasiswa`
--

LOCK TABLES `lkps_t2a2_asal_mahasiswa` WRITE;
/*!40000 ALTER TABLE `lkps_t2a2_asal_mahasiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2a2_asal_mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2a3_kondisi_mahasiswa`
--

DROP TABLE IF EXISTS `lkps_t2a3_kondisi_mahasiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2a3_kondisi_mahasiswa` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kondisi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` int DEFAULT NULL,
  `ts1` int DEFAULT NULL,
  `ts` int DEFAULT NULL,
  `jumlah` int DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2a3_kondisi_mahasiswa`
--

LOCK TABLES `lkps_t2a3_kondisi_mahasiswa` WRITE;
/*!40000 ALTER TABLE `lkps_t2a3_kondisi_mahasiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2a3_kondisi_mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2b1_isi_pembelajaran`
--

DROP TABLE IF EXISTS `lkps_t2b1_isi_pembelajaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2b1_isi_pembelajaran` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kode_mk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_mk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sks` int DEFAULT NULL,
  `semester` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pl1` tinyint(1) DEFAULT '0',
  `pl2` tinyint(1) DEFAULT '0',
  `pl3` tinyint(1) DEFAULT '0',
  `pl4` tinyint(1) DEFAULT '0',
  `pl5` tinyint(1) DEFAULT '0',
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2b1_isi_pembelajaran`
--

LOCK TABLES `lkps_t2b1_isi_pembelajaran` WRITE;
/*!40000 ALTER TABLE `lkps_t2b1_isi_pembelajaran` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b1_isi_pembelajaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2b2_cpl_pl`
--

DROP TABLE IF EXISTS `lkps_t2b2_cpl_pl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2b2_cpl_pl` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cpl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pl1` tinyint(1) DEFAULT '0',
  `pl2` tinyint(1) DEFAULT '0',
  `pl3` tinyint(1) DEFAULT '0',
  `pl4` tinyint(1) DEFAULT '0',
  `pl5` tinyint(1) DEFAULT '0',
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2b2_cpl_pl`
--

LOCK TABLES `lkps_t2b2_cpl_pl` WRITE;
/*!40000 ALTER TABLE `lkps_t2b2_cpl_pl` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b2_cpl_pl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2b3_peta_cpl`
--

DROP TABLE IF EXISTS `lkps_t2b3_peta_cpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2b3_peta_cpl` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cpl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cpmk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `semester_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `semester_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `semester_3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `semester_4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `semester_5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `semester_6` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2b3_peta_cpl`
--

LOCK TABLES `lkps_t2b3_peta_cpl` WRITE;
/*!40000 ALTER TABLE `lkps_t2b3_peta_cpl` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b3_peta_cpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2b4_masa_tunggu`
--

DROP TABLE IF EXISTS `lkps_t2b4_masa_tunggu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2b4_masa_tunggu` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tahun_lulus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jumlah_lulusan` int DEFAULT NULL,
  `terlacak` int DEFAULT NULL,
  `rata_masa_tunggu` decimal(15,2) DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2b4_masa_tunggu`
--

LOCK TABLES `lkps_t2b4_masa_tunggu` WRITE;
/*!40000 ALTER TABLE `lkps_t2b4_masa_tunggu` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b4_masa_tunggu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2b5_bidang_kerja`
--

DROP TABLE IF EXISTS `lkps_t2b5_bidang_kerja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2b5_bidang_kerja` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tahun_lulus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jumlah_lulusan` int DEFAULT NULL,
  `terlacak` int DEFAULT NULL,
  `profesi_infokom` int DEFAULT NULL,
  `profesi_non_infokom` int DEFAULT NULL,
  `tempat_multinasional` int DEFAULT NULL,
  `tempat_nasional` int DEFAULT NULL,
  `tempat_wirausaha` int DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2b5_bidang_kerja`
--

LOCK TABLES `lkps_t2b5_bidang_kerja` WRITE;
/*!40000 ALTER TABLE `lkps_t2b5_bidang_kerja` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b5_bidang_kerja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2b6_kepuasan_pengguna`
--

DROP TABLE IF EXISTS `lkps_t2b6_kepuasan_pengguna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2b6_kepuasan_pengguna` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `jenis_kemampuan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sangat_baik` decimal(15,2) DEFAULT NULL,
  `baik` decimal(15,2) DEFAULT NULL,
  `cukup` decimal(15,2) DEFAULT NULL,
  `kurang` decimal(15,2) DEFAULT NULL,
  `tindak_lanjut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2b6_kepuasan_pengguna`
--

LOCK TABLES `lkps_t2b6_kepuasan_pengguna` WRITE;
/*!40000 ALTER TABLE `lkps_t2b6_kepuasan_pengguna` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b6_kepuasan_pengguna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2c_fleksibilitas`
--

DROP TABLE IF EXISTS `lkps_t2c_fleksibilitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2c_fleksibilitas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bentuk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` int DEFAULT NULL,
  `ts1` int DEFAULT NULL,
  `ts` int DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2c_fleksibilitas`
--

LOCK TABLES `lkps_t2c_fleksibilitas` WRITE;
/*!40000 ALTER TABLE `lkps_t2c_fleksibilitas` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2c_fleksibilitas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t2d_rekognisi_lulusan`
--

DROP TABLE IF EXISTS `lkps_t2d_rekognisi_lulusan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t2d_rekognisi_lulusan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sumber_rekognisi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_pengakuan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` int DEFAULT NULL,
  `ts1` int DEFAULT NULL,
  `ts` int DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t2d_rekognisi_lulusan`
--

LOCK TABLES `lkps_t2d_rekognisi_lulusan` WRITE;
/*!40000 ALTER TABLE `lkps_t2d_rekognisi_lulusan` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2d_rekognisi_lulusan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t3a1_sarpras_penelitian`
--

DROP TABLE IF EXISTS `lkps_t3a1_sarpras_penelitian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t3a1_sarpras_penelitian` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_prasarana` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `daya_tampung` int DEFAULT NULL,
  `luas_ruang` decimal(15,2) DEFAULT NULL,
  `kepemilikan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lisensi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `perangkat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t3a1_sarpras_penelitian`
--

LOCK TABLES `lkps_t3a1_sarpras_penelitian` WRITE;
/*!40000 ALTER TABLE `lkps_t3a1_sarpras_penelitian` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3a1_sarpras_penelitian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t3a2_penelitian_dtpr`
--

DROP TABLE IF EXISTS `lkps_t3a2_penelitian_dtpr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t3a2_penelitian_dtpr` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_dtpr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `judul` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jumlah_mahasiswa` int DEFAULT NULL,
  `jenis_hibah` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `durasi` decimal(15,2) DEFAULT NULL,
  `dana_ts2` decimal(15,2) DEFAULT NULL,
  `dana_ts1` decimal(15,2) DEFAULT NULL,
  `dana_ts` decimal(15,2) DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t3a2_penelitian_dtpr`
--

LOCK TABLES `lkps_t3a2_penelitian_dtpr` WRITE;
/*!40000 ALTER TABLE `lkps_t3a2_penelitian_dtpr` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3a2_penelitian_dtpr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t3a3_pengembangan_dtpr`
--

DROP TABLE IF EXISTS `lkps_t3a3_pengembangan_dtpr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t3a3_pengembangan_dtpr` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `jenis_pengembangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_dtpr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` tinyint(1) DEFAULT '0',
  `ts1` tinyint(1) DEFAULT '0',
  `ts` tinyint(1) DEFAULT '0',
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t3a3_pengembangan_dtpr`
--

LOCK TABLES `lkps_t3a3_pengembangan_dtpr` WRITE;
/*!40000 ALTER TABLE `lkps_t3a3_pengembangan_dtpr` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3a3_pengembangan_dtpr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t3c1_kerjasama_penelitian`
--

DROP TABLE IF EXISTS `lkps_t3c1_kerjasama_penelitian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t3c1_kerjasama_penelitian` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `judul_kerjasama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mitra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `durasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dana_ts2` decimal(15,2) DEFAULT NULL,
  `dana_ts1` decimal(15,2) DEFAULT NULL,
  `dana_ts` decimal(15,2) DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t3c1_kerjasama_penelitian`
--

LOCK TABLES `lkps_t3c1_kerjasama_penelitian` WRITE;
/*!40000 ALTER TABLE `lkps_t3c1_kerjasama_penelitian` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3c1_kerjasama_penelitian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t3c2_publikasi`
--

DROP TABLE IF EXISTS `lkps_t3c2_publikasi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t3c2_publikasi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_dtpr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `judul_publikasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_publikasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` tinyint(1) DEFAULT '0',
  `ts1` tinyint(1) DEFAULT '0',
  `ts` tinyint(1) DEFAULT '0',
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t3c2_publikasi`
--

LOCK TABLES `lkps_t3c2_publikasi` WRITE;
/*!40000 ALTER TABLE `lkps_t3c2_publikasi` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3c2_publikasi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t3c3_hki_penelitian`
--

DROP TABLE IF EXISTS `lkps_t3c3_hki_penelitian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t3c3_hki_penelitian` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `judul` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_hki` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_dtpr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` tinyint(1) DEFAULT '0',
  `ts1` tinyint(1) DEFAULT '0',
  `ts` tinyint(1) DEFAULT '0',
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t3c3_hki_penelitian`
--

LOCK TABLES `lkps_t3c3_hki_penelitian` WRITE;
/*!40000 ALTER TABLE `lkps_t3c3_hki_penelitian` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3c3_hki_penelitian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t4a1_sarpras_pkm`
--

DROP TABLE IF EXISTS `lkps_t4a1_sarpras_pkm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t4a1_sarpras_pkm` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_prasarana` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `daya_tampung` int DEFAULT NULL,
  `luas_ruang` decimal(15,2) DEFAULT NULL,
  `kepemilikan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lisensi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `perangkat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t4a1_sarpras_pkm`
--

LOCK TABLES `lkps_t4a1_sarpras_pkm` WRITE;
/*!40000 ALTER TABLE `lkps_t4a1_sarpras_pkm` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t4a1_sarpras_pkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t4a2_pkm_dtpr`
--

DROP TABLE IF EXISTS `lkps_t4a2_pkm_dtpr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t4a2_pkm_dtpr` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_dtpr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `judul` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jumlah_mahasiswa` int DEFAULT NULL,
  `jenis_hibah` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `durasi` decimal(15,2) DEFAULT NULL,
  `dana_ts2` decimal(15,2) DEFAULT NULL,
  `dana_ts1` decimal(15,2) DEFAULT NULL,
  `dana_ts` decimal(15,2) DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t4a2_pkm_dtpr`
--

LOCK TABLES `lkps_t4a2_pkm_dtpr` WRITE;
/*!40000 ALTER TABLE `lkps_t4a2_pkm_dtpr` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t4a2_pkm_dtpr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t4c1_kerjasama_pkm`
--

DROP TABLE IF EXISTS `lkps_t4c1_kerjasama_pkm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t4c1_kerjasama_pkm` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `judul_kerjasama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mitra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `durasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dana_ts2` decimal(15,2) DEFAULT NULL,
  `dana_ts1` decimal(15,2) DEFAULT NULL,
  `dana_ts` decimal(15,2) DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t4c1_kerjasama_pkm`
--

LOCK TABLES `lkps_t4c1_kerjasama_pkm` WRITE;
/*!40000 ALTER TABLE `lkps_t4c1_kerjasama_pkm` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t4c1_kerjasama_pkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t4c2_diseminasi_pkm`
--

DROP TABLE IF EXISTS `lkps_t4c2_diseminasi_pkm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t4c2_diseminasi_pkm` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_dtpr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `judul` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diseminasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` tinyint(1) DEFAULT '0',
  `ts1` tinyint(1) DEFAULT '0',
  `ts` tinyint(1) DEFAULT '0',
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t4c2_diseminasi_pkm`
--

LOCK TABLES `lkps_t4c2_diseminasi_pkm` WRITE;
/*!40000 ALTER TABLE `lkps_t4c2_diseminasi_pkm` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t4c2_diseminasi_pkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t4c3_hki_pkm`
--

DROP TABLE IF EXISTS `lkps_t4c3_hki_pkm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t4c3_hki_pkm` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `judul` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jenis_hki` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_dtpr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ts2` tinyint(1) DEFAULT '0',
  `ts1` tinyint(1) DEFAULT '0',
  `ts` tinyint(1) DEFAULT '0',
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t4c3_hki_pkm`
--

LOCK TABLES `lkps_t4c3_hki_pkm` WRITE;
/*!40000 ALTER TABLE `lkps_t4c3_hki_pkm` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t4c3_hki_pkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t5_1_tata_kelola`
--

DROP TABLE IF EXISTS `lkps_t5_1_tata_kelola`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t5_1_tata_kelola` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `jenis_tata_kelola` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_sistem` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `akses` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_pengelola` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t5_1_tata_kelola`
--

LOCK TABLES `lkps_t5_1_tata_kelola` WRITE;
/*!40000 ALTER TABLE `lkps_t5_1_tata_kelola` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t5_1_tata_kelola` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t5_2_sarpras_pendidikan`
--

DROP TABLE IF EXISTS `lkps_t5_2_sarpras_pendidikan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t5_2_sarpras_pendidikan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_prasarana` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `daya_tampung` int DEFAULT NULL,
  `luas_ruang` decimal(15,2) DEFAULT NULL,
  `kepemilikan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lisensi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `perangkat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t5_2_sarpras_pendidikan`
--

LOCK TABLES `lkps_t5_2_sarpras_pendidikan` WRITE;
/*!40000 ALTER TABLE `lkps_t5_2_sarpras_pendidikan` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t5_2_sarpras_pendidikan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lkps_t6_visi_misi`
--

DROP TABLE IF EXISTS `lkps_t6_visi_misi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lkps_t6_visi_misi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `visi_pt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `visi_upps` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `visi_keilmuan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `misi_pt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `misi_upps` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `lampiran_bukti` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lkps_t6_visi_misi`
--

LOCK TABLES `lkps_t6_visi_misi` WRITE;
/*!40000 ALTER TABLE `lkps_t6_visi_misi` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t6_visi_misi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_01_01_000001_create_akreditasi_tables',1),(5,'2026_10_07_000001_create_data_induk_dokumen_table',2),(6,'2026_10_08_000100_create_lkps_tables',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Administrator','admininf@tsu.ac.id',NULL,'$2y$12$WEjQ7VxdrC/vp/O1kJ7VauQ.OPNfeUskd5vVgNhm0B8UPcYUAdeiO','0qo69YvAZXPNg7i6wQvtFSybVDmeHJIRMOguxziSpp1rXOH5VoH53VTP2vyh','2026-10-05 01:37:21','2026-10-06 08:40:10'),(2,'Program Studi','informatika@tsu.ac.id',NULL,'$2y$12$/yvlRIOC97UCtrjItjl5Teo3w33aECM8lsxhXzGluVIFYUizozdjO','zh49eBEHT6kYtvdulAOuFHZlRhvK1plrGD1Lt3TTSYPgR1lfeTzoHDRmery5','2026-10-06 00:14:14','2026-10-07 01:20:04');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'akreditasiinf'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
-- MySQL dump 10.13  Distrib 8.4.11, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: akreditasiinf
-- ------------------------------------------------------
-- Server version	8.4.11-0ubuntu0.26.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
