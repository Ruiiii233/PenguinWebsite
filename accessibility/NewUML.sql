-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PenguinWeb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PenguinWeb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PenguinWeb` ;
USE `PenguinWeb` ;

-- -----------------------------------------------------
-- Table `PenguinWeb`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWeb`.`Users` ;

CREATE TABLE IF NOT EXISTS `PenguinWeb`.`Users` (
  `UserId` INT NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(255) NULL,
  `Password` VARCHAR(255) NULL,
  `Status` ENUM("Administrator", "Researcher", "User") NULL,
  PRIMARY KEY (`UserId`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PenguinWeb`.`Researchers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWeb`.`Researchers` ;

CREATE TABLE IF NOT EXISTS `PenguinWeb`.`Researchers` (
  `UserId` INT NOT NULL,
  `FirstName` VARCHAR(255) NULL,
  `LastName` VARCHAR(255) NULL,
  `Gender` TINYINT NULL,
  `AcademicPaper` LONGTEXT NULL,
  `Institute` VARCHAR(255) NULL,
  PRIMARY KEY (`UserId`),
  INDEX `Researcher_Users1_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `Researcher_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `PenguinWeb`.`Users` (`UserId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWeb`.`Posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWeb`.`Posts` ;

CREATE TABLE IF NOT EXISTS `PenguinWeb`.`Posts` (
  `PostId` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(255) NOT NULL,
  `Picture` LONGBLOB NULL,
  `Content` LONGTEXT NULL,
  `Published` TINYINT NULL DEFAULT 0,
  `Created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `UserId` INT NULL,
  PRIMARY KEY (`PostId`),
  INDEX `Posts_Users1_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `Posts_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `PenguinWeb`.`Users` (`UserId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWeb`.`Comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWeb`.`Comments` ;

CREATE TABLE IF NOT EXISTS `PenguinWeb`.`Comments` (
  `CommentId` INT NOT NULL AUTO_INCREMENT,
  `Content` VARCHAR(255) NOT NULL,
  `Created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `UserId` INT NULL,
  `PostId` INT NULL,
  PRIMARY KEY (`CommentId`),
  INDEX `Comments_Users1_idx` (`UserId` ASC) VISIBLE,
  INDEX `Comments_Posts1_idx` (`PostId` ASC) VISIBLE,
  CONSTRAINT `Comments_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `PenguinWeb`.`Users` (`UserId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Comments_Posts1`
    FOREIGN KEY (`PostId`)
    REFERENCES `PenguinWeb`.`Posts` (`PostId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWeb`.`Reshares`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWeb`.`Reshares` ;

CREATE TABLE IF NOT EXISTS `PenguinWeb`.`Reshares` (
  `ReshareId` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NULL,
  `PostId` INT NULL,
  `CommentId` INT NULL,
  PRIMARY KEY (`ReshareId`),
  INDEX `Reshares_Users1_idx` (`UserId` ASC) VISIBLE,
  INDEX `Reshares_Posts1_idx` (`PostId` ASC) VISIBLE,
  INDEX `Reshares_Comments1_idx` (`CommentId` ASC) VISIBLE,
  CONSTRAINT `Reshares_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `PenguinWeb`.`Users` (`UserId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Reshares_Posts1`
    FOREIGN KEY (`PostId`)
    REFERENCES `PenguinWeb`.`Posts` (`PostId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Reshares_Comments1`
    FOREIGN KEY (`CommentId`)
    REFERENCES `PenguinWeb`.`Comments` (`CommentId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PenguinWeb`.`Collections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWeb`.`Collections` ;

CREATE TABLE IF NOT EXISTS `PenguinWeb`.`Collections` (
  `CollectionId` INT NOT NULL AUTO_INCREMENT, 
  `UserId` INT NULL,
  `PostId` INT NULL,
  `CommentId` INT NULL,
  PRIMARY KEY (`CollectionId`),
  INDEX `Collections_Users1_idx` (`UserId` ASC) VISIBLE,
  INDEX `Collections_Posts1_idx` (`PostId` ASC) VISIBLE,
  INDEX `Collections_Comments1_idx` (`CommentId` ASC) VISIBLE,
  CONSTRAINT `Collections_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `PenguinWeb`.`Users` (`UserId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Collections_Posts1`
    FOREIGN KEY (`PostId`)
    REFERENCES `PenguinWeb`.`Posts` (`PostId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Collections_Comments1`
    FOREIGN KEY (`CommentId`)
    REFERENCES `PenguinWeb`.`Comments` (`CommentId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWeb`.`Likes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWeb`.`Likes` ;

CREATE TABLE IF NOT EXISTS `PenguinWeb`.`Likes` (
  `LikeId` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NULL,
  `PostId` INT NULL,
  `CommentId` INT NULL,
  PRIMARY KEY (`LikeId`),
  INDEX `Likes_Users1_idx` (`UserId` ASC) VISIBLE,
  INDEX `Likes_Posts1_idx` (`PostId` ASC) VISIBLE,
  INDEX `Likes_Comments1_idx` (`CommentId` ASC) VISIBLE,
  CONSTRAINT `Likes_Users1`
    FOREIGN KEY (`UserId`)
    REFERENCES `PenguinWeb`.`Users` (`UserId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Likes_Posts1`
    FOREIGN KEY (`PostId`)
    REFERENCES `PenguinWeb`.`Posts` (`PostId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Likes_Comments1`
    FOREIGN KEY (`CommentId`)
    REFERENCES `PenguinWeb`.`Comments` (`CommentId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
