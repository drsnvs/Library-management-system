CREATE TABLE `liabrarymanagenentsystem`.`data_table` (
  `id` INT(4) NOT NULL AUTO_INCREMENT,
  `role_id` INT(4) NOT NULL,
  `email_id` VARCHAR(255) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `mobile_no` INT(12) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `allocated_book` INT(3) NOT NULL,
  `active` INT(1) NOT NULL,
  `createdBy` INT(4) NOT NULL,
  `createdOn` DATE NOT NULL,
  `modifiedBy` INT(4),
  `modifiedOn` DATE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_id_UNIQUE` (`email_id` ASC) );

ALTER TABLE `liabrarymanagenentsystem`.`data_table` 
ADD COLUMN `enrollment_no` INT NOT NULL AFTER `allocated_book`;

ALTER TABLE `liabrarymanagenentsystem`.`data_table` 
ADD COLUMN `last_name` VARCHAR(45) NOT NULL AFTER `first_name`,
CHANGE COLUMN `name` `first_name` VARCHAR(45) NOT NULL ;

ALTER TABLE `liabrarymanagenentsystem`.`data_table` MODIFY COLUMN mobile_no VARCHAR(15);


CREATE TABLE `liabrarymanagenentsystem`.`book_table` (
  `book_id` INT(4) NOT NULL AUTO_INCREMENT,
  `book_title` VARCHAR(45) NOT NULL,
  `author_name` VARCHAR(45) NOT NULL,
  `price` DOUBLE NOT NULL,
  `quantity` INT(4) NOT NULL,
  `ISBN` VARCHAR(13) NOT NULL,
  `publisher` VARCHAR(45) NOT NULL,
  `edition_year` INT(4) NOT NULL,
  `active` INT(1) NOT NULL,
  `createdBy` INT(4) NOT NULL,
  `createdOn` DATE NOT NULL,
  `modifiedBy` INT(4),
  `modifiedOn` DATE ,
  PRIMARY KEY (`book_id`),
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC) );

-- ALTER TABLE `liabrarymanagenentsystem`.`book_table` 
-- CHANGE COLUMN `modifiedBy` `modifiedBy` INT(4) NULL ,
-- CHANGE COLUMN `modifiedOn` `modifiedOn` DATE NULL ;


CREATE TABLE `liabrarymanagenentsystem`.`book_rent_table` (
  `rent_id` INT(4) NOT NULL AUTO_INCREMENT,
  `book_id` INT(4) NOT NULL,
  `id` INT(4) NOT NULL,
  `date_out` DATE NOT NULL,
  `date_due` DATE NOT NULL,
  `active` INT(1) NOT NULL,
  `createdBy` INT(4) NOT NULL,
  `createdOn` DATE NOT NULL,
  `modifiedBy` INT(4) ,
  `modifiedOn` DATE ,
  PRIMARY KEY (`rent_id`));

ALTER TABLE `liabrarymanagenentsystem`.`book_rent_table` 
ADD COLUMN `allocated_book` INT NULL AFTER `return_date`;


CREATE TABLE `liabrarymanagenentsystem`.`book_fine_table` (
  `fine_id` INT(4) NOT NULL AUTO_INCREMENT,
  `rent_id` INT(4) NOT NULL,
  `id` INT(4) NOT NULL,
  `fine_amount` DOUBLE NOT NULL,
  `paid` TINYINT NOT NULL,
  `active` INT(1) NOT NULL,
  `createdBy` INT(4) NOT NULL,
  `createdOn` DATE NOT NULL,
  `modifiedBy` INT ,
  `modifiedOn` DATE ,
  PRIMARY KEY (`fine_id`));



CREATE TABLE `liabrarymanagenentsystem`.`record_table` (
  `record_id` INT(4) NOT NULL AUTO_INCREMENT,
  `book_id` INT(4) NOT NULL,
  `rent_id` INT(4) NOT NULL,
  `fine_id` INT(4) ,
  `id` INT(4) NOT NULL,
  PRIMARY KEY (`record_id`));
  ALTER TABLE `liabrarymanagenentsystem`.`record_table` 
ADD COLUMN `date_out` DATE NOT NULL AFTER `id`,
ADD COLUMN `date_due` DATE NOT NULL AFTER `date_out`,
ADD COLUMN `createdBy` INT NOT NULL AFTER `date_due`,
ADD COLUMN `createdOn` DATE NOT NULL AFTER `createdBy`,
ADD COLUMN `modifiedBy` INT NULL AFTER `createdOn`,
ADD COLUMN `modifiedOn` DATE NULL AFTER `modifiedBy`;

ALTER TABLE `liabrarymanagenentsystem`.`record_table` 
DROP COLUMN `rent_id`;
ALTER TABLE `liabrarymanagenentsystem`.`book_rent_table` 
ADD COLUMN `return_date` DATE NULL AFTER `date_due`;


INSERT INTO `liabrarymanagenentsystem`.`role_table` (`role_name`) VALUES ('admin');
INSERT INTO `liabrarymanagenentsystem`.`role_table` (`role_name`) VALUES ('user');

INSERT INTO `liabrarymanagenentsystem`.`data_table` (`role_id`, `email_id`, `password`, `mobile_no`, `first_name`,`last_name`, `address`, `allocated_book`, `active`, `createdBy`) VALUES ('1', '212308014.gvp@gujaratvidyapith.org', '12345678', '9824312924', 'Darshan','Sarvaiya', 'Nikol', '2', '1', '1');

CREATE TABLE `liabrarymanagenentsystem`.`language_table` (
  `language_id` INT NOT NULL,
  `language_name` VARCHAR(30) NOT NULL,
  `createdOn` DATE NULL,
  `createdBy` INT NULL,
  `updatedOn` DATE NULL,
  `updatedBy` INT NULL,
  PRIMARY KEY (`language_id`));

CREATE TABLE `liabrarymanagenentsystem`.`format_table` (
  `format_id` INT NOT NULL,
  `format_name` VARCHAR(30) NOT NULL,
  `createdOn` DATE NULL,
  `createdBy` INT NULL,
  `updatedOn` DATE NULL,
  `updatedBy` INT NULL,
  PRIMARY KEY (`format_id`));

ALTER TABLE `liabrarymanagenentsystem`.`book_table` 
CHANGE COLUMN `language` `language` INT(11) NOT NULL AFTER `edition_year`;

ALTER TABLE `liabrarymanagenentsystem`.`language_table` 
CHANGE COLUMN `language_id` `language_id` INT(11) NOT NULL AUTO_INCREMENT ;


ALTER TABLE `liabrarymanagenentsystem`.`book_table` 
ADD COLUMN `pages` INT NULL AFTER `language`;

ALTER TABLE `liabrarymanagenentsystem`.`book_table` 
ADD COLUMN `format` varchar(20) NULL AFTER `pages`;

ALTER TABLE `liabrarymanagenentsystem`.`format_table` 
CHANGE COLUMN `format_id` `format_id` INT(11) NOT NULL AUTO_INCREMENT ;
