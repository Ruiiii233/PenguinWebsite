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
-- Table `PenguinWebsite`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Users` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Users` (
    `UserId` INT NOT NULL AUTO_INCREMENT,
    `UserName` VARCHAR(255) NULL,
    `Password` VARCHAR(255) NULL,
    `Status` ENUM("Administrator", "Researcher", "User") NULL,
    PRIMARY KEY (`UserId`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Researchers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Researchers` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Researchers` (
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
            REFERENCES `PenguinWebsite`.`Users` (`UserId`)
            ON DELETE CASCADE
            ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Posts` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Posts` (
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
            REFERENCES `PenguinWebsite`.`Users` (`UserId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Comments` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Comments` (
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
            REFERENCES `PenguinWebsite`.`Users` (`UserId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    CONSTRAINT `Comments_Posts1`
        FOREIGN KEY (`PostId`)
            REFERENCES `PenguinWebsite`.`Posts` (`PostId`)
            ON DELETE CASCADE
            ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Reshares`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Reshares` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Reshares` (
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
            REFERENCES `PenguinWebsite`.`Users` (`UserId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    CONSTRAINT `Reshares_Posts1`
        FOREIGN KEY (`PostId`)
            REFERENCES `PenguinWebsite`.`Posts` (`PostId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    CONSTRAINT `Reshares_Comments1`
        FOREIGN KEY (`CommentId`)
            REFERENCES `PenguinWebsite`.`Comments` (`CommentId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Collections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Collections` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Collections` (
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
            REFERENCES `PenguinWebsite`.`Users` (`UserId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    CONSTRAINT `Collections_Posts1`
        FOREIGN KEY (`PostId`)
            REFERENCES `PenguinWebsite`.`Posts` (`PostId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    CONSTRAINT `Collections_Comments1`
        FOREIGN KEY (`CommentId`)
            REFERENCES `PenguinWebsite`.`Comments` (`CommentId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Likes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Likes` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Likes` (
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
            REFERENCES `PenguinWebsite`.`Users` (`UserId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    CONSTRAINT `Likes_Posts1`
        FOREIGN KEY (`PostId`)
            REFERENCES `PenguinWebsite`.`Posts` (`PostId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    CONSTRAINT `Likes_Comments1`
        FOREIGN KEY (`CommentId`)
            REFERENCES `PenguinWebsite`.`Comments` (`CommentId`)
            ON DELETE SET NULL
            ON UPDATE CASCADE)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Cameras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Cameras` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Cameras` (
  `CameraId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`CameraId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Sites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Sites` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Sites` (
  `SiteId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`SiteId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Images`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `PenguinWebsite`.`Images` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Images` (
  `ImageId` INT NOT NULL AUTO_INCREMENT,
  `FileName` VARCHAR(45) NOT NULL,
  `FileType` ENUM("jpg", "png", "tif", "tiff", "dng") NOT NULL,
  `SiteId` INT NULL,
  `Size` INT NULL,
  `MediaLink` VARCHAR(100) NULL,
  `TimeStamp` TIMESTAMP NULL,
  `Width` INT NULL,
  `Height` INT NULL,
  `Longitude` DOUBLE NULL,
  `Latitude` DOUBLE NULL,
  `CameraId` INT NULL,
  PRIMARY KEY (`ImageId`),
  INDEX `camID_idx` (`CameraId` ASC) VISIBLE,
  INDEX `siteID_idx` (`SiteId` ASC) VISIBLE,
  CONSTRAINT `Image_Cam_fk`
    FOREIGN KEY (`CameraId`)
    REFERENCES `PenguinWebsite`.`Cameras` (`CameraId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `SiteId`
    FOREIGN KEY (`SiteId`)
    REFERENCES `PenguinWebsite`.`Sites` (`SiteId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`UAVs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`UAVs` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`UAVs` (
  `UavId` INT NOT NULL AUTO_INCREMENT,
  `Model` VARCHAR(45) NOT NULL,
  `CameraId` INT NULL,
  `Weight` FLOAT NOT NULL,
  PRIMARY KEY (`UavId`),
  INDEX `idx_Cam` (`CameraId` ASC) VISIBLE,
  CONSTRAINT `fk_Uav_Camera`
    FOREIGN KEY (`CameraId`)
    REFERENCES `PenguinWebsite`.`Cameras` (`CameraId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Models`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Models` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Models` (
  `ModelId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `CreateTime` TIMESTAMP NOT NULL,
  PRIMARY KEY (`ModelId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Annotations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Annotations` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Annotations` (
  `AnnotationId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `FileType` ENUM("shp", "json", "xml", "dbf", "prj", "cpg", "shx") NOT NULL,
  `SiteId` INT NULL,
  `PathOnCloud` VARCHAR(100) NOT NULL,
  `Criteria` ENUM("withChick", "withoutChick") NOT NULL,
  PRIMARY KEY (`AnnotationId`),
  INDEX `Annotation_Site_idx` (`SiteId` ASC) VISIBLE,
  CONSTRAINT `Annotation_Site_fk`
    FOREIGN KEY (`SiteId`)
    REFERENCES `PenguinWebsite`.`Sites` (`SiteId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Detections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Detections` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Detections` (
  `DetectionId` INT NOT NULL AUTO_INCREMENT,
  `ImageId` INT NOT NULL,
  `Count` INT NOT NULL,
  `PathOnCloud` VARCHAR(99) NOT NULL,
  `ModelId` INT NOT NULL,
  PRIMARY KEY (`DetectionId`),
  INDEX `idImage_idx` (`ImageId` ASC) VISIBLE,
  INDEX `idModel_idx` (`ModelId` ASC) VISIBLE,
  CONSTRAINT `Detection_Image_fk`
    FOREIGN KEY (`ImageId`)
    REFERENCES `PenguinWebsite`.`Images` (`ImageId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Detection_Model_fk`
    FOREIGN KEY (`ModelId`)
    REFERENCES `PenguinWebsite`.`Models` (`ModelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Participates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Participates` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Participates` (
  `ParticipateId` INT NOT NULL AUTO_INCREMENT,
  `SiteId` INT NULL,
  `ResearcherId` INT NULL,
  PRIMARY KEY (`ParticipateId`),
  INDEX `Participate_Site_fk_idx` (`SiteId` ASC) VISIBLE,
  INDEX `Participate_Researcher_fk_idx` (`ResearcherId` ASC) VISIBLE,
  CONSTRAINT `fk_Participate_Site`
    FOREIGN KEY (`SiteId`)
    REFERENCES `PenguinWebsite`.`Sites` (`SiteId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Participate_Researcher_fk`
    FOREIGN KEY (`ResearcherId`)
    REFERENCES `PenguinWebsite`.`Researchers` (`UserId`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PenguinWebsite`.`Weathers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PenguinWebsite`.`Weathers` ;

CREATE TABLE IF NOT EXISTS `PenguinWebsite`.`Weathers` (
  `WeatherId` INT NOT NULL AUTO_INCREMENT,
  `Time` DATETIME NULL,
  `TmpOut` FLOAT NULL,
  `TmpH` FLOAT NULL,
  `TmpL` FLOAT NULL,
  `WindSpeed` FLOAT NULL,
  `WindDir` VARCHAR(45) NULL,
  `WindRun` FLOAT NULL,
  `HiSpeed` FLOAT NULL,
  `WindChill` VARCHAR(45) NULL,
  `Bar` VARCHAR(45) NULL,
  `HeatDD` VARCHAR(45) NULL,
  `CoolDD` VARCHAR(45) NULL,
  `TmpIn` VARCHAR(45) NULL,
  `HumIn` VARCHAR(45) NULL,
  `ArcInt` VARCHAR(45) NULL,
  `Longitude` DOUBLE NULL,
  `Latitude` DOUBLE NULL,
  PRIMARY KEY (`WeatherId`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
