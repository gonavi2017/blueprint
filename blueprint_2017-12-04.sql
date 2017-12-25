# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: blueprint
# Generation Time: 2017-12-04 10:38:10 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `lot` WRITE;
/*!40000 ALTER TABLE `lot` DISABLE KEYS */;

INSERT INTO `lot` (`id`, `name`, `block_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(8,'Lot - 4 - lot',4,1,'2017-11-24 05:40:37','2017-12-02 20:14:43',NULL),
	(9,'Lot - 4 - lot',4,1,'2017-11-24 05:40:44','2017-12-02 20:14:47',NULL),
	(10,'Lot - 5 - lot',6,1,'2017-11-24 05:40:51','2017-12-02 20:14:51',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migration_blueprint` WRITE;
/*!40000 ALTER TABLE `migration_blueprint` DISABLE KEYS */;

INSERT INTO `migration_blueprint` (`id`, `name`, `created_at`)
VALUES
	(1,'20160630_020000.000000_init','2017-10-21 21:23:37');

/*!40000 ALTER TABLE `migration_blueprint` ENABLE KEYS */;
UNLOCK TABLES;


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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;

INSERT INTO `block` (`id`, `name`, `user_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(4,'Block - 4',1,'2017-11-24 05:40:37','2017-12-02 19:43:10',NULL),
	(5,'Block - 5',1,'2017-11-24 05:40:44','2017-12-02 19:43:18',NULL),
	(6,'Block - 6',1,'2017-11-24 05:40:51','2017-12-02 19:43:29',NULL);

/*!40000 ALTER TABLE `block` ENABLE KEYS */;
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
  CONSTRAINT `f_user_status` FOREIGN KEY (`status_id`) REFERENCES `user_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `status_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'go','navi2017','gonavi2017@gmail.com','$2a$10$g0Yeq4Wkk9F2ixoXvvVNIODf6MoJWqYX4atyID1hEcag3ScnwJRju',1,'2017-10-21 21:48:03',NULL,NULL);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_status`;

CREATE TABLE `user_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user_status` WRITE;
/*!40000 ALTER TABLE `user_status` DISABLE KEYS */;

INSERT INTO `user_status` (`id`, `status`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'active','2017-10-21 21:23:37',NULL,NULL),
	(2,'inactive','2017-10-21 21:23:37',NULL,NULL);

/*!40000 ALTER TABLE `user_status` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
