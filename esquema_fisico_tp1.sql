-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema web_tp1_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema web_tp1_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `web_tp1_db` DEFAULT CHARACTER SET utf8 ;
USE `web_tp1_db` ;

-- -----------------------------------------------------
-- Table `web_tp1_db`.`xdk`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_tp1_db`.`xdk` ;

CREATE TABLE IF NOT EXISTS `web_tp1_db`.`xdk` (
  `username` VARCHAR(45) NOT NULL,
  `lat` DECIMAL(10,8) NOT NULL,
  `long` DECIMAL(11,8) NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `web_tp1_db`.`valores_sensores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `web_tp1_db`.`valores_sensores` ;

CREATE TABLE IF NOT EXISTS `web_tp1_db`.`valores_sensores` (
  `temp` INT NULL,
  `ruido` INT NULL,
  `data` VARCHAR(45) NULL,
  `sensor_lat` DECIMAL(10,8) NULL,
  `sensor_long` DECIMAL(11,8) NULL,
  `xdk_username` VARCHAR(45) NOT NULL,
  INDEX `fk_valores_sensores_xdk_idx` (`xdk_username` ASC),
  CONSTRAINT `username`
    FOREIGN KEY (`xdk_username`)
    REFERENCES `web_tp1_db`.`xdk` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
