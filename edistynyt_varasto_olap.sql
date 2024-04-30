-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema edistynyt_varasto_OLAP
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema edistynyt_varasto_OLAP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `edistynyt_varasto_OLAP` DEFAULT CHARACTER SET utf8 ;
USE `edistynyt_varasto_OLAP` ;

-- -----------------------------------------------------
-- Table `edistynyt_varasto_OLAP`.`rental_item_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `edistynyt_varasto_OLAP`.`rental_item_dim` (
  `item_key` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `status_id` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `category_id` INT NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`item_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `edistynyt_varasto_OLAP`.`user_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `edistynyt_varasto_OLAP`.`user_dim` (
  `user_key` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `role_id` INT NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_key`),
  UNIQUE INDEX `user_key_UNIQUE` (`user_key` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `edistynyt_varasto_OLAP`.`date_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `edistynyt_varasto_OLAP`.`date_dim` (
  `date_key` INT NOT NULL AUTO_INCREMENT,
  `year` INT NOT NULL,
  `month` INT NOT NULL,
  `week` INT NOT NULL,
  `day` INT NOT NULL,
  `hour` INT NOT NULL,
  `min` INT NOT NULL,
  `sec` INT NOT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE INDEX `date_key_UNIQUE` (`date_key` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `edistynyt_varasto_OLAP`.`rental_fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `edistynyt_varasto_OLAP`.`rental_fact` (
  `created_date` INT NOT NULL,
  `due_date` INT NOT NULL,
  `user` INT NOT NULL,
  `item` INT NOT NULL,
  PRIMARY KEY (`created_date`, `due_date`, `user`, `item`),
  INDEX `last_rental_date` (`due_date` ASC),
  INDEX `user_renter` (`user` ASC),
  INDEX `rented_item` (`item` ASC),
  CONSTRAINT `fk_rental_fact_date_dim1`
    FOREIGN KEY (`created_date`)
    REFERENCES `edistynyt_varasto_OLAP`.`date_dim` (`date_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_fact_date_dim2`
    FOREIGN KEY (`due_date`)
    REFERENCES `edistynyt_varasto_OLAP`.`date_dim` (`date_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_fact_user_dim1`
    FOREIGN KEY (`user`)
    REFERENCES `edistynyt_varasto_OLAP`.`user_dim` (`user_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_fact_rental_item_dim1`
    FOREIGN KEY (`item`)
    REFERENCES `edistynyt_varasto_OLAP`.`rental_item_dim` (`item_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `edistynyt_varasto_OLAP`.`rental_returned_fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `edistynyt_varasto_OLAP`.`rental_returned_fact` (
  `returned_date` INT NOT NULL,
  `item` INT NOT NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`returned_date`, `item`, `user`),
  INDEX `item_returned` (`item` ASC),
  INDEX `returner_user` (`user` ASC),
  CONSTRAINT `fk_rental_returned_fact_date_dim1`
    FOREIGN KEY (`returned_date`)
    REFERENCES `edistynyt_varasto_OLAP`.`date_dim` (`date_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_returned_fact_rental_item_dim1`
    FOREIGN KEY (`item`)
    REFERENCES `edistynyt_varasto_OLAP`.`rental_item_dim` (`item_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_returned_fact_user_dim1`
    FOREIGN KEY (`user`)
    REFERENCES `edistynyt_varasto_OLAP`.`user_dim` (`user_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `edistynyt_varasto_OLAP`.`item_fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `edistynyt_varasto_OLAP`.`item_fact` (
  `item_id` INT NOT NULL,
  `date_created` INT NOT NULL,
  PRIMARY KEY (`item_id`, `date_created`),
  INDEX `date_item_added` (`date_created` ASC),
  CONSTRAINT `fk_item_fact_rental_item_dim`
    FOREIGN KEY (`item_id`)
    REFERENCES `edistynyt_varasto_OLAP`.`rental_item_dim` (`item_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_fact_date_dim1`
    FOREIGN KEY (`date_created`)
    REFERENCES `edistynyt_varasto_OLAP`.`date_dim` (`date_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
