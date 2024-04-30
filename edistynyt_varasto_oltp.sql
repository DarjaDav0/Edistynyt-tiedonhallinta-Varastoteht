-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lapinamk_varasto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lapinamk_varasto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lapinamk_varasto` DEFAULT CHARACTER SET utf8 ;
USE `lapinamk_varasto` ;

-- -----------------------------------------------------
-- Table `lapinamk_varasto`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lapinamk_varasto`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `role_UNIQUE` (`role` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lapinamk_varasto`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lapinamk_varasto`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `deleted_at` DATETIME NULL,
  `roles_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_users_roles_idx` (`roles_id` ASC),
  CONSTRAINT `fk_users_roles`
    FOREIGN KEY (`roles_id`)
    REFERENCES `lapinamk_varasto`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lapinamk_varasto`.`rental_item_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lapinamk_varasto`.`rental_item_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lapinamk_varasto`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lapinamk_varasto`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lapinamk_varasto`.`rental_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lapinamk_varasto`.`rental_items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `created_at` DATETIME NOT NULL,
  `deleted_at` DATETIME NULL,
  `address` VARCHAR(255) NOT NULL,
  `rental_item_statuses_id` INT NOT NULL,
  `created_by_id` INT NOT NULL,
  `categories_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rental_items_rental_item_statuses1_idx` (`rental_item_statuses_id` ASC),
  INDEX `fk_rental_items_users1_idx` (`created_by_id` ASC),
  INDEX `fk_rental_items_categories1_idx` (`categories_id` ASC),
  CONSTRAINT `fk_rental_items_rental_item_statuses1`
    FOREIGN KEY (`rental_item_statuses_id`)
    REFERENCES `lapinamk_varasto`.`rental_item_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_items_users1`
    FOREIGN KEY (`created_by_id`)
    REFERENCES `lapinamk_varasto`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_items_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `lapinamk_varasto`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lapinamk_varasto`.`features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lapinamk_varasto`.`features` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `feature` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `feature_UNIQUE` (`feature` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lapinamk_varasto`.`rental_items_has_features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lapinamk_varasto`.`rental_items_has_features` (
  `rental_items_id` INT NOT NULL,
  `features_id` INT NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`rental_items_id`, `features_id`),
  INDEX `fk_rental_items_has_features_features1_idx` (`features_id` ASC),
  INDEX `fk_rental_items_has_features_rental_items1_idx` (`rental_items_id` ASC),
  CONSTRAINT `fk_rental_items_has_features_rental_items1`
    FOREIGN KEY (`rental_items_id`)
    REFERENCES `lapinamk_varasto`.`rental_items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_items_has_features_features1`
    FOREIGN KEY (`features_id`)
    REFERENCES `lapinamk_varasto`.`features` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lapinamk_varasto`.`rental_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lapinamk_varasto`.`rental_transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `due_date` DATETIME NOT NULL,
  `returned_at` DATETIME NULL,
  `rental_items_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rental_transactions_rental_items1_idx` (`rental_items_id` ASC),
  INDEX `fk_rental_transactions_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_rental_transactions_rental_items1`
    FOREIGN KEY (`rental_items_id`)
    REFERENCES `lapinamk_varasto`.`rental_items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_transactions_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `lapinamk_varasto`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `lapinamk_varasto`.`roles`
-- -----------------------------------------------------
START TRANSACTION;
USE `lapinamk_varasto`;
INSERT INTO `lapinamk_varasto`.`roles` (`id`, `role`) VALUES (1, 'admin');
INSERT INTO `lapinamk_varasto`.`roles` (`id`, `role`) VALUES (2, 'personnel');
INSERT INTO `lapinamk_varasto`.`roles` (`id`, `role`) VALUES (3, 'customer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lapinamk_varasto`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `lapinamk_varasto`;
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (1, 'rlydiate0', '$2a$04$EqVnnU/O1yxV8GNRz6orKObBLjqjO5t4WqnmihUXRrF2DG/40JTv6', '2023-11-04 01:46:56', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (2, 'cluff1', '$2a$04$KaQxdd.EV2rJfH4pQF8.5e2oZQqOKsJWbHyHYB898xn/Ak3CKOlom', '2023-05-23 01:40:16', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (3, 'chastler2', '$2a$04$yVdo.3a3DEyOoXpYaGkRberZHm60VsItvaIsWayLpqSlHPVNfkQs.', '2024-02-17 22:22:49', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (4, 'ciannetti3', '$2a$04$ggbOo959HA9ys7EmgXo1zuIZGpGma6ESwk05/IfzWJVisVle2.1ga', '2023-05-30 13:23:24', '2024-03-23 14:20:11', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (5, 'mcoopey4', '$2a$04$RTb310O92fZ3EwSv2g2OPOJfL7bv6Bo1nGb.iWAaNMcHaOBK.FHjO', '2024-03-28 20:32:55', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (6, 'bseeney5', '$2a$04$EidnzmwhNlhgel1DYImZQeHDrr.SOVmW7ERon8xDhJuAx4VHF50FK', '2024-03-31 11:38:46', '2023-12-16 23:58:25', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (7, 'tvogelein6', '$2a$04$RJjOIRXwUOZ17n2CEBORaOV04wr4U6Bd7RshIlGIyDvenvffxneeK', '2023-11-27 02:15:13', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (8, 'cbrims7', '$2a$04$02GWfsqZT/OqxCB7N2BQ..Dne9usB3rgUks0/ZVIdwgObDgGr/1Om', '2023-09-07 10:42:52', '2023-06-29 20:32:47', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (9, 'bbeesey8', '$2a$04$jzjxlAdHnTuM.38k4pc9P.Uz3Tj30kch6p5qPJUJrRnOhOxuvnvIO', '2023-06-26 17:05:39', '2023-06-22 18:52:38', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (10, 'bwestrip9', '$2a$04$t29aj5xp8AbEj.Er6pPSiOK9ry2EW9hk4x7urH/NNdxMituNTD3h6', '2023-04-16 05:18:23', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (11, 'sandrzejowskia', '$2a$04$yvZ6HUFTHCOvuq6De.WIj.WIzzjADT7q39LBQGiAW3iQTBtXmiaEy', '2023-05-03 09:11:02', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (12, 'ltinanb', '$2a$04$59ZyXV29NmPQuR0CXYDikuidlyAYf1PRtae9WgAjx8PzUgigD93Ju', '2024-02-18 23:32:36', '2024-03-19 19:35:26', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (13, 'edomenyc', '$2a$04$HrqlnLQzDx2dqq7QEEBn7OOUI79tOkf4.PONphQjvNF6nZX8OrQ6u', '2023-09-13 14:54:51', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (14, 'cdrabled', '$2a$04$YB80h2BwK8WYT8ZJETOK1OyE.ARGgp2sKUlCAj6ZwN0odXN4FDWfW', '2023-04-22 09:15:21', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (15, 'drallse', '$2a$04$5BHZGi6QGsrh31UsafU0OuyhYqn1CW0Na9FYRyXPR8SA4fN.Ob/ji', '2023-07-23 12:42:08', '2023-04-13 08:24:43', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (16, 'flambrichtf', '$2a$04$0FJDywyDhSbkypqWK4yDMeWlGDIE7qynKg1hiztmcfxgmE5WHpB2i', '2023-07-08 05:06:51', '2023-08-24 16:28:26', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (17, 'dbosenworthg', '$2a$04$VXF9Tw2s8omPssfqUgHbq.LTGfYStsAOVUqSui2OTJKaneLbUfPzm', '2023-07-08 11:09:28', '2024-02-13 03:57:44', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (18, 'ffolkh', '$2a$04$0s7kZOTDZ/78JCbxNgKPYejpAI13KsnH6T9/cp8SXVkfOgWbYUM1G', '2023-06-24 17:28:23', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (19, 'etilburni', '$2a$04$yhq0M2ebCs3oJzgCpdrKneuH5AGC30xlu5OGSvXKtlm2GP8cIeHmC', '2024-01-15 03:23:34', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (20, 'cplaistowej', '$2a$04$32s52NxAYqJzVxP0XirB8egRVBHb3fBgt1SFvdS3ebqP7HQL32qYS', '2023-10-10 02:36:56', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (21, 'omcilroyk', '$2a$04$egP31jsHmrLsVUmETFyYxu5MEB3f1rPb/.FQZAI4n18r09zbsKIxS', '2024-01-27 08:10:37', '2023-08-22 15:20:40', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (22, 'eblythl', '$2a$04$sstm3Q/LXfn9EVytDQiqSeIoLxghOaU9bE3/LioBwJyHDHCPjYdsq', '2023-05-21 07:58:51', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (23, 'bghidellim', '$2a$04$qBQWu2Jg2VLM/95HmnNixuwMP39qt7nN2vVyh4fhqAfqQG8CsfoHa', '2023-04-28 15:01:27', '2023-08-07 09:38:05', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (24, 'mswepsonn', '$2a$04$pBeYrQbAguMV4PXOWR68HeBQ2VWxRJvWhAIp96QGlf55mYrVeHXqu', '2023-05-26 23:58:15', '2024-02-27 17:32:36', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (25, 'lduigenano', '$2a$04$fmzgIhVzHbXq/xPy7ZrnK.OMxE.x0HY8Ix.rLPfcP04Evycq5Viaa', '2023-10-03 07:06:01', '2023-12-20 20:43:05', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (26, 'hbarckep', '$2a$04$HTRqt3nGvEu5vOd1tZbup.5KjnSmMm7xGkyz/MYbHvjwNIjlCnJC6', '2023-06-10 04:13:45', '2023-06-26 08:18:58', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (27, 'dbertheletq', '$2a$04$Uai3Gwhn.fV02hRiZ5HMeeCPU.2JvAvcOFQ9y8i3GcJSToyrXS3hK', '2023-05-03 02:35:37', '2024-02-26 05:18:51', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (28, 'bborrottr', '$2a$04$sj3Z8vJKmxmjPSfCtZBnXep07vV6dN60yyDtA0JshsIh9AhkkTcXe', '2023-10-15 11:23:37', '2024-02-11 12:08:35', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (29, 'amccromleys', '$2a$04$gXnZp6TXHURnM7LlgS9WQ.r/lFS.ywAIQNlQS/0LgzNFB.892LuxK', '2023-10-21 23:28:22', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (30, 'bproctort', '$2a$04$wE3VtY3cTNSIPaq65/a/HODLGGcwt0lpleSykj.uRed.lci6LOsla', '2023-10-17 14:20:07', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (31, 'jreadeu', '$2a$04$RvSr1FLjWwbFer4Ch5xy9u/uHbdsqmM1TJmmPae9f0zzldAKCo4tu', '2023-10-17 17:03:38', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (32, 'gguillotinv', '$2a$04$DEzgRuxoagXB5NZ/tyfcnOMimAPxNlgu7RotdDnI9lLvOkSlewBSu', '2024-03-26 02:39:09', '2023-07-07 05:57:24', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (33, 'gpilcherw', '$2a$04$vm7QYp3gc89mxfBZ2elpFeqwQNOcHTAsSa5YHFiB/pk58p0ykUh2i', '2023-10-28 08:00:28', '2023-12-02 13:24:06', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (34, 'aneliusx', '$2a$04$aT9D6.h048BLM4WBpXr12OotxVGf7WRtzKGnZlOUAWGZNcTrUeKUi', '2023-11-06 15:06:36', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (35, 'econibeery', '$2a$04$thRUjGCpF4N9A6Clwz6YQ.8eKhyh7WpT3EJ3BAD7vMqLpqsVKV2/C', '2023-07-04 01:37:44', '2023-07-27 08:32:20', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (36, 'mmcmoyerz', '$2a$04$nS15gbYXX5t1vpJAO2aKueXSmi6YDHMyQtvnG2QmYRROcjsKccKFm', '2024-02-16 21:45:23', '2024-02-17 00:48:26', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (37, 'ksoutter10', '$2a$04$RuGFTpQ.zT.A5pSCu3tcI.2c2aimlJfu/cAWuCpJU8ylm.E8r/NES', '2023-05-22 07:11:03', '2023-05-10 04:23:55', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (38, 'arowler11', '$2a$04$Pk2vTjolY3eUScpTETp7NOaL5ixQFdTOFTDqFXB9T6MnsHDxpjoE.', '2023-10-18 08:21:53', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (39, 'vrumble12', '$2a$04$v22SDFagAmk5CBJNva0GEOmWxOjw00vb6eEl.nP09ksap/M4KB/j2', '2023-07-23 19:37:31', '2023-11-08 11:31:13', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (40, 'jmcdermid13', '$2a$04$BCgRqTJK8m3PjViy1QArzOveg6Ngr1jrfYiO2Lo2sAb6XjptAXp2i', '2023-12-07 21:53:30', '2024-03-12 00:19:28', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (41, 'proggers14', '$2a$04$EE0lXVnQX42SJJpnpscbS.pktUHbHFQk/hW5WLg3k3o5b687LLA3u', '2023-06-03 09:03:32', '2023-06-09 12:34:39', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (42, 'pbrozsset15', '$2a$04$7dCH.OeWPrKr9hZ.7AYZtOeXC1OT8CepEjtRJWfduzeoK..MpVzgS', '2023-04-11 10:47:04', '2023-08-26 23:16:35', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (43, 'sthomann16', '$2a$04$5YHHE13SG.MM/l0J6s/diuH6LTFuDVUD2iXI//klBy/.vxnhktZeu', '2024-03-11 22:57:24', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (44, 'mfetherstone17', '$2a$04$XxE3LcQOkqBhf71lu56BUe0y7zkgf.sCF1bSuMlA2d7/09lqI.nEG', '2023-05-10 05:50:20', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (45, 'rcreeboe18', '$2a$04$cWnyWCogtrsUX3hu9QqntOF18ZA1ecF6Uwh5QDG6Oo8QNtHNoLXi2', '2023-11-21 06:57:02', '2023-05-21 21:53:42', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (46, 'orozet19', '$2a$04$TTgX.mf9eIquraBVBg3y5O/mrfG.pLqZtkGzrBHDu3PhX1k6xGpJe', '2024-01-06 11:11:08', '2023-11-20 20:16:24', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (47, 'emccomb1a', '$2a$04$YU7lGHpMnZvvN3pMO1HOHOxn1/bpBpZ0ANkhY8WxxId71LpIkcXqa', '2023-12-24 08:52:32', '2023-10-28 15:48:56', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (48, 'ghowship1b', '$2a$04$8HmS8kXUUMN43/3OHzBgmeAD6RkHtJCSDfjaKIHz7hx1g17Zj9EkW', '2024-02-07 11:01:47', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (49, 'dgrace1c', '$2a$04$h1Z8sPaKGDHfIWGkFTT3i.0555jCKALD1wyhAzGUuasgfMr67HkSm', '2023-08-31 18:37:28', '2023-12-10 04:50:38', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (50, 'drosenthal1d', '$2a$04$vrerlNV3dyWr9nFo/dcO9ewPXiIchI0QT6Pc1WGewvC/vLavgMZ1O', '2023-09-21 09:22:39', '2023-06-25 08:40:08', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (51, 'phowerd1e', '$2a$04$Ny4f5JdZVYyPZw6p3pYQFuBXVB1bsbpeWP0ifboBXpN7ZtcQHiQNe', '2023-06-21 13:36:39', '2023-05-09 20:07:09', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (52, 'dminchell1f', '$2a$04$89AnLQ.wImnh4zLnF0Yfjue4GKrjBgoik921lVctSVKjMwDwsxmbi', '2024-01-11 10:14:59', '2023-04-23 20:21:24', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (53, 'afollis1g', '$2a$04$tImFpd5IPtkPYnixlX61pu1jyOylfly0xFmuNQ/mPTGksTihIaY.6', '2023-06-09 15:38:37', '2023-04-26 15:50:04', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (54, 'scharlon1h', '$2a$04$eaR60k63Jbfcz5U1L..xy.e/ZN4nhp.HF3vNDFxrR0Tpyw1e6TkdS', '2023-08-28 02:34:09', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (55, 'jdodworth1i', '$2a$04$onTKf/Y83zcerfWAFMW.n.l/k/ufP34ToxEe0mGi72FkNcSTKn3c6', '2024-04-02 21:48:24', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (56, 'lallain1j', '$2a$04$BsHQCpscWulpWQ6hz/6bw./Q3EGOJz9mRfgvgLrSs0qyf4sYcSO5m', '2023-04-18 08:12:56', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (57, 'lgaitskell1k', '$2a$04$3ol/AYQM6A1d94jzP40zMepyO6IbQyrhOjzhIoxvm1B4thEzsNPty', '2024-01-02 16:34:42', '2024-02-10 17:38:30', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (58, 'wmoring1l', '$2a$04$tCDI6LeDAOsIR0OoIzOvg.aTCRS.Dnd.B8Y6EVb38ewo7VSOScyVa', '2024-03-28 01:01:56', '2023-11-08 20:33:31', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (59, 'cpomfrey1m', '$2a$04$A2IsnH9Xy6d86YERT3vci.xAFfxPAufKoaaOiMsnjgisVFzpfLQLu', '2024-01-26 04:49:18', '2023-12-16 03:03:04', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (60, 'atoffoloni1n', '$2a$04$jOnvd4kGksA63SuVng.lYuEARrEHEkNUwDc49aBE1V9z61uZUOBoy', '2024-03-24 03:15:01', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (61, 'jbrumham1o', '$2a$04$IfasnS.1oHTCKSlQSGd2he3aFC6tU7UxrlhuMEEmSWm7XY259BASq', '2023-05-19 10:18:45', '2023-09-06 07:10:28', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (62, 'whughland1p', '$2a$04$yY17p1Q9ybQjSjbiyJV33OK2HUj.2voDUie4cr/ldrO.wkzF9g9Jy', '2024-03-14 02:44:26', '2024-01-19 06:55:57', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (63, 'ktompkin1q', '$2a$04$O2R895UOncZrk.pbRWmOnOCdU6VwUtxkvoRAhuNLgEE2WUZeZm0qy', '2024-01-08 04:12:41', '2024-01-10 02:31:57', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (64, 'mdodle1r', '$2a$04$ylKd5IiNduPYmfizeAQRLeLe7C0gIYdhALq8ATsuCAbKKI.DGNB/e', '2023-04-24 22:04:54', '2023-12-13 01:30:30', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (65, 'amaher1s', '$2a$04$5kup3lQl1NozoOZA.cu17e4d8uOxkBJ9NQmjkOrY2fGrQuLUkTK8W', '2023-12-12 12:27:51', '2024-02-20 16:50:52', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (66, 'gstiger1t', '$2a$04$ntaKF/ReIZi2s.k/diSjRufJH9uDOm0bVSPg8Cd7tUs.6CuoskGqe', '2023-06-24 22:57:06', '2023-11-06 17:29:21', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (67, 'gvandenvelde1u', '$2a$04$376VibH6KB2XLo0y6umHSusiGr8JG2Pwosywfb.V6Pwaq5dVk9JaG', '2024-02-12 14:31:02', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (68, 'vverryan1v', '$2a$04$RSY9c7mWusUeTRkFTTf.C.5aX82nN8tUvHiQK59fLha/AoLQG4gAe', '2023-05-17 11:28:56', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (69, 'wkleinhandler1w', '$2a$04$Lx8VPTLXQaj.y1OBp8lEWednAP5tgW3bDBiKwi.NTICyi7EHCCMNy', '2023-07-19 05:15:09', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (70, 'athundercliffe1x', '$2a$04$pzHgBAtdEdDB4qiHiZExp.B6akH/C2aiarkKugwiCfZ28DFZDkPwS', '2024-01-04 21:05:09', '2023-12-24 06:47:09', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (71, 'rcostanza1y', '$2a$04$9JNfTgWG0D2UTAclUSwbF.TMWEx/kPl0SCYnoEZrKDOMaTM4XjhEC', '2024-02-24 15:24:48', '2024-03-12 10:17:59', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (72, 'nmatchitt1z', '$2a$04$Rmr2wrQ0sMPw5hrt6RrMAeb4f6gX8oNJwQ.cLKKojgHLT5y0V8QS6', '2023-12-07 04:52:30', '2023-04-16 14:35:04', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (73, 'bdormand20', '$2a$04$PIjrGwMi4XSKqtVIyukP0uX6DZpImfHwSGDGYvMdBS1gpHqpKHala', '2023-05-26 13:14:09', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (74, 'lbeazley21', '$2a$04$XqBhmLjux2lZph.CsKNCRO2fjB6zpgu6NW3KAJOVlk1ZH0.IxEEL.', '2024-03-30 12:55:20', '2023-04-14 13:00:39', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (75, 'hskamell22', '$2a$04$xNXvdEQO1F/U8ohTDON3OeAyMcF26T5ytafxUu.gt6p5wcwqVr/ni', '2023-07-17 05:49:53', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (76, 'mwingham23', '$2a$04$OB056a4T3c10cBWmmKRgr.Kn2Uzv6kUj3qJKXSt0Wkmiug1dCANKK', '2023-10-18 09:32:30', '2023-10-08 09:15:59', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (77, 'hcradock24', '$2a$04$JXSz6gxel2ZWuq.qmHLi7.CVFy3dXl6PVATjUZxy40740OuTjBcZW', '2024-01-03 21:37:50', '2023-12-02 19:37:31', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (78, 'ebuzine25', '$2a$04$HjmMog2SHPFxLC7dQfl9uOyx52LgEnkfVkZM5zv/a4jL7cLpJUEv2', '2023-07-20 19:00:39', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (79, 'cfranck26', '$2a$04$KauyC7tLGCBLcT/GqsywquBA6vULM7KgUN.Sa9MyvSDHo3pS4O.Ma', '2023-09-14 11:47:36', '2023-09-25 04:49:53', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (80, 'cbreese27', '$2a$04$CKHbQ4tVe1.DaPcExSTsp.TQ0hLrxtL.V59.kA6Bf7Ti/w0op.jSq', '2023-05-04 17:56:19', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (81, 'etriggs28', '$2a$04$zaCDTXSNf2dIDRwzu67t2eSgw7bW9Flemr6yQ3UC9vLuK5O1TxCqi', '2023-05-30 06:59:09', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (82, 'kpladen29', '$2a$04$yMEMJPubSXkaHOTocHYBfOHC5owbWhXBgyLfS2eWBAYV8iHz6M052', '2023-12-23 19:37:44', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (83, 'fbrenston2a', '$2a$04$M0rLwPYIBHmQUdKgRwHxz.VYPu58A7X0y5QrZOUjU2luRW4qXo2u.', '2023-11-23 12:38:23', '2024-01-08 23:19:56', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (84, 'emanlow2b', '$2a$04$vanHRqqSlXll/bLAyeG8Vu2W8Cw1ijBY6tFqRccqAOOsa.X1f8ltC', '2023-08-21 03:51:34', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (85, 'thillhouse2c', '$2a$04$AwU5F0FI6FiwJ3xachVDBetcFwc9od2RD0Pmc9XGVnNagP8vLzffS', '2024-02-19 05:28:39', '2023-11-08 06:26:34', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (86, 'jkeppel2d', '$2a$04$HjWK9PNQkkLL8xyuZ97GS.eVqjG/UjrWxauXObBadaV62pHWFLd5e', '2024-02-02 13:55:24', '2023-04-14 06:39:34', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (87, 'vgarvan2e', '$2a$04$bQx9thYGDSzOo0KoM5AHIuYEr0Qn.yOFZ72GmPXp2lhTlAWWLs0x.', '2024-02-19 17:25:57', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (88, 'lbrayshay2f', '$2a$04$gnSTRVxaWe7YKp2rOHSVHO52DPyBqzCCX76WTV93lHEq076kt6KJK', '2023-09-12 13:38:32', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (89, 'ustrewthers2g', '$2a$04$lSlA7/vqgdIJSytqZ6MbCePghTSJyY38HkrCY9cFn/1x2zfoNX/ES', '2023-08-27 04:58:54', '2024-02-04 13:48:28', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (90, 'wedds2h', '$2a$04$b3dlz9X7voErydpGZvAvY.jaV1J.lpYyTmFLtsN236nI6C2ZO591K', '2023-10-12 02:19:14', '2023-08-20 01:47:44', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (91, 'fraddin2i', '$2a$04$F2v2JJdOnvv2joaBKrHtx.R7nZ.4Tdz9/7rKyMIYuglDPQ22YYKXm', '2023-08-01 16:27:59', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (92, 'kbroadbridge2j', '$2a$04$4rCpX7OAl.nelVDEM/yAlu9COnxmnwvE0dnrn3.zRmii/f8hnPNtq', '2023-06-03 00:59:48', '2024-02-18 02:54:38', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (93, 'bdower2k', '$2a$04$nW4eG3roZW4O3KvnaMBVcObBqyWdGBLC6xm/5oEeS2Ae2BlecQhui', '2023-10-01 04:30:11', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (94, 'ifairlamb2l', '$2a$04$eokuJmoaF3LEYeP87kLQu.7mjKcNLSdPE/lv9t3AMmiUpY0zB6mZS', '2023-08-26 16:21:04', '2023-08-20 20:01:34', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (95, 'lgianolini2m', '$2a$04$gPE2WuGNsUVeUIEAAvE4hO.4TGvlu7zCWEeN9oopcv69lJOQEhmO6', '2023-12-21 11:05:38', '2023-06-01 07:29:46', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (96, 'rlathey2n', '$2a$04$iTRGBwZl4/zrVKsc0qAg1e/E2R0/JGZ0TdAhGn9SyGVt8IbBH8hjW', '2023-09-13 03:28:43', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (97, 'sguisby2o', '$2a$04$ZrzO22PrZlb5vcYQnNKjD.me09/3XrEyIrC8A.4HsvKRqN5zuFQWi', '2023-08-07 21:54:04', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (98, 'smarklund2p', '$2a$04$E/WjCsarB8K10UBljzokbO4kd5LlU71j8CKNmV4.a5Bb8pyp5GWBS', '2024-02-24 00:05:03', '2023-08-10 06:02:08', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (99, 'abraun2q', '$2a$04$ayQ0I49KSkflMOUOACAQLuPmcWlrSw4VMvIfPFjOxuD16wk3PZNvW', '2024-01-30 18:02:00', '2023-07-18 15:52:26', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (100, 'clamborn2r', '$2a$04$HLc521z2K7qKDXmtfChv2OtyRM/I2Yp/zs7O1mWdwWU51nqrQgV/K', '2023-10-25 22:26:45', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (101, 'ffancott2s', '$2a$04$EZsJ7FBi/RAPgXdmWQqSmOOg.5tdYwcZJnxwoXO2D32RrCtwtvdlq', '2023-06-06 20:22:18', '2024-03-28 08:04:31', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (102, 'bfaloon2t', '$2a$04$vKyOHsvl7X7/Iqj9t2TLu.Xj68f5oGBsPF3T9rdx2mL02HB936aVG', '2023-12-09 23:46:41', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (103, 'mchristoffels2u', '$2a$04$r9nn1faj2bHHcsujs/xhuuS8QsOJt0a/5mAxB0mP13bqpSX157pVK', '2023-05-07 22:02:23', '2023-12-02 02:21:50', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (104, 'wheindrich2v', '$2a$04$SwmzBLmnOcSBHf0xMmZLGuE.I/8BbSfwDAIzT1hUzYbJE0IFp1sIi', '2023-10-13 23:15:36', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (105, 'cgerish2w', '$2a$04$TEFdfRM3Y80e2CCSYTDLnu42X1dzEnBYLbcCZqG9VbLLNc1ve851C', '2023-11-20 08:53:43', '2023-07-16 07:50:18', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (106, 'cbullcock2x', '$2a$04$O6eQRShSHRjbFRSa5athr.L4WKPwvITGfpGC4TLpNqoyIPUt1cUnu', '2023-11-08 14:01:42', '2023-08-16 01:38:33', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (107, 'rgaven2y', '$2a$04$TFEOlyFgQW8PJcjojIls6e8oufNXbUvl7dLgqBY63GAKykzU43JUq', '2023-09-29 09:37:21', '2023-10-26 21:12:01', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (108, 'bpeppett2z', '$2a$04$QEWU/lGtlg.xg9Tu6kkbaeA7IsOp3EE61SNIbRKJSlkYG43Uqzuzi', '2023-06-23 02:05:48', '2024-04-04 05:55:12', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (109, 'nchildren30', '$2a$04$N3wSuGwotiaJ3kTOPVbiC.0gmY3ElF3SNQ5WOFlifknHlMNywDKsK', '2024-03-20 22:50:38', '2023-11-03 08:11:10', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (110, 'cbuzine31', '$2a$04$Cec0ZzOukuW9B2fKAtF58uUQQuDFJRW2nT1/22pV/kTt3ZYHk9PAm', '2024-03-12 00:36:01', '2024-01-02 13:15:02', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (111, 'oallaway32', '$2a$04$StPtX18tL2KAIw54/ZtOF.5ugtqIV/N9xwfwWwYxxs6EdFE.85jYm', '2024-02-10 13:41:42', '2023-05-22 16:27:23', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (112, 'aheinel33', '$2a$04$fKh8czyv1uP2L13dE29dh.1KcXqzqZd4GTf9I7Z7wBiOEGIX36NLe', '2023-05-15 19:23:33', '2023-07-09 00:03:53', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (113, 'spatterson34', '$2a$04$alI5LuslmBZik/XJguCEg.XUxiHeDQuh0bB9z3Ga36yDeLkyxxF.W', '2023-05-04 16:40:14', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (114, 'cwerndly35', '$2a$04$ZqhiTebFBAnydl9TOFPRT.SaLPvIUhhic78NuDP6NHuBkCah.wcyC', '2023-06-17 21:15:57', '2023-11-30 06:20:30', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (115, 'eacors36', '$2a$04$23GK/CpRaMZJ3V3xgchtD.I3bCesA9yzlzcDgFLKBzTHQXeo44A46', '2023-10-01 09:17:49', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (116, 'dmordin37', '$2a$04$iQjDV7QF4LLAGjEL3kyF7OqPzvJnMxO0ZNBT16RfYD4t36cRr.gmi', '2024-01-20 15:14:04', '2024-04-02 04:46:53', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (117, 'acutmere38', '$2a$04$wDxCfQiZ5YpQIBwQs4Zplut6wwUsjFVMOfNyO/wyuSSRVtvX2cEgi', '2023-09-16 05:40:10', '2024-03-06 14:05:36', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (118, 'cwaith39', '$2a$04$4hajTCbWMQt80ocTvjnv1uqVUwRoyUY9p.IGw/VaLb3iCf6hA5QWa', '2023-06-12 16:22:31', '2023-06-07 15:53:29', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (119, 'jlghan3a', '$2a$04$QveNJ3baU1XmQsv7QgubfeBLOK3ruMOdtvPhgQt9Uk.SAMaKnvC4.', '2024-02-16 06:28:40', '2023-10-01 13:29:56', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (120, 'dagronski3b', '$2a$04$YTrIOD5UOFpleFEZprYr6.VWeRoobbPuasASovIdAVF7lR4APf1Lq', '2023-10-23 04:28:28', '2023-06-16 03:18:28', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (121, 'abrushfield3c', '$2a$04$Sp1ePxS2JPHRgvYGkvcJ6uMj0S64qebAXIaokhruXFFdVtIkDiXtO', '2023-05-22 00:12:58', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (122, 'acharrier3d', '$2a$04$UwBdbTIcXiKJaZPoV43wsuc2ccR6mahTbCdY8XdCi27cXglljNNT.', '2023-09-04 12:05:28', '2024-01-14 23:42:50', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (123, 'jedgell3e', '$2a$04$huLZ1EO60O492tNSGM3t3exBczbtbrMgVy/HiaSejA9CaJvQQMz5.', '2023-05-03 12:56:56', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (124, 'csawley3f', '$2a$04$RNxijIpPCgX6XECv0omRTe7sk3SL/qOuZt1xxGlCJ05o1wtOLHvVq', '2023-08-29 11:53:01', '2023-10-25 05:24:11', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (125, 'clivett3g', '$2a$04$WRQKgCRSua4QGsvf.lAYPuAdcqEeU9rzwsHkMmb26w/1Yqvvt7O2G', '2023-10-20 05:33:55', '2023-11-10 23:30:28', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (126, 'tblazej3h', '$2a$04$7/zz6J7mdExIJ/GLGdPQ8OCRU/.onO3ts55i5RebkUdjwdWGagOp2', '2024-02-28 03:56:18', '2023-05-07 05:50:52', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (127, 'icosans3i', '$2a$04$l3TaBjPKcqvTngEcShUaee/y6quQTku66.TUiUBJ3Xv6wYQwFFxde', '2023-10-04 06:35:28', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (128, 'cbruhnke3j', '$2a$04$edhkst0Dyoo8SeGkLQysAu8YRLjmXIDpSVHqyimqSZSeBeKLTb5u6', '2023-07-25 03:44:43', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (129, 'ctemblett3k', '$2a$04$PTV.KI1Gnz/1KryNfS2VpO87u/FMBL6HtGisb8fa4beOGhkcB9x2m', '2023-09-29 13:09:11', '2023-06-15 10:43:22', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (130, 'mdrewclifton3l', '$2a$04$1UtaQVNGYSw/MxYvnA/2he4klndxFDbw4mElA0Ix5BN.XfBUMtpSe', '2023-05-03 02:47:12', '2023-11-01 22:49:09', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (131, 'jovitz3m', '$2a$04$O6peD7k6YEpVkM3xMDKFOuVrr2B7YlHGGpS0r2svLmwNtNDNfvEH2', '2023-12-08 16:09:16', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (132, 'llaverock3n', '$2a$04$6yAtpxGdgztmTMqRgF0qsOyHrZfl9CUz.xa..lzX/dEniKdnV.hia', '2024-02-27 11:30:41', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (133, 'ggiovanetti3o', '$2a$04$SB8qk.f.NWfiGbz15rNFEOWtoVafdy0soFsXb5I6MFtJ2150klmzK', '2024-02-09 02:43:03', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (134, 'estambridge3p', '$2a$04$NpbvS6uPk7qympQ56eqRX.aSGG6aHBXvfl6ij4SVhnqrqwuTFEjdW', '2023-05-09 11:47:57', '2023-07-15 08:48:01', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (135, 'jheinrici3q', '$2a$04$T4FO0QU5r/R5HFtuhnuQueW7TrO1nqOF8dI5GRd3qRcFdf4mp0ryC', '2023-05-27 05:19:17', '2024-01-14 15:17:55', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (136, 'araisher3r', '$2a$04$CX6o/8ZMAqhgbzpdiPJKP.XugDqT55EpSbHtrfFFQje0M9fNj6Lc6', '2024-01-04 00:34:36', '2023-10-15 12:49:27', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (137, 'fbaume3s', '$2a$04$g7MSeArKMehrNMn22XpIkeza/05Rd6JM8QfMWqW1qI.f5G6wz1wqq', '2023-10-10 10:55:28', '2024-02-22 22:05:28', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (138, 'rbeeze3t', '$2a$04$Q9dH.N2VCF4Wy1DS1u3k/e5hy5D1TirjRUjp5M9phA39nuWjIPlBu', '2024-01-16 19:38:33', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (139, 'jarundel3u', '$2a$04$0MF3zzaLLIxPEwaHCoBXSOL0Z/QnOKM7d9raBGrLL3.NerUhU.XYq', '2023-11-14 15:12:20', '2024-02-13 09:36:17', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (140, 'wpendergrast3v', '$2a$04$mKt/WOPP3tNtBpGpnQo8UeSjsrOREL4rnzo9E25TTd8ulYQ9JKopm', '2024-02-20 23:31:51', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (141, 'nbeig3w', '$2a$04$M7n6lhWMdB.PVXN86PF0A..xP1RW3jq728Q.0l3snbvUWSi4XPJ0e', '2023-06-24 11:03:14', '2023-06-26 02:01:37', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (142, 'cdy3x', '$2a$04$IN25LAWYekPWhImza3zX0OH6ZuXAmOQBMpw7Idme9Ezv/ltqjcL.i', '2023-06-26 11:26:37', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (143, 'sgosnold3y', '$2a$04$R8yu6IJA.9FXUEzWTa2gXu7Rs7Hr9eYZoCv7HUuYiaQykwdZyzSAO', '2024-01-02 10:47:32', '2023-06-17 12:16:54', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (144, 'arenon3z', '$2a$04$MX3ahBAehQDcLvWspt8xiOe4rYHJpoEAtUoFPMgDMtmDYfJokW7h2', '2023-09-11 17:46:30', '2023-10-31 23:42:33', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (145, 'bpresslee40', '$2a$04$bMNC4CF8OaqgLywDr0zQBeS5rcObnh1nhe5yxLmCzybeoj0O6gwcO', '2023-07-09 21:05:30', '2024-04-01 11:02:10', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (146, 'lwort41', '$2a$04$Oxh1ebPF.bE4juI.J1v1NOgtfCUupUciYOdyfwGAn/Nt4YnZQ7vqq', '2024-03-17 17:32:46', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (147, 'dbrewitt42', '$2a$04$0mOojuq9q9O7d13KPjCsvOFXhBHygt37FNjFp2kinIaYKk/y4eQNe', '2023-11-23 09:06:08', '2024-04-07 19:57:10', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (148, 'fbrunsden43', '$2a$04$.krFfZctAl0X7uLC.BX3HOZiwr.35tQVOF3iZdm.rNeaDh6AhHhie', '2023-08-19 15:28:36', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (149, 'tyepiskopov44', '$2a$04$d0tQl0rCamcUry4wrBJ3NeCXkRpWIctNkISQOPwN/K.tsQ3PUM2v6', '2023-11-03 05:14:47', '2023-05-10 02:52:37', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (150, 'lcreese45', '$2a$04$H5XMNHqGmNy/yk6/5zvBiuvT.jooZkC5Al/ONwLhqkhRNhFKnclrW', '2024-01-08 20:04:48', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (151, 'gohalligan46', '$2a$04$5PTKUpUwcpAXVl16jO2gWunKzdvaeME5iIjFYWc5z/4znL3D3c/IG', '2023-06-20 15:38:51', '2024-01-26 18:16:13', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (152, 'fscotchmoor47', '$2a$04$eWnzG/c504v8Op9ABIyGV.aL3Zf/xe7L6IoECTgbBMBSxgfJNrnLm', '2023-10-17 15:19:03', '2023-07-06 10:17:24', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (153, 'scoarser48', '$2a$04$gPkyBImNkMTANEsw0.dDCelcGoLzruYLPLKKG9utzl.YL7WrPGbyq', '2023-07-24 03:49:02', '2023-12-18 16:40:00', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (154, 'mcorck49', '$2a$04$HEwD7I37Y4byIFS38ERn3OdYu.KXpDZDsjOUz6VnT9dDHXBr2Yi.K', '2023-06-20 17:51:02', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (155, 'ibineham4a', '$2a$04$EciTTZMWjFUzl3FO97gbuueQOkN/QtExM5GFygUaAmjfJVqSNwiaa', '2023-07-15 08:18:39', '2024-03-17 05:04:19', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (156, 'lbutterly4b', '$2a$04$/zkDi73KhIfMFbl3aE4O1uPJGhU5eYF9bc.XckhUlBBAuWjuiQWpa', '2023-06-26 06:39:41', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (157, 'ljevon4c', '$2a$04$l8bsybBMG5DYrV5z6IwzTuZwjKM3NNx0BKlLY1xkVW9ieIgv7/XDC', '2023-08-11 11:25:19', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (158, 'ryanne4d', '$2a$04$V4TAurf1jmQecAERkBphmerdx08PElhDxyw384g2u.1dFPlG6seme', '2023-05-13 08:18:59', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (159, 'dwiddowfield4e', '$2a$04$1HRGfvN2.X74uAFDfFjI6ud2flUd9MRkiEVWPi1xsPRldCv3QXnMa', '2023-09-11 15:41:39', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (160, 'ccleator4f', '$2a$04$qDdp7g0F1.Dwacuhz.N1YerXKYhtdV9O2QnF2ZY5bA4Urbw6N3e6C', '2023-11-06 08:44:22', '2023-06-24 13:56:10', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (161, 'dloton4g', '$2a$04$YY69SYAZwR3c7pGa8.iC/.aFh4y2fgF3dNFivz9pWTvvg/kTFqnZ6', '2023-05-06 22:28:34', '2023-07-26 13:01:41', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (162, 'fburbage4h', '$2a$04$FKX1pa9VsGJp9UejoZuBm.jnjAyB0H6vgNbP2uV/M2w4Me1vpRE2u', '2023-04-28 09:03:00', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (163, 'tlangtry4i', '$2a$04$4D66EAICKxhsQaNPje4ibet5YQlpGsmnCjjpoO/dmp2QVOf3h2NuO', '2023-12-04 17:47:41', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (164, 'vcapponeer4j', '$2a$04$QOn1NF6lRXHgQOR0YxcQNufcUnK5fe2JVkrV29Pj4zYQ4kKWFcI.K', '2023-09-16 07:46:22', '2023-08-29 02:05:06', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (165, 'ecarnachen4k', '$2a$04$Tmv8N69lIjS5b9DHwAvBA.gUYMRBwTjULYrICK.TaF.BNqQvAjOFO', '2023-08-21 03:14:42', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (166, 'vbown4l', '$2a$04$ieqZbSJKie/rV/LdWaqtEe2UCVQf08mxqXQlzCJEzpLJJGRb2aO2y', '2024-02-05 00:13:23', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (167, 'apixton4m', '$2a$04$u95hVIaC4.0ALbPNtRtoaepGmElL/eIpZXm29zMJIPt5HFYXMx.te', '2023-06-12 00:16:56', '2024-03-04 01:42:59', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (168, 'umarians4n', '$2a$04$28BYR3NB5hLaidgfpd35G.nAGZC9eKZ920BB8VpX2pUZaH3IcTCDW', '2024-03-30 14:46:13', '2023-04-17 17:19:37', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (169, 'rmclucky4o', '$2a$04$ivqtiKbPY.iVHoFesVQF8e2O9ZnHfKcBZTLmvnUPc1nkbUuGK1F/S', '2023-08-24 11:44:38', '2023-10-05 16:10:37', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (170, 'nschuh4p', '$2a$04$1GmjdZARJq6wbIoU1LucCea/rsqSYAYae/SAIP7I0QAFJk93QL6xC', '2024-03-19 21:13:50', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (171, 'wbarttrum4q', '$2a$04$cJOESUnKEHp3.jXkvE4RWufZLjc0ksa/ojH9wTa1NQfHwMQqbDTUu', '2023-12-23 06:53:54', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (172, 'sfolbig4r', '$2a$04$caEK14/l4cdiAK6L2kpUjO8jXIDGqKEvwn/sC94YsbyvmDmtP386y', '2023-05-14 22:03:42', '2023-08-29 15:02:54', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (173, 'mbarkworth4s', '$2a$04$2v6AOOmoBfF9aDj5JLAZMOPM2Q6w2QILfeNt9AwQWvLLWAPAuDhTq', '2023-09-24 11:49:34', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (174, 'rblincow4t', '$2a$04$sOmEXefWgM8lQ1WUbWL3WO3s57Jo9IeJ6nXG.ms4/jW6AxBmj4w8W', '2023-11-01 16:09:03', '2023-06-10 21:08:50', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (175, 'cjenney4u', '$2a$04$8LM55v./zFZLfl4XUSqMYeILhtUjk/S7cXr3Tuwv2Wpixt9Vp9tF.', '2023-11-22 14:07:34', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (176, 'khatherleigh4v', '$2a$04$s9riHCQh7fQt7659sTQ5L.Zi8PdkppWYOuWzZa0LhEJW1QuWdHAv6', '2024-01-14 22:05:15', '2023-06-08 15:39:29', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (177, 'rblackborow4w', '$2a$04$fwvl.s3qzYXpClyOjMySdeNRmt/BLlAzO7uhmqUdAtxiMAO28Wz5i', '2023-10-10 16:45:12', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (178, 'pilson4x', '$2a$04$Ilwb9i6llVElHdblW.DaNeZVV6YYgpYiEPYG8kJhXi61IcPPt/FOS', '2023-07-26 13:02:21', '2024-04-06 22:34:05', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (179, 'bhearnden4y', '$2a$04$GqDQMRtc3zq9B4y3l5i8IeypoyzTp79RrkofF7PjhXROGqPDBWgYm', '2023-07-04 18:37:49', '2023-10-23 14:50:38', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (180, 'aayer4z', '$2a$04$YoLxIhKfj/sbFPTsnqcz7u7qCwkMM1c1oeoPIpE5UNo6GseH6WjcS', '2023-09-16 12:29:10', '2023-09-01 20:42:09', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (181, 'gclaessens50', '$2a$04$cV5X41a.Yb2KCN/bWJ.rYOSvyHyGrPb3Wtu/IVYEOUXiWz7SqmYDq', '2023-07-11 04:08:04', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (182, 'rpedgrift51', '$2a$04$3Q2TmGR7cdj5AyDGDPt6TuuomI7HL/Lc.XNjHy5rMFl1Q7N9yraVC', '2024-03-28 06:05:07', '2023-06-29 14:08:48', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (183, 'llivezley52', '$2a$04$9d8wP/m4Y271f8lM3DpytODekWdJJejcB5PDmsAd2z9d5bdvbOe3u', '2023-08-22 05:19:44', '2024-02-04 22:04:05', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (184, 'corder53', '$2a$04$568haXsJWoLRlF66GpylxueqlympRCb2yceWMjMY7VnbX0Iai1Z7m', '2023-04-21 23:28:44', '2023-07-11 15:17:43', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (185, 'tpetford54', '$2a$04$HFU1XH9Ti/bLyNtOTDBMzuBqTYkowKKrEJS36qxxBUqFGGd6GtKNS', '2023-07-21 20:55:35', '2023-09-23 12:27:29', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (186, 'akincla55', '$2a$04$jrR.a8F0S2YS.x1FlPWwkuauXh5Z2R1JKiUYHWGuPer0CYyNYGEjy', '2024-03-20 10:21:29', '2024-03-05 13:51:55', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (187, 'hwaterfall56', '$2a$04$MIOoDzTDACL94sIEGJyK3.6uIV/4XGi.CyiNCvth9EH6mFuei2OKi', '2024-02-02 13:02:43', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (188, 'kkippie57', '$2a$04$YtDor9SuPfbsmadrHCM9/uEviQMiyqJg7psjLq6zMkWdW7alQFMNK', '2023-09-18 14:47:01', '2023-10-13 10:34:56', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (189, 'cfields58', '$2a$04$0LIpKxJ5yK/uJ/nivDRFhOR2AD7ccT6t7MRZetn7xsEOfQCy8U8cC', '2024-01-11 20:32:17', '2023-09-20 22:02:34', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (190, 'nblamires59', '$2a$04$s92gBPaiwml7SR2rbaoyE.EAbRGZ63kb6lBRfV0uapsJ1lC2av.DS', '2023-11-05 08:31:08', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (191, 'blowerson5a', '$2a$04$7JpatR5XqXbIg87RRqZMMuYPusxog38VFA9w.IG7QiVAUzq8UFE4C', '2023-12-17 21:57:30', '2023-11-22 12:13:01', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (192, 'ctonna5b', '$2a$04$Nh.4U3Lqm8tN1QVZa50zYu7a4wpkPv59QBOFdZmUYiwi.Gs7L0Mta', '2023-07-19 05:00:40', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (193, 'gmckeevers5c', '$2a$04$ae1bLLFWZxlOeYZ.MKBxIe9j8G4lBfGp1wVRC6oVG8bByN5pSiSnW', '2024-03-18 10:11:01', '2024-03-06 02:42:29', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (194, 'rdabbs5d', '$2a$04$6zi6sFfPX3w9VBtMEZULPOwepDaiTB/OJg2B2Yfkyuv0pPQ595WhK', '2024-04-03 09:56:24', '2023-11-17 05:00:39', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (195, 'twilcocke5e', '$2a$04$B5CNG5NeTHWniIxiedFwoOdkzvI5DhHh30XCidHuLo/bJHMFopT3K', '2024-03-04 05:51:22', '', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (196, 'kcarley5f', '$2a$04$k.qP8k/ZDWXTMzTJmv9wuehz8Ens7Am/2RMrImLrDhodbFdjfnlOi', '2023-10-13 11:47:35', '', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (197, 'lmccahey5g', '$2a$04$kaeG7Ak3mUJoXbWQmvxOS.9u/v9x7r8wbUBhlBlq8zQWUP4ipBvWa', '2024-01-31 02:55:43', '2024-03-15 21:16:15', 2);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (198, 'gesgate5h', '$2a$04$Hhlv4s1YQNoSJk/GdkxyEOYyT5XPTw/Mbnhhu1U00B8TW8EFoLQgG', '2023-11-23 05:24:03', '', 3);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (199, 'whainsworth5i', '$2a$04$yhecLW2g5JbtlnfjkS8uSeuvMBW3NAYSXaeLEAvFvVDyY/8Vcxz92', '2023-07-09 11:54:47', '2024-03-03 12:03:06', 1);
INSERT INTO `lapinamk_varasto`.`users` (`id`, `username`, `password`, `created_at`, `deleted_at`, `roles_id`) VALUES (200, 'klorriman5j', '$2a$04$yGVZ68T6jPc1WTCVsVQxGeQ7Ms72rQAabv1Qtxii7JwXcp1ROIffe', '2023-10-01 04:15:48', '2023-12-12 06:17:17', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `lapinamk_varasto`.`rental_item_status`
-- -----------------------------------------------------
START TRANSACTION;
USE `lapinamk_varasto`;
INSERT INTO `lapinamk_varasto`.`rental_item_status` (`id`, `status`) VALUES (1, 'functional');
INSERT INTO `lapinamk_varasto`.`rental_item_status` (`id`, `status`) VALUES (2, 'broken');
INSERT INTO `lapinamk_varasto`.`rental_item_status` (`id`, `status`) VALUES (3, 'lost');
INSERT INTO `lapinamk_varasto`.`rental_item_status` (`id`, `status`) VALUES (4, 'rented');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lapinamk_varasto`.`categories`
-- -----------------------------------------------------
START TRANSACTION;
USE `lapinamk_varasto`;
INSERT INTO `lapinamk_varasto`.`categories` (`id`, `name`) VALUES (1, 'android_phone');
INSERT INTO `lapinamk_varasto`.`categories` (`id`, `name`) VALUES (2, 'iphone');
INSERT INTO `lapinamk_varasto`.`categories` (`id`, `name`) VALUES (DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `lapinamk_varasto`.`rental_items`
-- -----------------------------------------------------
START TRANSACTION;
USE `lapinamk_varasto`;
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (1, 'Intex Aqua Y2 Remote', '', '2023-07-19 04:47:12', '', '6984 Kings Way', 4, 14, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (2, 'Gionee X1', '', '2024-03-02 09:35:07', '', '75259 Kings Plaza', 4, 29, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (3, 'Samsung Galaxy S20+', '', '2023-04-11 21:48:10', '', '94400 Prentice Court', 3, 16, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (4, 'Panasonic Eluga A3', '', '2023-11-08 05:32:00', '', '885 Mallory Road', 2, 13, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (5, 'Celkon A88', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem. Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio. Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', '2023-06-16 06:32:38', '2023-06-13 09:05:17', '9 Spenser Road', 4, 21, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (6, 'ZTE Memo', '', '2023-09-07 11:06:39', '2023-11-14 15:15:01', '160 Garrison Place', 1, 3, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (7, 'Ulefone Armor 3WT', '', '2023-06-16 16:54:36', '2023-07-22 08:18:53', '1569 Esch Park', 1, 20, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (8, 'Plum Tweek', '', '2023-06-08 18:09:30', '', '48090 Merchant Parkway', 4, 22, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (9, 'Honor 8C', '', '2023-08-28 03:28:17', '2024-01-11 12:28:55', '4890 Redwing Point', 4, 21, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (10, 'HTC One (M8) dual sim', 'Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '2024-03-05 16:57:10', '', '86 8th Hill', 3, 1, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (11, 'Samsung Galaxy Express I8730', '', '2023-10-20 05:38:54', '', '3357 Eliot Court', 2, 8, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (12, 'LG GB250', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '2023-04-30 10:24:59', '2023-08-23 04:38:56', '04 Coleman Terrace', 3, 11, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (13, 'verykool s5526 Alpha', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '2024-02-22 17:38:34', '', '382 Weeping Birch Place', 2, 3, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (14, 'LG KP265', '', '2024-02-08 05:29:21', '', '33 Johnson Plaza', 4, 20, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (15, 'Panasonic Eluga Ray 600', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.', '2024-04-09 04:39:03', '', '74422 Marquette Hill', 2, 7, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (16, 'Motorola ZN5', '', '2024-03-13 09:14:45', '', '3 Corry Crossing', 1, 21, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (17, 'Nokia 2690', '', '2023-04-16 20:10:55', '', '99723 Reindahl Park', 2, 23, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (18, 'Unnecto Quattro V', '', '2024-01-10 09:26:31', '2023-11-03 01:13:04', '02 Monument Place', 4, 15, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (19, 'Benefon Track', 'Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', '2023-07-06 08:41:49', '2024-02-15 02:25:35', '3847 East Plaza', 1, 5, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (20, 'Celkon C619', '', '2023-06-07 06:04:55', '', '54863 Summit Junction', 4, 19, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (21, 'Nokia 6103', '', '2023-08-28 23:47:10', '2023-05-24 10:17:08', '97508 Pankratz Terrace', 1, 20, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (22, 'Siemens A62', '', '2023-09-12 16:19:48', '', '93006 Bunker Hill Plaza', 4, 6, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (23, 'Samsung Acclaim', '', '2023-07-10 15:36:11', '', '231 Eagan Lane', 2, 6, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (24, 'BLU Studio G', '', '2023-08-26 14:48:19', '', '7325 Dahle Pass', 3, 26, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (25, 'Micromax A110 Canvas 2', 'Vestibulum rutrum rutrum neque.', '2024-01-16 18:27:03', '', '6 Memorial Alley', 1, 30, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (26, 'Samsung E950', 'Morbi a ipsum. Integer a nibh. In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.', '2023-06-08 13:23:02', '', '51 Arapahoe Court', 3, 19, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (27, 'Motorola Moto G8 Power Lite', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.', '2024-03-04 04:36:14', '2023-09-22 22:58:49', '1 Corben Place', 2, 16, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (28, 'Samsung Galaxy A8s', 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', '2024-01-20 10:02:19', '', '5 La Follette Place', 4, 26, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (29, 'Samsung E2530', '', '2024-02-06 05:21:48', '', '0 Ramsey Lane', 4, 17, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (30, 'Samsung S500', 'Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.', '2023-08-11 06:16:36', '', '783 Commercial Court', 3, 17, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (31, 'Asus Zenfone 6 ZS630KL', 'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.', '2023-05-04 13:31:08', '', '40 Bunting Way', 3, 30, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (32, 'Plum Coach Plus', '', '2023-11-18 19:48:19', '2024-03-09 08:54:21', '0 Canary Terrace', 4, 7, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (33, 'Lava X10', '', '2023-11-08 11:52:41', '', '7234 Cottonwood Circle', 2, 17, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (34, 'QMobile Noir A120', '', '2023-12-10 09:12:47', '2023-11-12 07:19:09', '82103 Bellgrove Place', 4, 5, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (35, 'Philips X603', '', '2024-02-07 22:16:51', '', '35559 Green Hill', 2, 22, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (36, 'alcatel 3T 8', '', '2023-07-03 23:05:43', '', '571 Dawn Crossing', 3, 25, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (37, 'Samsung E2350B', 'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', '2023-08-12 18:51:29', '', '69 Maple Alley', 4, 29, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (38, 'Oppo A71 (2018)', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', '2023-10-13 05:45:44', '', '7 Bayside Avenue', 3, 7, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (39, 'XOLO Q1100', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla.', '2024-03-10 07:02:38', '2023-11-06 00:48:54', '8092 Clyde Gallagher Pass', 4, 3, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (40, 'Sony Ericsson G502', '', '2023-10-19 19:32:03', '', '73591 Gerald Place', 3, 28, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (41, 'Icemobile Prime 3.5', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '2024-03-14 18:57:27', '2023-09-11 23:16:59', '91867 Pankratz Way', 1, 6, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (42, 'LG G4 Pro', '', '2023-10-22 14:16:12', '', '20 Scofield Drive', 4, 3, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (43, 'Honor 9C', '', '2024-01-29 02:53:10', '2023-07-07 04:50:15', '98 Trailsway Court', 3, 3, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (44, 'QMobile Noir i5', 'Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus.', '2024-02-27 13:39:26', '2024-02-05 07:48:21', '92470 Norway Maple Point', 2, 4, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (45, 'BLU C5 (2017)', '', '2024-01-06 20:39:24', '', '8882 Dovetail Way', 3, 6, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (46, 'Philips D612', '', '2023-08-21 05:30:13', '', '8168 Algoma Center', 1, 14, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (47, 'alcatel Pop 7', 'Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '2023-12-27 09:44:42', '2023-11-10 16:20:37', '4605 Sommers Trail', 2, 26, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (48, 'Panasonic Eluga I9', 'Integer ac leo. Pellentesque ultrices mattis odio.', '2024-01-30 01:06:28', '', '8560 Bashford Park', 3, 4, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (49, 'ZTE Blade 10 Prime', '', '2023-06-11 17:29:07', '', '115 Susan Park', 3, 8, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (50, 'Sewon SGD-106', '', '2023-06-20 00:29:28', '', '26470 Westerfield Crossing', 2, 23, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (51, 'Siemens C35', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '2023-10-04 18:47:36', '2023-06-06 03:47:04', '9526 Northfield Park', 3, 14, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (52, 'Philips W9588', '', '2024-02-14 16:52:37', '', '64639 Westridge Hill', 4, 21, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (53, 'LG G5300', '', '2023-06-13 02:19:23', '2024-02-25 11:45:20', '972 Lillian Avenue', 3, 4, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (54, 'QMobile Noir Z12', '', '2023-05-20 13:12:37', '', '904 Brown Lane', 1, 17, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (55, 'Philips X518', '', '2023-08-06 04:23:11', '', '57883 Fair Oaks Lane', 2, 22, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (56, 'LG U8380', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti.', '2023-12-01 02:08:22', '', '50 Gerald Trail', 1, 16, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (57, 'i-mobile 638CG', 'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', '2023-10-26 00:45:43', '', '3282 Dunning Hill', 4, 30, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (58, 'BlackBerry Z3', 'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.', '2024-03-11 10:20:09', '', '87 Swallow Street', 1, 30, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (59, 'Motorola W396', '', '2024-03-17 12:26:29', '', '6822 Petterle Way', 3, 19, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (60, 'Philips 655', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.', '2024-01-19 14:33:47', '2023-06-21 12:55:53', '947 Daystar Trail', 1, 21, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (61, 'Energizer Energy E220s', '', '2024-02-23 23:53:41', '', '8645 Warrior Way', 4, 6, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (62, 'vivo Y51 (2020, December)', 'Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.', '2023-06-03 08:16:12', '2023-07-23 10:33:25', '4 Chinook Parkway', 4, 17, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (63, 'Icemobile Prime 5.0 Plus', 'In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.', '2023-07-10 04:18:46', '', '75467 Sugar Plaza', 3, 23, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (64, 'Spice S-5010', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', '2023-10-15 18:40:43', '', '8987 School Hill', 3, 14, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (65, 'Nokia Lumia 2520', 'Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh. In quis justo.', '2023-10-08 11:45:16', '', '178 Village Green Park', 2, 22, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (66, 'NEC N610', '', '2023-07-25 12:26:45', '2024-02-16 02:25:44', '55 Cottonwood Pass', 3, 15, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (67, 'Samsung Galaxy A3', '', '2023-10-30 22:05:43', '', '83174 Mcguire Junction', 2, 27, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (68, 'Meizu E2', '', '2023-04-30 04:26:35', '2023-12-09 04:46:00', '9814 Eagle Crest Hill', 4, 28, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (69, 'Samsung Galaxy J5 Prime (2017)', '', '2024-02-01 09:57:56', '', '487 Aberg Plaza', 3, 29, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (70, 'Gionee Ctrl V3', '', '2023-09-04 12:44:51', '', '89599 Amoth Hill', 1, 19, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (71, 'Samsung E3213 Hero', '', '2023-09-29 19:37:17', '', '04 Fremont Drive', 2, 10, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (72, 'Plum Boot', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.', '2023-04-20 08:10:29', '', '56963 Charing Cross Parkway', 3, 6, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (73, 'HTC Wildfire CDMA', '', '2023-04-10 06:32:41', '', '887 Macpherson Drive', 1, 27, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (74, 'Micromax Vdeo 4', '', '2023-05-30 06:47:34', '', '319 Sutherland Street', 4, 9, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (75, 'Sharp GX30', '', '2023-11-15 05:50:00', '', '586 Merrick Court', 3, 9, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (76, 'Motorola Rambler', 'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '2023-10-10 23:35:09', '', '91 Katie Avenue', 3, 24, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (77, 'HTC One (M8) CDMA', 'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.', '2023-08-24 11:34:35', '', '233 Ridge Oak Parkway', 1, 27, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (78, 'Lenovo Z6', 'Quisque ut erat.', '2023-12-10 20:46:21', '2023-06-17 11:12:02', '805 Utah Parkway', 3, 3, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (79, 'Samsung E2510', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.', '2023-05-10 09:49:34', '2023-12-22 20:57:58', '8 Shopko Circle', 3, 25, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (80, 'Samsung Galaxy S9', '', '2024-01-18 18:10:21', '', '0843 Arizona Lane', 3, 2, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (81, 'Micromax Canvas Sliver 5 Q450', '', '2023-04-25 20:25:14', '', '2952 Loftsgordon Place', 3, 19, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (82, 'Huawei nova 8 Pro 5G', '', '2023-05-17 15:14:44', '', '85179 Crescent Oaks Court', 3, 8, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (83, 'Samsung S7550 Blue Earth', '', '2023-09-18 04:52:45', '', '9865 Park Meadow Plaza', 1, 17, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (84, 'Philips 588', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit.', '2023-08-15 21:49:09', '', '3 Fair Oaks Lane', 4, 16, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (85, 'Energizer Hardcase H500S', '', '2023-09-05 17:16:00', '', '1370 Little Fleur Lane', 3, 16, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (86, 'Lava Z61 Pro', 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '2023-12-09 03:16:29', '', '23 Pepper Wood Alley', 4, 13, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (87, 'Eten glofiish X600', '', '2023-11-29 06:59:51', '', '40 Service Park', 3, 13, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (88, 'Samsung I6500U Galaxy', '', '2023-09-13 12:47:53', '', '5732 Lien Lane', 3, 17, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (89, 'Sony Ericsson Xperia Duo', '', '2023-05-08 21:44:31', '2023-07-03 18:54:29', '3007 Reinke Pass', 4, 4, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (90, 'Unnecto Drone XL', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.', '2023-10-12 06:45:57', '', '4769 Autumn Leaf Street', 1, 22, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (91, 'Vodafone 835', '', '2023-08-08 16:50:29', '2024-01-07 13:05:34', '275 Waywood Way', 2, 13, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (92, 'Sony Ericsson G900', '', '2024-01-07 03:10:08', '', '15759 Del Sol Park', 3, 24, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (93, 'Philips X500', 'Suspendisse potenti. Nullam porttitor lacus at turpis.', '2024-02-29 21:04:06', '', '69576 Pleasure Trail', 3, 24, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (94, 'Plum Optimax 10', '', '2023-10-02 13:48:56', '2023-05-13 14:43:09', '3879 Messerschmidt Center', 3, 4, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (95, 'alcatel One Touch X\'Pop', '', '2024-02-22 13:03:55', '', '6 Graedel Hill', 3, 4, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (96, 'Samsung E810', '', '2023-08-24 00:21:21', '', '31 Maple Wood Drive', 2, 19, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (97, 'Samsung Breeze B209', '', '2024-03-23 02:14:46', '2023-06-18 13:34:39', '49 Superior Circle', 4, 6, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (98, 'Haier A66', 'Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.', '2023-07-08 13:40:30', '', '0 Autumn Leaf Court', 3, 23, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (99, 'verykool i119', '', '2023-10-11 07:14:03', '2024-04-01 19:30:56', '00 Shasta Park', 4, 1, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (100, 'ZTE Style Messanger', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.', '2024-03-19 13:11:42', '', '907 Shasta Hill', 1, 5, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (101, 'Coolpad Torino', 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', '2023-10-27 21:56:26', '', '5 Goodland Hill', 3, 15, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (102, 'HTC J', '', '2023-12-04 06:40:17', '2024-01-03 23:37:42', '58871 Morrow Street', 3, 26, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (103, 'QMobile Linq L15', '', '2023-09-12 15:06:55', '', '0 Thackeray Center', 3, 28, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (104, 'Kyocera Milano C5121', '', '2024-01-04 19:24:31', '', '36 Pennsylvania Trail', 3, 9, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (105, 'T-Mobile Revvlry+', '', '2023-09-05 14:19:46', '', '9423 Truax Hill', 2, 26, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (106, 'Asus P525', '', '2024-01-23 08:47:01', '', '3937 Garrison Junction', 3, 1, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (107, 'Coolpad Cool1 dual', '', '2023-10-26 23:31:35', '', '83 Scoville Street', 2, 2, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (108, 'Karbonn S5 Titanium', '', '2023-04-29 01:45:13', '2023-12-30 21:30:18', '2 Muir Street', 4, 28, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (109, 'Samsung Galaxy 551', '', '2023-06-29 12:22:40', '', '4 Superior Circle', 2, 14, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (110, 'Coolpad Mega', '', '2023-10-03 10:46:18', '', '044 Hanson Point', 1, 30, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (111, 'YU Yuphoria', 'Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit.', '2023-11-14 08:08:45', '2024-01-07 18:17:46', '628 Cascade Lane', 3, 29, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (112, 'Samsung Galaxy S20', '', '2023-10-10 04:39:11', '', '017 Eastlawn Avenue', 2, 1, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (113, 'Samsung S410i', 'Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio.', '2023-05-21 14:19:13', '2023-06-20 05:54:39', '2010 Trailsway Crossing', 3, 19, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (114, 'HTC One (E8)', 'Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', '2023-12-29 07:38:01', '', '87476 Claremont Plaza', 3, 2, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (115, 'XOLO Q2100', 'Duis aliquam convallis nunc.', '2024-03-10 16:03:51', '', '79816 David Place', 3, 12, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (116, 'Prestigio MultiPhone 7600 Duo', '', '2023-12-28 12:10:51', '2023-04-10 22:14:25', '8 Maywood Point', 3, 2, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (117, 'alcatel Pixi 4 (4)', '', '2023-08-14 23:22:28', '', '93 Ridgeway Place', 4, 15, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (118, 'Nokia 206', '', '2024-02-27 16:53:34', '', '7 Moland Circle', 1, 2, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (119, 'Asus Fonepad 8 FE380CG', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '2023-11-23 13:24:10', '', '382 Crest Line Circle', 1, 1, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (120, 'Celkon Q455', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', '2023-10-16 19:52:48', '', '6 Straubel Parkway', 2, 1, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (121, 'alcatel Idol 3C', 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '2024-02-06 11:11:03', '', '31260 Farmco Place', 1, 15, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (122, 'alcatel 3v (2019)', '', '2023-12-01 14:43:16', '', '5904 Eliot Court', 3, 10, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (123, 'Ulefone T2 Pro', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus.', '2024-01-12 13:59:21', '', '27 Manitowish Way', 2, 19, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (124, 'Micromax A104 Canvas Fire 2', '', '2023-10-21 13:00:03', '', '28 Linden Trail', 2, 22, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (125, 'Sony Xperia Z2a', '', '2023-05-21 10:43:25', '', '68790 Havey Hill', 3, 22, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (126, 'Lenovo K6', '', '2023-11-09 07:23:38', '', '815 Butterfield Terrace', 4, 22, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (127, 'alcatel OT 153', '', '2023-07-13 00:35:52', '', '3 Jenifer Lane', 2, 12, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (128, 'alcatel OT-305', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt.', '2023-07-21 14:40:25', '', '656 Manufacturers Park', 4, 6, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (129, 'LG Q70', '', '2024-02-16 16:04:35', '', '8913 Dixon Plaza', 2, 30, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (130, 'Amoi F320', 'Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', '2024-03-08 19:14:12', '', '82 Mallory Hill', 1, 10, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (131, 'NIU F10', '', '2024-01-03 05:30:22', '', '26278 Kipling Park', 2, 4, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (132, 'Huawei P40', '', '2023-10-27 02:40:02', '', '02 Pankratz Circle', 2, 13, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (133, 'Samsung P920', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus.', '2023-10-02 03:05:44', '2023-06-29 05:39:13', '999 Hallows Plaza', 4, 23, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (134, 'ZTE F951', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.', '2024-03-21 06:04:28', '', '33575 Loeprich Junction', 2, 6, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (135, 'Acer Iconia Tab A500', 'Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla.', '2023-08-03 11:56:45', '', '79 Birchwood Road', 2, 23, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (136, 'Philips W626', '', '2024-01-22 15:19:09', '', '07 Bluejay Terrace', 3, 7, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (137, 'Samsung Galaxy Beam2', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '2023-04-30 23:25:48', '2024-01-10 16:58:43', '8039 Ramsey Street', 1, 26, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (138, 'alcatel OT-818', '', '2024-01-02 02:14:27', '2023-04-25 16:20:58', '89493 Arizona Point', 1, 19, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (139, 'Huawei Ascend GX1', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros.', '2023-07-03 19:39:01', '2023-05-29 01:37:59', '9115 Marcy Way', 3, 26, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (140, 'Sagem my300X', 'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', '2023-07-17 21:24:26', '', '76 Hovde Alley', 1, 8, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (141, 'vivo Y20i', 'Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '2023-08-18 08:53:49', '2023-07-06 13:48:50', '6 Continental Plaza', 2, 23, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (142, 'Karbonn A5', '', '2023-12-30 02:56:17', '', '58 Talisman Lane', 3, 27, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (143, 'verykool i705', '', '2023-11-15 13:16:21', '2023-12-31 18:04:05', '1 Northview Junction', 2, 30, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (144, 'Toshiba TS605', '', '2023-09-22 13:06:39', '', '71 Havey Street', 4, 9, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (145, 'Philips S890', 'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.', '2023-06-19 02:10:21', '', '67391 Toban Way', 1, 5, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (146, 'Micromax X40', 'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '2023-12-21 15:39:03', '2023-09-12 09:37:13', '41529 Anthes Plaza', 1, 8, 2);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (147, 'Philips W7555', '', '2024-02-02 22:04:01', '2023-12-13 14:21:53', '48875 Dawn Avenue', 2, 10, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (148, 'Sagem MY X1-2', '', '2024-01-18 09:24:20', '', '8323 Claremont Street', 1, 22, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (149, 'BLU Life One (2015)', 'In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '2024-03-21 10:05:27', '', '50429 Warner Way', 4, 6, 1);
INSERT INTO `lapinamk_varasto`.`rental_items` (`id`, `name`, `description`, `created_at`, `deleted_at`, `address`, `rental_item_statuses_id`, `created_by_id`, `categories_id`) VALUES (150, 'vivo iQOO Neo3 5G', '', '2024-02-04 17:09:48', '', '2 Lotheville Drive', 3, 6, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `lapinamk_varasto`.`features`
-- -----------------------------------------------------
START TRANSACTION;
USE `lapinamk_varasto`;
INSERT INTO `lapinamk_varasto`.`features` (`id`, `feature`) VALUES (1, 'black');
INSERT INTO `lapinamk_varasto`.`features` (`id`, `feature`) VALUES (2, 'white');
INSERT INTO `lapinamk_varasto`.`features` (`id`, `feature`) VALUES (3, 'other colour');
INSERT INTO `lapinamk_varasto`.`features` (`id`, `feature`) VALUES (4, 'dual SIM');
INSERT INTO `lapinamk_varasto`.`features` (`id`, `feature`) VALUES (5, 'two cameras');
INSERT INTO `lapinamk_varasto`.`features` (`id`, `feature`) VALUES (6, 'three cameras');
INSERT INTO `lapinamk_varasto`.`features` (`id`, `feature`) VALUES (7, 'more cameras than 3');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lapinamk_varasto`.`rental_items_has_features`
-- -----------------------------------------------------
START TRANSACTION;
USE `lapinamk_varasto`;
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (1, 3, '66.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (2, 6, '196.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (3, 2, '640.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (4, 3, '828.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (5, 1, '587.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (6, 1, '714.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (7, 7, '179.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (8, 1, '711.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (9, 5, '331.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (10, 2, '903.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (11, 5, '692.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (12, 5, '71.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (13, 2, '959.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (14, 5, '385.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (15, 4, '909.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (16, 4, '683.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (17, 4, '14.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (18, 4, '90.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (19, 3, '805.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (20, 3, '996.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (21, 3, '998.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (22, 6, '213.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (23, 6, '500.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (24, 2, '229.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (25, 3, '558.2');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (26, 2, '926.2');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (27, 3, '912.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (28, 6, '822.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (29, 7, '691.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (30, 4, '540.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (31, 4, '851.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (32, 4, '882.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (33, 5, '25.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (34, 4, '175.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (35, 5, '414.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (36, 2, '585.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (37, 4, '88.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (38, 3, '498.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (39, 3, '96.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (40, 5, '929.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (41, 5, '562.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (42, 1, '42.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (43, 6, '288.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (44, 4, '597.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (45, 2, '338.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (46, 4, '407.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (47, 3, '78.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (48, 5, '620.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (49, 2, '829.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (50, 1, '60.2');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (51, 5, '667.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (52, 5, '923.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (53, 3, '311.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (54, 1, '953.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (55, 7, '475.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (56, 4, '969.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (57, 2, '275.2');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (58, 6, '375.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (59, 7, '819.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (60, 5, '360.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (61, 7, '627.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (62, 1, '521.2');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (63, 7, '780.2');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (64, 7, '352.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (65, 7, '717.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (66, 2, '63.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (67, 4, '648.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (68, 1, '585.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (69, 7, '495.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (70, 7, '896.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (71, 1, '49.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (72, 1, '302.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (73, 1, '395.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (74, 5, '537.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (75, 7, '518.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (76, 2, '995.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (77, 4, '571.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (78, 1, '972.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (79, 2, '893.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (80, 5, '375.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (81, 3, '746.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (82, 3, '721.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (83, 6, '871.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (84, 6, '230.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (85, 4, '881.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (86, 1, '98.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (87, 7, '285.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (88, 4, '26.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (89, 6, '515.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (90, 6, '221.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (91, 2, '38.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (92, 3, '718.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (93, 6, '645.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (94, 3, '364.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (95, 7, '259.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (96, 7, '706.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (97, 7, '116.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (98, 2, '857.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (99, 5, '651.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (100, 2, '838.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (101, 7, '267.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (102, 3, '351.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (103, 1, '238.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (104, 6, '730.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (105, 7, '476.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (106, 7, '455.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (107, 5, '359.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (108, 4, '5.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (109, 1, '772.2');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (110, 6, '690.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (111, 5, '474.2');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (112, 3, '626.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (113, 2, '640.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (114, 5, '764.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (115, 3, '728.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (116, 4, '255.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (117, 5, '689.2');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (118, 7, '920.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (119, 5, '812.6');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (120, 4, '81.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (121, 7, '32.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (122, 7, '93.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (123, 5, '946.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (124, 5, '74.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (125, 4, '560.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (126, 2, '541.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (127, 3, '288.3');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (128, 2, '895.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (129, 4, '956.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (130, 2, '556.2');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (131, 2, '93.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (132, 7, '532.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (133, 2, '593.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (134, 1, '417.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (135, 5, '180.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (136, 3, '491.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (137, 1, '892.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (138, 7, '647.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (139, 4, '561.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (140, 5, '51.9');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (141, 4, '925.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (142, 3, '259.8');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (143, 1, '260.7');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (144, 2, '260.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (145, 6, '767.4');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (146, 3, '380.0');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (147, 1, '725.5');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (148, 6, '808.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (149, 1, '984.1');
INSERT INTO `lapinamk_varasto`.`rental_items_has_features` (`rental_items_id`, `features_id`, `value`) VALUES (150, 3, '858.0');

COMMIT;


-- -----------------------------------------------------
-- Data for table `lapinamk_varasto`.`rental_transactions`
-- -----------------------------------------------------
START TRANSACTION;
USE `lapinamk_varasto`;
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (1, '2023-08-10 06:17:11', '2023-09-08 20:29:29', '2023-10-02 16:10:52', 102, 78);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (2, '2023-08-07 16:30:18', '2024-03-28 04:09:41', '2023-10-29 01:12:22', 132, 133);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (3, '2024-02-27 08:16:04', '2024-02-10 17:54:15', '2023-10-14 22:24:18', 40, 82);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (4, '2023-09-30 21:48:12', '2023-06-08 14:06:07', '', 35, 143);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (5, '2023-04-22 17:49:32', '2023-05-19 17:59:02', '', 142, 102);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (6, '2024-03-21 07:38:36', '2023-09-06 17:13:02', '', 84, 16);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (7, '2023-10-06 07:10:15', '2024-01-12 00:11:29', '2023-07-14 13:47:38', 53, 122);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (8, '2023-04-22 18:50:16', '2023-07-02 12:00:37', '2023-07-31 03:03:47', 60, 68);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (9, '2023-07-25 22:16:29', '2024-03-28 11:10:33', '', 35, 127);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (10, '2023-04-10 13:00:52', '2023-09-19 12:29:55', '2023-07-14 10:09:54', 33, 39);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (11, '2023-05-11 13:45:12', '2024-01-12 15:33:01', '', 73, 139);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (12, '2023-04-30 16:51:24', '2023-07-02 12:18:34', '2024-02-09 01:01:32', 112, 119);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (13, '2023-11-01 12:58:28', '2023-11-27 23:44:04', '', 49, 119);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (14, '2023-09-02 05:26:04', '2023-12-07 05:06:47', '', 44, 167);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (15, '2023-05-25 00:57:42', '2023-07-22 00:04:14', '2024-03-24 21:46:08', 129, 190);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (16, '2023-10-12 21:20:13', '2024-02-15 08:41:01', '2023-07-16 00:30:05', 149, 129);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (17, '2024-03-13 14:33:04', '2024-02-22 08:25:23', '', 133, 100);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (18, '2023-11-02 14:33:27', '2024-02-29 05:29:35', '2023-10-06 17:27:43', 118, 48);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (19, '2023-09-21 00:38:10', '2024-02-06 19:31:53', '2023-11-24 16:51:30', 135, 200);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (20, '2024-01-26 02:23:07', '2023-05-20 14:49:49', '2023-07-16 15:48:15', 150, 15);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (21, '2023-05-30 15:09:35', '2023-07-28 22:26:54', '2023-08-13 03:31:02', 3, 46);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (22, '2023-05-16 19:56:51', '2024-02-06 21:35:33', '2023-07-30 17:43:38', 61, 110);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (23, '2024-02-03 14:19:06', '2023-10-14 02:40:05', '2024-01-02 06:54:52', 8, 136);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (24, '2024-02-05 20:39:10', '2023-09-06 09:50:08', '2023-12-29 23:06:11', 14, 115);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (25, '2023-08-27 11:15:30', '2024-02-26 10:29:31', '', 12, 130);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (26, '2024-03-22 02:05:34', '2023-12-11 11:56:35', '2024-03-08 14:13:39', 34, 87);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (27, '2023-12-02 14:55:32', '2023-06-27 20:23:20', '', 22, 190);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (28, '2024-01-06 03:42:23', '2024-03-13 09:58:54', '', 83, 150);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (29, '2023-06-20 04:20:45', '2024-03-23 15:46:16', '2023-06-08 07:08:59', 68, 144);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (30, '2023-04-14 05:18:39', '2023-08-28 02:59:39', '', 47, 114);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (31, '2023-07-27 00:42:17', '2023-08-04 05:39:00', '', 145, 44);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (32, '2023-05-18 12:06:10', '2023-08-13 21:45:54', '', 137, 157);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (33, '2023-08-05 21:36:56', '2023-07-28 14:57:14', '2023-10-30 00:32:44', 16, 151);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (34, '2024-01-08 23:06:34', '2024-02-11 11:27:04', '2024-02-07 00:20:24', 124, 38);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (35, '2023-08-29 23:44:57', '2023-09-15 19:50:36', '', 12, 51);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (36, '2023-08-16 05:16:04', '2024-03-18 11:57:52', '', 143, 80);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (37, '2023-11-21 20:48:06', '2023-10-29 19:49:29', '', 36, 118);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (38, '2023-10-14 09:29:34', '2023-07-19 01:30:49', '', 1, 33);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (39, '2023-05-03 05:26:51', '2023-09-13 20:21:27', '2024-02-10 22:47:23', 133, 77);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (40, '2023-10-02 08:18:33', '2023-06-01 09:02:13', '2024-01-11 17:17:43', 66, 79);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (41, '2023-07-05 21:06:03', '2023-10-27 05:42:01', '2023-08-03 16:03:10', 110, 53);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (42, '2024-02-14 05:28:28', '2024-03-13 19:27:04', '', 24, 65);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (43, '2023-09-16 22:01:34', '2023-12-23 06:25:24', '2023-06-02 22:19:16', 132, 139);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (44, '2024-03-30 18:01:37', '2024-01-31 03:29:56', '', 35, 174);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (45, '2023-07-17 17:28:26', '2023-10-04 11:10:32', '2024-01-10 04:34:43', 8, 79);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (46, '2024-02-05 08:59:59', '2023-05-18 02:11:53', '2024-01-12 16:38:06', 24, 178);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (47, '2023-12-28 01:09:23', '2023-11-27 16:54:46', '2023-06-04 19:44:30', 44, 119);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (48, '2023-11-11 08:25:07', '2023-10-07 18:24:03', '', 135, 108);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (49, '2023-07-24 11:04:35', '2023-07-18 07:30:19', '2024-01-24 02:03:41', 150, 161);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (50, '2023-12-10 08:11:53', '2023-08-02 01:28:28', '', 114, 81);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (51, '2024-03-11 03:47:52', '2023-12-27 08:41:26', '', 112, 29);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (52, '2023-11-23 07:57:40', '2023-08-16 09:56:30', '', 68, 18);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (53, '2023-10-24 01:23:36', '2024-02-23 20:14:05', '', 12, 198);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (54, '2023-10-17 12:08:34', '2023-12-23 08:03:58', '', 3, 72);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (55, '2024-02-04 05:56:27', '2024-02-20 15:23:25', '', 94, 98);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (56, '2024-04-02 16:48:11', '2024-01-16 01:45:14', '', 16, 152);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (57, '2023-04-12 16:09:45', '2023-08-11 08:42:13', '', 63, 125);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (58, '2023-06-16 17:28:18', '2023-07-04 02:02:04', '2023-11-02 01:26:54', 52, 134);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (59, '2023-12-29 18:57:06', '2023-07-01 18:17:24', '2023-05-17 18:16:49', 50, 24);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (60, '2023-11-22 18:24:41', '2023-06-20 23:33:26', '2023-05-30 00:56:45', 143, 50);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (61, '2023-11-16 08:29:39', '2024-01-23 03:36:22', '2023-08-04 06:05:52', 29, 177);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (62, '2023-11-23 03:52:07', '2023-07-01 01:14:14', '2023-07-13 19:11:42', 1, 125);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (63, '2023-10-17 17:45:01', '2024-03-17 15:00:35', '2023-09-30 20:03:46', 74, 112);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (64, '2023-04-20 03:50:26', '2024-01-22 20:35:51', '', 122, 55);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (65, '2023-11-02 10:42:18', '2024-02-16 11:03:35', '2023-12-22 07:09:15', 72, 108);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (66, '2024-01-04 01:42:57', '2023-11-25 18:20:26', '2023-06-26 23:10:40', 127, 135);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (67, '2023-05-13 12:58:24', '2023-12-14 02:28:14', '2023-12-17 02:11:39', 36, 11);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (68, '2023-09-30 01:59:02', '2024-01-04 23:14:37', '', 84, 73);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (69, '2024-01-21 04:31:56', '2023-09-07 19:42:52', '2023-05-30 03:43:21', 46, 118);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (70, '2023-04-28 07:40:17', '2023-09-02 18:08:09', '2023-07-17 00:13:57', 150, 43);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (71, '2023-07-03 19:56:38', '2023-08-28 05:22:56', '2023-09-23 17:19:05', 26, 130);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (72, '2024-02-05 05:43:17', '2023-07-18 02:48:53', '', 135, 65);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (73, '2023-08-13 23:55:30', '2024-03-30 21:53:32', '2023-10-30 20:11:40', 24, 88);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (74, '2024-01-27 18:42:34', '2023-06-28 22:01:02', '2023-06-16 20:18:02', 17, 6);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (75, '2023-10-18 21:05:03', '2023-08-31 04:29:37', '2023-12-24 18:17:13', 141, 28);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (76, '2024-01-17 21:31:39', '2023-06-10 19:28:59', '2024-03-17 12:26:27', 44, 151);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (77, '2023-06-04 01:06:22', '2023-12-19 10:16:56', '', 92, 89);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (78, '2023-08-10 09:58:56', '2023-09-24 11:39:55', '', 81, 178);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (79, '2024-01-18 16:20:55', '2023-06-24 06:33:55', '2023-09-27 17:30:06', 46, 122);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (80, '2023-08-07 21:21:01', '2024-02-15 18:04:51', '2023-12-20 13:01:27', 95, 136);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (81, '2023-08-15 01:08:35', '2023-11-25 02:40:53', '2023-06-19 22:00:33', 27, 145);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (82, '2024-01-01 08:40:31', '2023-07-13 22:35:17', '2023-11-20 17:50:26', 111, 109);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (83, '2023-04-17 04:26:24', '2023-12-04 06:53:10', '', 80, 74);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (84, '2023-06-05 14:41:42', '2023-10-25 05:46:45', '2023-09-23 05:41:47', 123, 7);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (85, '2023-11-29 11:24:53', '2024-03-18 11:10:59', '', 78, 2);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (86, '2023-07-31 13:38:11', '2023-10-14 22:45:12', '', 119, 19);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (87, '2023-05-11 00:47:40', '2023-12-08 07:42:22', '2024-02-01 04:32:41', 93, 48);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (88, '2023-10-21 04:44:02', '2024-01-22 21:34:03', '2023-06-26 22:31:24', 60, 21);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (89, '2023-10-01 22:04:33', '2023-12-04 11:24:59', '2023-07-06 18:06:05', 105, 67);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (90, '2023-04-13 14:59:51', '2023-07-07 21:47:52', '2023-08-26 14:22:49', 16, 47);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (91, '2023-12-14 20:41:18', '2024-01-30 06:38:22', '', 31, 10);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (92, '2023-08-05 05:35:05', '2024-03-14 19:14:53', '2024-01-21 21:04:30', 136, 189);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (93, '2023-10-30 16:36:17', '2024-03-03 00:09:59', '2024-03-24 04:07:57', 9, 127);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (94, '2023-12-04 14:11:20', '2024-01-10 18:18:24', '', 24, 175);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (95, '2024-04-07 02:22:22', '2024-01-19 16:24:21', '2023-06-03 16:50:10', 66, 102);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (96, '2023-04-24 21:26:54', '2024-03-04 11:55:40', '', 6, 108);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (97, '2023-09-17 14:20:05', '2024-01-05 09:00:28', '', 140, 12);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (98, '2023-07-29 02:09:48', '2023-10-05 22:03:04', '2023-08-05 20:36:21', 41, 16);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (99, '2023-06-12 11:19:35', '2023-11-30 20:47:18', '', 107, 63);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (100, '2023-11-11 01:40:42', '2023-05-25 10:06:28', '2023-12-08 03:40:37', 77, 65);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (101, '2023-06-04 00:04:55', '2023-07-23 15:22:27', '2023-07-29 21:36:54', 22, 181);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (102, '2024-03-23 14:20:04', '2023-05-22 08:12:02', '2024-02-27 10:28:39', 104, 83);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (103, '2023-12-14 07:30:37', '2024-01-03 18:35:56', '2024-03-30 04:52:33', 107, 83);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (104, '2023-12-27 18:51:57', '2023-09-11 05:20:09', '', 56, 183);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (105, '2023-12-01 02:37:04', '2023-08-29 05:30:31', '2023-09-08 23:22:11', 37, 36);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (106, '2023-04-24 03:56:29', '2023-05-13 19:37:20', '2023-08-13 11:23:29', 27, 127);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (107, '2023-12-23 15:46:12', '2024-04-04 09:41:24', '2023-05-30 20:39:27', 104, 152);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (108, '2023-06-02 12:14:00', '2023-07-26 14:56:35', '', 141, 64);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (109, '2023-09-06 10:29:33', '2023-10-18 03:40:53', '2023-11-21 05:21:06', 40, 185);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (110, '2023-06-02 10:03:36', '2023-11-25 22:27:02', '', 23, 115);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (111, '2023-07-22 03:54:05', '2023-09-03 07:52:35', '2024-01-26 22:52:44', 115, 64);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (112, '2023-05-29 20:42:24', '2023-10-10 16:13:46', '2024-04-07 06:23:11', 111, 8);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (113, '2023-11-30 10:45:35', '2024-02-14 04:48:30', '2023-08-18 19:21:28', 114, 97);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (114, '2023-12-26 21:20:33', '2024-04-01 06:15:22', '', 65, 173);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (115, '2024-03-05 04:44:24', '2023-05-15 23:43:41', '', 27, 67);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (116, '2023-12-28 02:46:13', '2023-11-29 06:00:51', '2023-10-29 14:45:58', 19, 7);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (117, '2023-07-27 00:16:49', '2023-09-21 08:01:48', '2023-09-04 08:35:37', 5, 191);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (118, '2023-04-18 04:33:26', '2023-05-15 04:26:56', '2023-12-28 17:32:16', 101, 52);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (119, '2024-03-29 01:54:04', '2023-09-15 21:30:22', '', 81, 76);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (120, '2023-09-10 05:08:43', '2023-05-27 21:15:20', '2023-07-25 04:01:34', 106, 73);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (121, '2023-09-23 07:58:45', '2023-05-11 06:32:10', '', 33, 145);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (122, '2024-01-24 01:10:07', '2023-09-30 07:33:40', '', 134, 128);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (123, '2023-08-07 00:13:40', '2023-08-01 14:07:00', '2023-12-15 13:55:54', 116, 112);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (124, '2023-09-14 12:19:00', '2023-05-30 08:41:31', '', 98, 44);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (125, '2023-08-19 10:00:22', '2023-10-16 13:42:43', '', 47, 155);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (126, '2023-08-02 08:44:07', '2024-02-15 22:45:50', '2023-07-08 01:44:34', 125, 186);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (127, '2023-04-15 23:01:15', '2023-07-06 08:07:58', '', 147, 193);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (128, '2023-05-17 08:47:00', '2023-10-09 16:57:19', '2023-07-30 06:48:57', 96, 145);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (129, '2023-10-20 23:45:57', '2023-07-18 15:18:58', '', 127, 40);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (130, '2023-11-24 23:24:21', '2024-03-05 16:45:21', '2023-06-04 12:21:04', 44, 119);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (131, '2023-09-04 19:58:17', '2024-03-23 09:05:36', '2024-02-24 03:51:13', 74, 126);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (132, '2023-11-09 07:33:00', '2023-10-08 17:07:07', '2023-09-10 17:20:41', 17, 148);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (133, '2024-03-26 09:19:04', '2023-07-08 06:44:38', '2023-05-11 08:22:50', 84, 118);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (134, '2024-02-25 06:24:44', '2024-02-29 02:34:52', '', 28, 184);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (135, '2023-09-28 03:35:11', '2023-09-11 10:37:45', '', 136, 92);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (136, '2023-06-09 06:44:41', '2023-06-28 16:01:00', '2024-02-10 10:23:05', 58, 39);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (137, '2023-05-11 11:42:56', '2023-11-01 04:47:13', '', 120, 71);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (138, '2023-10-12 00:03:21', '2024-03-27 01:51:09', '', 113, 82);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (139, '2023-12-04 10:29:14', '2023-11-15 17:26:51', '2024-03-20 05:54:59', 53, 159);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (140, '2023-08-19 18:22:07', '2023-11-15 00:30:34', '2023-11-19 04:19:00', 82, 126);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (141, '2024-02-28 19:17:12', '2024-02-01 05:20:53', '2023-11-20 01:19:28', 106, 184);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (142, '2023-04-11 16:28:24', '2023-10-09 04:45:11', '2023-07-10 07:43:56', 84, 16);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (143, '2023-08-10 19:09:26', '2023-08-23 04:15:26', '2024-03-01 17:18:37', 124, 88);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (144, '2023-10-01 10:58:07', '2023-12-09 20:12:35', '', 81, 86);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (145, '2023-07-31 07:55:08', '2024-02-17 23:12:53', '2023-09-11 12:00:32', 84, 43);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (146, '2024-02-04 15:03:07', '2024-02-05 14:26:08', '2023-08-17 01:09:39', 85, 200);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (147, '2023-11-09 19:06:12', '2023-11-24 13:31:29', '2023-08-08 20:43:21', 15, 114);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (148, '2023-12-19 07:26:11', '2024-03-24 04:08:24', '', 17, 26);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (149, '2023-11-03 22:17:41', '2024-02-16 10:55:43', '', 145, 149);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (150, '2023-08-26 08:38:23', '2023-05-31 20:39:33', '2023-11-27 21:20:15', 134, 87);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (151, '2023-09-10 10:48:16', '2023-07-29 08:39:40', '2024-01-10 07:32:29', 107, 167);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (152, '2023-06-24 01:55:48', '2023-08-13 14:33:55', '2023-11-23 10:16:23', 36, 149);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (153, '2023-07-05 04:31:01', '2024-03-24 16:32:54', '', 82, 108);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (154, '2023-07-29 04:36:36', '2023-06-19 07:58:01', '', 65, 110);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (155, '2023-05-18 06:23:40', '2023-11-11 13:20:45', '2023-05-22 22:08:06', 43, 15);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (156, '2023-10-03 19:06:17', '2024-03-08 16:50:10', '', 138, 92);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (157, '2023-05-18 22:05:05', '2024-02-05 20:18:00', '', 56, 36);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (158, '2023-11-04 17:50:57', '2023-06-04 12:57:01', '', 33, 158);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (159, '2023-06-18 18:45:46', '2023-12-31 10:43:42', '2023-08-31 06:11:04', 22, 143);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (160, '2023-08-01 23:50:17', '2023-09-03 13:17:54', '2023-09-24 21:40:21', 42, 163);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (161, '2023-10-31 14:43:11', '2023-08-08 20:38:08', '2024-01-08 23:53:00', 115, 124);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (162, '2024-01-10 06:37:43', '2023-12-26 22:42:48', '2023-12-27 19:47:09', 144, 39);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (163, '2023-07-30 07:23:25', '2023-10-11 07:58:22', '', 6, 172);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (164, '2023-11-24 07:28:26', '2023-09-19 03:48:34', '2024-02-07 02:28:09', 87, 170);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (165, '2024-02-14 03:08:50', '2024-01-08 00:58:49', '', 8, 187);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (166, '2023-05-09 05:53:02', '2023-06-05 10:31:47', '2023-05-14 11:53:46', 91, 177);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (167, '2023-07-08 04:15:50', '2024-04-02 18:52:49', '2023-12-05 06:15:27', 64, 162);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (168, '2024-02-04 21:05:57', '2023-10-02 09:29:06', '', 103, 101);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (169, '2024-02-26 11:42:18', '2023-11-23 15:44:38', '', 44, 119);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (170, '2023-11-25 12:56:17', '2023-11-26 21:25:22', '2023-08-27 06:30:41', 104, 190);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (171, '2023-05-03 09:32:20', '2024-04-02 17:41:38', '2024-01-02 07:47:27', 119, 187);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (172, '2023-12-05 16:16:08', '2023-07-05 02:50:30', '', 23, 179);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (173, '2023-07-11 03:41:09', '2024-01-30 11:04:28', '2023-06-02 07:44:50', 55, 154);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (174, '2023-12-25 18:31:36', '2024-02-15 18:57:56', '2023-09-30 21:11:38', 27, 44);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (175, '2024-01-12 07:20:39', '2024-03-25 11:34:30', '2024-01-23 08:17:35', 10, 86);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (176, '2023-04-22 03:49:04', '2023-08-07 09:41:21', '', 5, 115);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (177, '2024-03-19 15:58:02', '2024-01-03 20:44:17', '2024-01-30 10:38:07', 82, 45);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (178, '2023-10-10 22:40:51', '2024-01-23 03:01:15', '2023-10-15 20:20:47', 75, 8);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (179, '2023-06-07 03:06:31', '2023-08-29 09:10:43', '', 145, 69);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (180, '2023-05-05 19:55:42', '2023-07-23 11:54:12', '', 24, 158);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (181, '2023-07-01 06:00:11', '2023-12-26 19:59:55', '2023-09-14 12:07:38', 147, 20);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (182, '2023-05-31 14:25:42', '2023-12-24 03:28:45', '2023-12-06 07:14:04', 137, 127);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (183, '2023-10-29 18:31:11', '2024-02-29 20:25:59', '', 7, 23);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (184, '2023-08-09 04:04:20', '2023-10-19 17:00:43', '', 26, 48);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (185, '2024-03-03 20:04:34', '2023-06-02 06:47:01', '', 88, 47);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (186, '2023-09-16 17:18:32', '2023-07-27 00:34:01', '2023-07-26 11:42:17', 43, 93);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (187, '2023-04-29 12:05:41', '2023-07-31 06:10:12', '2023-06-11 06:31:15', 14, 5);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (188, '2023-07-02 15:06:19', '2023-10-31 11:26:44', '2023-09-20 01:54:29', 90, 129);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (189, '2023-08-13 09:17:32', '2024-01-07 22:26:47', '2023-12-25 16:50:22', 107, 76);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (190, '2023-12-21 03:44:47', '2023-11-22 20:29:53', '', 39, 138);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (191, '2023-10-29 05:47:56', '2023-05-28 03:57:53', '2023-05-13 16:05:49', 136, 24);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (192, '2023-09-06 11:31:12', '2023-06-11 02:13:34', '2023-05-29 21:41:01', 22, 165);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (193, '2023-06-14 10:40:37', '2023-07-18 14:38:20', '', 98, 59);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (194, '2024-02-24 05:35:16', '2023-08-24 15:43:50', '2023-11-19 08:22:04', 103, 73);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (195, '2023-11-14 12:57:41', '2023-12-09 05:33:18', '2024-02-27 16:33:49', 114, 200);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (196, '2023-04-21 05:41:25', '2023-06-05 13:54:18', '2024-02-29 19:02:29', 135, 110);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (197, '2023-07-09 16:26:59', '2023-05-10 08:04:14', '', 91, 179);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (198, '2023-10-10 04:53:47', '2023-06-08 21:01:00', '2023-07-24 07:03:38', 145, 95);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (199, '2024-02-29 20:39:59', '2023-09-02 10:43:51', '', 116, 108);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (200, '2023-11-27 18:17:11', '2023-06-16 07:53:06', '2024-02-19 06:09:42', 46, 147);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (201, '2024-03-08 14:53:05', '2024-01-04 18:41:57', '2024-01-09 02:58:48', 82, 67);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (202, '2023-08-30 18:14:35', '2024-02-05 12:54:54', '2023-08-17 14:20:26', 106, 109);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (203, '2023-04-20 00:44:40', '2023-06-28 17:52:44', '2024-03-14 03:00:59', 25, 144);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (204, '2023-08-19 00:09:48', '2024-01-29 13:02:35', '', 41, 195);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (205, '2023-08-05 15:13:52', '2024-02-26 12:31:03', '2023-09-22 02:48:50', 27, 166);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (206, '2024-02-14 03:44:12', '2023-08-03 06:39:32', '2024-02-15 23:16:47', 46, 59);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (207, '2023-06-02 13:11:22', '2023-09-23 16:59:56', '2023-09-09 16:18:24', 89, 139);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (208, '2023-05-06 00:59:38', '2023-06-02 15:56:03', '', 130, 190);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (209, '2024-02-29 05:38:04', '2023-09-01 11:16:22', '2023-09-06 00:14:09', 80, 50);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (210, '2024-03-17 11:02:43', '2023-09-07 16:25:57', '2023-10-27 23:09:02', 45, 110);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (211, '2024-03-11 12:22:39', '2024-01-01 07:58:12', '', 20, 155);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (212, '2023-05-16 16:28:26', '2024-01-28 13:03:58', '2023-08-04 15:56:08', 146, 82);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (213, '2023-10-19 16:51:10', '2023-12-26 11:13:26', '2023-08-30 14:03:13', 6, 17);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (214, '2024-01-20 08:35:00', '2024-01-29 12:43:43', '2023-11-29 15:02:51', 43, 55);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (215, '2023-09-09 07:45:20', '2023-07-30 10:39:04', '', 131, 64);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (216, '2023-05-11 06:03:10', '2024-01-27 17:16:16', '2024-01-19 15:27:33', 4, 61);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (217, '2024-02-28 16:39:53', '2024-01-04 15:44:46', '2023-08-23 16:39:48', 125, 26);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (218, '2023-09-05 08:37:40', '2024-04-06 03:16:28', '2023-05-26 18:23:41', 149, 19);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (219, '2023-10-25 23:43:24', '2023-09-27 16:56:42', '2023-10-02 23:39:31', 127, 162);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (220, '2023-12-05 09:41:20', '2024-03-25 22:40:10', '', 70, 158);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (221, '2023-07-27 17:30:33', '2024-04-06 03:12:44', '2023-08-11 19:50:18', 115, 127);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (222, '2023-05-11 21:46:16', '2024-03-09 16:04:43', '2024-03-02 18:16:46', 29, 83);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (223, '2023-10-30 09:39:43', '2023-06-24 12:11:49', '2023-08-20 22:16:10', 17, 91);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (224, '2024-01-08 05:52:26', '2023-10-28 07:04:22', '2024-02-22 17:51:42', 76, 181);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (225, '2023-04-15 07:55:06', '2023-12-03 21:12:08', '', 7, 57);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (226, '2023-11-16 19:07:32', '2023-06-06 23:27:36', '', 67, 196);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (227, '2023-11-12 12:53:35', '2023-12-16 07:34:46', '', 3, 145);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (228, '2023-05-27 20:01:24', '2023-09-12 03:29:50', '2023-06-29 19:53:46', 49, 116);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (229, '2024-01-03 20:40:38', '2024-04-06 19:17:36', '', 37, 81);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (230, '2023-11-07 11:17:07', '2024-01-13 22:58:04', '2023-12-26 19:08:54', 59, 114);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (231, '2023-05-10 15:23:56', '2023-06-29 22:18:08', '2023-11-02 17:57:38', 115, 3);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (232, '2023-09-16 17:34:41', '2023-09-30 14:57:40', '2023-09-02 18:35:45', 141, 153);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (233, '2023-06-27 22:02:40', '2023-05-20 03:33:33', '2024-01-28 20:53:46', 31, 95);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (234, '2023-08-16 20:45:00', '2023-06-04 21:52:06', '', 33, 65);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (235, '2024-03-03 21:06:18', '2023-12-11 04:50:26', '', 27, 115);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (236, '2023-05-24 20:26:08', '2023-09-01 09:23:28', '2023-11-25 23:37:08', 30, 155);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (237, '2023-07-30 06:54:53', '2023-05-20 03:30:37', '2023-09-03 18:25:28', 103, 87);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (238, '2023-07-24 17:23:37', '2023-10-14 12:20:13', '', 28, 42);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (239, '2023-10-31 08:24:13', '2023-11-07 10:07:16', '2023-06-20 07:19:33', 54, 13);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (240, '2023-12-25 11:44:27', '2023-12-25 12:26:44', '2023-07-08 04:21:59', 35, 196);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (241, '2023-04-30 15:19:22', '2024-03-11 14:30:28', '', 135, 93);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (242, '2023-10-18 06:42:50', '2023-11-26 10:15:12', '', 122, 170);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (243, '2024-01-25 07:11:45', '2024-03-15 21:28:09', '2023-10-13 03:10:01', 137, 188);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (244, '2024-03-05 22:48:44', '2023-10-30 05:42:34', '2023-10-19 10:38:13', 114, 15);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (245, '2024-01-26 08:49:50', '2023-08-09 18:44:53', '', 55, 70);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (246, '2023-04-12 10:09:30', '2023-12-13 01:40:28', '2023-11-27 11:31:44', 89, 50);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (247, '2023-11-29 09:10:47', '2024-03-13 05:18:20', '2023-07-20 00:55:07', 47, 135);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (248, '2023-11-20 07:26:46', '2023-07-07 03:49:52', '2023-07-02 12:36:46', 30, 93);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (249, '2023-09-04 23:52:32', '2024-03-30 09:55:10', '', 80, 161);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (250, '2023-05-18 16:48:06', '2023-12-05 15:51:27', '2023-11-25 09:35:50', 144, 154);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (251, '2024-02-09 04:32:25', '2024-03-18 02:58:01', '', 74, 157);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (252, '2024-02-06 11:51:58', '2023-09-18 10:50:34', '', 64, 9);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (253, '2023-09-19 12:51:56', '2023-05-18 16:08:05', '2023-08-29 21:42:17', 98, 9);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (254, '2023-12-20 02:45:41', '2024-03-17 00:04:51', '', 16, 150);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (255, '2023-10-31 01:02:33', '2024-01-02 01:53:18', '', 106, 127);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (256, '2023-11-07 07:43:45', '2023-10-19 09:26:43', '2024-01-04 00:08:37', 146, 148);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (257, '2023-04-23 21:08:13', '2023-07-26 01:33:47', '', 19, 110);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (258, '2023-06-30 03:37:49', '2024-01-23 04:13:45', '2023-06-29 19:11:38', 6, 19);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (259, '2023-04-20 18:49:03', '2023-11-06 14:58:41', '2023-12-12 14:15:25', 124, 125);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (260, '2023-09-25 00:36:51', '2024-02-15 02:26:16', '', 127, 140);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (261, '2023-04-14 08:32:11', '2023-09-12 14:26:41', '2023-08-12 11:33:23', 138, 131);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (262, '2023-08-26 05:49:09', '2023-10-04 22:58:03', '2023-06-17 17:09:49', 149, 123);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (263, '2023-06-27 14:51:29', '2023-05-30 05:43:34', '', 83, 80);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (264, '2023-09-13 19:13:29', '2023-07-01 17:14:20', '2023-12-23 16:53:28', 150, 21);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (265, '2023-07-06 18:29:37', '2023-07-16 07:03:49', '', 96, 103);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (266, '2023-12-03 19:44:10', '2023-11-04 11:49:24', '', 104, 186);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (267, '2024-02-11 00:00:54', '2024-02-03 13:15:22', '2023-12-16 01:30:15', 123, 123);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (268, '2023-11-20 00:03:39', '2023-11-10 20:30:09', '', 25, 186);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (269, '2024-01-15 01:53:43', '2024-01-04 03:00:48', '', 121, 1);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (270, '2023-09-30 21:16:04', '2023-06-24 05:00:21', '', 112, 14);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (271, '2024-02-20 18:51:47', '2023-09-09 09:21:56', '2023-07-20 21:28:49', 135, 32);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (272, '2023-08-31 23:21:20', '2023-08-03 15:10:10', '2024-02-02 20:54:49', 19, 17);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (273, '2024-02-12 14:24:46', '2023-09-30 12:29:05', '', 55, 62);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (274, '2023-12-02 03:02:18', '2024-02-26 03:15:21', '2024-02-19 23:51:59', 125, 137);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (275, '2023-04-30 13:17:10', '2024-03-09 23:36:08', '', 15, 5);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (276, '2024-03-15 11:14:15', '2023-12-08 22:01:41', '', 11, 94);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (277, '2023-12-01 03:23:25', '2024-01-29 02:27:26', '2023-11-02 14:29:54', 97, 121);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (278, '2023-10-18 19:08:11', '2023-06-14 17:31:01', '2023-12-16 15:04:24', 27, 116);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (279, '2024-01-17 04:55:16', '2023-08-21 19:43:53', '2023-10-21 19:48:56', 76, 97);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (280, '2023-11-12 03:28:38', '2023-08-17 10:21:43', '2023-11-05 18:20:17', 132, 133);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (281, '2023-09-14 22:01:20', '2023-11-29 20:31:28', '2023-07-24 10:15:44', 137, 48);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (282, '2023-05-15 20:14:36', '2024-02-09 06:12:12', '', 102, 58);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (283, '2023-08-31 19:53:50', '2023-07-03 11:40:04', '', 127, 144);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (284, '2023-10-07 17:40:44', '2023-10-19 06:52:42', '', 4, 147);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (285, '2023-09-22 06:40:52', '2023-10-26 05:31:40', '2024-01-30 15:54:23', 141, 46);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (286, '2024-03-30 04:24:54', '2023-07-09 01:48:29', '2024-01-21 03:35:40', 145, 82);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (287, '2023-06-20 00:32:03', '2023-06-29 23:59:15', '', 117, 172);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (288, '2023-07-12 23:04:55', '2023-06-04 02:34:53', '2024-04-05 02:49:35', 23, 126);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (289, '2023-07-27 17:02:32', '2023-08-02 03:32:26', '2024-02-01 15:47:03', 78, 88);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (290, '2023-05-13 14:20:50', '2023-10-20 04:35:36', '2024-01-26 08:37:26', 76, 173);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (291, '2023-12-29 12:02:54', '2023-12-25 19:05:27', '2023-07-23 09:10:21', 147, 159);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (292, '2023-04-30 17:12:16', '2023-12-24 04:16:57', '2023-09-20 01:57:51', 148, 85);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (293, '2024-03-10 23:59:17', '2023-09-13 10:17:10', '', 116, 103);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (294, '2023-11-10 17:51:47', '2023-11-04 00:37:13', '', 82, 138);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (295, '2024-04-04 17:28:02', '2023-10-02 10:32:00', '2023-08-16 23:45:39', 109, 136);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (296, '2023-12-04 13:20:28', '2023-05-19 09:28:15', '2024-01-02 03:02:56', 122, 186);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (297, '2023-11-29 03:28:32', '2023-06-12 04:45:33', '2023-10-08 17:43:06', 119, 117);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (298, '2023-06-05 23:49:19', '2024-02-12 12:04:38', '', 79, 93);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (299, '2024-01-08 06:52:52', '2023-07-13 07:38:12', '', 16, 27);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (300, '2023-09-23 02:09:35', '2024-03-23 11:58:12', '2023-06-25 22:51:09', 142, 24);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (301, '2023-06-18 23:37:42', '2023-07-30 00:55:21', '2023-10-04 16:40:34', 79, 148);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (302, '2023-05-10 07:36:51', '2023-07-07 09:57:03', '2023-08-10 05:46:48', 135, 146);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (303, '2023-04-12 07:11:54', '2023-10-27 23:21:29', '2024-01-09 23:41:42', 25, 198);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (304, '2023-10-16 01:37:47', '2024-01-22 14:43:11', '2023-11-25 12:01:52', 103, 66);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (305, '2023-07-02 04:41:41', '2023-06-26 08:28:39', '2023-08-03 09:10:59', 86, 96);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (306, '2023-06-13 03:33:34', '2023-09-25 12:20:56', '', 102, 152);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (307, '2023-10-23 10:11:30', '2024-03-12 18:39:49', '', 140, 91);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (308, '2023-10-04 22:21:30', '2023-08-11 08:41:27', '2023-10-23 18:16:06', 9, 128);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (309, '2023-10-16 07:01:14', '2023-10-25 06:28:43', '2024-01-18 02:18:34', 119, 195);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (310, '2024-01-16 20:30:30', '2023-10-12 05:11:57', '2023-07-28 05:43:54', 116, 77);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (311, '2023-05-17 19:28:39', '2023-11-08 09:22:22', '', 102, 175);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (312, '2023-11-30 19:30:15', '2023-10-10 09:12:00', '', 70, 29);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (313, '2023-07-11 05:55:07', '2023-09-30 16:14:03', '', 28, 88);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (314, '2023-08-24 11:32:00', '2023-12-28 06:20:36', '', 102, 4);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (315, '2023-10-09 10:13:18', '2023-07-30 18:27:18', '2023-12-08 01:49:17', 87, 38);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (316, '2023-07-19 22:00:50', '2023-08-10 05:43:49', '', 60, 55);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (317, '2023-12-20 01:12:26', '2024-02-03 11:34:27', '', 112, 69);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (318, '2023-08-05 16:59:35', '2023-06-23 13:25:55', '2023-08-11 12:43:12', 17, 131);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (319, '2024-02-07 12:39:29', '2023-07-18 02:42:35', '', 67, 90);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (320, '2023-08-13 12:51:26', '2023-06-11 15:49:53', '', 69, 90);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (321, '2024-03-01 13:36:56', '2023-11-26 09:11:53', '', 88, 68);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (322, '2024-02-02 17:01:21', '2023-05-19 09:42:26', '2024-02-07 22:56:30', 88, 182);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (323, '2023-09-28 08:19:37', '2023-08-11 15:12:05', '2023-09-14 21:17:55', 129, 153);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (324, '2023-10-23 10:56:58', '2024-01-30 05:40:54', '2024-01-14 12:05:41', 91, 104);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (325, '2023-08-11 19:29:12', '2023-10-10 20:05:26', '', 38, 120);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (326, '2023-06-11 13:36:25', '2023-12-15 02:04:20', '2023-09-01 19:55:58', 52, 62);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (327, '2023-12-24 18:37:39', '2024-02-03 13:05:29', '2024-04-04 13:51:00', 99, 52);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (328, '2023-08-29 09:02:06', '2023-06-12 19:40:08', '', 134, 120);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (329, '2023-05-12 19:10:13', '2024-01-03 16:26:22', '2024-02-16 13:08:39', 122, 53);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (330, '2024-03-12 15:22:01', '2024-03-21 00:34:43', '2023-06-08 14:49:15', 32, 163);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (331, '2024-02-02 16:10:42', '2023-08-27 01:32:40', '2023-07-04 07:21:22', 40, 187);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (332, '2023-06-14 17:24:15', '2023-07-19 19:04:56', '2023-09-08 11:37:27', 71, 146);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (333, '2023-09-05 21:28:12', '2023-05-19 22:21:49', '', 108, 103);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (334, '2023-12-28 18:41:23', '2023-09-21 18:55:16', '2023-08-06 10:35:41', 22, 115);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (335, '2024-01-12 01:48:22', '2023-07-15 10:31:02', '2023-10-17 06:42:00', 46, 62);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (336, '2023-08-16 21:46:24', '2023-05-24 02:54:43', '', 79, 135);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (337, '2024-01-21 14:54:02', '2023-07-20 00:12:56', '', 148, 183);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (338, '2023-11-01 05:34:05', '2024-01-30 01:19:05', '', 123, 126);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (339, '2023-10-03 19:05:34', '2024-04-02 11:48:52', '', 110, 99);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (340, '2024-02-10 12:45:51', '2023-12-02 13:25:15', '2023-07-03 08:12:59', 95, 136);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (341, '2024-02-07 04:01:47', '2024-02-06 17:11:16', '2023-07-10 09:21:54', 94, 102);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (342, '2023-06-22 15:39:09', '2024-03-03 00:42:54', '2024-04-06 12:22:28', 108, 183);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (343, '2023-08-28 15:42:24', '2024-03-25 00:22:53', '2024-03-26 20:01:01', 98, 19);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (344, '2024-02-01 10:49:27', '2023-11-18 20:11:04', '', 66, 124);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (345, '2023-08-12 09:46:03', '2023-12-06 22:38:56', '2023-11-08 13:54:41', 103, 34);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (346, '2023-08-18 18:36:29', '2023-07-16 05:06:43', '', 11, 23);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (347, '2023-05-27 20:48:37', '2023-07-03 00:10:04', '2024-04-08 09:25:27', 26, 152);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (348, '2023-06-10 15:21:19', '2023-06-11 10:37:01', '2023-12-20 04:04:31', 102, 34);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (349, '2024-01-07 02:03:12', '2023-12-02 07:28:49', '', 47, 63);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (350, '2023-08-19 00:11:16', '2024-03-11 20:44:12', '2024-01-30 06:23:52', 150, 9);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (351, '2024-02-19 11:39:26', '2024-01-02 08:07:22', '2023-09-21 18:01:58', 108, 23);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (352, '2023-06-16 15:20:03', '2024-02-10 08:40:16', '', 55, 20);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (353, '2023-04-29 04:41:30', '2023-06-11 22:27:53', '', 76, 121);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (354, '2024-02-11 16:47:11', '2023-12-06 02:18:02', '2023-10-22 09:20:24', 26, 108);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (355, '2023-05-17 04:01:34', '2023-08-13 09:35:42', '', 142, 129);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (356, '2023-12-22 02:20:04', '2023-10-06 20:47:32', '2023-11-19 19:55:45', 12, 142);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (357, '2023-06-12 12:43:53', '2023-10-01 08:14:45', '', 46, 121);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (358, '2023-06-04 20:56:09', '2023-09-27 09:17:55', '2023-09-01 00:02:03', 47, 9);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (359, '2023-05-14 07:15:00', '2023-11-24 07:50:28', '2024-02-14 15:35:56', 127, 153);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (360, '2023-12-24 00:51:13', '2024-03-16 23:29:23', '2023-09-28 14:46:35', 42, 138);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (361, '2023-06-19 06:12:02', '2023-10-05 02:38:20', '', 88, 89);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (362, '2024-01-29 10:05:45', '2023-07-05 22:19:00', '2024-04-02 23:12:33', 89, 76);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (363, '2024-01-09 10:38:44', '2024-01-08 16:13:58', '2023-08-28 19:09:11', 102, 176);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (364, '2023-12-07 23:07:57', '2023-10-27 18:56:54', '2024-02-08 11:10:40', 113, 45);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (365, '2023-06-09 18:59:46', '2023-12-30 02:45:18', '2023-09-20 16:03:35', 4, 14);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (366, '2023-11-10 22:47:30', '2023-06-21 14:15:07', '', 2, 190);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (367, '2024-01-28 12:54:23', '2024-03-20 06:42:06', '', 50, 69);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (368, '2023-06-20 16:12:39', '2023-09-19 00:24:00', '2024-01-22 05:38:41', 148, 93);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (369, '2023-05-06 10:58:42', '2023-11-23 21:32:13', '2023-07-18 03:37:14', 40, 20);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (370, '2023-07-07 23:51:12', '2023-11-14 14:52:27', '2023-08-28 15:06:02', 99, 74);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (371, '2023-11-21 11:43:09', '2023-05-31 14:21:20', '', 119, 33);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (372, '2023-06-06 03:25:57', '2024-03-25 00:02:42', '2023-05-16 19:10:47', 69, 76);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (373, '2023-12-22 14:58:03', '2024-02-02 08:29:49', '', 17, 45);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (374, '2023-05-15 03:26:49', '2023-10-16 21:10:46', '2023-05-28 14:19:50', 150, 2);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (375, '2023-05-03 18:20:43', '2023-07-06 19:09:08', '2023-09-05 18:04:40', 100, 189);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (376, '2023-08-19 07:50:34', '2023-08-02 19:38:24', '2024-03-13 16:17:19', 96, 107);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (377, '2024-02-11 09:38:09', '2023-09-19 09:10:18', '2023-08-04 18:58:55', 75, 118);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (378, '2023-05-21 05:07:54', '2023-12-06 16:18:05', '2024-02-09 11:34:11', 15, 48);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (379, '2023-11-13 23:48:46', '2023-10-23 08:55:24', '2023-07-02 13:35:26', 69, 121);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (380, '2024-03-23 21:57:39', '2023-12-22 10:10:37', '', 144, 177);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (381, '2024-01-13 22:53:11', '2023-10-27 16:51:51', '', 24, 80);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (382, '2023-11-20 23:15:08', '2024-02-23 17:02:51', '2023-11-14 03:19:46', 23, 181);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (383, '2023-04-18 16:02:21', '2023-08-16 15:45:44', '2024-01-15 01:06:59', 118, 46);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (384, '2023-10-13 03:33:24', '2023-06-12 09:11:13', '', 40, 8);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (385, '2023-05-31 19:10:37', '2023-11-03 18:55:04', '', 3, 101);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (386, '2024-01-03 01:25:13', '2023-08-31 03:43:50', '', 4, 130);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (387, '2023-09-22 15:46:44', '2023-11-22 12:07:46', '', 131, 7);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (388, '2023-06-22 14:39:28', '2024-03-27 12:51:09', '', 135, 116);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (389, '2023-08-25 21:33:08', '2023-06-04 21:28:07', '', 136, 45);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (390, '2023-11-20 07:48:12', '2023-06-02 16:20:06', '2024-02-01 14:31:15', 122, 172);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (391, '2024-03-16 12:00:29', '2024-03-20 12:29:03', '2024-02-20 21:06:27', 144, 133);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (392, '2023-04-30 22:03:41', '2023-06-19 12:38:54', '2023-08-08 16:16:28', 125, 9);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (393, '2023-05-02 12:13:30', '2023-07-27 09:59:01', '2024-04-04 13:49:52', 66, 137);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (394, '2024-01-02 02:38:25', '2023-12-12 07:07:16', '2023-10-17 01:58:10', 67, 9);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (395, '2024-01-12 16:25:55', '2023-09-07 03:48:04', '2023-12-10 19:15:16', 77, 22);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (396, '2024-03-14 04:44:02', '2023-12-05 17:14:59', '', 41, 76);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (397, '2024-04-06 19:05:50', '2023-11-05 19:36:33', '', 77, 8);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (398, '2023-09-28 08:32:17', '2024-01-25 03:22:55', '2023-05-27 16:02:04', 101, 3);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (399, '2024-03-01 22:58:37', '2024-03-27 14:46:15', '', 128, 52);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (400, '2024-01-10 07:25:24', '2023-09-21 23:55:27', '2023-05-20 01:49:20', 136, 93);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (401, '2023-07-20 06:05:49', '2024-03-06 19:36:33', '2024-03-04 18:41:15', 122, 53);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (402, '2023-09-26 03:23:55', '2024-01-09 01:17:15', '2023-06-23 12:18:46', 47, 98);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (403, '2023-07-06 05:30:39', '2023-08-06 13:41:24', '2023-10-13 12:58:54', 121, 183);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (404, '2023-10-09 23:00:01', '2024-04-04 15:57:50', '2023-08-15 06:27:59', 147, 163);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (405, '2023-09-12 09:14:19', '2023-12-20 06:45:03', '2024-02-11 04:03:42', 135, 179);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (406, '2024-01-02 06:45:21', '2023-10-24 21:21:57', '', 26, 153);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (407, '2023-12-25 04:52:02', '2023-06-18 22:59:39', '2023-05-16 04:22:40', 130, 20);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (408, '2023-11-02 14:36:20', '2023-10-26 23:52:25', '2023-07-24 12:54:10', 116, 175);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (409, '2023-12-10 23:22:11', '2023-08-31 06:00:15', '', 107, 61);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (410, '2023-05-31 17:01:15', '2023-06-11 07:15:07', '', 112, 106);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (411, '2023-05-24 12:15:32', '2023-09-06 13:43:28', '', 4, 73);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (412, '2023-06-21 16:55:04', '2023-05-20 09:51:11', '2023-10-18 17:57:57', 102, 91);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (413, '2024-02-05 07:24:23', '2024-03-03 14:26:55', '', 143, 112);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (414, '2023-10-18 23:56:02', '2023-07-18 04:12:22', '', 15, 103);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (415, '2023-09-29 01:15:28', '2023-09-19 18:55:21', '', 123, 38);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (416, '2023-04-30 03:19:20', '2023-07-18 21:42:32', '', 59, 18);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (417, '2023-05-01 22:19:07', '2023-09-24 15:30:44', '2024-02-29 18:00:09', 25, 172);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (418, '2023-07-04 04:33:40', '2024-01-04 20:30:33', '', 138, 105);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (419, '2023-05-27 08:00:38', '2023-12-20 11:56:30', '', 136, 129);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (420, '2023-09-09 01:34:17', '2023-08-23 09:51:55', '2024-03-18 04:20:54', 96, 145);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (421, '2023-09-22 04:05:03', '2023-09-29 07:40:47', '2023-09-10 02:25:32', 29, 128);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (422, '2023-08-17 01:08:19', '2023-05-23 06:26:31', '2024-02-20 17:31:29', 57, 164);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (423, '2023-11-16 07:08:00', '2023-11-07 10:55:15', '2023-10-08 06:28:56', 10, 114);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (424, '2023-07-23 07:47:34', '2023-09-24 01:40:58', '2023-06-27 11:45:23', 42, 190);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (425, '2024-04-04 13:45:48', '2023-08-06 22:58:42', '', 34, 74);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (426, '2023-08-16 06:21:22', '2023-11-04 10:18:50', '2023-08-27 08:55:37', 25, 159);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (427, '2023-08-09 08:19:00', '2024-01-13 12:06:37', '', 139, 91);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (428, '2023-07-03 00:22:55', '2023-12-02 22:38:06', '2023-11-01 23:10:59', 62, 37);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (429, '2023-07-13 11:19:57', '2023-10-27 22:37:10', '2023-07-20 16:15:26', 115, 128);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (430, '2023-08-11 21:32:41', '2023-08-25 06:36:04', '2024-03-03 19:35:05', 4, 176);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (431, '2023-04-16 22:26:05', '2023-11-20 21:23:12', '', 20, 163);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (432, '2023-05-22 00:49:59', '2023-06-18 22:53:42', '', 122, 81);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (433, '2023-04-11 23:57:40', '2023-09-15 04:26:06', '2023-09-21 09:06:12', 12, 197);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (434, '2023-12-21 22:09:05', '2024-03-21 02:30:28', '2023-10-02 10:38:47', 93, 161);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (435, '2023-04-26 10:07:08', '2024-02-13 06:49:39', '', 45, 141);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (436, '2023-05-07 23:17:10', '2023-10-24 20:10:43', '2024-01-19 01:36:17', 49, 188);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (437, '2023-11-09 13:20:53', '2024-01-09 15:25:36', '2023-07-26 11:17:22', 100, 90);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (438, '2023-06-25 01:38:20', '2023-07-18 11:07:29', '', 28, 73);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (439, '2023-10-17 01:20:30', '2023-12-09 14:57:01', '', 81, 135);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (440, '2023-05-12 01:42:57', '2023-05-17 18:36:37', '2024-04-02 06:22:37', 42, 23);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (441, '2023-12-18 16:53:29', '2023-08-11 21:54:34', '', 101, 3);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (442, '2024-02-06 11:13:05', '2023-12-22 18:15:22', '2023-11-13 15:10:24', 37, 195);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (443, '2023-06-22 09:17:34', '2023-09-19 16:20:25', '2023-09-24 19:46:58', 67, 127);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (444, '2023-10-20 06:09:42', '2023-08-31 15:57:02', '2023-09-04 09:10:56', 110, 157);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (445, '2023-12-23 02:59:19', '2024-02-18 18:50:26', '2023-10-04 20:24:28', 13, 69);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (446, '2024-02-24 21:58:08', '2024-03-07 22:07:08', '2023-08-13 09:52:19', 44, 168);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (447, '2024-02-27 01:24:43', '2023-08-16 20:17:50', '2024-02-12 07:48:13', 109, 108);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (448, '2023-06-18 21:13:25', '2023-10-09 09:26:53', '2023-10-27 06:00:53', 42, 12);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (449, '2024-02-15 11:53:13', '2024-04-08 19:51:30', '', 85, 91);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (450, '2023-07-10 09:06:27', '2023-10-25 12:15:11', '2023-09-09 08:49:08', 36, 36);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (451, '2024-03-25 15:17:55', '2023-07-10 11:26:28', '', 45, 139);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (452, '2024-01-09 10:05:38', '2023-10-23 20:04:07', '2024-01-04 22:04:30', 121, 31);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (453, '2023-12-28 06:56:42', '2024-04-02 04:34:11', '', 142, 93);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (454, '2023-09-06 23:44:27', '2023-06-10 00:04:54', '2023-08-23 03:05:04', 137, 120);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (455, '2023-11-06 19:47:41', '2023-10-25 00:30:35', '', 127, 21);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (456, '2023-09-07 19:40:56', '2024-02-12 15:35:36', '', 62, 96);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (457, '2023-10-14 00:50:55', '2023-10-28 08:17:50', '', 99, 109);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (458, '2023-04-13 17:07:18', '2023-09-11 14:08:52', '2023-08-20 20:36:50', 99, 35);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (459, '2023-04-10 13:59:58', '2023-07-28 12:57:56', '2023-10-04 16:28:58', 109, 148);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (460, '2023-07-07 04:45:52', '2024-01-09 03:06:43', '2024-01-07 22:30:13', 69, 6);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (461, '2024-01-04 23:09:02', '2023-07-14 07:01:12', '2023-09-02 14:30:49', 47, 120);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (462, '2024-04-04 17:42:21', '2024-03-27 06:39:53', '2023-07-17 18:52:34', 125, 96);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (463, '2024-02-28 12:40:39', '2023-07-13 13:14:54', '2023-09-15 20:03:53', 116, 43);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (464, '2023-08-22 05:48:24', '2023-06-27 03:21:29', '2023-07-13 12:30:42', 131, 123);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (465, '2023-07-30 05:55:41', '2024-03-28 06:34:13', '2024-03-12 03:46:24', 13, 36);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (466, '2023-10-29 07:24:15', '2023-08-22 05:30:12', '', 61, 74);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (467, '2023-12-15 00:40:58', '2023-07-11 07:37:16', '', 90, 46);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (468, '2023-09-23 20:53:49', '2023-12-06 19:41:45', '2024-02-07 19:17:27', 62, 101);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (469, '2023-06-06 21:41:37', '2023-08-08 14:45:49', '', 12, 86);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (470, '2023-07-13 10:16:43', '2023-12-17 09:05:11', '2024-02-11 02:00:09', 112, 91);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (471, '2024-02-12 04:01:51', '2023-05-22 03:51:21', '2023-09-15 16:13:12', 118, 1);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (472, '2024-03-21 08:57:36', '2023-10-01 13:37:01', '2023-08-14 04:17:01', 68, 114);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (473, '2023-11-09 03:35:20', '2023-08-17 15:03:15', '', 35, 21);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (474, '2023-05-09 23:15:51', '2023-08-12 07:26:44', '', 51, 56);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (475, '2023-12-30 06:44:51', '2024-01-23 20:23:22', '2024-02-02 12:59:55', 22, 99);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (476, '2024-03-11 21:54:41', '2024-01-16 04:42:46', '2024-03-06 06:54:32', 77, 193);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (477, '2024-04-08 21:38:19', '2023-12-30 22:50:55', '', 79, 41);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (478, '2023-11-20 00:16:58', '2024-02-23 07:06:27', '', 50, 56);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (479, '2024-01-20 15:32:35', '2023-10-23 02:45:50', '2023-12-15 11:53:31', 46, 17);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (480, '2023-09-13 20:33:39', '2023-07-08 18:41:28', '2023-05-17 23:47:16', 112, 43);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (481, '2023-04-17 03:47:42', '2023-10-01 16:52:12', '', 144, 194);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (482, '2023-06-21 14:58:19', '2023-06-28 20:04:51', '2024-04-08 02:35:12', 37, 72);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (483, '2024-01-16 18:25:02', '2023-12-27 10:35:26', '', 16, 36);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (484, '2023-09-14 04:16:30', '2023-10-17 08:22:02', '', 138, 47);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (485, '2023-08-15 07:40:48', '2023-06-08 16:21:09', '2024-01-25 00:43:34', 109, 160);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (486, '2023-10-13 21:48:45', '2023-08-12 23:03:29', '2023-10-24 13:31:43', 86, 30);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (487, '2023-11-30 07:33:51', '2023-11-18 04:37:22', '', 36, 27);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (488, '2023-04-14 00:55:25', '2023-05-25 17:37:34', '2024-02-17 14:36:00', 87, 103);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (489, '2024-02-10 14:08:44', '2023-09-18 16:40:16', '', 137, 28);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (490, '2024-04-06 10:51:12', '2023-10-18 09:56:07', '', 10, 26);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (491, '2023-07-28 06:56:15', '2023-10-21 02:50:47', '', 123, 152);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (492, '2024-03-15 05:08:01', '2023-08-19 20:02:03', '2023-06-24 20:38:37', 10, 152);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (493, '2023-04-10 22:25:40', '2023-06-14 06:11:40', '2023-10-13 20:31:24', 141, 125);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (494, '2023-11-04 21:58:27', '2023-08-04 14:16:29', '', 90, 35);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (495, '2023-08-19 07:49:22', '2023-05-21 15:49:45', '', 127, 65);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (496, '2023-12-26 21:48:30', '2023-10-14 23:09:12', '', 32, 171);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (497, '2023-08-30 11:26:22', '2023-08-28 09:36:01', '2023-10-03 15:52:25', 147, 63);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (498, '2023-07-10 03:00:36', '2024-03-05 10:55:02', '2024-02-08 07:05:14', 110, 110);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (499, '2023-12-06 23:01:08', '2024-03-19 15:00:29', '', 16, 53);
INSERT INTO `lapinamk_varasto`.`rental_transactions` (`id`, `created_at`, `due_date`, `returned_at`, `rental_items_id`, `users_id`) VALUES (500, '2024-04-02 14:02:31', '2024-04-05 15:54:06', '2024-03-29 13:56:44', 6, 7);

COMMIT;

