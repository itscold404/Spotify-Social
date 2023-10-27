-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: spotifySocial
-- ------------------------------------------------------
-- Server version	8.0.31-google

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
-- Current Database: `spotifySocial`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `spotifySocial` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `spotifySocial`;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album` (
  `album_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `popularity` int NOT NULL DEFAULT '0',
  `album_type` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total_tracks` int NOT NULL DEFAULT '0',
  `release_date` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO album (album_id, title, popularity, album_type, total_tracks, release_date)
VALUES
	('TS123456789ABCDEFGHIJ', 'reputation', 8000, 'Studio', 12, '2017-11-10 00:00:00'), 
	('BTSALBUM45678912345', 'Renaissance', 7500, 'Studio', 10, '2022-07-29 18:06:20'), 
	('NEWJEANS567891234567', 'Map of the Soul: 7', 9000, 'Studio', 15, '2020-02-21 01:03:50'), 
	('KENSHI1234567890ALBM', '21', 7200, 'Studio', 14, '2011-01-24 09:00:00'), 
	('TAYLORSWIFTALBUM5678', '÷ (Deluxe)', 8500, 'Studio', 9, '2017-03-03 10:20:30'), 
	('BTS45678912345ALBUM', 'thank u, next', 7600, 'Studio', 11, '2019-02-08 06:44:55'), 
	('JEANSNEWALBUM567891', 'Illuminate (Deluxe)', 9400, 'Studio', 8, '2016-09-23 00:08:10'), 
	('KENSHI567890ALBUM123', 'When We All Fall Asleep, Where Do We Go?', 9200, 'Studio', 13, '2019-03-29 08:07:09'), 
	('SWIFTTAYLORALBUM123', 'Next Episode', 7800, 'Studio', 10, '2020-11-16 00:00:00'), 
	('BTSALBUM1234567890', 'Kid Krow', 8700, 'Studio', 15, '2020-03-20 16:26:00'), 
	('NEWALBUM4567890JEANS', 'beerbongs & bentleys', 8200, 'Studio', 12, '2018-04-27 12:11:05'), 
	('KENSHIALBUM5678901', 'k bye for now (swt live)', 6800, 'Live', 10, '2019-12-23 00:00:00'), 
	('TAYLORALBUM12345678', 'Speak Now World Tour Live', 9500, 'Live', 14, '2011-11-21 00:00:00'), 
	('BTSALBUM45678901', 'Teenage Dream', 8900, 'Studio', 9, '2010-08-24 10:03:02'),
	('JEANSNEW45678ALBUM', 'Purpose (Deluxe)', 8600, 'Studio', 11, '2015-11-13 03:19:56'), 
	('KENSHI12345ALBUM67', 'Endless Summer Vacation', 7200, 'Studio', 8, '2023-03-10 17:28:08'), 
	('SWIFTALBUM56789012', 'Recovery (Deluxe Edition)', 9000, 'Studio', 13, '2010-06-18 23:34:10'), 
	('BTSALBUM56789123', 'Good Girl Gone Bad: Reloaded', 7800, 'Studio', 12, '2007-05-31 00:00:00'),
	('JEANSNEW40121ALBUM', 'The Joshua Tree (Super Deluxe)', 8500, 'Studio', 14, '1987-03-09 09:18:45'), 
	('KENSHI567890ALBUM', 'After Hours (Deluxe)', 7600, 'Studio', 11, '2020-03-20 14:20:13');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album_by`
--

