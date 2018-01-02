# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: blueprint
# Generation Time: 2018-01-02 02:44:21 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table block
# ------------------------------------------------------------

DROP TABLE IF EXISTS `block`;

CREATE TABLE `block` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_block_user` (`user_id`),
  CONSTRAINT `f_block_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;

INSERT INTO `block` (`id`, `name`, `user_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(4,'Block - 4',1,'2017-11-24 05:40:37','2017-12-25 19:30:44','2017-12-25 19:30:44'),
	(5,'Block - 5',1,'2017-11-24 05:40:44','2017-12-02 19:43:18',NULL),
	(6,'Block - 6',1,'2017-11-24 05:40:51','2017-12-02 19:43:29',NULL);

/*!40000 ALTER TABLE `block` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table field
# ------------------------------------------------------------

DROP TABLE IF EXISTS `field`;

CREATE TABLE `field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `line` int(10) unsigned NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `form_id` int(10) unsigned NOT NULL,
  `field_type_id` int(10) unsigned NOT NULL,
  `status_id` int(10) unsigned NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_field_type_id` (`field_type_id`),
  KEY `fk_field_status_id` (`status_id`),
  KEY `fk_field_form_id` (`form_id`),
  CONSTRAINT `fk_field_form_id` FOREIGN KEY (`form_id`) REFERENCES `form` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_field_status_id` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_field_type_id` FOREIGN KEY (`field_type_id`) REFERENCES `field_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;

INSERT INTO `field` (`id`, `line`, `name`, `description`, `form_id`, `field_type_id`, `status_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,1,'MarriageDetails','Marriage Details',2,1,1,'2017-12-27 07:30:30','2017-12-28 12:21:22',NULL),
	(2,2,'MarriageMenu','Marriage Menu',2,2,1,'2017-12-27 07:30:30','2018-01-01 19:40:32',NULL),
	(3,3,'LegalMarriage','Legal Marriage',2,3,1,'2017-12-27 07:30:30','2018-01-01 19:40:32',NULL),
	(4,4,'MarriageParty','Groom',2,4,1,'2017-12-27 07:30:30','2018-01-01 20:52:10',NULL),
	(5,4,'MarriageParty','Bride',2,4,1,'2017-12-27 07:30:30','2018-01-01 20:52:17',NULL),
	(6,5,'MarriageVenue','MarriageVenue',2,5,1,'2017-12-27 07:30:30','2018-01-01 21:05:09',NULL),
	(7,5,'MarriageVenue','Newyork',2,5,1,'2017-12-27 07:30:30','2018-01-01 21:05:37',NULL),
	(8,5,'MarriageVenue','London',2,5,1,'2017-12-27 07:30:30','2018-01-01 21:05:44',NULL),
	(9,5,'MarriageVenue','Tokyo',2,5,1,'2017-12-27 07:30:30','2018-01-01 21:05:54',NULL),
	(10,5,'MarriageVenue','',2,5,1,'2017-12-27 07:30:30','2018-01-01 21:30:08',NULL),
	(11,6,'MarriageMenu','MarriageMenu',2,6,1,'2017-12-27 07:30:30','2018-01-01 21:05:09',NULL),
	(12,6,'MarriageMenu','Veg',2,6,1,'2017-12-27 07:30:30','2018-01-01 21:05:37',NULL),
	(13,6,'MarriageMenu','NonVeg',2,6,1,'2017-12-27 07:30:30','2018-01-01 21:05:44',NULL),
	(14,6,'MarriageMenu','Vegan',2,6,1,'2017-12-27 07:30:30','2018-01-01 21:05:54',NULL),
	(15,6,'MarriageMenu','',2,6,1,'2017-12-27 07:30:30','2018-01-01 21:30:13',NULL),
	(16,7,'CreateAccount ','Create Account',2,7,1,'2017-12-27 07:30:30','2018-01-01 21:40:41',NULL);

/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table field_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `field_type`;

CREATE TABLE `field_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `status_id` int(10) unsigned NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_field_type_status_id` (`status_id`),
  CONSTRAINT `fk_field_type_status_id` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `field_type` WRITE;
/*!40000 ALTER TABLE `field_type` DISABLE KEYS */;

INSERT INTO `field_type` (`id`, `name`, `description`, `status_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'TEXT','',1,'2017-12-27 07:19:11','2017-12-29 04:13:43',NULL),
	(2,'TEXTAREA','',1,'2017-12-27 07:19:11','2017-12-29 04:13:51',NULL),
	(3,'CHECKBOX','',1,'2017-12-27 07:19:11','2017-12-29 04:13:59',NULL),
	(4,'RADIO','',1,'2017-12-27 07:19:11','2017-12-29 04:14:07',NULL),
	(5,'OPTION','',1,'2017-12-27 07:20:24','2017-12-29 04:14:16',NULL),
	(6,'MOPTION','',1,'2018-01-01 21:06:09','2018-01-01 21:11:44',NULL),
	(7,'SUBMIT','',1,'2018-01-01 21:06:09','2018-01-01 21:11:44',NULL);

/*!40000 ALTER TABLE `field_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table form
# ------------------------------------------------------------

DROP TABLE IF EXISTS `form`;

CREATE TABLE `form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `status_id` int(10) unsigned NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_form_status_id` (`status_id`),
  CONSTRAINT `fk_form_status_id` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;

INSERT INTO `form` (`id`, `name`, `description`, `status_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'Financial','These',1,'2017-12-25 20:34:57','2017-12-25 20:54:51',NULL),
	(2,'Marriage','These',1,'2017-12-25 20:35:16','2017-12-27 17:48:59',NULL);

/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table lot
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lot`;

CREATE TABLE `lot` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `block_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_lot_block` (`block_id`),
  KEY `f_lot_user` (`user_id`),
  CONSTRAINT `f_lot_block` FOREIGN KEY (`block_id`) REFERENCES `block` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `f_lot_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `lot` WRITE;
/*!40000 ALTER TABLE `lot` DISABLE KEYS */;

INSERT INTO `lot` (`id`, `name`, `block_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(8,'Lot - 4 - lot',4,1,'2017-11-24 05:40:37','2017-12-02 20:14:43',NULL),
	(9,'Lot - 4 - lot',4,1,'2017-11-24 05:40:44','2017-12-02 20:14:47',NULL),
	(10,'Lot - 5 - lot',6,1,'2017-11-24 05:40:51','2017-12-02 20:14:51',NULL),
	(16,'rest -123',5,1,'2017-12-25 19:31:01','2017-12-25 19:45:56','2017-12-25 19:45:56'),
	(17,'test 22',5,1,'2017-12-25 19:31:06','2017-12-25 19:31:16',NULL),
	(18,'rest 546',5,1,'2017-12-25 19:38:20','2017-12-25 19:45:59','2017-12-25 19:45:59'),
	(19,'test 123',5,1,'2017-12-25 19:48:30','2017-12-25 19:49:51','2017-12-25 19:49:51'),
	(20,'Hey',5,1,'2017-12-26 11:30:37',NULL,NULL);

/*!40000 ALTER TABLE `lot` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migration_blueprint
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migration_blueprint`;

CREATE TABLE `migration_blueprint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migration_blueprint` WRITE;
/*!40000 ALTER TABLE `migration_blueprint` DISABLE KEYS */;

INSERT INTO `migration_blueprint` (`id`, `name`, `created_at`)
VALUES
	(1,'20160630_020000.000000_init','2017-10-21 21:23:37');

/*!40000 ALTER TABLE `migration_blueprint` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `status`;

CREATE TABLE `status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;

INSERT INTO `status` (`id`, `status`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'active','2017-10-21 21:23:37',NULL,NULL),
	(2,'inactive','2017-10-21 21:23:37',NULL,NULL);

/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` char(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_id` int(10) unsigned NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `f_user_status` (`status_id`),
  CONSTRAINT `f_user_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `status_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'go','navi2017','gonavi2017@gmail.com','$2a$10$g0Yeq4Wkk9F2ixoXvvVNIODf6MoJWqYX4atyID1hEcag3ScnwJRju',1,'2017-10-21 21:48:03',NULL,NULL);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
