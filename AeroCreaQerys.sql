-- MySQL Workbench Forward Engineering
-- DROP DATABASE aeropuerto;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema aeropuerto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema aeropuerto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aeropuerto` DEFAULT CHARACTER SET utf8 ;
USE `aeropuerto` ;

-- -----------------------------------------------------
-- Table `aeropuerto`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aeropuerto`.`Marca` (
  `idMarca` INT NOT NULL AUTO_INCREMENT,
  `Codigo` VARCHAR(45) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `pais_Origen` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMarca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aeropuerto`.`Avion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aeropuerto`.`Avion` (
  `idAvion` INT NOT NULL AUTO_INCREMENT,
  `Modelo` VARCHAR(45) NOT NULL,
  `Matricula` VARCHAR(45) NOT NULL,
  `inicio_Servicio` VARCHAR(45) NOT NULL,
  `Marca_idMarca` INT NOT NULL,
  PRIMARY KEY (`idAvion`, `Marca_idMarca`),
  INDEX `fk_Avion_Marca1_idx` (`Marca_idMarca` ASC) VISIBLE,
  CONSTRAINT `fk_Avion_Marca1`
    FOREIGN KEY (`Marca_idMarca`)
    REFERENCES `aeropuerto`.`Marca` (`idMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aeropuerto`.`Domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aeropuerto`.`Domicilio` (
  `idDomicilio` INT NOT NULL,
  `Calle` VARCHAR(45) NULL,
  `Numero` VARCHAR(45) NULL,
  `Provincia` VARCHAR(45) NULL,
  `Localidad` VARCHAR(45) NULL,
  PRIMARY KEY (`idDomicilio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aeropuerto`.`Piloto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aeropuerto`.`Piloto` (
  `idPiloto` INT NOT NULL AUTO_INCREMENT,
  `Apellido` VARCHAR(30) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `DNI` INT NOT NULL,
  `Cuil` INT NOT NULL,
  `fecha_Ingreso` DATETIME NOT NULL,
  `Domicilio_idDomicilio` INT NOT NULL,
  PRIMARY KEY (`idPiloto`),
  INDEX `fk_Piloto_Domicilio1_idx` (`Domicilio_idDomicilio` ASC) VISIBLE,
  CONSTRAINT `fk_Piloto_Domicilio1`
    FOREIGN KEY (`Domicilio_idDomicilio`)
    REFERENCES `aeropuerto`.`Domicilio` (`idDomicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aeropuerto`.`Aeropuerto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aeropuerto`.`Aeropuerto` (
  `idAeropuerto` INT NOT NULL AUTO_INCREMENT,
  `codigo_AITA` VARCHAR(10) NOT NULL,
  `nombre_Aeropuerto` VARCHAR(45) NOT NULL,
  `Ciudad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAeropuerto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aeropuerto`.`Vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aeropuerto`.`Vuelo` (
  `idVuelo` INT NOT NULL AUTO_INCREMENT,
  `codigo_Vuelo` VARCHAR(45) NOT NULL,
  `Piloto` VARCHAR(45) NOT NULL,
  `fecha_Hora_Partida` DATETIME NOT NULL,
  `fecha_Hora_Arribo` DATETIME NOT NULL,
  `distancia_Recorrida` INT NOT NULL,
  `Avion_idAvion` INT NOT NULL,
  `Piloto_idPiloto` INT NOT NULL,
  `Aeropuerto_Origen` INT NOT NULL,
  `Aeropuerto_Destino` INT NOT NULL,
  PRIMARY KEY (`idVuelo`, `Aeropuerto_Origen`, `Aeropuerto_Destino`),
  INDEX `fk_Vuelo_Avion_idx` (`Avion_idAvion` ASC) VISIBLE,
  INDEX `fk_Vuelo_Piloto1_idx` (`Piloto_idPiloto` ASC) VISIBLE,
  INDEX `fk_Vuelo_Aeropuerto1_idx` (`Aeropuerto_Origen` ASC) VISIBLE,
  INDEX `fk_Vuelo_Aeropuerto2_idx` (`Aeropuerto_Destino` ASC) VISIBLE,
  UNIQUE INDEX `codigo_Vuelo_UNIQUE` (`codigo_Vuelo` ASC) VISIBLE,
  CONSTRAINT `fk_Vuelo_Avion`
    FOREIGN KEY (`Avion_idAvion`)
    REFERENCES `aeropuerto`.`Avion` (`idAvion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vuelo_Piloto1`
    FOREIGN KEY (`Piloto_idPiloto`)
    REFERENCES `aeropuerto`.`Piloto` (`idPiloto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vuelo_Aeropuerto1`
    FOREIGN KEY (`Aeropuerto_Origen`)
    REFERENCES `aeropuerto`.`Aeropuerto` (`idAeropuerto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vuelo_Aeropuerto2`
    FOREIGN KEY (`Aeropuerto_Destino`)
    REFERENCES `aeropuerto`.`Aeropuerto` (`idAeropuerto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aeropuerto`.`Pasajero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aeropuerto`.`Pasajero` (
  `idPasajero` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `DNI` VARCHAR(45) NOT NULL,
  `Domicilio_idDomicilio` INT NOT NULL,
  `vFrecuente` TINYINT NOT NULL,
  PRIMARY KEY (`idPasajero`),
  INDEX `fk_Pasajero_Domicilio1_idx` (`Domicilio_idDomicilio` ASC) VISIBLE,
  CONSTRAINT `fk_Pasajero_Domicilio1`
    FOREIGN KEY (`Domicilio_idDomicilio`)
    REFERENCES `aeropuerto`.`Domicilio` (`idDomicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aeropuerto`.`Vuelo_has_Pasajero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aeropuerto`.`Vuelo_has_Pasajero` (
  `Vuelo_idVuelo` INT NOT NULL,
  `Vuelo_Aeropuerto_Origen` INT NOT NULL,
  `Vuelo_Aeropuerto_Destino` INT NOT NULL,
  `Pasajero_idPasajero` INT NOT NULL,
  PRIMARY KEY (`Vuelo_idVuelo`, `Vuelo_Aeropuerto_Origen`, `Vuelo_Aeropuerto_Destino`, `Pasajero_idPasajero`),
  INDEX `fk_Vuelo_has_Pasajero1_Pasajero1_idx` (`Pasajero_idPasajero` ASC) VISIBLE,
  INDEX `fk_Vuelo_has_Pasajero1_Vuelo1_idx` (`Vuelo_idVuelo` ASC, `Vuelo_Aeropuerto_Origen` ASC, `Vuelo_Aeropuerto_Destino` ASC) VISIBLE,
  CONSTRAINT `fk_Vuelo_has_Pasajero1_Vuelo1`
    FOREIGN KEY (`Vuelo_idVuelo` , `Vuelo_Aeropuerto_Origen` , `Vuelo_Aeropuerto_Destino`)
    REFERENCES `aeropuerto`.`Vuelo` (`idVuelo` , `Aeropuerto_Origen` , `Aeropuerto_Destino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vuelo_has_Pasajero1_Pasajero1`
    FOREIGN KEY (`Pasajero_idPasajero`)
    REFERENCES `aeropuerto`.`Pasajero` (`idPasajero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


ALTER TABLE piloto MODIFY Cuil VARCHAR(45);
ALTER TABLE piloto MODIFY fecha_Ingreso DATETIME;

ALTER TABLE vuelo MODIFY distancia_Recorrida INT;

ALTER TABLE avion MODIFY inicio_Servicio DATETIME;


INSERT INTO marca (Codigo, Nombre, pais_Origen)
VALUES (1, "Cessna", "Estados Unidos"),
(2, "Beechcraft", "Estados Unidos"),
(3, "Fokker", "Alemania"),
(4, "The Nashe", "Argentina");



INSERT INTO avion (idAvion, Modelo, Matricula, inicio_Servicio, Marca_idMarca)
VALUES (1, "Citation", "LV-ABC", '2010-12-01', 1),
(2, "Baron", "LV-CDE", '2011-10-01', 2),
(3, "F-27", "LV-FGH", '2008-04-01', 3),
(4, "Citation", "LV-IJK", '2015-06-21', 1),
(5, "King Air", "LV-LMN", '2012-02-01', 4);


INSERT INTO domicilio (idDomicilio, Calle, Numero, Localidad, Provincia)
VALUES (1, "Ituzaingo", "123", "Lanus", "Buenos Aires"),
(2, "Roca", "4561", "CABA", "CABA"), 
(3, "Campichielo", "6532", "Avellaneda", "Buenos Aires"),
(4, "Meeks", "562", "Lomas de Zamora", "Buenos Aires"), 
(5, "Mamberti", "2356", "Lanus", "Buenos Aires"), 
(6, "Amenabar", "2345", "CABA", "CABA"),
(7, "Capello", "1589", "Lomas de Zamora", "Buenos Aires"),
(8, "Amenabar", "356", "CABA", "CABA"),
(9, "Meeks", "1296", "Lomas de Zamora", "Buenos Aires"),
(10, "San Martin", "3652", "Avellaneda", "Buenos Aires");

INSERT INTO domicilio (idDomicilio, Calle, Numero, Localidad, Provincia)
VALUES (10000, "San Martin", "2235", "CABA", "CABA"),
(10001, "Azara", "1254", "Lomas de Zamora", "Buenos Aires"),
(10002, "Sarmiento", "500", "Lanus", "Buenos Aires"),
(10003, "Rivadavia", "2351", "CABA", "CABA"),
(10004, "Martinto", "663", "Lanus", "Buenos Aires"),
(10005, "Bolaños", "1256", "Lanus", "Buenos Aires"),
(10006, "Loria", "333", "Lomas de Zamora", "Buenos Aires");



INSERT INTO piloto(Nombre, Apellido, DNI, Cuil, fecha_Ingreso, Domicilio_idDomicilio)
VALUES ("Juarez", "Federico Bernardo", 12345678, 12345678, '1994-10-01', 10000),
("Lacoste", "Franco", 12345678, 12345678, '2003-07-01', 10001),
("Laime", "Mariana", 12345678, 12345678, '2001-04-01', 10002),
("Lopez", "Germán Ignacio", 12345678, 12345678, '2013-05-01', 10003),
("Martinez", "Giuliano", 12345678, 12345678, '2010-07.01', 10004),
("Medina", "Adriana", 12345678, 12345678, '2015-08-01', 10005),
("Melgarejo", "Jair Alberto", 12345678, 12345678, '2011-03-01', 10006);


INSERT INTO pasajero (idPasajero, Nombre, Apellido, DNI, Domicilio_idDomicilio, vFrecuente )
VALUES (1, "Barragan", "Alejo", "11111111", 1, true), 
(2, "Casas", "Andrés Alfredo", "22222222", 2, true),
(3, "Chaves", "Barbara", "33333333", 3, false),
(4, "Chimbo", "Brisa", "44444444", 4, true),
(5, "Chudoba", "Camila", "55555555", 5, false),
(6, "Cires", "Carlos", "66666666", 6, true),
(7, "Cusato", "Carlos Sebastián", "77777777", 7, false),
(8, "Dominguez", "Christian", "88888888", 8, true),
(9, "Escullini", "Cristian", "99999999", 9, true),
(10, "Feijoo", "Cristian", "10101010", 10, true);



INSERT INTO aeropuerto (idAeropuerto, codigo_AITA, nombre_Aeropuerto, Ciudad)
VALUES (1, "BUE", "Aeroparque Jorge NewBERY", "CABA"),
 (2, "MDQ", "Astor Piazolla", "Mar del Plata"),
 (3, "BRC", "Teniente Luis Candelaria", "San Carlos de Bariloche");


 INSERT INTO  vuelo (codigo_Vuelo, Piloto, aeropuerto_Origen, aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, distancia_Recorrida, Avion_idAvion, Piloto_idPiloto)
 VALUES ("TT1234", 1, 1, 3, '2018-05-01 20:00:00', '2018-5-01 23:45:00', 300, 1, 1);
  
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES (1, 1, 3, 4);
  INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES (1, 1, 3, 5);
  INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES (1, 1, 3, 6);
 
 
 
 INSERT INTO  vuelo (codigo_Vuelo, Piloto, aeropuerto_Origen, aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, distancia_Recorrida, Avion_idAvion, Piloto_idPiloto)
 VALUES ("TT3456", 2, 1, 2, '2018-06-02 20:00:00', '2018-06-02 23:45:00', 300, 2, 2);
 
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(2, 1, 2, 1);
  INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(2, 1, 2, 2);
  INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(2, 1, 2, 3);
 
 
 
 INSERT INTO vuelo (codigo_Vuelo, Piloto, aeropuerto_Origen, aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, distancia_Recorrida, Avion_idAvion, Piloto_idPiloto)
 VALUES ("TT1235", 3, 1, 3, '2018-05-01 20:00:00', '2018-5-01 23:45:00', 300, 1, 3);
 
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(3, 1, 3, 4);
  INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(3, 1, 3, 5);


  INSERT INTO vuelo (codigo_Vuelo, Piloto, aeropuerto_Origen, aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, distancia_Recorrida, Avion_idAvion, Piloto_idPiloto)
 VALUES("TT1256", 4, 3, 1, '2018-05-01 20:00:00', '2018-5-01 23:45:00', 300, 3, 4);
 
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(4, 3, 1, 1);
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(4, 3, 1, 2);
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(4, 3, 1, 3);
 
 
 INSERT INTO vuelo (codigo_Vuelo, Piloto, aeropuerto_Origen, aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, distancia_Recorrida, Avion_idAvion, Piloto_idPiloto)
 VALUES("TT5632", 5, 1, 2, '2018-05-01 20:00:00', '2018-5-01 23:45:00', 300, 4, 5);
 
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(5, 1, 2, 7);
  INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(5, 1, 2, 8);
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(5, 1, 2, 9);
 
 
 
 INSERT INTO vuelo (codigo_Vuelo, Piloto, aeropuerto_Origen, aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, distancia_Recorrida, Avion_idAvion, Piloto_idPiloto)
 VALUES("TT3333", 6, 1, 3, '2018-05-01 20:00:00', '2018-5-01 23:45:00', 300, 2, 6);

INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(6, 1, 3, 7);
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(6, 1, 3, 8);
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(6, 1, 3, 9);



 INSERT INTO vuelo (codigo_Vuelo, Piloto, aeropuerto_Origen, aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, distancia_Recorrida, Avion_idAvion, Piloto_idPiloto)
 VALUES("TT1257", 7, 3, 2, '2018-05-01 20:00:00', '2018-5-01 23:45:00', 300, 4, 7);
 
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(7, 3, 2, 2);
 
 
  INSERT INTO vuelo (codigo_Vuelo, Piloto, aeropuerto_Origen, aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, distancia_Recorrida, Avion_idAvion, Piloto_idPiloto)
 VALUES("TT3457", 2, 2, 1, '2018-05-01 20:00:00', '2018-5-01 23:45:00', 300, 3, 2);
 
  INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(8, 2, 1, 7);
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(8, 2, 1, 8);
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(8, 2, 1, 9);
 
 
 
 INSERT INTO vuelo (codigo_Vuelo, Piloto, aeropuerto_Origen, aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, distancia_Recorrida, Avion_idAvion, Piloto_idPiloto)
 VALUES("TT5633", 6, 1, 3, '2018-05-01 20:00:00', '2018-5-01 23:45:00', 300, 5, 6);
 
 INSERT INTO Vuelo_has_Pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(9, 1, 3, 7);
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(9, 1, 3, 8);
 INSERT INTO vuelo_has_pasajero (Vuelo_idVuelo, Vuelo_Aeropuerto_Origen, Vuelo_Aeropuerto_Destino, Pasajero_idPasajero)
 VALUES(9, 1, 3, 9);
 
 -- Cambio de fecha en avion

UPDATE avion set inicio_Servicio="2010-12-12" WHERE idAvion=1;
UPDATE avion set inicio_Servicio="2011-10-01" WHERE idAvion=2;
UPDATE avion set inicio_Servicio="2008-04-01" WHERE idAvion=3;
UPDATE avion set inicio_Servicio="2011-06-07" WHERE idAvion=4;
UPDATE avion set inicio_Servicio="2012-07-08" WHERE idAvion=5; 

  -- AGREGUE UN AVION
      
INSERT INTO marca (idMarca, Codigo, Nombre, pais_Origen)
VALUES (5, 5, "Flecha", "Argentina");
INSERT INTO avion (idAvion, Modelo, Matricula, inicio_Servicio, Marca_idMarca)
VALUES (6, "El palomo", "GGSZZ", '2018-01-13', 5);


 -- QERYS
 
SELECT Nombre, Apellido, DNI FROM pasajero;
  
SELECT Nombre, Apellido, DNI, Calle, Numero FROM pasajero P
INNER JOIN domicilio D
ON D.idDomicilio= Domicilio_idDomicilio;

SELECT Apellido, Nombre, DNI, Calle, Numero FROM pasajero P
INNER JOIN domicilio D
ON D.idDomicilio= Domicilio_idDomicilio
WHERE vFrecuente
ORDER BY Apellido, Nombre;

SELECT M.Nombre, A.Modelo, A.Matricula, A.inicio_Servicio, M.pais_Origen FROM avion A
INNER JOIN marca M
ON M.idMarca= Marca_idMarca;


SELECT Nombre, Modelo, Matricula, inicio_Servicio, pais_Origen FROM avion A
INNER JOIN marca M
ON M.idMarca= Marca_idMarca
WHERE pais_Origen= "Alemania";

-- (problema con el codigo AITA que solo aparece el numero) Solucion: Dos SUBQUERYS.
SELECT A.idAvion, M.Nombre, A.Modelo, A.Matricula,
 (select codigo_aita from Aeropuerto where idAeropuerto=Aeropuerto_Origen) as Origen ,
 (select codigo_aita from Aeropuerto where idAeropuerto=Aeropuerto_destino) as Destino,
 fecha_Hora_Partida, fecha_Hora_Arribo, P.Cuil FROM vuelo V
INNER JOIN avion A
ON A.idAvion= Avion_idAvion
INNER JOIN marca M
ON M.idMarca= Marca_idMarca
INNER JOIN piloto P
ON P.idPiloto = Piloto_idPiloto
INNER JOIN aeropuerto AE
ON AE.idAeropuerto = Aeropuerto_Origen;


-- 3 
SELECT A.idAvion, M.Nombre, A.Modelo, A.Matricula, aeropuerto_Origen, 
aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, P.Cuil FROM vuelo V
INNER JOIN avion A
ON A.idAvion= Avion_idAvion
INNER JOIN marca M
ON M.idMarca= Marca_idMarca
INNER JOIN piloto P
ON P.idPiloto = Piloto_idPiloto
INNER JOIN aeropuerto AE
ON AE.idAeropuerto = Aeropuerto_Origen
WHERE aeropuerto_Origen= 1
ORDER BY fecha_Hora_Partida;


-- 4
SELECT A.idAvion, M.Nombre, A.Modelo, A.Matricula, aeropuerto_Origen, 
aeropuerto_Destino, fecha_Hora_Partida, fecha_Hora_Arribo, P.Cuil FROM vuelo V
INNER JOIN avion A
ON A.idAvion= Avion_idAvion
INNER JOIN marca M
ON M.idMarca= Marca_idMarca
INNER JOIN piloto P
ON P.idPiloto = Piloto_idPiloto
INNER JOIN aeropuerto AE
ON AE.idAeropuerto = Aeropuerto_Origen
WHERE aeropuerto_Origen= 1
AND aeropuerto_Destino= 2;


-- 6
SELECT COUNT(idVuelo) FROM vuelo
WHERE aeropuerto_Origen=1
AND aeropuerto_Destino=3;

SELECT V.idVuelo, P.idPasajero, P.Apellido, P.Nombre, P.DNI FROM vuelo V
INNER JOIN vuelo_has_pasajero VHP
ON VHP.Vuelo_idVuelo = Aeropuerto_Origen
INNER JOIN pasajero P
ON P.idPasajero = Pasajero_idPasajero
WHERE aeropuerto_Origen=1
AND aeropuerto_Destino=3;

-- 7
SELECT codigo_AITA AS Aeropuerto, COUNT(idVuelo) AS Cantidad_Vuelo FROM vuelo
INNER JOIN aeropuerto A
ON A.idAeropuerto = Aeropuerto_Origen
WHERE aeropuerto_Origen=2;

SELECT V.idVuelo, P.idPasajero, P.Apellido, P.Nombre, P.DNI FROM vuelo V
INNER JOIN vuelo_has_pasajero VHP
ON VHP.Vuelo_idVuelo = Aeropuerto_Origen
INNER JOIN pasajero P
ON P.idPasajero = Pasajero_idPasajero
WHERE aeropuerto_Origen=2;

-- 8
SELECT AE.codigo_AITA AS Aeropuerto, COUNT(V.idVuelo) AS Cantidad_Vuelos FROM vuelo V
INNER JOIN aeropuerto AE
ON AE.idAeropuerto = Aeropuerto_Origen
group by codigo_AITA;


-- 9
SELECT COUNT(Pasajero_idPasajero) AS Pasajeros_Transportados, Localidad FROM vuelo V
INNER JOIN vuelo_has_pasajero VHS
ON VHS.Vuelo_idVuelo = idVuelo
INNER JOIN pasajero P
ON P.idPasajero = Pasajero_idPasajero
INNER JOIN domicilio D
ON D.idDomicilio = Domicilio_idDomicilio
GROUP BY Localidad;

-- 10
SELECT fecha_Hora_Partida, COUNT(Pasajero_idPasajero) AS Cantidad_Pasajeros FROM vuelo V
INNER JOIN vuelo_has_pasajero VHS
ON VHS.Vuelo_idVuelo = Aeropuerto_Origen
GROUP BY fecha_Hora_Partida;

-- 11
SELECT P.Apellido, P.Nombre, P.DNI, COUNT(Vuelo_idVuelo) FROM vuelo V
INNER JOIN vuelo_has_pasajero VHS
ON VHS.Vuelo_idVuelo = idVuelo
INNER JOIN pasajero P
ON P.idPasajero= Pasajero_idPasajero
GROUP BY Pasajero_idPasajero;

-- adds

SELECT Modelo, Matricula, COUNT(idVuelo) FROM vuelo V
INNER JOIN avion A
ON A.idAvion = Avion_idAvion
GROUP BY Avion_idAvion;


 SELECT * FROM domicilio;
 SELECT * FROM avion;
 SELECT * FROM marca;
 SELECT * FROM aeropuerto;
 SELECT * FROM piloto;
 SELECT * FROM pasajero;
 SELECT * FROM vuelo;
 SELECT * FROM vuelo_has_pasajero;