-- MySQL Script generated by MySQL Workbench
-- Sun 06 Feb 2022 10:49:50 PM CET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CubeReview
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CubeReview` ;

-- -----------------------------------------------------
-- Schema CubeReview
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CubeReview` ;
USE `CubeReview` ;

-- -----------------------------------------------------
-- Table `CubeReview`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`Role` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`Role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CubeReview`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`User` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `creation_time` DATETIME NOT NULL,
  `user_role_id` INT NOT NULL,
  `about` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_User_Role1_idx` (`user_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_Role1`
    FOREIGN KEY (`user_role_id`)
    REFERENCES `CubeReview`.`Role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CubeReview`.`CubeType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`CubeType` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`CubeType` (
  `cube_type_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cube_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CubeReview`.`Cube`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`Cube` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`Cube` (
  `cube_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `release_year` INT NOT NULL,
  `image_path` VARCHAR(200) NOT NULL,
  `cube_cube_type_id` INT NOT NULL,
  PRIMARY KEY (`cube_id`),
  INDEX `fk_Cube_CubeType1_idx` (`cube_cube_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cube_CubeType1`
    FOREIGN KEY (`cube_cube_type_id`)
    REFERENCES `CubeReview`.`CubeType` (`cube_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CubeReview`.`Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`Review` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`Review` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(300) NULL,
  `creation_time` DATETIME NOT NULL,
  `review_user_id` INT NOT NULL,
  `review_cube_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `votes` INT NOT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `fk_Review_User_idx` (`review_user_id` ASC) VISIBLE,
  INDEX `fk_Review_Cube1_idx` (`review_cube_id` ASC) VISIBLE,
  CONSTRAINT `fk_Review_User`
    FOREIGN KEY (`review_user_id`)
    REFERENCES `CubeReview`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Review_Cube1`
    FOREIGN KEY (`review_cube_id`)
    REFERENCES `CubeReview`.`Cube` (`cube_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CubeReview`.`UserLikeReview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`UserLikeReview` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`UserLikeReview` (
  `like_user_id` INT NOT NULL,
  `like_review_id` INT NOT NULL,
  `likes` TINYINT(1) NOT NULL,
  PRIMARY KEY (`like_user_id`, `like_review_id`),
  INDEX `fk_User_has_Review_Review1_idx` (`like_review_id` ASC) VISIBLE,
  INDEX `fk_User_has_Review_User1_idx` (`like_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Review_User1`
    FOREIGN KEY (`like_user_id`)
    REFERENCES `CubeReview`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Review_Review1`
    FOREIGN KEY (`like_review_id`)
    REFERENCES `CubeReview`.`Review` (`review_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CubeReview`.`FollowUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`FollowUser` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`FollowUser` (
  `follower_id` INT NOT NULL,
  `followed_id` INT NOT NULL,
  `follow_date` DATETIME NOT NULL,
  PRIMARY KEY (`follower_id`, `followed_id`),
  INDEX `fk_User_has_User_User2_idx` (`followed_id` ASC) VISIBLE,
  INDEX `fk_User_has_User_User1_idx` (`follower_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_User_User1`
    FOREIGN KEY (`follower_id`)
    REFERENCES `CubeReview`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_User_User2`
    FOREIGN KEY (`followed_id`)
    REFERENCES `CubeReview`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CubeReview`.`FavoriteCube`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`FavoriteCube` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`FavoriteCube` (
  `favourite_cube_id` INT NOT NULL,
  `favourite_user_id` INT NOT NULL,
  PRIMARY KEY (`favourite_cube_id`, `favourite_user_id`),
  INDEX `fk_Cube_has_User_User1_idx` (`favourite_user_id` ASC) VISIBLE,
  INDEX `fk_Cube_has_User_Cube1_idx` (`favourite_cube_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cube_has_User_Cube1`
    FOREIGN KEY (`favourite_cube_id`)
    REFERENCES `CubeReview`.`Cube` (`cube_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cube_has_User_User1`
    FOREIGN KEY (`favourite_user_id`)
    REFERENCES `CubeReview`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CubeReview`.`ReviewComment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`ReviewComment` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`ReviewComment` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `comment_user_id` INT NOT NULL,
  `comment_review_id` INT NOT NULL,
  `content` VARCHAR(300) NOT NULL,
  `comment_date` DATETIME NOT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `fk_User_has_Review_Review2_idx` (`comment_review_id` ASC) VISIBLE,
  INDEX `fk_User_has_Review_User2_idx` (`comment_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Review_User2`
    FOREIGN KEY (`comment_user_id`)
    REFERENCES `CubeReview`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Review_Review2`
    FOREIGN KEY (`comment_review_id`)
    REFERENCES `CubeReview`.`Review` (`review_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CubeReview`.`CubeRequest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`CubeRequest` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`CubeRequest` (
  `cube_request_id` INT NOT NULL AUTO_INCREMENT,
  `cube_request_user_id` INT NOT NULL,
  `cube_name` VARCHAR(45) NOT NULL,
  `content` VARCHAR(300) NULL,
  `approved` INT NULL,
  PRIMARY KEY (`cube_request_id`),
  INDEX `fk_CubeRequest_User1_idx` (`cube_request_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_CubeRequest_User1`
    FOREIGN KEY (`cube_request_user_id`)
    REFERENCES `CubeReview`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CubeReview`.`ReportReview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CubeReview`.`ReportReview` ;

CREATE TABLE IF NOT EXISTS `CubeReview`.`ReportReview` (
  `report_review_id` INT NOT NULL AUTO_INCREMENT,
  `report_review_id_user` INT NOT NULL,
  `report_review_review_id` INT NOT NULL,
  `content` VARCHAR(300) NOT NULL,
  INDEX `fk_User_has_Review_Review3_idx` (`report_review_review_id` ASC) VISIBLE,
  INDEX `fk_User_has_Review_User3_idx` (`report_review_id_user` ASC) VISIBLE,
  PRIMARY KEY (`report_review_id`),
  CONSTRAINT `fk_User_has_Review_User3`
    FOREIGN KEY (`report_review_id_user`)
    REFERENCES `CubeReview`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Review_Review3`
    FOREIGN KEY (`report_review_review_id`)
    REFERENCES `CubeReview`.`Review` (`review_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
