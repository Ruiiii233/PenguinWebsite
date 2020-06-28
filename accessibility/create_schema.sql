-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PenguinWebsite
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PenguinWebsite
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PenguinWebsite` ;
USE `PenguinWebsite` ;

-- -----------------------------------------------------
-- Table `PenguinWebsite`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`User` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`User` (
  `UserKey` INT NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  `DoB` DATE NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`UserKey`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Researcher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Researcher` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Researcher` (
  `idResearcher` INT NOT NULL AUTO_INCREMENT,
  `UserKeyFK` INT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `AcademicPaper` VARCHAR(255) NULL,
  `Gender` ENUM("M", "F") NULL,
  `institute` VARCHAR(255) NULL,
  PRIMARY KEY (`idResearcher`),
  INDEX `Researcher_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  CONSTRAINT `Researcher_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `PenguinWebsite`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Post` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Post` (
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
    REFERENCES `PenguinWebsite`.`User` (`UserKey`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`NormalUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`NormalUser` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`NormalUser` (
  `NormalUserKey` INT NOT NULL AUTO_INCREMENT,
  `UserKeyFK` INT NOT NULL,
  PRIMARY KEY (`NormalUserKey`),
  INDEX `NormalUser_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  CONSTRAINT `NormalUser_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `PenguinWebsite`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Administrator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Administrator` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Administrator` (
  `AdministratorKey` INT NOT NULL AUTO_INCREMENT,
  `UserKeyFK` INT NOT NULL,
  PRIMARY KEY (`AdministratorKey`),
  INDEX `Administrator_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  CONSTRAINT `Administrator_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `PenguinWebsite`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Comment` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Comment` (
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
    REFERENCES `PenguinWebsite`.`User` (`UserKey`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Comment_PostFK1`
    FOREIGN KEY (`PostKeyFK`)
    REFERENCES `PenguinWebsite`.`Post` (`PostKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Share`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Share` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Share` (
  `UserKeyFK` INT NULL,
  `PostKeyFK` INT NULL,
  `CommentKeyFK` INT NULL,
  `ShareCreated` TIMESTAMP NULL DEFAULT now(),
  INDEX `Share_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  INDEX `Share_PostFK1_idx` (`PostKeyFK` ASC) VISIBLE,
  INDEX `Share_CommentFK1_idx` (`CommentKeyFK` ASC) VISIBLE,
  CONSTRAINT `Share_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `PenguinWebsite`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Share_PostFK1`
    FOREIGN KEY (`PostKeyFK`)
    REFERENCES `PenguinWebsite`.`Post` (`PostKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Share_CommentFK1`
    FOREIGN KEY (`CommentKeyFK`)
    REFERENCES `PenguinWebsite`.`Comment` (`CommentKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Save`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Save` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Save` (
  `UserKeyFK` INT NULL,
  `PostKeyFK` INT NULL,
  `CommentKeyFK` INT NULL,
  `SaveCreated` TIMESTAMP NULL DEFAULT now(),
  INDEX `Save_UserFK1_idx` (`UserKeyFK` ASC) VISIBLE,
  INDEX `Save_PostFK1_idx` (`PostKeyFK` ASC) VISIBLE,
  INDEX `Save_CommentFK1_idx` (`CommentKeyFK` ASC) VISIBLE,
  CONSTRAINT `Save_UserFK1`
    FOREIGN KEY (`UserKeyFK`)
    REFERENCES `PenguinWebsite`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Save_PostFK1`
    FOREIGN KEY (`PostKeyFK`)
    REFERENCES `PenguinWebsite`.`Post` (`PostKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Save_CommentFK1`
    FOREIGN KEY (`CommentKeyFK`)
    REFERENCES `PenguinWebsite`.`Comment` (`CommentKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`LikeOrDislike`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`LikeOrDislike` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`LikeOrDislike` (
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
    REFERENCES `PenguinWebsite`.`User` (`UserKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `LikeOrDislike_PostFK1`
    FOREIGN KEY (`PostKeyFK`)
    REFERENCES `PenguinWebsite`.`Post` (`PostKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `LikeOrDislike_CommentFK1`
    FOREIGN KEY (`CommentKeyFK`)
    REFERENCES `PenguinWebsite`.`Comment` (`CommentKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Camera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Camera` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Camera` (
  `idCamera` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idCamera`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Site` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Site` (
  `idSite` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`idSite`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Image`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `PenguinWebsite`.`Image` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Image` (
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
  `idCam` INT NULL,
  PRIMARY KEY (`idImage`),
  INDEX `camID_idx` (`idCam` ASC) VISIBLE,
  INDEX `siteID_idx` (`siteID` ASC) VISIBLE,
  CONSTRAINT `Image_Cam_fk`
    FOREIGN KEY (`idCam`)
    REFERENCES `PenguinWebsite`.`Camera` (`idCamera`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `siteID`
    FOREIGN KEY (`siteID`)
    REFERENCES `PenguinWebsite`.`Site` (`idSite`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`UAV`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`UAV` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`UAV` (
  `idUAV` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(45) NOT NULL,
  `idCam` INT NULL,
  `weight` FLOAT NOT NULL,
  PRIMARY KEY (`idUAV`),
  INDEX `idx_Cam` (`idCam` ASC) VISIBLE,
  CONSTRAINT `fk_Uav_Camera`
    FOREIGN KEY (`idCam`)
    REFERENCES `PenguinWebsite`.`Camera` (`idCamera`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Model`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Model` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Model` (
  `idModel` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `createTime` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idModel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Annotation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Annotation` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Annotation` (
  `idAnnotation` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `fileType` ENUM("shp", "json", "xml", "dbf", "prj", "cpg", "shx") NOT NULL,
  `idSiteFK` INT NULL,
  `pathOnCloud` VARCHAR(100) NOT NULL,
  `criteria` ENUM("withChick", "withoutChick") NOT NULL,
  PRIMARY KEY (`idAnnotation`),
  INDEX `Annotation_Site_idx` (`idSiteFK` ASC) VISIBLE,
  CONSTRAINT `Annotation_Site_fk`
    FOREIGN KEY (`idSiteFK`)
    REFERENCES `PenguinWebsite`.`Site` (`idSite`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Detection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Detection` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Detection` (
  `idDetection` INT NOT NULL AUTO_INCREMENT,
  `idImage` INT NOT NULL,
  `totalCount` INT NOT NULL,
  `pathOnCloud` VARCHAR(99) NOT NULL,
  `idModel` INT NOT NULL,
  PRIMARY KEY (`idDetection`),
  INDEX `idImage_idx` (`idImage` ASC) VISIBLE,
  INDEX `idModel_idx` (`idModel` ASC) VISIBLE,
  CONSTRAINT `Detection_Image_fk`
    FOREIGN KEY (`idImage`)
    REFERENCES `PenguinWebsite`.`Image` (`idImage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Detection_Model_fk`
    FOREIGN KEY (`idModel`)
    REFERENCES `PenguinWebsite`.`Model` (`idModel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Participate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Participate` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Participate` (
  `idParticipate` INT NOT NULL AUTO_INCREMENT,
  `idSiteFK` INT NULL,
  `idResearcherFK` INT NULL,
  PRIMARY KEY (`idParticipate`),
  INDEX `Participate_Site_fk_idx` (`idSiteFK` ASC) VISIBLE,
  INDEX `Participate_Researcher_fk_idx` (`idResearcherFK` ASC) VISIBLE,
  CONSTRAINT `fk_Participate_Site`
    FOREIGN KEY (`idSiteFK`)
    REFERENCES `PenguinWebsite`.`Site` (`idSite`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Participate_Researcher_fk`
    FOREIGN KEY (`idResearcherFK`)
    REFERENCES `PenguinWebsite`.`Researcher` (`idResearcher`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Weather`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Weather` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Weather` (
  `idWeather` INT NOT NULL AUTO_INCREMENT,
  `time` DATETIME NULL,
  `tmpOut` FLOAT NULL,
  `tmpH` FLOAT NULL,
  `tmpL` FLOAT NULL,
  `windSpeed` FLOAT NULL,
  `windDir` VARCHAR(45) NULL,
  `windRun` FLOAT NULL,
  `hiSpeed` FLOAT NULL,
  `windChill` VARCHAR(45) NULL,
  `bar` VARCHAR(45) NULL,
  `heatDD` VARCHAR(45) NULL,
  `coolDD` VARCHAR(45) NULL,
  `tmpIn` VARCHAR(45) NULL,
  `humIn` VARCHAR(45) NULL,
  `arcInt` VARCHAR(45) NULL,
  `longitude` DOUBLE NULL,
  `latitude` DOUBLE NULL,
  PRIMARY KEY (`idWeather`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
