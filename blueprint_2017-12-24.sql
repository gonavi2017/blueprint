# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: blueprint
# Generation Time: 2017-12-24 18:11:32 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table clearing
# ------------------------------------------------------------

DROP TABLE IF EXISTS `clearing`;

CREATE TABLE `clearing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `execution_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL COMMENT 'Broker',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_clearing_created_at` (`created_at`),
  KEY `i_clearing_execution` (`execution_id`),
  KEY `i_clearing_user_id` (`user_id`),
  CONSTRAINT `f_clearing_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `execution` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `f_clearing_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `clearing` WRITE;
/*!40000 ALTER TABLE `clearing` DISABLE KEYS */;

INSERT INTO `clearing` (`id`, `name`, `execution_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'BOT 5@10.9875',1,1,'2017-12-23 20:43:16','2017-12-23 20:43:57',NULL),
	(2,'SOLD 5@10.9800',1,1,'2017-12-23 20:43:16','2017-12-23 20:44:31',NULL);

/*!40000 ALTER TABLE `clearing` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `note_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_comment_user` (`user_id`),
  KEY `i_comment_note` (`note_id`),
  CONSTRAINT `f_comment_note_id` FOREIGN KEY (`note_id`) REFERENCES `note` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `f_comment_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;

INSERT INTO `comment` (`id`, `name`, `note_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(21,'B 5@ 100-14',16,1,'2017-12-21 18:35:48','2017-12-21 18:36:46',NULL),
	(22,'B 5@ 100-20',16,1,'2017-12-21 18:36:07','2017-12-21 18:36:51',NULL),
	(23,'S 10@ 100-20',16,1,'2017-12-21 18:36:34',NULL,NULL);

/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table execution
# ------------------------------------------------------------

DROP TABLE IF EXISTS `execution`;

CREATE TABLE `execution` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `market_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL COMMENT 'Trader Id',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_execution_create_at` (`created_at`),
  KEY `i_execution_user_id` (`user_id`),
  KEY `i_execution_market_id` (`market_id`),
  CONSTRAINT `f_execution_market_id` FOREIGN KEY (`market_id`) REFERENCES `market` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `f_execution_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `execution` WRITE;
/*!40000 ALTER TABLE `execution` DISABLE KEYS */;

INSERT INTO `execution` (`id`, `name`, `market_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'BUY 5@10.98 ',1,1,'2017-12-23 20:40:27','2017-12-24 12:47:20',NULL),
	(2,'SELL 5@10.98 ',2,1,'2017-12-23 20:40:27','2017-12-24 12:47:25',NULL),
	(3,'SOLD 5@10.98 ',3,1,'2017-12-23 20:40:27','2017-12-24 12:47:28',NULL),
	(4,'BOT 5@10.98 ',4,1,'2017-12-23 20:40:27','2017-12-24 12:47:32',NULL);

/*!40000 ALTER TABLE `execution` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table market
# ------------------------------------------------------------

DROP TABLE IF EXISTS `market`;

CREATE TABLE `market` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL COMMENT 'Market Provider',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_market_reference` (`reference_id`),
  KEY `i_market_user` (`user_id`),
  KEY `i_market_created_at` (`created_at`),
  CONSTRAINT `f_market_referene_id` FOREIGN KEY (`reference_id`) REFERENCES `reference` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `f_market_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `market` WRITE;
/*!40000 ALTER TABLE `market` DISABLE KEYS */;

INSERT INTO `market` (`id`, `name`, `reference_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'BUY 10@10.98 - 5@11.00 SELL',1,1,'2017-12-23 20:38:30',NULL,NULL),
	(2,'BUY 10@10.99 - 5@11.00 SELL',1,1,'2017-12-23 20:38:30',NULL,NULL),
	(3,'BUY 10@10.98 - 5@10.99 SELL',1,1,'2017-12-23 20:38:30','2017-12-23 20:39:39',NULL),
	(4,'BUY 5@10.98 - 5@10.99 SELL',1,1,'2017-12-23 20:38:30','2017-12-23 20:39:39',NULL);

/*!40000 ALTER TABLE `market` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migration_blueprint
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migration_blueprint`;

CREATE TABLE `migration_blueprint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `i_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migration_blueprint` WRITE;
/*!40000 ALTER TABLE `migration_blueprint` DISABLE KEYS */;

INSERT INTO `migration_blueprint` (`id`, `name`, `created_at`)
VALUES
	(1,'20160630_020000.000000_init','2017-10-21 21:23:37');

/*!40000 ALTER TABLE `migration_blueprint` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `note`;

CREATE TABLE `note` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_note_user` (`user_id`),
  CONSTRAINT `f_note_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;

INSERT INTO `note` (`id`, `name`, `user_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(16,'MSFT 15@100-14  | 10@101-20',1,'2017-12-21 18:34:05','2017-12-21 18:34:45',NULL),
	(17,'Republican lawmakers said they wanted to simplify the tax code so you could file your return on a postcard. It turns out the new tax law will be anything but simple for many affluent Americans, who are now inundating their accountants for advice. \r\n\r\n“They made it a lot more complex for a lot of people,” said Jody Padar, chief executive officer of New Vision CPA Group in Mt. Prospect, Illinois. \r\n',3,'2017-12-22 15:41:06',NULL,NULL),
	(18,'The United Nations Security Council unanimously approved new sanctions targeting North Korea’s economy following the launch of a ballistic missile last month that Kim Jong Un’s regime said shows it can now target the entire continental U.S.\r\n\r\nA week after U.S. Secretary of State Rex Tillerson called out Russia and China for their support of Kim Jong Un’s regime, the 15-member Security Council passed its fourth resolution against Pyongyang in 13 months on Friday. The new restrictions are meant to slash North Korea’s imports of refined petroleum products, further restrict shipping and impose a 24-month deadline for expatriate North Korean workers to be sent home, up from a 12-month deadline in earlier drafts of the resolution.',3,'2017-12-22 15:41:47',NULL,NULL);

/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table reference
# ------------------------------------------------------------

DROP TABLE IF EXISTS `reference`;

CREATE TABLE `reference` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i_reference_user` (`user_id`),
  CONSTRAINT `f_reference_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `reference` WRITE;
/*!40000 ALTER TABLE `reference` DISABLE KEYS */;

INSERT INTO `reference` (`id`, `name`, `user_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'MSFT',1,'2017-12-23 20:36:44','2017-12-23 20:36:57',NULL),
	(2,'C',1,'2017-12-23 20:36:44','2017-12-23 20:36:57',NULL),
	(3,'APPL',1,'2017-12-23 20:36:44','2017-12-23 20:36:57',NULL);

/*!40000 ALTER TABLE `reference` ENABLE KEYS */;
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
  KEY `i_user_status` (`status_id`),
  KEY `i_email` (`email`),
  CONSTRAINT `f_user_status_id` FOREIGN KEY (`status_id`) REFERENCES `user_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `status_id`, `created_at`, `updated_at`, `deleted_at`)
VALUES
	(1,'go','navi2017','gonavi2017@gmail.com','$2a$10$g0Yeq4Wkk9F2ixoXvvVNIODf6MoJWqYX4atyID1hEcag3ScnwJRju',1,'2017-10-21 21:48:03',NULL,NULL),
	(3,'Kshitiz','Sharma','kshitizsharmav@gmail.com','$2a$10$29pv64W0jh5zshC2u6NdiO62pJUtq1CWlSuP.bKEBkDg4DwxzEtJu',1,'2017-12-22 15:39:55',NULL,NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
