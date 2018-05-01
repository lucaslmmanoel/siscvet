-- MySQL Script generated by MySQL Workbench
-- Tue May  1 20:36:22 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`endereco` (
  `idEndereco` INT(11) NOT NULL AUTO_INCREMENT,
  `Cep` VARCHAR(45) NULL DEFAULT NULL,
  `logradouro` VARCHAR(45) NULL DEFAULT NULL,
  `bairro` VARCHAR(45) NULL DEFAULT NULL,
  `cidade` VARCHAR(45) NULL DEFAULT NULL,
  `complemento` VARCHAR(45) NULL DEFAULT NULL,
  `numero` VARCHAR(45) NULL,
  PRIMARY KEY (`idEndereco`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `idcliente` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeCliente` VARCHAR(45) NULL DEFAULT NULL,
  `telefone` VARCHAR(45) NULL DEFAULT NULL,
  `celular` VARCHAR(45) NULL DEFAULT NULL,
  `sexo` CHAR(2) NULL DEFAULT NULL,
  `nascimento` DATE NULL DEFAULT NULL,
  `email` VARCHAR(250) NULL DEFAULT NULL,
  `numdoc` VARCHAR(45) NULL,
  `tipodoc_idtipodoc` INT NOT NULL,
  `tipopessoa` CHAR(2) NULL,
  `idEndereco` INT(11) NOT NULL,
  PRIMARY KEY (`idcliente`),
  INDEX `fk_cliente_endereco1_idx` (`idEndereco` ASC),
  CONSTRAINT `fk_cliente_endereco1`
    FOREIGN KEY (`idEndereco`)
    REFERENCES `mydb`.`endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`especies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`especies` (
  `idespecies` INT(11) NOT NULL AUTO_INCREMENT,
  `descricaoespecie` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idespecies`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`racas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`racas` (
  `idracas` INT(11) NOT NULL AUTO_INCREMENT,
  `descricaoraca` VARCHAR(45) NULL DEFAULT NULL,
  `idespecies` INT(11) NOT NULL,
  PRIMARY KEY (`idracas`),
  INDEX `fk_racas_especies1_idx` (`idespecies` ASC),
  CONSTRAINT `fk_racas_especies1`
    FOREIGN KEY (`idespecies`)
    REFERENCES `mydb`.`especies` (`idespecies`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`animal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`animal` (
  `idAnimal` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cor` VARCHAR(15) NULL DEFAULT NULL,
  `datanascimento` DATE NULL DEFAULT NULL,
  `sexo` CHAR(1) NULL DEFAULT NULL,
  `peso` DOUBLE NULL DEFAULT NULL,
  `observacao` VARCHAR(200) NULL DEFAULT NULL,
  `Pelagem` VARCHAR(45) NULL DEFAULT NULL,
  `Animalcol` VARCHAR(45) NULL DEFAULT NULL,
  `idcliente` INT(11) NOT NULL,
  `racas_idracas` INT(11) NOT NULL,
  PRIMARY KEY (`idAnimal`),
  INDEX `fk_animal_cliente1_idx` (`idcliente` ASC),
  INDEX `fk_animal_racas1_idx` (`racas_idracas` ASC),
  CONSTRAINT `fk_animal_cliente1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `mydb`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_racas1`
    FOREIGN KEY (`racas_idracas`)
    REFERENCES `mydb`.`racas` (`idracas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`status` (
  `idstatus` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idstatus`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ficha_atendimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ficha_atendimento` (
  `idficha_de_atendimento` INT(11) NOT NULL AUTO_INCREMENT,
  `idAnimal` INT(11) NOT NULL,
  `descricao` VARCHAR(45) NULL DEFAULT NULL,
  `tipoatendimento` VARCHAR(45) NULL DEFAULT NULL,
  `valor` DOUBLE NULL DEFAULT NULL,
  `status_idstatus` INT NOT NULL,
  PRIMARY KEY (`idficha_de_atendimento`, `status_idstatus`),
  INDEX `fk_ficha_de_atendimento_Animal1_idx` (`idAnimal` ASC),
  INDEX `fk_ficha_atendimento_status1_idx` (`status_idstatus` ASC),
  CONSTRAINT `fk_ficha_de_atendimento_Animal1`
    FOREIGN KEY (`idAnimal`)
    REFERENCES `mydb`.`animal` (`idAnimal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ficha_atendimento_status1`
    FOREIGN KEY (`status_idstatus`)
    REFERENCES `mydb`.`status` (`idstatus`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`perfil` (
  `idperfil` INT(11) NOT NULL AUTO_INCREMENT,
  `descricaoperfil` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idperfil`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`funcionarios` (
  `idfuncionarios` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `cpf` VARCHAR(45) NULL DEFAULT NULL,
  `endereco` VARCHAR(45) NULL DEFAULT NULL,
  `telefone` VARCHAR(45) NULL DEFAULT NULL,
  `idEndereco` INT(11) NOT NULL,
  `idperfil` INT(11) NOT NULL,
  PRIMARY KEY (`idfuncionarios`),
  INDEX `fk_funcionarios_endereco1_idx` (`idEndereco` ASC),
  INDEX `fk_funcionarios_perfil1_idx` (`idperfil` ASC),
  CONSTRAINT `fk_funcionarios_endereco1`
    FOREIGN KEY (`idEndereco`)
    REFERENCES `mydb`.`endereco` (`idEndereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionarios_perfil1`
    FOREIGN KEY (`idperfil`)
    REFERENCES `mydb`.`perfil` (`idperfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`ficha_atendimento_funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ficha_atendimento_funcionarios` (
  `idficha_de_atendimento` INT(11) NOT NULL AUTO_INCREMENT,
  `idfuncionarios` INT(11) NOT NULL,
  PRIMARY KEY (`idficha_de_atendimento`, `idfuncionarios`),
  INDEX `fk_ficha_de_atendimento_has_funcionarios_funcionarios1_idx` (`idfuncionarios` ASC),
  INDEX `fk_ficha_de_atendimento_has_funcionarios_ficha_de_atendimen_idx` (`idficha_de_atendimento` ASC),
  CONSTRAINT `fk_ficha_de_atendimento_has_funcionarios_ficha_de_atendimento1`
    FOREIGN KEY (`idficha_de_atendimento`)
    REFERENCES `mydb`.`ficha_atendimento` (`idficha_de_atendimento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ficha_de_atendimento_has_funcionarios_funcionarios1`
    FOREIGN KEY (`idfuncionarios`)
    REFERENCES `mydb`.`funcionarios` (`idfuncionarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`historico` (
  `idhistorico` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NULL,
  `descricao` VARCHAR(250) NULL,
  `funcionarios_idfuncionarios` INT(11) NOT NULL,
  `idficha_de_atendimento` INT(11) NOT NULL,
  PRIMARY KEY (`idhistorico`),
  INDEX `fk_historico_funcionarios1_idx` (`funcionarios_idfuncionarios` ASC),
  INDEX `fk_historico_ficha_atendimento1_idx` (`idficha_de_atendimento` ASC),
  CONSTRAINT `fk_historico_funcionarios1`
    FOREIGN KEY (`funcionarios_idfuncionarios`)
    REFERENCES `mydb`.`funcionarios` (`idfuncionarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_ficha_atendimento1`
    FOREIGN KEY (`idficha_de_atendimento`)
    REFERENCES `mydb`.`ficha_atendimento` (`idficha_de_atendimento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;