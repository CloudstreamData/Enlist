CREATE SCHEMA IF NOT EXISTS enlist;

SET SCHEMA enlist;

CREATE TABLE  IF NOT EXISTS`setting` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `defaultPointValue` int(11) DEFAULT NULL,
  `orgName` varchar(100) DEFAULT NULL,
  `orgDesc` text,
  `orgAddress` varchar(100) DEFAULT NULL,
  `sendEmail` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;