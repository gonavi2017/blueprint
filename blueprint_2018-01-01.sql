# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: blueprint
# Generation Time: 2018-01-03 10:47:47 +0000
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
	(2,2,'MarriageDetail','Marriage Detail',2,2,1,'2017-12-27 07:30:30','2018-01-02 22:27:03',NULL),
	(3,3,'LegalMarriage','Legal Marriage',2,3,1,'2017-12-27 07:30:30','2018-01-01 19:40:32',NULL),
	(4,4,'MarriageParty','Groom',2,4,1,'2017-12-27 07:30:30','2018-01-01 20:52:10',NULL),
	(5,5,'MarriageParty','Bride',2,4,1,'2017-12-27 07:30:30','2018-01-03 04:54:23',NULL),
	(6,6,'MarriageVenue','MarriageVenue',2,5,1,'2017-12-27 07:30:30','2018-01-03 04:54:30',NULL),
	(7,7,'MarriageVenue','Marriage Venue',2,5,1,'2017-12-27 07:30:30','2018-01-03 04:54:37',NULL),
	(8,8,'MarriageVenue','London',2,5,1,'2017-12-27 07:30:30','2018-01-03 04:54:47',NULL),
	(9,9,'MarriageVenue','Tokyo',2,5,1,'2017-12-27 07:30:30','2018-01-03 04:54:52',NULL),
	(10,10,'MarriageVenue','',2,5,1,'2017-12-27 07:30:30','2018-01-03 04:54:59',NULL),
	(11,11,'MarriageMenu','MarriageMenu',2,6,1,'2017-12-27 07:30:30','2018-01-03 04:55:05',NULL),
	(12,12,'MarriageMenu','Marriage Menu',2,6,1,'2017-12-27 07:30:30','2018-01-03 04:55:10',NULL),
	(13,13,'MarriageMenu','Veg',2,6,1,'2017-12-27 07:30:30','2018-01-03 04:55:15',NULL),
	(14,14,'MarriageMenu','NonVeg',2,6,1,'2017-12-27 07:30:30','2018-01-03 04:55:24',NULL),
	(15,15,'MarriageMenu','',2,6,1,'2017-12-27 07:30:30','2018-01-03 04:55:31',NULL),
	(16,16,'CreateRecord','Create Record',2,7,1,'2017-12-27 07:30:30','2018-01-03 04:55:39',NULL),
	(17,1,'BankName','Bank Name',1,1,1,'2017-12-27 07:30:30','2018-01-03 04:53:20',NULL),
	(18,2,'BankAccount','Bank Account',1,1,1,'2017-12-27 07:30:30','2018-01-03 04:53:25',NULL),
	(19,3,'BankAddress','Bank Address',1,1,1,'2017-12-27 07:30:30','2018-01-02 22:49:02',NULL),
	(20,4,'BankAccountType','Saving Account',1,4,1,'2017-12-27 07:30:30','2018-01-02 22:48:01',NULL),
	(21,5,'BankAccountType','Checking Account',1,4,1,'2017-12-27 07:30:30','2018-01-03 04:01:49',NULL),
	(22,6,'CustomerType','CustomerType',1,5,1,'2017-12-27 07:30:30','2018-01-03 04:02:02',NULL),
	(23,7,'CustomerType','Customer Type',1,5,1,'2017-12-27 07:30:30','2018-01-03 04:02:10',NULL),
	(24,8,'CustomerType','Retail',1,5,1,'2017-12-27 07:30:30','2018-01-03 04:02:15',NULL),
	(25,9,'CustomerType','Investment',1,5,1,'2017-12-27 07:30:30','2018-01-03 04:02:22',NULL),
	(26,10,'CustomerType','',1,5,1,'2017-12-27 07:30:30','2018-01-03 04:02:28',NULL),
	(27,11,'CardType','CardType',1,6,1,'2017-12-27 07:30:30','2018-01-03 04:05:45',NULL),
	(28,12,'CardType','Card Type',1,6,1,'2017-12-27 07:30:30','2018-01-03 04:04:36',NULL),
	(29,13,'CardType','Credit',1,6,1,'2017-12-27 07:30:30','2018-01-03 04:02:44',NULL),
	(30,14,'CardType','Debit',1,6,1,'2017-12-27 07:30:30','2018-01-03 04:02:49',NULL),
	(31,15,'CardType','',1,6,1,'2017-12-27 07:30:30','2018-01-03 04:02:55',NULL),
	(32,16,'KYC','KYC?',1,8,1,'2017-12-27 07:30:30','2018-01-03 05:02:09',NULL),
	(33,17,'KYC','KYC',1,5,1,'2017-12-27 07:30:30','2018-01-03 04:56:31',NULL),
	(34,18,'KYC','Yes',1,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:07',NULL),
	(35,19,'KYC','No',1,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:13',NULL),
	(36,20,'KYC','',1,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:20',NULL),
	(37,21,'CreateRecord','Create Record',1,7,1,'2017-12-27 07:30:30','2018-01-03 04:10:38',NULL),
	(38,1,'ChildName','Child Name',3,1,1,'2017-12-27 07:30:30','2018-01-03 04:53:20',NULL),
	(39,2,'ParentName','Parent Name',3,1,1,'2017-12-27 07:30:30','2018-01-03 05:20:36',NULL),
	(40,3,'BirthPlace','Birth Place',3,1,1,'2017-12-27 07:30:30','2018-01-03 05:24:25',NULL),
	(41,4,'BirthDay','Birth Day',3,10,1,'2017-12-27 07:30:30','2018-01-03 05:26:15',NULL),
	(42,5,'BirthTime','Birth Time',3,25,1,'2017-12-27 07:30:30','2018-01-03 05:26:36',NULL),
	(43,6,'GenderType','GenderType',3,5,1,'2017-12-27 07:30:30','2018-01-03 05:27:42',NULL),
	(44,7,'GenderType','Gender Type',3,5,1,'2017-12-27 07:30:30','2018-01-03 05:28:39',NULL),
	(45,8,'GenderType','Boy',3,5,1,'2017-12-27 07:30:30','2018-01-03 05:27:54',NULL),
	(46,9,'GenderType','Girl',3,5,1,'2017-12-27 07:30:30','2018-01-03 05:27:59',NULL),
	(47,10,'GenderType','Other',3,5,1,'2017-12-27 07:30:30','2018-01-03 05:28:03',NULL),
	(48,11,'GenderType','',3,5,1,'2017-12-27 07:30:30','2018-01-03 05:28:08',NULL),
	(49,12,'ParentDetails','ParentDetails',3,6,1,'2017-12-27 07:30:30','2018-01-03 05:29:18',NULL),
	(50,13,'ParentDetails','Parent Details',3,6,1,'2017-12-27 07:30:30','2018-01-03 05:29:30',NULL),
	(51,14,'ParentDetails','Mother',3,6,1,'2017-12-27 07:30:30','2018-01-03 05:29:36',NULL),
	(52,15,'ParentDetails','Father',3,6,1,'2017-12-27 07:30:30','2018-01-03 05:30:25',NULL),
	(53,16,'ParentDetails','',3,6,1,'2017-12-27 07:30:30','2018-01-03 05:30:05',NULL),
	(54,17,'CaesareanSection','Caesarean section?',3,8,1,'2017-12-27 07:30:30','2018-01-03 05:02:09',NULL),
	(55,18,'CaesareanSection','CaesareanSection',3,5,1,'2017-12-27 07:30:30','2018-01-03 04:56:31',NULL),
	(56,19,'CaesareanSection','Yes',3,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:07',NULL),
	(57,20,'CaesareanSection','No',3,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:13',NULL),
	(58,21,'CaesareanSection','',3,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:20',NULL),
	(59,22,'CreateRecord','Create Record',3,7,1,'2017-12-27 07:30:30','2018-01-03 04:10:38',NULL),
	(60,1,'ProperyName','Propery Name',4,1,1,'2017-12-27 07:30:30','2018-01-03 04:53:20',NULL),
	(61,2,'OwnerName','Owner Name',4,1,1,'2017-12-27 07:30:30','2018-01-03 05:20:36',NULL),
	(62,3,'ProperyAddress','Propery Address',4,1,1,'2017-12-27 07:30:30','2018-01-03 05:24:25',NULL),
	(63,4,'RegisterDate','Register Date',4,10,1,'2017-12-27 07:30:30','2018-01-03 05:26:15',NULL),
	(64,5,'RegisterOffice','Register Office',4,25,1,'2017-12-27 07:30:30','2018-01-03 05:26:36',NULL),
	(65,6,'ZoneType','ZoneType',4,5,1,'2017-12-27 07:30:30','2018-01-03 05:27:42',NULL),
	(66,7,'ZoneType','Zone Type',4,5,1,'2017-12-27 07:30:30','2018-01-03 05:28:39',NULL),
	(67,8,'ZoneType','Commercial',4,5,1,'2017-12-27 07:30:30','2018-01-03 05:27:54',NULL),
	(68,9,'ZoneType','Personal',4,5,1,'2017-12-27 07:30:30','2018-01-03 05:27:59',NULL),
	(69,10,'ZoneType','Other',4,5,1,'2017-12-27 07:30:30','2018-01-03 05:28:03',NULL),
	(70,11,'ZoneType','',4,5,1,'2017-12-27 07:30:30','2018-01-03 05:28:08',NULL),
	(71,12,'PropertyOwnership','PropertyOwnership',4,6,1,'2017-12-27 07:30:30','2018-01-03 05:29:18',NULL),
	(72,13,'PropertyOwnership','Property Ownership',4,6,1,'2017-12-27 07:30:30','2018-01-03 05:29:30',NULL),
	(73,14,'PropertyOwnership','Owner',4,6,1,'2017-12-27 07:30:30','2018-01-03 05:29:36',NULL),
	(74,15,'PropertyOwnership','Bank',4,6,1,'2017-12-27 07:30:30','2018-01-03 05:30:25',NULL),
	(75,16,'PropertyOwnership','',4,6,1,'2017-12-27 07:30:30','2018-01-03 05:30:05',NULL),
	(76,17,'PropertyType','Property Type?',4,8,1,'2017-12-27 07:30:30','2018-01-03 05:02:09',NULL),
	(77,18,'PropertyType','PropertyType',4,5,1,'2017-12-27 07:30:30','2018-01-03 04:56:31',NULL),
	(78,19,'PropertyType','Land',4,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:07',NULL),
	(79,20,'PropertyType','Plot',4,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:13',NULL),
	(80,21,'PropertyType','',4,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:20',NULL),
	(81,22,'CreateRecord','Create Record',4,7,1,'2017-12-27 07:30:30','2018-01-03 04:10:38',NULL),
	(82,1,'AssetName','Asset Name',5,1,1,'2017-12-27 07:30:30','2018-01-03 04:53:20',NULL),
	(83,2,'AssetName','Asset Name',5,1,1,'2017-12-27 07:30:30','2018-01-03 05:20:36',NULL),
	(84,3,'AssetAddress','Asset Address',5,1,1,'2017-12-27 07:30:30','2018-01-03 05:24:25',NULL),
	(85,4,'PurchasedDate','Purchased Date',5,10,1,'2017-12-27 07:30:30','2018-01-03 05:26:15',NULL),
	(86,5,'Purchased From','Purchased From',5,25,1,'2017-12-27 07:30:30','2018-01-03 05:26:36',NULL),
	(87,6,'PurchasedType','PurchasedType',5,5,1,'2017-12-27 07:30:30','2018-01-03 05:27:42',NULL),
	(88,7,'PurchasedType','Purchased Type',5,5,1,'2017-12-27 07:30:30','2018-01-03 05:28:39',NULL),
	(89,8,'PurchasedType','Cash',5,5,1,'2017-12-27 07:30:30','2018-01-03 05:27:54',NULL),
	(90,9,'PurchasedType','Loan',5,5,1,'2017-12-27 07:30:30','2018-01-03 05:27:59',NULL),
	(91,10,'PurchasedType','Other',5,5,1,'2017-12-27 07:30:30','2018-01-03 05:28:03',NULL),
	(92,11,'PurchasedType','',5,5,1,'2017-12-27 07:30:30','2018-01-03 05:28:08',NULL),
	(93,12,'AssetOwnership','AssetOwnership',5,6,1,'2017-12-27 07:30:30','2018-01-03 05:46:56',NULL),
	(94,13,'AssetOwnership','Asset Ownership',5,6,1,'2017-12-27 07:30:30','2018-01-03 05:29:30',NULL),
	(95,14,'AssetOwnership','Owner',5,6,1,'2017-12-27 07:30:30','2018-01-03 05:29:36',NULL),
	(96,15,'AssetOwnership','Bank',5,6,1,'2017-12-27 07:30:30','2018-01-03 05:30:25',NULL),
	(97,16,'AssetOwnership','',5,6,1,'2017-12-27 07:30:30','2018-01-03 05:30:05',NULL),
	(98,17,'AssetType','Asset Type?',5,8,1,'2017-12-27 07:30:30','2018-01-03 05:02:09',NULL),
	(99,18,'AssetType','AssetType',5,5,1,'2017-12-27 07:30:30','2018-01-03 04:56:31',NULL),
	(100,19,'AssetType','Computer',5,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:07',NULL),
	(101,20,'AssetType','Jewelry',5,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:13',NULL),
	(102,21,'AssetType','',5,5,1,'2017-12-27 07:30:30','2018-01-03 04:11:20',NULL),
	(103,22,'CreateRecord','Create Record',5,7,1,'2017-12-27 07:30:30','2018-01-03 04:10:38',NULL);

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
	(7,'SUBMIT','',1,'2018-01-01 21:06:09','2018-01-01 21:11:44',NULL),
	(8,'LABEL','',1,'2018-01-01 21:06:09','2018-01-01 21:11:44',NULL),
	(9,'COLOR','',1,'2018-01-01 21:06:09','2018-01-03 04:17:37',NULL),
	(10,'DATE','',1,'2018-01-01 21:06:09','2018-01-03 04:17:47',NULL),
	(11,'DATETIMELOCAL','',1,'2018-01-01 21:06:09','2018-01-03 04:18:14',NULL),
	(12,'EMAIL','',1,'2018-01-01 21:06:09','2018-01-03 04:18:32',NULL),
	(13,'FILE','',1,'2018-01-01 21:06:09','2018-01-03 04:18:40',NULL),
	(14,'MONTH','',1,'2018-01-01 21:06:09','2018-01-03 04:18:53',NULL),
	(15,'NUMBER','',1,'2018-01-01 21:06:09','2018-01-03 04:19:07',NULL),
	(16,'RANGE','',1,'2018-01-01 21:06:09','2018-01-03 04:19:23',NULL),
	(17,'SEARCH','',1,'2018-01-01 21:06:09','2018-01-03 04:19:23',NULL),
	(18,'TEL','',1,'2018-01-01 21:06:09','2018-01-03 04:19:23',NULL),
	(19,'URL','',1,'2018-01-01 21:06:09','2018-01-03 04:19:23',NULL),
	(20,'WEEK','',1,'2018-01-01 21:06:09','2018-01-03 04:19:23',NULL),
	(21,'RESET','',1,'2018-01-01 21:06:09','2018-01-03 04:19:23',NULL),
	(22,'HIDDEN','',1,'2018-01-01 21:06:09','2018-01-03 04:19:23',NULL),
	(23,'BUTTON','',1,'2018-01-01 21:06:09','2018-01-03 04:19:23',NULL),
	(24,'IMAGE','',1,'2018-01-01 21:06:09','2018-01-03 04:19:23',NULL),
	(25,'TIME','',1,'2018-01-01 21:06:09','2018-01-03 04:19:23',NULL);

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
	(2,'Marriage','These',1,'2017-12-25 20:35:16','2017-12-27 17:48:59',NULL),
	(3,'BirthCertificate','These',1,'2017-12-25 20:35:16','2017-12-27 17:48:59',NULL),
	(4,'Property','These',1,'2017-12-25 20:35:16','2017-12-27 17:48:59',NULL),
	(5,'Asset','These',1,'2017-12-25 20:35:16','2017-12-27 17:48:59',NULL);

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
