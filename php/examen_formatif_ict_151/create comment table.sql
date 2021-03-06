-- Version: 1.0
-- Project: Examen formatif ICT-151
-- Author: Samuel Roland

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP TABLE if EXISTS comments;

CREATE TABLE IF NOT EXISTS `snows`.`comments` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `snowtype_id` INT(11) NOT NULL,
  `user_id` INT(10) UNSIGNED NOT NULL,
  `date` DATE NOT NULL,
  `text` VARCHAR(1000) NOT NULL,
  `emoji` INT(11) NOT NULL,
  `nbstars` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_snowtypes_has_users_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_snowtypes_has_users_snowtypes1_idx` (`snowtype_id` ASC) VISIBLE,
  UNIQUE INDEX `text_UNIQUE` (`text` ASC) VISIBLE,
  CONSTRAINT `fk_comments_snowtypes1`
    FOREIGN KEY (`snowtype_id`)
    REFERENCES `snows`.`snowtypes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `snows`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- insertion of data
INSERT INTO `snows`.`comments` (`snowtype_id`, `user_id`, `date`, `text`, `emoji`, `nbstars`) VALUES ('6', '20', '2020-04-14', 'Génial, je recommande !', '3', '5'),
  ('6', '21', '2020-04-14', 'pas mal, je recommande !', '2', '3'),
   ('6', '25', '2020-04-14', 'pas top ce modèle...', '1', '1'),
    ('6', '18', '2019-12-20', 'Ce modèle K409 est vraiment sympa.', '3', '4'),
     ('6', '32', '2019-09-20', 'The board is new and original. It comes with the inserts for the channel bindings.', '5', '3') ,
	 ('6', '56', '2019-06-09', 'tiens super bien, 1,84m et 85kg j’ai pris du xl. parfait tiens super bien, ne procure pas de trace sur les chevilles!', '4', '4'),
	  ('6', '27', '2019-05-15', 'Ce modèle K409 est vraiment incroyable. Il me semble parfait pour un débutant mais aussi très polyvalent pour les pros. A consommer sans modération.', '4', '5'),
	  ('6', '19', '2018-08-15', 'Je ne sais pas quoi dire', '3', '3'),
	  ('6', '43', '2015-09-17', 'Rien à redire. première version ok.', '3', '5');
	  
