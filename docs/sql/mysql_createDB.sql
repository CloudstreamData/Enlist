CREATE SCHEMA IF NOT EXISTS enlist;

SET SCHEMA enlist;

CREATE TABLE IF NOT EXISTS `setting` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `defaultPointValue` int(11) DEFAULT NULL,
  `orgName` varchar(100) DEFAULT NULL,
  `orgDesc` text,
  `orgAddress` varchar(100) DEFAULT NULL,
  `sendEmail` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `chapter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `location` varchar(100) DEFAULT NULL,
  `statusCode` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `event` (
  `id` INT(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL ,
  `startDate` DATETIME NULL ,
  `endDate` DATETIME NULL ,
  `location` VARCHAR(100) NULL ,
  `status` VARCHAR(50) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;
