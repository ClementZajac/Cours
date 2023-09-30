-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 21 mars 2022 à 16:34
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
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `REFERENCE_COMMANDE` int(11) NOT NULL,
  `RAISON_SOCIALE` varchar(32) NOT NULL,
  `DATE_COMMANDE` date DEFAULT NULL,
  `DATE_LIVRAISON_SOUHAITEE` date DEFAULT NULL,
  PRIMARY KEY (`REFERENCE_COMMANDE`),
  KEY `DESTINER_IDX` (`RAISON_SOCIALE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`REFERENCE_COMMANDE`, `RAISON_SOCIALE`, `DATE_COMMANDE`, `DATE_LIVRAISON_SOUHAITEE`) VALUES
(1, 'BERTOULD', '2006-04-12', '2006-04-18'),
(2, 'BERTOULD', '2006-04-17', '2006-04-21'),
(3, 'PEUGEOT', '2006-04-19', '2006-04-23'),
(4, 'PEUGEOT', '2006-04-29', '2006-05-03'),
(5, 'MOTOBECANE', '2006-05-02', '2006-05-08'),
(6, 'MOTOBECANE', '2006-06-03', '2006-06-08');

-- --------------------------------------------------------

--
-- Structure de la table `commercialiser`
--

DROP TABLE IF EXISTS `commercialiser`;
CREATE TABLE IF NOT EXISTS `commercialiser` (
  `RAISON_SOCIALE` varchar(32) NOT NULL,
  `REFERENCE_TYPE_PIECE` varchar(10) NOT NULL,
  PRIMARY KEY (`RAISON_SOCIALE`,`REFERENCE_TYPE_PIECE`),
  KEY `LIEN_12_IDX` (`RAISON_SOCIALE`),
  KEY `LIEN_13_IDX` (`REFERENCE_TYPE_PIECE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commercialiser`
--

INSERT INTO `commercialiser` (`RAISON_SOCIALE`, `REFERENCE_TYPE_PIECE`) VALUES
('BERTOULD', 'AR232'),
('MBK', 'AR232'),
('MOTOBECANE', 'AR232'),
('PEUGEOT', 'AR232'),
('BERTOULD', 'HD934'),
('MBK', 'HD934'),
('MOTOBECANE', 'HD934'),
('PEUGEOT', 'HD934'),
('BERTOULD', 'LP412'),
('MBK', 'LP412'),
('MOTOBECANE', 'LP412'),
('PEUGEOT', 'LP412'),
('BERTOULD', 'TL683'),
('MBK', 'TL683'),
('MOTOBECANE', 'TL683'),
('PEUGEOT', 'TL683');

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `RAISON_SOCIALE` varchar(32) NOT NULL,
  `NOM_DIRECTEUR` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`RAISON_SOCIALE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `fournisseur`
--

INSERT INTO `fournisseur` (`RAISON_SOCIALE`, `NOM_DIRECTEUR`) VALUES
('BERTOULD', 'DUPONT'),
('GITANE', 'MARTIN'),
('MBK', 'MERLIN'),
('MOTOBECANE', 'LEBLANC'),
('PEUGEOT', 'DUPUIS'),
('RALEIGH', 'DUMONT');

-- --------------------------------------------------------

--
-- Structure de la table `ligne_commande`
--

DROP TABLE IF EXISTS `ligne_commande`;
CREATE TABLE IF NOT EXISTS `ligne_commande` (
  `REFERENCE_COMMANDE` int(11) NOT NULL,
  `NUMERO_LIGNE_COMMANDE` int(11) NOT NULL,
  `REFERENCE_TYPE_PIECE` varchar(10) NOT NULL,
  `QUANTITE_PIECES_COMMANDEES` int(11) DEFAULT NULL,
  `PRIX_PIECE` decimal(7,2) DEFAULT NULL,
  PRIMARY KEY (`REFERENCE_COMMANDE`,`NUMERO_LIGNE_COMMANDE`),
  KEY `COMMANDER_IDX` (`REFERENCE_TYPE_PIECE`),
  KEY `DETAILLER_IDX` (`REFERENCE_COMMANDE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `ligne_commande`
--

INSERT INTO `ligne_commande` (`REFERENCE_COMMANDE`, `NUMERO_LIGNE_COMMANDE`, `REFERENCE_TYPE_PIECE`, `QUANTITE_PIECES_COMMANDEES`, `PRIX_PIECE`) VALUES
(1, 1, 'TL683', 1, '54.20'),
(1, 2, 'LP412', 5, '23.43'),
(1, 3, 'AR232', 3, '64.34'),
(1, 4, 'HD934', 2, '13.65'),
(1, 5, 'AR232', 1, '77.54'),
(2, 1, 'TL683', 6, '53.20'),
(2, 2, 'LP412', 5, '24.43'),
(2, 3, 'AR232', 3, '61.34'),
(2, 4, 'HD934', 1, '15.65'),
(2, 5, 'AR232', 1, '74.54'),
(3, 1, 'TL683', 2, '56.20'),
(3, 2, 'LP412', 1, '22.43'),
(3, 3, 'AR232', 3, '66.34'),
(3, 4, 'HD934', 1, '17.65'),
(3, 5, 'AR232', 1, '72.54'),
(4, 1, 'TL683', 1, '57.20'),
(4, 2, 'LP412', 5, '21.43'),
(4, 3, 'AR232', 3, '67.34'),
(4, 4, 'HD934', 1, '16.65'),
(4, 5, 'AR232', 2, '74.54'),
(4, 6, 'LP412', 1, '21.43'),
(5, 1, 'TL683', 1, '57.20'),
(5, 2, 'LP412', 5, '27.43'),
(5, 3, 'AR232', 3, '68.34'),
(5, 4, 'HD934', 1, '15.65'),
(5, 5, 'AR232', 1, '74.54');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `piece`
--

INSERT INTO `piece` (`REFERENCE_PIECE`, `REFERENCE_COMMANDE`, `NUMERO_LIGNE_COMMANDE`, `REFERENCE_TYPE_PIECE`) VALUES
(111, 1, 1, 'TL683'),
(121, 1, 2, 'LP412'),
(122, 1, 2, 'LP412'),
(123, 1, 2, 'LP412'),
(124, 1, 2, 'LP412'),
(125, 1, 2, 'LP412'),
(131, 1, 3, 'AR232'),
(132, 1, 3, 'AR232'),
(133, 1, 3, 'AR232'),
(134, 1, 3, 'AR232'),
(135, 1, 3, 'AR232'),
(141, 1, 4, 'HD934'),
(142, 1, 4, 'HD934'),
(151, 1, 5, 'AR232'),
(211, 2, 1, 'TL683'),
(212, 2, 1, 'TL683'),
(213, 2, 1, 'TL683'),
(214, 2, 1, 'TL683'),
(215, 2, 1, 'TL683'),
(216, 2, 1, 'TL683'),
(221, 2, 2, 'LP412'),
(222, 2, 2, 'LP412'),
(223, 2, 2, 'LP412'),
(224, 2, 2, 'LP412'),
(225, 2, 2, 'LP412'),
(231, 2, 3, 'AR232'),
(232, 2, 3, 'AR232'),
(233, 2, 3, 'AR232'),
(234, 2, 3, 'AR232'),
(235, 2, 3, 'AR232'),
(241, 2, 4, 'HD934'),
(251, 2, 5, 'AR232'),
(311, 3, 1, 'TL683'),
(312, 3, 1, 'TL683'),
(321, 3, 2, 'LP412'),
(331, 3, 3, 'AR232'),
(332, 3, 3, 'AR232'),
(333, 3, 3, 'AR232'),
(334, 3, 3, 'AR232'),
(335, 3, 3, 'AR232'),
(341, 3, 4, 'HD934'),
(351, 3, 5, 'AR232'),
(411, 4, 1, 'TL683'),
(422, 4, 2, 'LP412'),
(423, 4, 2, 'LP412'),
(424, 4, 2, 'LP412'),
(425, 4, 2, 'LP412'),
(431, 4, 3, 'AR232'),
(432, 4, 3, 'AR232'),
(433, 4, 3, 'AR232'),
(434, 4, 3, 'AR232'),
(435, 4, 3, 'AR232'),
(441, 4, 4, 'HD934'),
(451, 4, 5, 'AR232'),
(461, 4, 6, 'LP412'),
(511, 5, 1, 'TL683'),
(521, 5, 2, 'LP412'),
(522, 5, 2, 'LP412'),
(523, 5, 2, 'LP412'),
(524, 5, 2, 'LP412'),
(525, 5, 2, 'LP412'),
(531, 5, 3, 'AR232'),
(532, 5, 3, 'AR232'),
(533, 5, 3, 'AR232'),
(534, 5, 3, 'AR232'),
(535, 5, 3, 'AR232'),
(541, 5, 4, 'HD934'),
(551, 5, 5, 'AR232');

-- --------------------------------------------------------

--
-- Structure de la table `type_piece`
--

DROP TABLE IF EXISTS `type_piece`;
CREATE TABLE IF NOT EXISTS `type_piece` (
  `REFERENCE_TYPE_PIECE` varchar(10) NOT NULL,
  `LIBELLE_TYPE_PIECE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`REFERENCE_TYPE_PIECE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `type_piece`
--

INSERT INTO `type_piece` (`REFERENCE_TYPE_PIECE`, `LIBELLE_TYPE_PIECE`) VALUES
('AR232', 'guidon'),
('DE524', 'pignon'),
('GR674', 'plateau'),
('HD934', 'jante'),
('LP412', 'cadre'),
('TL683', 'pneu');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
