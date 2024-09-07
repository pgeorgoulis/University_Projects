CREATE DATABASE  IF NOT EXISTS `insurance` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `insurance`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: insurance
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `CATCODE` int NOT NULL,
  `CATNAME` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CATCODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (10,'Life Insurance'),(20,'Vehicle Insurance'),(30,'Health Insurance'),(40,'Property Insurance');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contract` (
  `CONCODE` int NOT NULL AUTO_INCREMENT,
  `CUSTCODE` int NOT NULL,
  `PRODCODE` int NOT NULL,
  `STARTDATE` date DEFAULT NULL,
  `ENDDATE` date DEFAULT NULL,
  `COST` int DEFAULT NULL,
  PRIMARY KEY (`CONCODE`),
  KEY `CUSTCODE` (`CUSTCODE`),
  KEY `PRODCODE` (`PRODCODE`),
  CONSTRAINT `contract_ibfk_1` FOREIGN KEY (`CUSTCODE`) REFERENCES `customer` (`CUSTCODE`),
  CONSTRAINT `contract_ibfk_2` FOREIGN KEY (`PRODCODE`) REFERENCES `product` (`PRODCODE`)
) ENGINE=InnoDB AUTO_INCREMENT=10017 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES (10001,1001,101,'2018-02-23','2048-02-23',9000),(10002,1002,202,'2019-05-01','2021-05-01',600),(10003,1001,201,'2019-09-05','2029-09-05',1800),(10004,1003,402,'2020-02-01','2022-02-01',2000),(10005,1003,401,'2020-03-08','2022-03-08',400),(10006,1004,103,'2020-03-14','2040-03-14',10000),(10007,1005,303,'2020-05-03','2025-05-03',1250),(10008,1006,301,'2020-05-16','2021-05-16',800),(10009,1004,301,'2020-08-12','2023-08-12',2400),(10010,1007,202,'2020-08-23','2021-02-23',150),(10011,1005,302,'2020-09-18','2025-09-18',7500),(10012,1006,201,'2020-09-23','2022-09-23',1200),(10013,1005,201,'2021-09-25','2022-09-25',600),(10014,1007,102,'2021-12-22','2031-12-22',10000);
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `contract_insert` AFTER INSERT ON `contract` FOR EACH ROW begin
update customer
set cost_of_contracts = (select sum(cost) from contract where contract.custcode = customer.custcode)
where custcode = new.custcode;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `contract_update` AFTER UPDATE ON `contract` FOR EACH ROW begin
update customer
set cost_of_contracts = (select sum(cost) from contract where contract.custcode = customer.custcode)
where custcode = new.custcode;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `contract_delete` AFTER DELETE ON `contract` FOR EACH ROW begin
update customer
set cost_of_contracts = (select sum(cost) from contract where contract.custcode = customer.custcode)
where old.custcode = custcode;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CUSTCODE` int NOT NULL AUTO_INCREMENT,
  `AFM` int DEFAULT NULL,
  `CNAME` varchar(20) DEFAULT NULL,
  `CSURNAME` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(30) DEFAULT NULL,
  `CITY` varchar(10) DEFAULT NULL,
  `TK` int DEFAULT NULL,
  `PHONE` varchar(15) DEFAULT NULL,
  `DOY` varchar(20) DEFAULT NULL,
  `cost_of_contracts` int DEFAULT NULL,
  PRIMARY KEY (`CUSTCODE`),
  UNIQUE KEY `AFM` (`AFM`)
) ENGINE=InnoDB AUTO_INCREMENT=1008 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1001,100028428,'Chiquita','Cline','Nestoros 13','MAROUSI',14121,'6945550000','AMAROUSIOU',10800),(1002,100785388,'Victoria','Hobbs','Chrisostomou Smirnis 95','AIGALEO',11855,'6047367951','AIGALEO',600),(1003,100087609,'Armando','Johnson','Lamprou Katsoni 34','ALIMOS',13671,'6738630856','GLYFADAS',2400),(1004,101654032,'Dolores','Askew','Salaminos 44','ILIOUPOLI',17236,'6689665868','ILIOUPOLIS',12400),(1005,100574954,'Rebekah','Broussard','Kapodistriou 20','VOULA',16673,'6213508686','GLYFADAS',9350),(1006,110058098,'Imogene','Slack','Chomateri 13','NIKAIA',18122,'6457764664','NIKAIAS',2000),(1007,101750611,'Henry','Smith','Kritika 31','GALATSI',14232,'6002598899','IG’ ATHINON',10150);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `prodcost`
--

