-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema wypozyczalnia_samochodow
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema wypozyczalnia_samochodow
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wypozyczalnia_samochodow` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `wypozyczalnia_samochodow` ;

-- -----------------------------------------------------
-- Table `wypozyczalnia_samochodow`.`pricelist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`pricelist` (
  `priceListID` INT NOT NULL AUTO_INCREMENT,
  `carType` VARCHAR(50) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`priceListID`),
  UNIQUE INDEX `priceListID_UNIQUE` (`priceListID` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `wypozyczalnia_samochodow`.`rentals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`rentals` (
  `rentalsID` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(50) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `creationDate` DATE NOT NULL,
  `closeDate` DATE NULL DEFAULT NULL,
  `opinion` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`rentalsID`),
  UNIQUE INDEX `rentalsID_UNIQUE` (`rentalsID` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `wypozyczalnia_samochodow`.`cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`cars` (
  `carsID` INT NOT NULL AUTO_INCREMENT,
  `rentalsID` INT NOT NULL,
  `priceListID` INT NOT NULL,
  `brand` VARCHAR(50) NOT NULL,
  `model` VARCHAR(50) NOT NULL,
  `fuel` VARCHAR(50) NOT NULL,
  `gearbox` VARCHAR(50) NOT NULL,
  `airCondition` VARCHAR(50) NOT NULL,
  `isActive` VARCHAR(3) NOT NULL DEFAULT 'yes',
  `toRepair` VARCHAR(3) NOT NULL DEFAULT 'no',
  PRIMARY KEY (`carsID`),
  UNIQUE INDEX `carsID_UNIQUE` (`carsID` ASC) VISIBLE,
  INDEX `rentalsID_idx` (`priceListID` ASC) VISIBLE,
  INDEX `rentalsID_idx1` (`rentalsID` ASC) VISIBLE,
  CONSTRAINT `priceListID`
    FOREIGN KEY (`priceListID`)
    REFERENCES `wypozyczalnia_samochodow`.`pricelist` (`priceListID`),
  CONSTRAINT `rentalsID`
    FOREIGN KEY (`rentalsID`)
    REFERENCES `wypozyczalnia_samochodow`.`rentals` (`rentalsID`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `wypozyczalnia_samochodow`.`discounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`discounts` (
  `discountsID` INT NOT NULL AUTO_INCREMENT,
  `discount` INT NOT NULL,
  PRIMARY KEY (`discountsID`),
  UNIQUE INDEX `discountsID_UNIQUE` (`discountsID` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `wypozyczalnia_samochodow`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`customers` (
  `customersID` INT NOT NULL AUTO_INCREMENT,
  `discountsID` INT NOT NULL,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `dateOfBirth` DATE NOT NULL,
  `phoneNumber` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`customersID`),
  UNIQUE INDEX `customersID_UNIQUE` (`customersID` ASC) VISIBLE,
  INDEX `discountsID_idx` (`discountsID` ASC) VISIBLE,
  CONSTRAINT `discountsID`
    FOREIGN KEY (`discountsID`)
    REFERENCES `wypozyczalnia_samochodow`.`discounts` (`discountsID`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `wypozyczalnia_samochodow`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`employees` (
  `employeesID` INT NOT NULL AUTO_INCREMENT,
  `rentalsID` INT NOT NULL,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  `position` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(12) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`employeesID`),
  UNIQUE INDEX `employeesID_UNIQUE` (`employeesID` ASC) VISIBLE,
  INDEX `rentalisID_idx` (`rentalsID` ASC) VISIBLE,
  CONSTRAINT `rentalisID`
    FOREIGN KEY (`rentalsID`)
    REFERENCES `wypozyczalnia_samochodow`.`rentals` (`rentalsID`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `wypozyczalnia_samochodow`.`finance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`finance` (
  `financeID` INT NOT NULL AUTO_INCREMENT,
  `dateOperation` DATE NOT NULL,
  `sum` INT NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`financeID`),
  UNIQUE INDEX `financeID_UNIQUE` (`financeID` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 36
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `wypozyczalnia_samochodow`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`orders` (
  `ordersID` INT NOT NULL AUTO_INCREMENT,
  `customersID` INT NOT NULL,
  `carsID` INT NOT NULL,
  `employeesID` INT NULL DEFAULT NULL,
  `startDate` DATE NOT NULL,
  `expectedEndDate` DATE NOT NULL,
  `endDate` DATE NULL DEFAULT NULL,
  `standardFee` INT NULL DEFAULT NULL,
  `discountedFee` INT NULL DEFAULT NULL,
  `status` VARCHAR(50) NOT NULL DEFAULT 'pending',
  `opinion` VARCHAR(50) NULL DEFAULT NULL,
  `wasPaid` VARCHAR(10) NOT NULL DEFAULT 'no',
  PRIMARY KEY (`ordersID`),
  UNIQUE INDEX `ordersID_UNIQUE` (`ordersID` ASC) VISIBLE,
  INDEX `customersID_idx` (`customersID` ASC) VISIBLE,
  INDEX `carsID_idx` (`carsID` ASC) VISIBLE,
  INDEX `employeesID_idx` (`employeesID` ASC) VISIBLE,
  CONSTRAINT `carsID`
    FOREIGN KEY (`carsID`)
    REFERENCES `wypozyczalnia_samochodow`.`cars` (`carsID`),
  CONSTRAINT `customersID`
    FOREIGN KEY (`customersID`)
    REFERENCES `wypozyczalnia_samochodow`.`customers` (`customersID`),
  CONSTRAINT `employeesID`
    FOREIGN KEY (`employeesID`)
    REFERENCES `wypozyczalnia_samochodow`.`employees` (`employeesID`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `wypozyczalnia_samochodow`.`repairs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`repairs` (
  `repairID` INT NOT NULL AUTO_INCREMENT,
  `carsID` INT NOT NULL,
  `repairType` VARCHAR(50) NOT NULL,
  `cost` INT NOT NULL,
  `finished` VARCHAR(3) NULL DEFAULT 'no',
  PRIMARY KEY (`repairID`),
  UNIQUE INDEX `carsID_UNIQUE` (`carsID` ASC) VISIBLE,
  UNIQUE INDEX `repairID_UNIQUE` (`repairID` ASC) VISIBLE,
  CONSTRAINT `carID`
    FOREIGN KEY (`carsID`)
    REFERENCES `wypozyczalnia_samochodow`.`cars` (`carsID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
KEY_BLOCK_SIZE = 1;

USE `wypozyczalnia_samochodow` ;

-- -----------------------------------------------------
-- Placeholder table for view `wypozyczalnia_samochodow`.`activecars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`activecars` (`carsID` INT, `rentalsID` INT, `priceListID` INT, `brand` INT, `model` INT, `fuel` INT, `gearbox` INT, `airCondition` INT, `isActive` INT, `toRepair` INT);

-- -----------------------------------------------------
-- Placeholder table for view `wypozyczalnia_samochodow`.`availablecars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`availablecars` (`brand` INT, `model` INT, `fuel` INT, `gearbox` INT, `airCondition` INT, `price per hour` INT);

-- -----------------------------------------------------
-- Placeholder table for view `wypozyczalnia_samochodow`.`carstorepair`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`carstorepair` (`employeesID` INT, `rentalsID` INT, `brand` INT, `model` INT, `fuel` INT, `gearbox` INT, `airCondition` INT);

-- -----------------------------------------------------
-- Placeholder table for view `wypozyczalnia_samochodow`.`financesummary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wypozyczalnia_samochodow`.`financesummary` (`dateOperation` INT, `Bilans` INT);

-- -----------------------------------------------------
-- function countOrderCostV2
-- -----------------------------------------------------

DELIMITER $$
USE `wypozyczalnia_samochodow`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `countOrderCostV2`(orderID INT) RETURNS int
BEGIN  

DECLARE startdate1 DATE; 
DECLARE enddate1 DATE;  
DECLARE betweendate INT;
DECLARE discount INT;
DECLARE baseCost INT;
DECLARE discountedCost INT;

	SET @startdate1 = (SELECT startDate FROM orders WHERE ordersID = orderID);
	SET @enddate1 = (SELECT expectedEndDate FROM orders WHERE ordersID = orderID);
    SET @betweendate = DATEDIFF(@enddate1, @startdate1) + 1;
	SET @baseCost = @betweendate * (SELECT price FROM pricelist JOIN cars ON pricelist.priceListID = cars.priceListID 
																JOIN orders ON cars.carsID = orders.carsID
																WHERE ordersID = orderID);
	SET @discount = @betweendate * (SELECT discount FROM discounts JOIN customers ON discounts.discountsID = customers.discountsID 
																   JOIN orders ON customers.customersID = orders.customersID       
																   WHERE orders.ordersID = orderID); 
	SET @discountedCost = @baseCost - @discount;
    UPDATE orders SET standardFee = @baseCost, discountedFee = @discountedCost WHERE ordersID = orderID;
	RETURN @discountedCost;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `wypozyczalnia_samochodow`.`activecars`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wypozyczalnia_samochodow`.`activecars`;
USE `wypozyczalnia_samochodow`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wypozyczalnia_samochodow`.`activecars` AS select `wypozyczalnia_samochodow`.`cars`.`carsID` AS `carsID`,`wypozyczalnia_samochodow`.`cars`.`rentalsID` AS `rentalsID`,`wypozyczalnia_samochodow`.`cars`.`priceListID` AS `priceListID`,`wypozyczalnia_samochodow`.`cars`.`brand` AS `brand`,`wypozyczalnia_samochodow`.`cars`.`model` AS `model`,`wypozyczalnia_samochodow`.`cars`.`fuel` AS `fuel`,`wypozyczalnia_samochodow`.`cars`.`gearbox` AS `gearbox`,`wypozyczalnia_samochodow`.`cars`.`airCondition` AS `airCondition`,`wypozyczalnia_samochodow`.`cars`.`isActive` AS `isActive`,`wypozyczalnia_samochodow`.`cars`.`toRepair` AS `toRepair` from `wypozyczalnia_samochodow`.`cars` where (`wypozyczalnia_samochodow`.`cars`.`isActive` = 'yes');

-- -----------------------------------------------------
-- View `wypozyczalnia_samochodow`.`availablecars`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wypozyczalnia_samochodow`.`availablecars`;
USE `wypozyczalnia_samochodow`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wypozyczalnia_samochodow`.`availablecars` AS select `wypozyczalnia_samochodow`.`cars`.`brand` AS `brand`,`wypozyczalnia_samochodow`.`cars`.`model` AS `model`,`wypozyczalnia_samochodow`.`cars`.`fuel` AS `fuel`,`wypozyczalnia_samochodow`.`cars`.`gearbox` AS `gearbox`,`wypozyczalnia_samochodow`.`cars`.`airCondition` AS `airCondition`,`wypozyczalnia_samochodow`.`pricelist`.`price` AS `price per hour` from (`wypozyczalnia_samochodow`.`cars` join `wypozyczalnia_samochodow`.`pricelist` on((`wypozyczalnia_samochodow`.`cars`.`priceListID` = `wypozyczalnia_samochodow`.`pricelist`.`priceListID`))) where (`wypozyczalnia_samochodow`.`cars`.`isActive` = 'yes');

-- -----------------------------------------------------
-- View `wypozyczalnia_samochodow`.`carstorepair`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wypozyczalnia_samochodow`.`carstorepair`;
USE `wypozyczalnia_samochodow`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wypozyczalnia_samochodow`.`carstorepair` AS select `wypozyczalnia_samochodow`.`employees`.`employeesID` AS `employeesID`,`wypozyczalnia_samochodow`.`employees`.`rentalsID` AS `rentalsID`,`wypozyczalnia_samochodow`.`cars`.`brand` AS `brand`,`wypozyczalnia_samochodow`.`cars`.`model` AS `model`,`wypozyczalnia_samochodow`.`cars`.`fuel` AS `fuel`,`wypozyczalnia_samochodow`.`cars`.`gearbox` AS `gearbox`,`wypozyczalnia_samochodow`.`cars`.`airCondition` AS `airCondition` from (`wypozyczalnia_samochodow`.`cars` join `wypozyczalnia_samochodow`.`employees`) where ((`wypozyczalnia_samochodow`.`cars`.`toRepair` = 'yes') and (`wypozyczalnia_samochodow`.`cars`.`isActive` = 'yes') and (`wypozyczalnia_samochodow`.`cars`.`rentalsID` = `wypozyczalnia_samochodow`.`employees`.`rentalsID`));

-- -----------------------------------------------------
-- View `wypozyczalnia_samochodow`.`financesummary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wypozyczalnia_samochodow`.`financesummary`;
USE `wypozyczalnia_samochodow`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wypozyczalnia_samochodow`.`financesummary` AS select `wypozyczalnia_samochodow`.`finance`.`dateOperation` AS `dateOperation`,sum(`wypozyczalnia_samochodow`.`finance`.`sum`) AS `Bilans` from `wypozyczalnia_samochodow`.`finance`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
