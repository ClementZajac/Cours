-- Structure de la table `raspberry`
DROP TABLE IF EXISTS `raspberry`;
CREATE TABLE IF NOT EXISTS `raspberry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userdatabase` int(11) DEFAULT NULL,
  `userwebsite` int(11) DEFAULT NULL,
  `physicallogin` tinyint(1) DEFAULT NULL,
  `sshlogin` tinyint(1) DEFAULT NULL,
  `vnclogin` tinyint(1) DEFAULT NULL,
  `databaselogin` tinyint(1) DEFAULT NULL,
  `websitelogin` tinyint(1) DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `usagecpu` double DEFAULT NULL,
  `usageram` double DEFAULT NULL,
  `usagestorage` double DEFAULT NULL,
  `maxstorage` double DEFAULT NULL,
  `powersupply` tinyint(1) DEFAULT NULL,
  `ping` int(11) DEFAULT NULL,
  `bandwidthWifi` double DEFAULT NULL,
  `bandwidthFilaire` double DEFAULT NULL,
  `MAJ` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informations datees';

-- --------------------------------------------------------

-- Structure de la table `raspberrysimulation`
DROP TABLE IF EXISTS `raspberrysimulation`;
CREATE TABLE IF NOT EXISTS `raspberrysimulation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userdatabase` int(11) DEFAULT NULL,
  `userwebsite` int(11) DEFAULT NULL,
  `physicallogin` tinyint(1) DEFAULT NULL,
  `sshlogin` tinyint(1) DEFAULT NULL,
  `vnclogin` tinyint(1) DEFAULT NULL,
  `databaselogin` tinyint(1) DEFAULT NULL,
  `websitelogin` tinyint(1) DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `usagecpu` double DEFAULT NULL,
  `usageram` double DEFAULT NULL,
  `usagestorage` double DEFAULT NULL,
  `maxstorage` double DEFAULT NULL,
  `powersupply` tinyint(1) DEFAULT NULL,
  `ping` int(11) DEFAULT NULL,
  `bandwidthWifi` double DEFAULT NULL,
  `bandwidthFilaire` double DEFAULT NULL,
  `MAJ` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informations datees';

-- --------------------------------------------------------

-- Structure de la table `users`
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
COMMIT;

-- Déchargement des données de la table `users`
INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'admin', '$2a$10$UyJwYS5t0jxSPyHtAA0peeyrCbp2cCzG2u2ZdKQzIFugvz/n94VYK');
COMMIT;