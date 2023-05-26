-- Create the wdw database
CREATE DATABASE IF NOT EXISTS wdw;
USE wdw;

-- Create the accounts table
CREATE TABLE `accounts` (
	`accountId` INT(11) NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`password` VARCHAR(64) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`email` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('inactive','active','banned') NULL DEFAULT 'active' COLLATE 'utf8mb4_general_ci',
	`subscription` ENUM('free','corporate') NULL DEFAULT 'free' COLLATE 'utf8mb4_general_ci',
	`lastModified` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`accountId`) USING BTREE,
	UNIQUE INDEX `username` (`username`) USING BTREE,
	UNIQUE INDEX `email` (`email`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

-- Create the trigger to encrypt password
DELIMITER //
CREATE TRIGGER encrypt_password_trigger BEFORE INSERT ON accounts
FOR EACH ROW
BEGIN
    SET NEW.password = SHA2(NEW.password, 256);
END//
DELIMITER ;

-- Create the websites table
CREATE TABLE `websites` (
	`webId` INT(11) NOT NULL AUTO_INCREMENT,
	`accountId` INT(11) NULL DEFAULT NULL,
	`name` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`url` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`status` ENUM('active','inactive') NULL DEFAULT 'active' COLLATE 'utf8mb4_general_ci',
	`visibility` ENUM('public','private') NULL DEFAULT 'public' COLLATE 'utf8mb4_general_ci',
	`lastModified` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`webId`) USING BTREE,
	INDEX `accountId` (`accountId`) USING BTREE,
	CONSTRAINT `websites_ibfk_1` FOREIGN KEY (`accountId`) REFERENCES `accounts` (`accountId`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

-- Create the statistics table
CREATE TABLE `statistics` (
	`webId` INT(11) NULL DEFAULT NULL,
	`date` DATE NULL DEFAULT NULL,
	`upvote` INT(11) NULL DEFAULT '0',
	`downvote` INT(11) NULL DEFAULT '0',
	`uptime` FLOAT NULL DEFAULT NULL,
	`lastModified` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	INDEX `webId` (`webId`) USING BTREE,
	CONSTRAINT `statistics_ibfk_1` FOREIGN KEY (`webId`) REFERENCES `websites` (`webId`) ON UPDATE RESTRICT ON DELETE RESTRICT
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

-- Create trigger to update uptime column
DELIMITER //
CREATE TRIGGER update_uptime_trigger BEFORE UPDATE ON statistics
FOR EACH ROW
BEGIN
    IF NEW.upvote != OLD.upvote OR NEW.downvote != OLD.downvote THEN
        SET NEW.uptime = NEW.upvote / (NEW.upvote + NEW.downvote);
    END IF;
END//
DELIMITER ;
