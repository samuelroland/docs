-- Version: 1.0
-- Project: Script SQL permettant de créer et remplir une base de données fictives avec des informations sur les films Marvel (les données ne sont pas réelles). (créé à l'occasion des portes ouvertes du CPNV en 2019).
-- Authors: Samuel Roland/ Benoît Pierrehumbert

-- Suppresion de la base de donnée existante:
DROP DATABASE IF EXISTS mcu;

-- Création de la structure:
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `MCU` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `MCU`.`films` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `filmcode` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `releasedate` DATE NOT NULL,
  `duration` TIME NOT NULL,
  `totalrevenue` FLOAT(11) NULL DEFAULT NULL,
  `productionsocietie_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC, `releasedate` ASC) VISIBLE,
  UNIQUE INDEX `filmcode_UNIQUE` (`filmcode` ASC) VISIBLE,
  INDEX `fk_films_productionsocieties1_idx` (`productionsocietie_id` ASC) VISIBLE,
  CONSTRAINT `fk_films_productionsocieties1`
    FOREIGN KEY (`productionsocietie_id`)
    REFERENCES `MCU`.`productionsocieties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `MCU`.`productionsocieties` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `creation` DATE NOT NULL,
  `headoffice` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `MCU`.`actors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `actornumber` INT(11) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `actornumber_UNIQUE` (`actornumber` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `MCU`.`heroes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `origin` VARCHAR(45) NOT NULL,
  `alias` VARCHAR(45) NOT NULL,
  `actor_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_heroes_actors1_idx` (`actor_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_heroes_actors1`
    FOREIGN KEY (`actor_id`)
    REFERENCES `MCU`.`actors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `MCU`.`filmmakers` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `filmmakersnumber` INT(11) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `birthname` DATE NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `filmmakersnumber_UNIQUE` (`filmmakersnumber` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `MCU`.`make` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `film_id` INT(11) NULL DEFAULT NULL,
  `filmmaker_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_films_has_filmmakers_filmmakers1_idx` (`filmmaker_id` ASC) VISIBLE,
  INDEX `fk_films_has_filmmakers_films_idx` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_films_has_filmmakers_films`
    FOREIGN KEY (`film_id`)
    REFERENCES `MCU`.`films` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_films_has_filmmakers_filmmakers1`
    FOREIGN KEY (`filmmaker_id`)
    REFERENCES `MCU`.`filmmakers` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `MCU`.`play` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `heroe_id` INT(11) NOT NULL,
  `film_id` INT(11) NOT NULL,
  `since` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_heroes_has_films_films1_idx` (`film_id` ASC) VISIBLE,
  INDEX `fk_heroes_has_films_heroes1_idx` (`heroe_id` ASC) VISIBLE,
  CONSTRAINT `fk_heroes_has_films_heroes1`
    FOREIGN KEY (`heroe_id`)
    REFERENCES `MCU`.`heroes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_heroes_has_films_films1`
    FOREIGN KEY (`film_id`)
    REFERENCES `MCU`.`films` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- Import des données, selon cet ordre des tables:

-- filmakers
INSERT INTO `mcu`.`filmmakers` (`id`, `filmmakersnumber`, `lastname`, `firstname`, `birthname`, `nationality`) VALUES ('1', '1362246', 'Bertrand', 'Jean-Michel', '1996-04-11', 'Suisse');
INSERT INTO `mcu`.`filmmakers` (`id`, `filmmakersnumber`, `lastname`, `firstname`, `birthname`, `nationality`) VALUES ('2', '1236424', 'Duc', 'Jean-Philippe', '1986-07-06', 'Belgique');
INSERT INTO `mcu`.`filmmakers` (`id`, `filmmakersnumber`, `lastname`, `firstname`, `birthname`, `nationality`) VALUES ('3', '2136456', 'Chamblon', 'Luc-Olivier', '1975-10-13', 'Amérique');
INSERT INTO `mcu`.`filmmakers` (`id`, `filmmakersnumber`, `lastname`, `firstname`, `birthname`, `nationality`) VALUES ('4', '1326496', 'Picard', 'Valentin', '1959-11-15', 'Italie');

-- productionssocieties
INSERT INTO `mcu`.`productionsocieties` (`id`, `name`, `creation`, `headoffice`) VALUES ('1', 'Columbia Pictures', '1924-01-01', 'Anthony Vinciquerra');
INSERT INTO `mcu`.`productionsocieties` (`id`, `name`, `creation`, `headoffice`) VALUES ('2', 'Sony Pictures Entertainment Inc.', '1987-01-01', 'Anthony Vinciquerra');
INSERT INTO `mcu`.`productionsocieties` (`id`, `name`, `creation`, `headoffice`) VALUES ('3', 'Marvel Studios', '1993-01-01', 'Kevin Feige');
INSERT INTO `mcu`.`productionsocieties` (`id`, `name`, `creation`, `headoffice`) VALUES ('4', 'Marvel Entertainment', '2019-11-15', 'Isaac Perlmutter');

-- actors
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('1', '1', 'Ruffalo', 'Mark', '1967-11-22', 'USA');
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('2', '2', 'Holland', 'Tom', '1996-06-01', 'UK');
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('3', '3', 'Hemsworth', 'Chris', '1983-08-11', 'AU');
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('4', '4', 'Downey Jr.', 'Robert ', '1965-04-04', 'USA');
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('5', '5', 'Jackman ', 'Hugh', '1968-10-12', 'AU');
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('6', '6', 'Evans ', 'Chris ', '1981-06-13', 'USA');
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('7', '7', 'Reynolds ', 'Ryan ', '1976-10-23', 'CA');
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('8', '8', 'Rudd ', 'Paul ', '1969-04-6', 'USA');
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('9', '9', 'Pfeiffer ', 'Michelle ', '1958-04-29', 'USA');
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('10','10', 'Diesel ', 'Vin ', '1967-07-18', 'USA');
INSERT INTO `mcu`.`actors` (`id`, `actornumber`, `lastname`, `firstname`, `birthdate`, `nationality`) VALUES ('11','11', 'Cumberbatch ', 'Benedict ', '1976-07-19', 'UK');


-- heroes
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('1','Hulk', 'N/A','Robert Bruce Banner','1');
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('2','Spider-Man', 'N/A','Peter Benjamin Parker','2');
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('3','Thor', 'N/A','Thor Odinson','3');
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('4','Iron Man', 'N/A','Anthony Edward Stark','4');
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('5','Wolverine', 'N/A','James Howlett','5');
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('6','Captain America', 'N/A','Steven Grant Rogers','6');
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('7','Deadpool', 'N/A','Wade Winston Wilson','7');
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('8','Ant-Man', 'N/A','Scott Lang','8');
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('9','Guèpe', 'N/A','Hope van Dyne','9');
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('10','Groot', 'N/A','Groot','10');
INSERT INTO `mcu`.`heroes`(`id`, `name`, `origin`, `alias`, `actor_id`) VALUES ('11','Docteur Strange', 'N/A','Docteur Strange','11');


-- films
INSERT INTO `mcu`.`films`(filmcode, name, releasedate, duration, totalrevenue, productionsocietie_id) VALUES ('1573','Avengers : Endgame','2019-03-15','01:05:06','2795473000', 3);
INSERT INTO `mcu`.`films`(filmcode, name, releasedate, duration, totalrevenue, productionsocietie_id) VALUES ('2758','Spider-Man: Far From Home','2018-04-19','02:50:00','1131783353', 3);
INSERT INTO `mcu`.`films`(filmcode, name, releasedate, duration, totalrevenue, productionsocietie_id) VALUES ('3759','Captain Marvel','2018-04-19','02:09:09','1126129839', 3);
INSERT INTO `mcu`.`films`(filmcode, name, releasedate, duration, totalrevenue, productionsocietie_id) VALUES ('7393','Ant-Man','2017-02-19','08:05:06','1142003109', 1);
INSERT INTO `mcu`.`films`(filmcode, name, releasedate, duration, totalrevenue, productionsocietie_id) VALUES ('1456','Les Gardiens de la Galaxie','2018-11-20','12:05:06','1641885213', 2);
INSERT INTO `mcu`.`films`(filmcode, name, releasedate, duration, totalrevenue, productionsocietie_id) VALUES ('1234','Black Panther','2018-06-12','12:05:06','1348258224', 4);
INSERT INTO `mcu`.`films`(filmcode, name, releasedate, duration, totalrevenue, productionsocietie_id) VALUES ('3580','Thor : Ragnarok','2016-02-15','12:05:06','853958289', 2);
INSERT INTO `mcu`.`films`(filmcode, name, releasedate, duration, totalrevenue, productionsocietie_id) VALUES ('5854','Iron Man 3','2012-11-02','03:45:06','1215392272', 4);
INSERT INTO `mcu`.`films`(filmcode, name, releasedate, duration, totalrevenue, productionsocietie_id) VALUES ('8782','Deadpool','2003-12-05','04:05:06','1587706150', 1);
INSERT INTO `mcu`.`films`(filmcode, name, releasedate, duration, totalrevenue, productionsocietie_id) VALUES ('8365','Deadpool 2','2011-06-03','06:05:06','786680652', 3);

-- make
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('1', '1', '1');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('2', '8', '4');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('3', '5', '4');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('4', '4', '2');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('5', '5', '1');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('6', '7', '4');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('7', '2', '3');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('8', '4', '2');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('9', '6', '4');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('10', '7', '4');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('11', '2', '3');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('12', '3', '1');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('13', '1', '2');
INSERT INTO `mcu`.`make` (`id`, `film_id`, `filmmaker_id`) VALUES ('14', '4', '1');

-- play
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('1', '1', '2', '2019-03-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('2', '8', '5', '2017-02-19');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('3', '6', '4', '2018-04-19');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('4', '7', '3', '2003-12-05');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('5', '7', '7', '2011-06-03');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('6', '10', '6', '2018-11-20');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('7', '4', '9', '2012-11-02');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('8', '3', '8', '2016-02-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('9', '2', '2', '2019-03-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('10', '3', '2', '2019-03-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('11', '4', '2', '2019-03-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('12', '5', '2', '2019-03-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('13', '6', '2', '2019-03-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('14', '7', '2', '2019-03-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('15', '8', '2', '2019-03-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('16', '9', '2', '2019-03-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('17', '10', '2', '2019-03-15');
INSERT INTO `mcu`.`play` (`id`, `heroe_id`, `film_id`, `since`) VALUES ('18', '11', '2', '2019-03-15');


-- fin du script