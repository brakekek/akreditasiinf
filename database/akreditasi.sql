-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: akreditasi
-- ------------------------------------------------------
-- Server version	8.4.3

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
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
-- Dumping routines for database 'akreditasi'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-07  1:14:45
-- MySQL dump 10.13  Distrib 8.4.3, for Win64 (x86_64)
--
-- Host: localhost    Database: akreditasi
-- ------------------------------------------------------
-- Server version	8.4.3

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
-- Dumping data for table `data_induk_dokumen`
--

LOCK TABLES `data_induk_dokumen` WRITE;
/*!40000 ALTER TABLE `data_induk_dokumen` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_induk_dokumen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `dokumen`
--

LOCK TABLES `dokumen` WRITE;
/*!40000 ALTER TABLE `dokumen` DISABLE KEYS */;
/*!40000 ALTER TABLE `dokumen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `isi_kriteria`
--

LOCK TABLES `isi_kriteria` WRITE;
/*!40000 ALTER TABLE `isi_kriteria` DISABLE KEYS */;
INSERT INTO `isi_kriteria` VALUES (15,1,'1.A','Ketersediaan dokumen Penetapan standar dan indikatornya.',NULL,0,'2026-10-05 02:03:04','2026-10-06 09:47:24'),(35,2,'2.A','Jumlah dosen tetap (homebase). \r\nJumlah minimal dosen tetap prodi (homebase) = 5.',NULL,0,'2026-10-05 02:21:42','2026-10-06 09:54:17'),(50,3,'3.A','Rasio jumlah judul penelitian atau penelitian terapan bidang INFOKOM terhadap jumlah DTPR per tahun.',NULL,0,'2026-10-05 02:42:02','2026-10-06 09:56:57'),(65,5,'5.A','Struktur Organisasi dan Tata Kelola',NULL,0,'2026-10-05 03:01:11','2026-10-06 09:59:31'),(84,4,'4.A','Rasio jumlah kegiatan PkM bidang INFOKOM terhadap jumlah DTPR per tahun.',NULL,0,'2026-10-05 03:13:25','2026-10-06 09:58:55'),(85,1,'1.B','Ketersediaan dokumen bukti Pelaksanaan yang sesuai dengan Penetapan.',NULL,0,'2026-10-06 09:47:49','2026-10-06 09:47:49'),(86,1,'1.C','Ketersediaan dokumen bukti Evaluasi.',NULL,0,'2026-10-06 09:48:02','2026-10-06 09:48:02'),(87,1,'1.D','Ketersediaan dokumen bukti Pengendalian.',NULL,0,'2026-10-06 09:48:39','2026-10-06 09:48:39'),(88,1,'1.E','Ketersediaan dokumen bukti Peningkatan.',NULL,0,'2026-10-06 09:49:56','2026-10-06 09:49:56'),(89,2,'2.B','Rasio jumlah Dosen Penghitung Rasio yang mempunyai NUPTK terhadap jumlah mahasiswa aktif, sesuai data di PDDIKTI.',NULL,0,'2026-10-06 09:54:35','2026-10-06 09:54:35'),(90,2,'2.C','Persentase kualifikasi akademik Dosen Penghitung Rasio yang memiliki NUPTK yang bergelar Doktor/Doktor Terapan (bidang INFOKOM) terhadap jumlah Dosen Penghitung Rasio.',NULL,0,'2026-10-06 09:54:48','2026-10-06 09:54:48'),(91,2,'2.D','Jumlah Dosen Penghitung Rasio yang memiliki Jabatan Fungsional Akademik (Guru Besar, Lektor Kepala dan Lektor) yang mempunyai NUPTK saat TS.',NULL,0,'2026-10-06 09:55:03','2026-10-06 09:55:03'),(92,2,'2.E','Persentase jumlah lulusan terhadap jumlah mahasiswa dalam 3 (tiga) tahun terakhir untuk Diploma, 4 (empat) tahun terakhir untuk Sarjana, 2 (lima) tahun terakhir untuk Magister, dan 3 (tiga) tahun terakhir untuk Doktor.',NULL,0,'2026-10-06 09:55:21','2026-10-06 09:55:21'),(93,2,'2.F','Persentase kelulusan tepat waktu  terhadap jumlah mahasiswa dalam 3 (tiga) tahun terakhir untuk Diploma, 4 (empat) tahun terakhir untuk Sarjana, 2 (lima) tahun terakhir untuk Magister, dan 3 (tiga) tahun terakhir untuk Doktor.',NULL,0,'2026-10-06 09:55:35','2026-10-06 09:55:35'),(94,3,'3.B','Rasio jumlah judul publikasi bidang INFOKOM terhadap jumlah DTPR per tahun.',NULL,0,'2026-10-06 09:57:17','2026-10-06 09:57:17');
/*!40000 ALTER TABLE `isi_kriteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `kriterias`
--

LOCK TABLES `kriterias` WRITE;
/*!40000 ALTER TABLE `kriterias` DISABLE KEYS */;
INSERT INTO `kriterias` VALUES (1,'C1','BUDAYA MUTU','2026-10-05 01:47:57','2026-10-05 01:47:57'),(2,'C2','RELEVANSI PENDIDIKAN','2026-10-05 01:48:12','2026-10-05 01:48:12'),(3,'C3','RELEVANSI PENELITIAN','2026-10-05 01:48:27','2026-10-05 01:48:27'),(4,'C4','RELEVANSI PENGABDIAN KEPADA MASYARAKAT','2026-10-05 01:48:46','2026-10-05 01:48:46'),(5,'C5','AKUNTABILITAS','2026-10-05 01:48:57','2026-10-05 01:48:57');
/*!40000 ALTER TABLE `kriterias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_isian`
--

LOCK TABLES `lkps_isian` WRITE;
/*!40000 ALTER TABLE `lkps_isian` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_isian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t1a1_pimpinan`
--

LOCK TABLES `lkps_t1a1_pimpinan` WRITE;
/*!40000 ALTER TABLE `lkps_t1a1_pimpinan` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1a1_pimpinan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t1a2_sumber_dana`
--

LOCK TABLES `lkps_t1a2_sumber_dana` WRITE;
/*!40000 ALTER TABLE `lkps_t1a2_sumber_dana` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1a2_sumber_dana` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t1a3_penggunaan_dana`
--

LOCK TABLES `lkps_t1a3_penggunaan_dana` WRITE;
/*!40000 ALTER TABLE `lkps_t1a3_penggunaan_dana` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1a3_penggunaan_dana` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t1a4_ewmp`
--

LOCK TABLES `lkps_t1a4_ewmp` WRITE;
/*!40000 ALTER TABLE `lkps_t1a4_ewmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1a4_ewmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t1a5_tendik`
--

LOCK TABLES `lkps_t1a5_tendik` WRITE;
/*!40000 ALTER TABLE `lkps_t1a5_tendik` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1a5_tendik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t1b_spmi`
--

LOCK TABLES `lkps_t1b_spmi` WRITE;
/*!40000 ALTER TABLE `lkps_t1b_spmi` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t1b_spmi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2a1_data_mahasiswa`
--

LOCK TABLES `lkps_t2a1_data_mahasiswa` WRITE;
/*!40000 ALTER TABLE `lkps_t2a1_data_mahasiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2a1_data_mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2a2_asal_mahasiswa`
--

LOCK TABLES `lkps_t2a2_asal_mahasiswa` WRITE;
/*!40000 ALTER TABLE `lkps_t2a2_asal_mahasiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2a2_asal_mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2a3_kondisi_mahasiswa`
--

LOCK TABLES `lkps_t2a3_kondisi_mahasiswa` WRITE;
/*!40000 ALTER TABLE `lkps_t2a3_kondisi_mahasiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2a3_kondisi_mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2b1_isi_pembelajaran`
--

LOCK TABLES `lkps_t2b1_isi_pembelajaran` WRITE;
/*!40000 ALTER TABLE `lkps_t2b1_isi_pembelajaran` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b1_isi_pembelajaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2b2_cpl_pl`
--

LOCK TABLES `lkps_t2b2_cpl_pl` WRITE;
/*!40000 ALTER TABLE `lkps_t2b2_cpl_pl` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b2_cpl_pl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2b3_peta_cpl`
--

LOCK TABLES `lkps_t2b3_peta_cpl` WRITE;
/*!40000 ALTER TABLE `lkps_t2b3_peta_cpl` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b3_peta_cpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2b4_masa_tunggu`
--

LOCK TABLES `lkps_t2b4_masa_tunggu` WRITE;
/*!40000 ALTER TABLE `lkps_t2b4_masa_tunggu` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b4_masa_tunggu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2b5_bidang_kerja`
--

LOCK TABLES `lkps_t2b5_bidang_kerja` WRITE;
/*!40000 ALTER TABLE `lkps_t2b5_bidang_kerja` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b5_bidang_kerja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2b6_kepuasan_pengguna`
--

LOCK TABLES `lkps_t2b6_kepuasan_pengguna` WRITE;
/*!40000 ALTER TABLE `lkps_t2b6_kepuasan_pengguna` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2b6_kepuasan_pengguna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2c_fleksibilitas`
--

LOCK TABLES `lkps_t2c_fleksibilitas` WRITE;
/*!40000 ALTER TABLE `lkps_t2c_fleksibilitas` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2c_fleksibilitas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t2d_rekognisi_lulusan`
--

LOCK TABLES `lkps_t2d_rekognisi_lulusan` WRITE;
/*!40000 ALTER TABLE `lkps_t2d_rekognisi_lulusan` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t2d_rekognisi_lulusan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t3a1_sarpras_penelitian`
--

LOCK TABLES `lkps_t3a1_sarpras_penelitian` WRITE;
/*!40000 ALTER TABLE `lkps_t3a1_sarpras_penelitian` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3a1_sarpras_penelitian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t3a2_penelitian_dtpr`
--

LOCK TABLES `lkps_t3a2_penelitian_dtpr` WRITE;
/*!40000 ALTER TABLE `lkps_t3a2_penelitian_dtpr` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3a2_penelitian_dtpr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t3a3_pengembangan_dtpr`
--

LOCK TABLES `lkps_t3a3_pengembangan_dtpr` WRITE;
/*!40000 ALTER TABLE `lkps_t3a3_pengembangan_dtpr` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3a3_pengembangan_dtpr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t3c1_kerjasama_penelitian`
--

LOCK TABLES `lkps_t3c1_kerjasama_penelitian` WRITE;
/*!40000 ALTER TABLE `lkps_t3c1_kerjasama_penelitian` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3c1_kerjasama_penelitian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t3c2_publikasi`
--

LOCK TABLES `lkps_t3c2_publikasi` WRITE;
/*!40000 ALTER TABLE `lkps_t3c2_publikasi` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3c2_publikasi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t3c3_hki_penelitian`
--

LOCK TABLES `lkps_t3c3_hki_penelitian` WRITE;
/*!40000 ALTER TABLE `lkps_t3c3_hki_penelitian` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t3c3_hki_penelitian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t4a1_sarpras_pkm`
--

LOCK TABLES `lkps_t4a1_sarpras_pkm` WRITE;
/*!40000 ALTER TABLE `lkps_t4a1_sarpras_pkm` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t4a1_sarpras_pkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t4a2_pkm_dtpr`
--

LOCK TABLES `lkps_t4a2_pkm_dtpr` WRITE;
/*!40000 ALTER TABLE `lkps_t4a2_pkm_dtpr` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t4a2_pkm_dtpr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t4c1_kerjasama_pkm`
--

LOCK TABLES `lkps_t4c1_kerjasama_pkm` WRITE;
/*!40000 ALTER TABLE `lkps_t4c1_kerjasama_pkm` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t4c1_kerjasama_pkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t4c2_diseminasi_pkm`
--

LOCK TABLES `lkps_t4c2_diseminasi_pkm` WRITE;
/*!40000 ALTER TABLE `lkps_t4c2_diseminasi_pkm` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t4c2_diseminasi_pkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t4c3_hki_pkm`
--

LOCK TABLES `lkps_t4c3_hki_pkm` WRITE;
/*!40000 ALTER TABLE `lkps_t4c3_hki_pkm` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t4c3_hki_pkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t5_1_tata_kelola`
--

LOCK TABLES `lkps_t5_1_tata_kelola` WRITE;
/*!40000 ALTER TABLE `lkps_t5_1_tata_kelola` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t5_1_tata_kelola` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t5_2_sarpras_pendidikan`
--

LOCK TABLES `lkps_t5_2_sarpras_pendidikan` WRITE;
/*!40000 ALTER TABLE `lkps_t5_2_sarpras_pendidikan` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t5_2_sarpras_pendidikan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `lkps_t6_visi_misi`
--

LOCK TABLES `lkps_t6_visi_misi` WRITE;
/*!40000 ALTER TABLE `lkps_t6_visi_misi` DISABLE KEYS */;
/*!40000 ALTER TABLE `lkps_t6_visi_misi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_01_01_000001_create_akreditasi_tables',1),(5,'2026_10_07_000001_create_data_induk_dokumen_table',2),(6,'2026_10_08_000100_create_lkps_tables',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Administrator','admininf@tsu.ac.id',NULL,'$2y$12$WEjQ7VxdrC/vp/O1kJ7VauQ.OPNfeUskd5vVgNhm0B8UPcYUAdeiO','1RzeYhp7IzmT0fgTBEKHO84aD1gkVczrSvqFwmr9KXyRSsmOMrj0uRAtDRpd','2026-10-05 01:37:21','2026-10-06 08:40:10'),(2,'Program Studi','informatika@tsu.ac.id',NULL,'$2y$12$pQRO9bAuxKX7tDKiadJdAuxV0GwZKl.0dHGfYYl9iMYg65LEqPHim','zh49eBEHT6kYtvdulAOuFHZlRhvK1plrGD1Lt3TTSYPgR1lfeTzoHDRmery5','2026-10-06 00:14:14','2026-10-06 08:40:51');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-07  1:14:46
