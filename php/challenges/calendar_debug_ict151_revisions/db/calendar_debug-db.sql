-- --------------------------------------------------------
-- Hôte :                        127.0.0.1
-- Version du serveur:           8.0.20 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             11.0.0.5978
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

DROP DATABASE IF EXISTS `calendar`;
-- Listage de la structure de la base pour calendar
CREATE DATABASE IF NOT EXISTS `calendar` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `calendar`;

-- Listage de la structure de la table calendar. events
CREATE TABLE IF NOT EXISTS `events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  `user_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_events_users_idx` (`user_id`),
  CONSTRAINT `fk_events_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- Listage des données de la table calendar.events : ~7 rows (environ)
DELETE FROM `events`;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` (`id`, `title`, `date`, `user_id`) VALUES
	(1, 'Réunion révision exams 151', '2020-06-20 09:07:58', 1),
	(2, 'Réunion discussion débat', '2020-06-12 18:15:47', 1),
	(3, 'Conférence zoom', '2020-06-15 18:15:47', 2),
	(4, 'anni du chien', '2020-06-15 18:15:47', 1),
	(5, 'anni de papa', '2020-06-15 09:15:47', 2),
	(6, 'début des exams', '2020-06-25 18:15:47', 1),
	(7, 'début des vacances... chouette!', '2020-06-10 18:15:47', 1),
	(8, 'live à 15h', '2020-06-13 08:15:47', 2),
	(9, 'festival paleo ', '2020-06-11 18:15:47', 2),
	(10, 'mon anni !!!!', '2020-06-06 10:15:47', 1),
	(11, 'rdv médical lausanne', '2020-06-18 18:15:47', 1),
	(12, 'sortie entre potes à yverdon.', '2020-06-06 18:15:47', 1),
	(13, 'sortie à vélo pour la fete du vélo.', '2020-06-19 08:15:47', 1),
	(14, 'publication du document technique', '2020-06-18 18:15:47', 2),
	(15, 'départ de pierre en vacs', '2020-06-05 18:15:47', 2),
	(16, 'Congé !', '2020-06-29 16:15:47', 1),
	(17, 'fin exam matu', '2020-06-30 13:15:47', 2),
	(18, 'réunion zoom apéro', '2020-06-17 23:08:43', 1),
	(19, 'visite des gd parents', '2020-06-30 18:08:43', 2),
	(20, 'formation comment gérer son temps, à yverdon', '2020-06-12 18:08:43', 1),
	(21, 'rdv dentiste 15h', '2020-06-19 15:00:00', 1);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;

-- Listage de la structure de la table calendar. users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Listage des données de la table calendar.users : ~0 rows (environ)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`) VALUES
	(1, 'john', '$2y$10$0RSy3d.ISF2ukPcBPv2uYO12yRB8SMpqTmQb3VPzqvhJk79pwuzHC'),
	(2, 'alicia', '$2y$10$l/3VUxX5zK6CMVPNeZ0LxeHNLw9LHBjhbuuN4VnGXia5TK78yNHKG');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