DROP TABLE IF EXISTS `prodcost`;
/*!50001 DROP VIEW IF EXISTS `prodcost`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `prodcost` AS SELECT 
 1 AS `Product_code`,
 1 AS `Product_name`,
 1 AS `Annual_cost`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `PRODCODE` int NOT NULL,
  `PNAME` varchar(20) DEFAULT NULL,
  `ANNCOST` int DEFAULT NULL,
  `MINTIME` varchar(15) DEFAULT NULL,
  `BENEFITS` varchar(15) DEFAULT NULL,
  `CATCODE` int NOT NULL,
  PRIMARY KEY (`PRODCODE`),
  KEY `CATCODE` (`CATCODE`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`CATCODE`) REFERENCES `category` (`CATCODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (101,'Term Plan',300,'30 years','15000 lump sum',10),(102,'Whole Life',1000,'10 years','50000 lump sum',10),(103,'Retirement Plan',500,'20 years','1200/year',10),(201,'Comprehensive',600,'3 months','cover expenses',20),(202,'Third-Party',300,'3 months','cover expenses',20),(301,'Individual',800,'1 year','150/month',30),(302,'Family',1500,'1 year','cover expenses',30),(303,'Critical Illness',250,'1 year','cover expenses',30),(401,'Natural Causes',200,'1 year','cover expenses',40),(402,'Burglaries',1000,'1 year','cover expenses',40);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vehcontract`
--

DROP TABLE IF EXISTS `vehcontract`;
/*!50001 DROP VIEW IF EXISTS `vehcontract`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vehcontract` AS SELECT 
 1 AS `CONCODE`,
 1 AS `CUSTCODE`,
 1 AS `AFM`,
 1 AS `PRODCODE`,
 1 AS `CATCODE`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'insurance'
--

--
-- Dumping routines for database 'insurance'
--
/*!50003 DROP FUNCTION IF EXISTS `timediffs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `timediffs`(STARTDATE date,  ENDDATE date) RETURNS smallint
begin
return timestampdiff(MONTH,STARTDATE,ENDDATE);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `monthly_cost_proc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `monthly_cost_proc`(IN s_afm INT, IN s_date DATE, 
OUT num_of_contracts INT, OUT monthly_cost DECIMAL(7,2))
begin
SELECT COUNT(contract.custcode), SUM(anncost/12)
INTO num_of_contracts, monthly_cost
FROM contract
INNER JOIN customer ON contract.custcode = customer.custcode
INNER JOIN product ON contract.prodcode = product.prodcode
WHERE s_afm IN(AFM)
AND s_date BETWEEN startdate AND enddate
GROUP BY contract.custcode;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `prodcost`
--

/*!50001 DROP VIEW IF EXISTS `prodcost`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `prodcost` (`Product_code`,`Product_name`,`Annual_cost`) AS select `product`.`PRODCODE` AS `PRODCODE`,`product`.`PNAME` AS `PNAME`,`product`.`ANNCOST` AS `ANNCOST` from `product` where (`product`.`ANNCOST` < 1000) */
/*!50002 WITH CASCADED CHECK OPTION */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vehcontract`
--

/*!50001 DROP VIEW IF EXISTS `vehcontract`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vehcontract` AS select distinct `contract`.`CONCODE` AS `CONCODE`,`contract`.`CUSTCODE` AS `CUSTCODE`,`customer`.`AFM` AS `AFM`,`product`.`PRODCODE` AS `PRODCODE`,`product`.`CATCODE` AS `CATCODE` from ((`contract` join `product`) join `customer`) where ((`contract`.`PRODCODE` = `product`.`PRODCODE`) and (`contract`.`CUSTCODE` = `customer`.`CUSTCODE`) and (`product`.`CATCODE` = 20)) order by `contract`.`CONCODE` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-20 20:25:33
