CREATE DATABASE  IF NOT EXISTS `selfbook` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `selfbook`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: selfbook
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aluno` (
  `id_aluno` int NOT NULL AUTO_INCREMENT,
  `nome_aluno` varchar(100) NOT NULL,
  `documento_aluno` varchar(20) NOT NULL,
  `data_inscricao` date DEFAULT (curdate()),
  PRIMARY KEY (`id_aluno`),
  UNIQUE KEY `uq_aluno_documento` (`documento_aluno`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aula`
--

DROP TABLE IF EXISTS `aula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aula` (
  `id_aula` int NOT NULL AUTO_INCREMENT,
  `id_aluno` int NOT NULL,
  `id_instrutor` int NOT NULL,
  `data_hora_inicio` datetime NOT NULL,
  PRIMARY KEY (`id_aula`),
  UNIQUE KEY `uq_aula_instrutor_hora` (`id_instrutor`,`data_hora_inicio`),
  UNIQUE KEY `uq_aula_aluno_hora` (`id_aluno`,`data_hora_inicio`),
  CONSTRAINT `aula_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id_aluno`),
  CONSTRAINT `aula_ibfk_2` FOREIGN KEY (`id_instrutor`) REFERENCES `instrutor` (`id_instrutor`),
  CONSTRAINT `ck_aula_hora_certa` CHECK (((minute(`data_hora_inicio`) = 0) and (second(`data_hora_inicio`) = 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carro`
--

DROP TABLE IF EXISTS `carro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carro` (
  `id_carro` int NOT NULL AUTO_INCREMENT,
  `matricula` varchar(10) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `disponivel` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_carro`),
  UNIQUE KEY `matricula` (`matricula`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `escala`
--

DROP TABLE IF EXISTS `escala`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `escala` (
  `id_escala` int NOT NULL AUTO_INCREMENT,
  `data_escala` date NOT NULL,
  `id_instrutor` int NOT NULL,
  `id_turno` int NOT NULL,
  PRIMARY KEY (`id_escala`),
  UNIQUE KEY `uq_escala_instrutor_dia` (`id_instrutor`,`data_escala`),
  KEY `id_turno` (`id_turno`),
  CONSTRAINT `escala_ibfk_1` FOREIGN KEY (`id_instrutor`) REFERENCES `instrutor` (`id_instrutor`),
  CONSTRAINT `escala_ibfk_2` FOREIGN KEY (`id_turno`) REFERENCES `turno` (`id_turno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instrutor`
--

DROP TABLE IF EXISTS `instrutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instrutor` (
  `id_instrutor` int NOT NULL AUTO_INCREMENT,
  `nome_instrutor` varchar(100) NOT NULL,
  `documento_instrutor` varchar(20) NOT NULL,
  `data_admissao` date DEFAULT (curdate()),
  `id_carro` int DEFAULT NULL,
  `id_unidade` int NOT NULL,
  `estado` enum('T','F','BM') NOT NULL,
  PRIMARY KEY (`id_instrutor`),
  UNIQUE KEY `uq_instrutor_documento` (`documento_instrutor`),
  UNIQUE KEY `uq_instrutor_carro` (`id_carro`),
  KEY `fk_instrutor_unidade` (`id_unidade`),
  CONSTRAINT `fk_instrutor_unidade` FOREIGN KEY (`id_unidade`) REFERENCES `unidade_ensino` (`id_unidade`),
  CONSTRAINT `instrutor_ibfk_2` FOREIGN KEY (`id_carro`) REFERENCES `carro` (`id_carro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `turno`
--

DROP TABLE IF EXISTS `turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turno` (
  `id_turno` int NOT NULL AUTO_INCREMENT,
  `descricao_turno` varchar(20) NOT NULL,
  `hora_inicio_turno` time NOT NULL,
  `hora_fim_turno` time NOT NULL,
  `hora_pausa` time NOT NULL,
  PRIMARY KEY (`id_turno`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unidade_ensino`
--

DROP TABLE IF EXISTS `unidade_ensino`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidade_ensino` (
  `id_unidade` int NOT NULL AUTO_INCREMENT,
  `nome_unidade` varchar(100) NOT NULL,
  `email_unidade` varchar(150) NOT NULL,
  `telefone_unidade` varchar(20) NOT NULL,
  PRIMARY KEY (`id_unidade`),
  UNIQUE KEY `email_unidade` (`email_unidade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `utilizador`
--

DROP TABLE IF EXISTS `utilizador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilizador` (
  `id_utilizador` int NOT NULL AUTO_INCREMENT,
  `email_utilizador` varchar(150) NOT NULL,
  `senha_hash` varchar(255) NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_aluno` int NOT NULL,
  PRIMARY KEY (`id_utilizador`),
  UNIQUE KEY `email_utilizador` (`email_utilizador`),
  UNIQUE KEY `uq_utilizador_tipo` (`id_utilizador`),
  KEY `fk_aluno_utilizador` (`id_aluno`),
  CONSTRAINT `fk_aluno_utilizador` FOREIGN KEY (`id_aluno`) REFERENCES `aluno` (`id_aluno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-12 21:19:38
