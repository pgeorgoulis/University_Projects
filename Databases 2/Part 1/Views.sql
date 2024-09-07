#View with all the contracts of vehicle insurance and their customers
#Non-updatable
CREATE VIEW vehcontract AS
SELECT DISTINCT CONCODE, contract.CUSTCODE, AFM, product.PRODCODE, CATCODE
FROM contract, product, customer
WHERE contract.PRODCODE=product.PRODCODE
AND contract.CUSTCODE=customer.CUSTCODE
AND CATCODE=20
ORDER BY CONCODE;
/*
mysql> update vehcontract set concode=0 where concode=10002;
ERROR 1288 (HY000): The target table vehcontract of the UPDATE is not updatable
*/
#
#
#View with all the annual prices of the available products below 1000€
#Updatable
CREATE VIEW prodcost(Product_code, Product_name, Annual_cost) AS
SELECT PRODCODE, PNAME, ANNCOST
FROM product
WHERE ANNCOST<1000 WITH CHECK OPTION;
/*
mysql> select * from prodcost;
+--------------+------------------+-------------+
| Product_code | Product_name     | Annual_cost |
+--------------+------------------+-------------+
|          101 | Term Plan        |         300 |
|          103 | Retirement Plan  |         500 |
|          201 | Comprehensive    |         600 |
|          202 | Third-Party      |         300 |
|          301 | Individual       |         800 |
|          303 | Critical Illness |         250 |
|          401 | Natural Causes   |         200 |
+--------------+------------------+-------------+
7 rows in set (0.00 sec)

mysql> update prodcost set Annual_cost=0 where Product_code=101;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from prodcost;
+--------------+------------------+-------------+
| Product_code | Product_name     | Annual_cost |
+--------------+------------------+-------------+
|          101 | Term Plan        |           0 |
|          103 | Retirement Plan  |         500 |
|          201 | Comprehensive    |         600 |
|          202 | Third-Party      |         300 |
|          301 | Individual       |         800 |
|          303 | Critical Illness |         250 |
|          401 | Natural Causes   |         200 |
+--------------+------------------+-------------+
7 rows in set (0.00 sec)
*/