DROP TABLE IF EXISTS `album_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_by` (
  `album_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `artist_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`album_id`,`artist_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `album_by_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`),
  CONSTRAINT `album_by_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_by`
--

LOCK TABLES `album_by` WRITE;
/*!40000 ALTER TABLE `album_by` DISABLE KEYS */;
INSERT INTO album_by (album_id, artist_id)
VALUES
	('TS123456789ABCDEFGHIJ', 'A1b2C3d4E5f6G7h8I9j0'), 
	('BTSALBUM45678912345', 'K1L2M3N4O5P6Q7R8S9T0'), 
	('NEWJEANS567891234567', 'U1V2W3X4Y5Z6a7b8c9d0'), 
	('KENSHI1234567890ALBM', 'D1E2F3G4H5I6J7K8L9M0'), 
	('TAYLORSWIFTALBUM5678', 'N1O2P3Q4R5S6T7U8V9W0'), 
	('BTS45678912345ALBUM', 'X1Y2Z3A4B5C6D7E8F9G0'), 
	('JEANSNEWALBUM567891', 'H1I2J3K4L5M6N7O8P9Q0'), 
	('KENSHI567890ALBUM123', 'R1S2T3U4V5W6X7Y8Z9A0'), 
	('SWIFTTAYLORALBUM123', 'B1C2D3E4F5G6H7I8J9K0'), 
	('BTSALBUM1234567890', 'E1F2G3H4I5J6K7L8M9N0'), 
	('NEWALBUM4567890JEANS', 'L1M2N3O4P5Q6R7S8T9U0'), 
	('KENSHIALBUM5678901', 'X1Y2Z3A4B5C6D7E8F9G0'), 
	('TAYLORALBUM12345678', 'A1b2C3d4E5f6G7h8I9j0'), 
	('BTSALBUM45678901', 'Q1W2E3R4T5Y6U7I8O9'), 
	('JEANSNEW45678ALBUM', 'Z1X2C3V4B5N6M7A8S9'), 
	('KENSHI12345ALBUM67', 'F1D2S3A4J5K6L7F8J9'), 
	('SWIFTALBUM56789012', 'B1E2T3S4Y5E6J7S8D9'), 
	('BTSALBUM56789123', 'R1O2N3E4D5I6R7N8K9'), 
	('JEANSNEW40121ALBUM', 'A1R2T3I4S5T6G7A8R9'), 
	('KENSHI567890ALBUM', 'L1O2V3E4S5H6A7C8M9');
/*!40000 ALTER TABLE `album_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `album_genre`
--

DROP TABLE IF EXISTS `album_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_genre` (
  `album_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `genre` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`album_id`,`genre`),
  CONSTRAINT `album_genre_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_genre`
--

LOCK TABLES `album_genre` WRITE;
/*!40000 ALTER TABLE `album_genre` DISABLE KEYS */;
INSERT INTO album_genre (album_id, genre)
VALUES
	('TS123456789ABCDEFGHIJ', 'Electropop'), 
	('BTSALBUM45678912345', 'Rap'), 
	('NEWJEANS567891234567', 'K-Pop'), 
	('KENSHI1234567890ALBM', 'Pop'), 
	('TAYLORSWIFTALBUM5678', 'Country'), 
	('BTS45678912345ALBUM', 'K-Pop'), 
	('JEANSNEWALBUM567891', 'Pop'), 
	('KENSHI567890ALBUM123', 'Dance'), 
	('SWIFTTAYLORALBUM123', 'Alternative'), 
	('BTSALBUM1234567890', 'Dance'), 
	('NEWALBUM4567890JEANS', 'Rap'), 
	('KENSHIALBUM5678901', 'Alternative'), 
	('TAYLORALBUM12345678', 'Pop'), 
	('BTSALBUM45678901', 'K-Pop'), 
	('JEANSNEW45678ALBUM', 'Hip-Hop'), 
	('KENSHI12345ALBUM67', 'Rock'), 
	('SWIFTALBUM56789012', 'Alternative'), 
	('BTSALBUM56789123', 'Rap'), 
	('JEANSNEW40121ALBUM', 'K-Pop'),
	('KENSHI567890ALBUM', 'Pop');
/*!40000 ALTER TABLE `album_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `artist_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `artist_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `popularity` int DEFAULT '0',
  `follower_count` int DEFAULT '0',
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO artist (artist_id, name, popularity, follower_count)
VALUES
	('A1b2C3d4E5f6G7h8I9j0', 'Taylor Swift', 10, 90026456),
	('K1L2M3N4O5P6Q7R8S9T0', 'Beyoncé', 20, 36075322),
	('U1V2W3X4Y5Z6a7b8c9d0', 'BTS', 50, 70356205),
	('D1E2F3G4H5I6J7K8L9M0', 'Adele', 12, 52004063),
	('N1O2P3Q4R5S6T7U8V9W0', 'Ed Sheeran', 86, 114875034),
	('X1Y2Z3A4B5C6D7E8F9G0', 'Ariana Grande', 92, 94233961),
	('H1I2J3K4L5M6N7O8P9Q0', 'Shawn Mendes', 72, 42521163),
	('R1S2T3U4V5W6X7Y8Z9A0', 'Billie Eilish', 54, 87878184),
	('B1C2D3E4F5G6H7I8J9K0', 'AKMU', 88, 1457519),
	('E1F2G3H4I5J6K7L8M9N0', 'Conan Gray', 96, 8518108),
	('L1M2N3O4P5Q6R7S8T9U0', 'Post Malone', 93, 42396464),
	('G1H2I3J4K5L6M7N8O9P0', 'Penomeco', 68, 356958),
	('P1Q2R3S4T5U6V7W8X9Y0', 'Coldplay', 77, 47637325),
	('Q1W2E3R4T5Y6U7I8O9', 'Katy Perry', 78, 29903757),
	('Z1X2C3V4B5N6M7A8S9', 'Justin Bieber', 100, 74256151),
	('F1D2S3A4J5K6L7F8J9', 'Miley Cyrus', 76, 22394226),
	('B1E2T3S4Y5E6J7S8D9', 'Eminem', 94, 77596640),
	('R1O2N3E4D5I6R7N8K9', 'Rihanna', 83, 58044161),
	('A1R2T3I4S5T6G7A8R9', 'U2', 33, 11614096),
	('L1O2V3E4S5H6A7C8M9', 'The Weeknd', 89, 73418832),
	('S1T2I3N4G5K6U7I8L9', 'Alicia Keys', 82, 11110247),
	('N1O2L3T4O5Y6I7T8S9', 'Norah Jones', 69, 3026525),
	('C1H2R3I4S5B6R7O8W9', 'New Jeans', 85, 5811406);
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist_genre`
--

DROP TABLE IF EXISTS `artist_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_genre` (
  `artist_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `genre` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`artist_id`,`genre`),
  CONSTRAINT `artist_genre_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_genre`
--

LOCK TABLES `artist_genre` WRITE;
/*!40000 ALTER TABLE `artist_genre` DISABLE KEYS */;
INSERT INTO artist_genre (artist_id, genre)
VALUES
	('A1b2C3d4E5f6G7h8I9j0', 'Pop'),
	('K1L2M3N4O5P6Q7R8S9T0', 'R&B'),
	('U1V2W3X4Y5Z6a7b8c9d0', 'K-Pop'),
	('D1E2F3G4H5I6J7K8L9M0', 'Pop Soul'),
	('N1O2P3Q4R5S6T7U8V9W0', 'Ed Sheeran'),
	('X1Y2Z3A4B5C6D7E8F9G0', 'Pop'),
	('H1I2J3K4L5M6N7O8P9Q0', 'Pop'),
	('R1S2T3U4V5W6X7Y8Z9A0', 'Pop'),
	('B1C2D3E4F5G6H7I8J9K0', 'K-Pop'),
	('E1F2G3H4I5J6K7L8M9N0', 'Pop'),
	('L1M2N3O4P5Q6R7S8T9U0', 'Rap'),
	('G1H2I3J4K5L6M7N8O9P0', 'K-Pop'),
	('P1Q2R3S4T5U6V7W8X9Y0', 'Alternative Rock'),
	('Q1W2E3R4T5Y6U7I8O9', 'Pop'),
	('Z1X2C3V4B5N6M7A8S9', 'Pop'),
	('F1D2S3A4J5K6L7F8J9', 'Pop'),
	('B1E2T3S4Y5E6J7S8D9', 'Rap'), 
	('R1O2N3E4D5I6R7N8K9', 'Reggae'),
	('A1R2T3I4S5T6G7A8R9', 'Rock'), 
	('L1O2V3E4S5H6A7C8M9', 'R&B'),
	('S1T2I3N4G5K6U7I8L9', 'R&B'),
	('N1O2L3T4O5Y6I7T8S9', 'Pop'),
	('C1H2R3I4S5B6R7O8W9', 'K-Pop');
/*!40000 ALTER TABLE `artist_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$390000$EdIStnlFt2dBX2Qte2KWDl$UFtLNHALfiPea5z+DoTBx6Gx4UBbvQ2r/U8OjpiD8GE=',NULL,1,'superuser','','','email@email.com',1,1,'2023-10-24 19:13:24.488203');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-10-24 19:06:54.448235'),(2,'auth','0001_initial','2023-10-24 19:06:56.400340'),(3,'admin','0001_initial','2023-10-24 19:06:56.895774'),(4,'admin','0002_logentry_remove_auto_add','2023-10-24 19:06:56.987188'),(5,'admin','0003_logentry_add_action_flag_choices','2023-10-24 19:06:57.080248'),(6,'contenttypes','0002_remove_content_type_name','2023-10-24 19:06:57.484361'),(7,'auth','0002_alter_permission_name_max_length','2023-10-24 19:06:57.700271'),(8,'auth','0003_alter_user_email_max_length','2023-10-24 19:06:57.854533'),(9,'auth','0004_alter_user_username_opts','2023-10-24 19:06:57.946738'),(10,'auth','0005_alter_user_last_login_null','2023-10-24 19:06:58.147212'),(11,'auth','0006_require_contenttypes_0002','2023-10-24 19:06:58.242813'),(12,'auth','0007_alter_validators_add_error_messages','2023-10-24 19:06:58.336772'),(13,'auth','0008_alter_user_username_max_length','2023-10-24 19:06:58.556415'),(14,'auth','0009_alter_user_last_name_max_length','2023-10-24 19:06:58.770830'),(15,'auth','0010_alter_group_name_max_length','2023-10-24 19:06:58.923267'),(16,'auth','0011_update_proxy_permissions','2023-10-24 19:06:59.141493'),(17,'auth','0012_alter_user_first_name_max_length','2023-10-24 19:06:59.372424'),(18,'sessions','0001_initial','2023-10-24 19:06:59.653051');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows_artist`
--

DROP TABLE IF EXISTS `follows_artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows_artist` (
  `user_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `artist_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`user_name`,`artist_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `follows_artist_ibfk_1` FOREIGN KEY (`user_name`) REFERENCES `user_profile` (`user_name`),
  CONSTRAINT `follows_artist_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows_artist`
--

LOCK TABLES `follows_artist` WRITE;
/*!40000 ALTER TABLE `follows_artist` DISABLE KEYS */;
INSERT INTO follows_artist (user_name, artist_id)
Values
	('12345', 'A1b2C3d4E5f6G7h8I9j0'),
	('67890', 'A1b2C3d4E5f6G7h8I9j0'),
	('11121','R1O2N3E4D5I6R7N8K9'),
	('13141', 'N1O2P3Q4R5S6T7U8V9W0'),
	('15161', 'F1D2S3A4J5K6L7F8J9'),
	('15161', 'E1F2G3H4I5J6K7L8M9N0'),
	('15161', 'L1O2V3E4S5H6A7C8M9');
/*!40000 ALTER TABLE `follows_artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follows_profile`
--

DROP TABLE IF EXISTS `follows_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows_profile` (
  `user_name_follower` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_name_following` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`user_name_follower`,`user_name_following`),
  KEY `user_name_following` (`user_name_following`),
  CONSTRAINT `follows_profile_ibfk_1` FOREIGN KEY (`user_name_follower`) REFERENCES `user_profile` (`user_name`),
  CONSTRAINT `follows_profile_ibfk_2` FOREIGN KEY (`user_name_following`) REFERENCES `user_profile` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows_profile`
--

LOCK TABLES `follows_profile` WRITE;
/*!40000 ALTER TABLE `follows_profile` DISABLE KEYS */;
INSERT INTO follows_profile (user_name_follower, user_name_following)
VALUES 
	('12345', '67890'), 
	('12345', '11121'),
	('67890', '15161'),
	('11121', '13141'),
	('13141', '15161'), 
	('15161', '67890');
/*!40000 ALTER TABLE `follows_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `user_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `content` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`user_name`,`date_time`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`user_name`) REFERENCES `user_profile` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO post (user_name, date_time, content) 
VALUES 
	('12345', '2023-10-26 13:00:00', 'just listened to "bohemian rhapsody" again. timeless classic!'),
	('67890', '2023-10-26 13:05:25', 'anyone else love the beat drop in "on the floor"?’'), ('12345', '2023-10-26 13:10:10', 'been on a jazz spree. coltrane is pure magic.'), 
	('13141', '2023-10-26 13:15:15', 'recommendations for indie rock bands? need new tunes!'), ('67890', '2023-10-26 13:20:20', 'the harmonies in "hallelujah" give me chills every time.'), ('13141', '2023-10-26 13:25:25', 'i cannot get the chorus of "shape of you" out of my head! #catchy'),
	('67890', '2023-10-26 13:30:30', 'just discovered "fleetwood mac". why did i wait so long?!'), ('13141', '2023-10-26 13:35:35', 'the lyrics of "imagine" by john lennon always make me ponder.'),
	('67890', '2023-10-26 13:40:40', 'on a reggae journey. bob marley vibes all day long.'), ('67890', '2023-10-26 13:45:45', 'there is something hauntingly beautiful about "sound of silence" by simon & garfunkel.');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_song_chart`
--

DROP TABLE IF EXISTS `school_song_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_song_chart` (
  `school_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `ranking` int NOT NULL,
  `song_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`school_name`,`ranking`),
  KEY `ranking_key` (`ranking`),
  KEY `school_song_chart_ibfk_1` (`song_id`),
  CONSTRAINT `school_song_chart_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_song_chart`
--

LOCK TABLES `school_song_chart` WRITE;
/*!40000 ALTER TABLE `school_song_chart` DISABLE KEYS */;
INSERT INTO school_song_chart (school_name, ranking, song_id)
VALUES
	('engineering', 1, '11dFghVXANMlKmJXsNCbNl003'),
	('engineering', 2, '11dFghVXANMlKmJXsNCbNl007'),
	('engineering', 3, '11dFghVXANMlKmJXsNCbNl015'), 
	('engineering', 4, '11dFghVXANMlKmJXsNCbNl013'), 
	('engineering', 5, '11dFghVXANMlKmJXsNCbNl005');
/*!40000 ALTER TABLE `school_song_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song`
--

DROP TABLE IF EXISTS `song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song` (
  `song_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `duration_ms` int DEFAULT '0',
  `song_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `popularity` int DEFAULT '0',
  PRIMARY KEY (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT INTO song (song_id, duration_ms, name, popularity)
VALUES
    ('11dFghVXANMlKmJXsNCbNl001', 228500, 'I Did Something Bad', 100),
    ('11dFghVXANMlKmJXsNCbNl002', 205800, 'Single Ladies (Put a Ring on It)', 90),
    ('11dFghVXANMlKmJXsNCbNl003', 219700, 'Dynamite', 85),
    ('11dFghVXANMlKmJXsNCbNl004', 212400, 'Someone Like You', 80),
    ('11dFghVXANMlKmJXsNCbNl005', 198200, 'Shape of You', 95),
    ('11dFghVXANMlKmJXsNCbNl006', 226100, '7rings', 88),
    ('11dFghVXANMlKmJXsNCbNl007', 207500, 'Stitches', 75),
    ('11dFghVXANMlKmJXsNCbNl008', 214800, 'bad guy', 78),
    ('11dFghVXANMlKmJXsNCbNl009', 197600, 'Nakka (feat. IU)', 92),
    ('11dFghVXANMlKmJXsNCbNl010', 222300, 'Heather', 89),
    ('11dFghVXANMlKmJXsNCbNl011', 218700, 'rockstar (feat. 21 Savage)', 82),
    ('11dFghVXANMlKmJXsNCbNl012', 211900, 'Bolo (feat. YDG)', 79),
    ('11dFghVXANMlKmJXsNCbNl013', 206500, 'My Universe', 97),
    ('11dFghVXANMlKmJXsNCbNl014', 199300, 'Dark Horse', 91),
    ('11dFghVXANMlKmJXsNCbNl015', 223400, 'Sorry', 84);
/*!40000 ALTER TABLE `song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song_by`
--

DROP TABLE IF EXISTS `song_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song_by` (
  `song_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `artist_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`song_id`,`artist_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `song_by_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`),
  CONSTRAINT `song_by_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song_by`
--

LOCK TABLES `song_by` WRITE;
/*!40000 ALTER TABLE `song_by` DISABLE KEYS */;
INSERT INTO song_by (song_id, artist_id)
VALUES
	('11dFghVXANMlKmJXsNCbNl001', 'A1b2C3d4E5f6G7h8I9j0'),
	('11dFghVXANMlKmJXsNCbNl002', 'K1L2M3N4O5P6Q7R8S9T0'),
	('11dFghVXANMlKmJXsNCbNl003', 'U1V2W3X4Y5Z6a7b8c9d0'),
	('11dFghVXANMlKmJXsNCbNl004', 'D1E2F3G4H5I6J7K8L9M0'),
	('11dFghVXANMlKmJXsNCbNl005', 'N1O2P3Q4R5S6T7U8V9W0'),
	('11dFghVXANMlKmJXsNCbNl006', 'X1Y2Z3A4B5C6D7E8F9G0'),
	('11dFghVXANMlKmJXsNCbNl007', 'H1I2J3K4L5M6N7O8P9Q0'),
	('11dFghVXANMlKmJXsNCbNl008', 'R1S2T3U4V5W6X7Y8Z9A0'),
	('11dFghVXANMlKmJXsNCbNl009', 'B1C2D3E4F5G6H7I8J9K0'),
	('11dFghVXANMlKmJXsNCbNl010', 'E1F2G3H4I5J6K7L8M9N0'),
	('11dFghVXANMlKmJXsNCbNl011', 'L1M2N3O4P5Q6R7S8T9U0'),
	('11dFghVXANMlKmJXsNCbNl012', 'G1H2I3J4K5L6M7N8O9P0'),
	('11dFghVXANMlKmJXsNCbNl013', 'P1Q2R3S4T5U6V7W8X9Y0'),
	('11dFghVXANMlKmJXsNCbNl014', 'Q1W2E3R4T5Y6U7I8O9'),
	('11dFghVXANMlKmJXsNCbNl015', 'Z1X2C3V4B5N6M7A8S9');
/*!40000 ALTER TABLE `song_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upvote_album`
--

DROP TABLE IF EXISTS `upvote_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upvote_album` (
  `user_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `album_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_name`,`album_id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `upvote_album_ibfk_1` FOREIGN KEY (`user_name`) REFERENCES `user_profile` (`user_name`),
  CONSTRAINT `upvote_album_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `album` (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upvote_album`
--

LOCK TABLES `upvote_album` WRITE;
/*!40000 ALTER TABLE `upvote_album` DISABLE KEYS */;
INSERT INTO upvote_album (user_name, album_id, date_time)
VALUES 
	('12345', 'TS123456789ABCDEFGHIJ', '2023-10-26 13:00:00'),
	('67890', 'BTSALBUM45678912345', '2023-10-26 13:10:00'),
	('11121', 'TAYLORSWIFTALBUM5678', '2023-10-26 13:20:00'), 
	('12345', 'BTS45678912345ALBUM', '2023-10-26 13:30:00'), 
	('67890', 'SWIFTTAYLORALBUM123', '2023-10-26 13:40:00'), 
	('11121', 'BTSALBUM1234567890', '2023-10-26 13:50:00'),
	('12345', 'TAYLORSWIFTALBUM5678', '2023-10-26 14:00:00'),
	('67890', 'TS123456789ABCDEFGHIJ', '2023-10-26 14:10:00'),
	('11121', 'BTS45678912345ALBUM', '2023-10-26 14:20:00'),
	('12345', 'BTSALBUM45678912345', '2023-10-26 14:30:00');
/*!40000 ALTER TABLE `upvote_album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upvote_post`
--

DROP TABLE IF EXISTS `upvote_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upvote_post` (
  `upvoter` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `receiver` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`upvoter`,`receiver`,`date_time`),
  KEY `receiver` (`receiver`,`date_time`),
  CONSTRAINT `upvote_post_ibfk_1` FOREIGN KEY (`upvoter`) REFERENCES `user_profile` (`user_name`),
  CONSTRAINT `upvote_post_ibfk_2` FOREIGN KEY (`receiver`, `date_time`) REFERENCES `post` (`user_name`, `date_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upvote_post`
--

LOCK TABLES `upvote_post` WRITE;
/*!40000 ALTER TABLE `upvote_post` DISABLE KEYS */;
INSERT INTO upvote_post (upvoter, receiver, date_time)
VALUES
	('67890', '12345', '2023-10-26 13:00:00'),   
	('13141', '67890', '2023-10-26 13:05:25'), 
	('11121', '12345', '2023-10-26 13:10:10'),
	('12345', '13141', '2023-10-26 13:15:15'), 
	('11121', '67890', '2023-10-26 13:20:20'),
	('15161', '13141', '2023-10-26 13:25:25'),
	('12345', '67890', '2023-10-26 13:30:30'),
	('11121', '12345', '2023-10-26 13:00:00'),
	('15161', '12345', '2023-10-26 13:00:00');
/*!40000 ALTER TABLE `upvote_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upvote_song`
--

DROP TABLE IF EXISTS `upvote_song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upvote_song` (
  `user_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `song_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_name`,`song_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `upvote_song_ibfk_1` FOREIGN KEY (`user_name`) REFERENCES `user_profile` (`user_name`),
  CONSTRAINT `upvote_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upvote_song`
--

LOCK TABLES `upvote_song` WRITE;
/*!40000 ALTER TABLE `upvote_song` DISABLE KEYS */;
INSERT INTO upvote_song (user_name, song_id, date_time)
VALUES
	('12345', '11dFghVXANMlKmJXsNCbNl007', '2023-10-26 10:10:00'), 
	('13141', '11dFghVXANMlKmJXsNCbNl009', '2023-10-26 10:20:00'),
	('13141', '11dFghVXANMlKmJXsNCbNl012', '2023-10-26 11:12:00'), 
	('12345', '11dFghVXANMlKmJXsNCbNl015', '2023-10-26 11:26:00'), 
	('11121', '11dFghVXANMlKmJXsNCbNl009', '2023-10-26 11:32:00'),
	('11121', '11dFghVXANMlKmJXsNCbNl006', '2023-10-26 11:42:00'),
	('67890', '11dFghVXANMlKmJXsNCbNl006', '2023-10-26 11:48:00'),
	('67890', '11dFghVXANMlKmJXsNCbNl011', '2023-10-26 11:53:00'),
	('67890', '11dFghVXANMlKmJXsNCbNl003', '2023-10-26 12:08:00'),
	('67890', '11dFghVXANMlKmJXsNCbNl009', '2023-10-26 12:28:00'),
	('12345', '11dFghVXANMlKmJXsNCbNl002', '2023-10-26 12:40:00'),
	('12345', '11dFghVXANMlKmJXsNCbNl012', '2023-10-26 12:46:00');
/*!40000 ALTER TABLE `upvote_song` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login`
--

DROP TABLE IF EXISTS `user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login` (
  `user_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login`
--

LOCK TABLES `user_login` WRITE;
/*!40000 ALTER TABLE `user_login` DISABLE KEYS */;
INSERT INTO user_login (user_name, password)
VALUES
	('12345', 'passwrd'),
	('67890','antoherpsswrd'),
	('11121', 'goodpassword'),
	('13141', 'anothergoodpasswrd'),
	('15161', '123');
/*!40000 ALTER TABLE `user_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profile` (
  `user_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `number_of_posts` int DEFAULT '0',
  `school` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `area_of_study` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `computing_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bio` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;
INSERT INTO user_profile (user_name, number_of_posts, school, area_of_study, computing_id, bio, full_name)
VALUES
	('11121', 7, 'UVA', 'Biology', 'aw11121', NULL, 'arnold'),
	('12345', 5, 'UVA', 'Computer Science', 'jd12345', NULL, 'bob'),
	('13141', 10, 'UVA', 'Mathematics', 'bb13141', NULL, 'sally'),
	('15161', 3, 'UVA', 'Chemical Engineering', 'cc15161', NULL, 'kelly'),
	('67890', 12, 'UVA', 'Mechanical Engineering', 'js67890', NULL, 'billy');
/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-27  3:09:19
