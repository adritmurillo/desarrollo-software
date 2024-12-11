-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema colegio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema colegio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `colegio` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `colegio` ;

-- -----------------------------------------------------
-- Table `colegio`.`asignaturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`asignaturas` (
  `id_asignatura` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_asignatura`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `colegio`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`roles` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `colegio`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `dni` VARCHAR(20) NOT NULL,
  `nombres` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `direccion` TEXT NULL DEFAULT NULL,
  `id_rol` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `dni` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `id_rol` (`id_rol` ASC) VISIBLE,
  CONSTRAINT `usuarios_ibfk_1`
    FOREIGN KEY (`id_rol`)
    REFERENCES `colegio`.`roles` (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `colegio`.`asistencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`asistencia` (
  `id_asistencia` INT NOT NULL AUTO_INCREMENT,
  `id_asignatura` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `presente` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_asistencia`),
  INDEX `id_asignatura` (`id_asignatura` ASC) VISIBLE,
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `asistencia_ibfk_1`
    FOREIGN KEY (`id_asignatura`)
    REFERENCES `colegio`.`asignaturas` (`id_asignatura`),
  CONSTRAINT `asistencia_ibfk_2`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `colegio`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `colegio`.`calendario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`calendario` (
  `id_evento` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `fecha_evento` DATE NOT NULL,
  `id_usuario` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_evento`),
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `calendario_ibfk_1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `colegio`.`usuarios` (`id_usuario`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `colegio`.`tareas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`tareas` (
  `id_tarea` INT NOT NULL AUTO_INCREMENT,
  `id_asignatura` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `descripcion` TEXT NULL DEFAULT NULL,
  `fecha_limite` DATE NOT NULL,
  PRIMARY KEY (`id_tarea`),
  INDEX `id_asignatura` (`id_asignatura` ASC) VISIBLE,
  CONSTRAINT `tareas_ibfk_1`
    FOREIGN KEY (`id_asignatura`)
    REFERENCES `colegio`.`asignaturas` (`id_asignatura`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `colegio`.`entregas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`entregas` (
  `id_entrega` INT NOT NULL AUTO_INCREMENT,
  `id_tarea` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha_entrega` DATE NOT NULL,
  `archivo_ruta` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id_entrega`),
  INDEX `id_tarea` (`id_tarea` ASC) VISIBLE,
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `entregas_ibfk_1`
    FOREIGN KEY (`id_tarea`)
    REFERENCES `colegio`.`tareas` (`id_tarea`),
  CONSTRAINT `entregas_ibfk_2`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `colegio`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `colegio`.`estudiantes_asignaturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`estudiantes_asignaturas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `id_asignatura` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  INDEX `id_asignatura` (`id_asignatura` ASC) VISIBLE,
  CONSTRAINT `estudiantes_asignaturas_ibfk_1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `colegio`.`usuarios` (`id_usuario`),
  CONSTRAINT `estudiantes_asignaturas_ibfk_2`
    FOREIGN KEY (`id_asignatura`)
    REFERENCES `colegio`.`asignaturas` (`id_asignatura`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `colegio`.`notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`notas` (
  `id_nota` INT NOT NULL AUTO_INCREMENT,
  `id_asignatura` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `nota` DECIMAL(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_nota`),
  INDEX `id_asignatura` (`id_asignatura` ASC) VISIBLE,
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `notas_ibfk_1`
    FOREIGN KEY (`id_asignatura`)
    REFERENCES `colegio`.`asignaturas` (`id_asignatura`),
  CONSTRAINT `notas_ibfk_2`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `colegio`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `colegio`.`notificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`notificaciones` (
  `id_notificacion` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `mensaje` TEXT NULL DEFAULT NULL,
  `fecha_envio` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_notificacion`),
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `notificaciones_ibfk_1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `colegio`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `colegio`.`reportes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `colegio`.`reportes` (
  `id_reporte` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `fecha_generacion` DATE NOT NULL,
  `contenido` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_reporte`),
  INDEX `id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `reportes_ibfk_1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `colegio`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
