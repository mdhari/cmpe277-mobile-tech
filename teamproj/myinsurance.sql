SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `myinsurance` ;
CREATE SCHEMA IF NOT EXISTS `myinsurance` DEFAULT CHARACTER SET utf8 ;
USE `myinsurance` ;

-- -----------------------------------------------------
-- Table `myinsurance`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `myinsurance`.`users` ;

CREATE  TABLE IF NOT EXISTS `myinsurance`.`users` (
  `idusers` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `policy_number` INT NOT NULL ,
  PRIMARY KEY (`idusers`) ,
  UNIQUE INDEX `policy_number_UNIQUE` (`policy_number` ASC) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) )
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `myinsurance`.`drivers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `myinsurance`.`drivers` ;

CREATE  TABLE IF NOT EXISTS `myinsurance`.`drivers` (
  `iddrivers` INT NOT NULL AUTO_INCREMENT ,
  `license_id` VARCHAR(8) NOT NULL ,
  `full_name` VARCHAR(255) NOT NULL ,
  `address1` VARCHAR(45) NOT NULL ,
  `address2` VARCHAR(45) NULL ,
  `city` VARCHAR(45) NOT NULL ,
  `state` VARCHAR(2) NOT NULL ,
  `date_of_birth` DATE NOT NULL ,
  `zipcode` INT NOT NULL ,
  `policy_number` INT NOT NULL ,
  PRIMARY KEY (`iddrivers`) ,
  UNIQUE INDEX `license_id_UNIQUE` (`license_id` ASC) )
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `myinsurance`.`vehicles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `myinsurance`.`vehicles` ;

CREATE  TABLE IF NOT EXISTS `myinsurance`.`vehicles` (
  `idvehicles` INT NOT NULL AUTO_INCREMENT ,
  `make` VARCHAR(45) NOT NULL ,
  `model` VARCHAR(45) NOT NULL ,
  `year` INT NOT NULL ,
  `vin` VARCHAR(17) NOT NULL ,
  `policy_number` INT NOT NULL ,
  PRIMARY KEY (`idvehicles`) ,
  UNIQUE INDEX `vin_UNIQUE` (`vin` ASC) )
ENGINE = MyISAM;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
