-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 23 mars 2022 à 13:32
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `cycle_v3`
--

-- --------------------------------------------------------

--
-- Structure de la table `piece`
--

DROP TABLE IF EXISTS `piece`;
CREATE TABLE IF NOT EXISTS `piece` (
  `REFERENCE_PIECE` int(11) NOT NULL,
  `REFERENCE_COMMANDE` int(11) NOT NULL,
  `NUMERO_LIGNE_COMMANDE` int(11) NOT NULL,
  `REFERENCE_TYPE_PIECE` varchar(10) NOT NULL,
  PRIMARY KEY (`REFERENCE_PIECE`),
  KEY `APPARTENIR_IDX` (`REFERENCE_COMMANDE`,`NUMERO_LIGNE_COMMANDE`),
  KEY `CARACTERISER_IDX` (`REFERENCE_TYPE_PIECE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `piece`
--

INSERT INTO `piece` (`REFERENCE_PIECE`, `REFERENCE_COMMANDE`, `NUMERO_LIGNE_COMMANDE`, `REFERENCE_TYPE_PIECE`) VALUES
(111, 1, 1, 'TL683'),
(211, 2, 1, 'TL683'),
(212, 2, 1, 'TL683'),
(213, 2, 1, 'TL683'),
(214, 2, 1, 'TL683'),
(215, 2, 1, 'TL683'),
(216, 2, 1, 'TL683'),
(311, 3, 1, 'TL683'),
(312, 3, 1, 'TL683'),
(411, 4, 1, 'TL683'),
(511, 5, 1, 'TL683'),
(121, 1, 2, 'LP412'),
(122, 1, 2, 'LP412'),
(123, 1, 2, 'LP412'),
(124, 1, 2, 'LP412'),
(125, 1, 2, 'LP412'),
(221, 2, 2, 'LP412'),
(222, 2, 2, 'LP412'),
(223, 2, 2, 'LP412'),
(224, 2, 2, 'LP412'),
(225, 2, 2, 'LP412'),
(321, 3, 2, 'LP412'),
(422, 4, 2, 'LP412'),
(423, 4, 2, 'LP412'),
(424, 4, 2, 'LP412'),
(425, 4, 2, 'LP412'),
(521, 5, 2, 'LP412'),
(522, 5, 2, 'LP412'),
(523, 5, 2, 'LP412'),
(524, 5, 2, 'LP412'),
(525, 5, 2, 'LP412'),
(131, 1, 3, 'AR232'),
(132, 1, 3, 'AR232'),
(133, 1, 3, 'AR232'),
(134, 1, 3, 'AR232'),
(135, 1, 3, 'AR232'),
(231, 2, 3, 'AR232'),
(232, 2, 3, 'AR232'),
(233, 2, 3, 'AR232'),
(234, 2, 3, 'AR232'),
(235, 2, 3, 'AR232'),
(331, 3, 3, 'AR232'),
(332, 3, 3, 'AR232'),
(333, 3, 3, 'AR232'),
(334, 3, 3, 'AR232'),
(335, 3, 3, 'AR232'),
(431, 4, 3, 'AR232'),
(432, 4, 3, 'AR232'),
(433, 4, 3, 'AR232'),
(434, 4, 3, 'AR232'),
(435, 4, 3, 'AR232'),
(531, 5, 3, 'AR232'),
(532, 5, 3, 'AR232'),
(533, 5, 3, 'AR232'),
(534, 5, 3, 'AR232'),
(535, 5, 3, 'AR232'),
(141, 1, 4, 'HD934'),
(142, 1, 4, 'HD934'),
(241, 2, 4, 'HD934'),
(341, 3, 4, 'HD934'),
(441, 4, 4, 'HD934'),
(541, 5, 4, 'HD934'),
(151, 1, 5, 'AR232'),
(251, 2, 5, 'AR232'),
(351, 3, 5, 'AR232'),
(451, 4, 5, 'AR232'),
(551, 5, 5, 'AR232'),
(461, 4, 6, 'LP412');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
