-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Project_User
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Project_User
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Project_User` ;
USE `Project_User` ;

-- -----------------------------------------------------
-- Table `Project_User`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`User` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`User` (
  `UserKey` INT NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  `DoB` DATE NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`UserKey`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Researcher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Researcher` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Researcher` (
  `ResearcherKey` INT NOT NULL AUTO_INCREMENT,
  `UserKeyFK` INT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `AcademicPaper` VARCHAR(255) NULL,
  `Gender` ENUM("M", "F") NULL,
  `institute` VARCHAR(255) NULL,
  PRIMARY KEY (`ResearcherKey`),
  INDEX `Researcher_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  CONSTRAINT `Researcher_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `Project_User`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Post` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Post` (
  `PostKey` INT NOT NULL AUTO_INCREMENT,
  `UserKeyFK` INT NULL,
  `Title` VARCHAR(255) NULL,
  `PostContent` TEXT NULL,
  `Published` TINYINT NULL,
  `PostCreated` TIMESTAMP NULL DEFAULT now(),
  PRIMARY KEY (`PostKey`),
  INDEX `Post_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  CONSTRAINT `Post_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `Project_User`.`User` (`UserKey`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`NormalUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`NormalUser` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`NormalUser` (
  `NormalUserKey` INT NOT NULL AUTO_INCREMENT,
  `UserKeyFK` INT NOT NULL,
  PRIMARY KEY (`NormalUserKey`),
  INDEX `NormalUser_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  CONSTRAINT `NormalUser_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `Project_User`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Administrator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Administrator` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Administrator` (
  `AdministratorKey` INT NOT NULL AUTO_INCREMENT,
  `UserKeyFK` INT NOT NULL,
  PRIMARY KEY (`AdministratorKey`),
  INDEX `Administrator_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  CONSTRAINT `Administrator_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `Project_User`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Comment` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Comment` (
  `CommentKey` INT NOT NULL AUTO_INCREMENT,
  `UserKeyFK` INT NULL,
  `PostKeyFK` INT NULL,
  `CommentContent` TEXT NULL,
  `CommentCreated` TIMESTAMP NULL DEFAULT now(),
  PRIMARY KEY (`CommentKey`),
  INDEX `Comment_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  INDEX `Comment_PostFK1_idx` (`PostKeyFK` ASC) VISIBLE,
  CONSTRAINT `Comment_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `Project_User`.`User` (`UserKey`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Comment_PostFK1`
    FOREIGN KEY (`PostKeyFK`)
    REFERENCES `Project_User`.`Post` (`PostKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Share`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Share` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Share` (
  `UserKeyFK` INT NULL,
  `PostKeyFK` INT NULL,
  `CommentKeyFK` INT NULL,
  `ShareCreated` TIMESTAMP NULL DEFAULT now(),
  INDEX `Share_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  INDEX `Share_PostFK1_idx` (`PostKeyFK` ASC) VISIBLE,
  INDEX `Share_CommentFK1_idx` (`CommentKeyFK` ASC) VISIBLE,
  CONSTRAINT `Share_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `Project_User`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Share_PostFK1`
    FOREIGN KEY (`PostKeyFK`)
    REFERENCES `Project_User`.`Post` (`PostKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Share_CommentFK1`
    FOREIGN KEY (`CommentKeyFK`)
    REFERENCES `Project_User`.`Comment` (`CommentKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Save`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Save` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Save` (
  `UserKeyFK` INT NULL,
  `PostKeyFK` INT NULL,
  `CommentKeyFK` INT NULL,
  `SaveCreated` TIMESTAMP NULL DEFAULT now(),
  INDEX `Save_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  INDEX `Save_PostFK1_idx` (`PostKeyFK` ASC) VISIBLE,
  INDEX `Save_CommentFK1_idx` (`CommentKeyFK` ASC) VISIBLE,
  CONSTRAINT `Save_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `Project_User`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Save_PostFK1`
    FOREIGN KEY (`PostKeyFK`)
    REFERENCES `Project_User`.`Post` (`PostKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Save_CommentFK1`
    FOREIGN KEY (`CommentKeyFK`)
    REFERENCES `Project_User`.`Comment` (`CommentKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`LikeOrDislike`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`LikeOrDislike` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`LikeOrDislike` (
  `UserKeyFK` INT NULL,
  `PostKeyFK` INT NULL,
  `CommentKeyFK` INT NULL,
  `LikeOrDislike` TINYINT NOT NULL,
  `LikeOrDislikeCreated` TIMESTAMP NULL DEFAULT now(),
  INDEX `LikeOrDislike_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  INDEX `LikeOrDislike_PostFK1_idx` (`PostKeyFK` ASC) VISIBLE,
  INDEX `LikeOrDislike_CommentFK1_idx` (`CommentKeyFK` ASC) VISIBLE,
  CONSTRAINT `LikeOrDislike_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `Project_User`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `LikeOrDislike_PostFK1`
    FOREIGN KEY (`PostKeyFK`)
    REFERENCES `Project_User`.`Post` (`PostKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `LikeOrDislike_CommentFK1`
    FOREIGN KEY (`CommentKeyFK`)
    REFERENCES `Project_User`.`Comment` (`CommentKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Camera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Camera` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Camera` (
  `idCamera` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idCamera`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Site` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Site` (
  `idSite` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`idSite`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Image`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `Project_User`.`Image` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Image` (
  `idImage` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `ftype` ENUM("jpg", "png", "tif", "tiff", "dng") NOT NULL,
  `siteID` INT NULL,
  `size` INT NULL,
  `mediaLink` VARCHAR(100) NULL,
  `timestamp` TIMESTAMP NULL,
  `width` INT NULL,
  `height` INT NULL,
  `longitude` DOUBLE NULL,
  `latitude` DOUBLE NULL,
  `camID` INT NULL,
  PRIMARY KEY (`idImage`),
  INDEX `camID_idx` (`camID` ASC) VISIBLE,
  INDEX `siteID_idx` (`siteID` ASC) VISIBLE,
  CONSTRAINT `camID`
    FOREIGN KEY (`camID`)
    REFERENCES `Project_User`.`Camera` (`idCamera`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `siteID`
    FOREIGN KEY (`siteID`)
    REFERENCES `Project_User`.`Site` (`idSite`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`UAV`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`UAV` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`UAV` (
  `idUAV` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(45) NOT NULL,
  `camID` INT NULL,
  `weight` FLOAT NOT NULL,
  PRIMARY KEY (`idUAV`),
  INDEX `camID_idx` (`camID` ASC) VISIBLE,
  CONSTRAINT `fk_uav_cam`
    FOREIGN KEY (`camID`)
    REFERENCES `Project_User`.`Camera` (`idCamera`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Model`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Model` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Model` (
  `idModel` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `createTime` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idModel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Annotation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Annotation` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Annotation` (
  `idAnnotation` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `fileType` ENUM("shp", "json", "xml", "dbf", "prj", "cpg", "shx") NOT NULL,
  `idSiteFK` INT NULL,
  `pathOnCloud` VARCHAR(100) NOT NULL,
  `criteria` ENUM("withChick", "withoutChick") NOT NULL,
  PRIMARY KEY (`idAnnotation`),
  INDEX `fk_Annotation_Site1_idx` (`idSiteFK` ASC) VISIBLE,
  CONSTRAINT `fk_Annotation_Site1`
    FOREIGN KEY (`idSiteFK`)
    REFERENCES `Project_User`.`Site` (`idSite`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Detection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Detection` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Detection` (
  `idDetection` INT NOT NULL AUTO_INCREMENT,
  `imageID` INT NOT NULL,
  `totalCount` INT NOT NULL,
  `pathOnCloud` VARCHAR(99) NOT NULL,
  `modelID` INT NOT NULL,
  PRIMARY KEY (`idDetection`),
  INDEX `of_idx` (`imageID` ASC) VISIBLE,
  INDEX `modelID_idx` (`modelID` ASC) VISIBLE,
  CONSTRAINT `fk_detection_image`
    FOREIGN KEY (`imageID`)
    REFERENCES `Project_User`.`Image` (`idImage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detection_model`
    FOREIGN KEY (`modelID`)
    REFERENCES `Project_User`.`Model` (`idModel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Participate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Participate` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Participate` (
  `idParticipate` INT NOT NULL AUTO_INCREMENT,
  `idSiteFK` INT NULL,
  `researcherKeyFK` INT NULL,
  PRIMARY KEY (`idParticipate`),
  INDEX `fk_Participate_Site1_idx` (`idSiteFK` ASC) VISIBLE,
  INDEX `fk_Participate_Researcher1_idx` (`researcherKeyFK` ASC) VISIBLE,
  CONSTRAINT `fk_Participate_Site1`
    FOREIGN KEY (`idSiteFK`)
    REFERENCES `Project_User`.`Site` (`idSite`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Participate_Researcher1`
    FOREIGN KEY (`researcherKeyFK`)
    REFERENCES `Project_User`.`Researcher` (`ResearcherKey`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Project_User`.`Weather`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Project_User`.`Weather` ;

CREATE TABLE IF NOT EXISTS `Project_User`.`Weather` (
  `WeatherKey` INT NOT NULL AUTO_INCREMENT,
  `Date Time` VARCHAR(45) NULL,
  `Date` VARCHAR(45) NULL,
  `Time` VARCHAR(45) NULL,
  `AverageTemp` VARCHAR(45) NULL,
  `HiTemp` VARCHAR(45) NULL,
  `LowTemp` VARCHAR(45) NULL,
  `WindSpeed` VARCHAR(45) NULL,
  `WindDir` VARCHAR(45) NULL,
  `WindRun` VARCHAR(45) NULL,
  `HiSpeed` VARCHAR(45) NULL,
  `WindChill` VARCHAR(45) NULL,
  `Bar` VARCHAR(45) NULL,
  `HeatD-D` VARCHAR(45) NULL,
  `CoolD-D` VARCHAR(45) NULL,
  `InTemp` VARCHAR(45) NULL,
  `InHum` VARCHAR(45) NULL,
  `Arc.Int.` VARCHAR(45) NULL,
  `Longitude` VARCHAR(45) NULL,
  `Latitude` VARCHAR(45) NULL,
  PRIMARY KEY (`WeatherKey`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
