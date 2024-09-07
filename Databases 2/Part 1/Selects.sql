#Number of contracts per product
SELECT contract.PRODCODE"Product code", PNAME"Name", COUNT(contract.PRODCODE)"Number of contracts"
FROM contract, product
WHERE contract.PRODCODE = product.PRODCODE
GROUP BY contract.PRODCODE;
/*
Results
+--------------+------------------+---------------------+
| Product code | Name             | Number of contracts |
+--------------+------------------+---------------------+
|          101 | Term Plan        |                   1 |
|          102 | Whole Life       |                   1 |
|          103 | Retirement Plan  |                   1 |
|          201 | Comprehensive    |                   3 |
|          202 | Third-Party      |                   2 |
|          301 | Individual       |                   2 |
|          302 | Family           |                   1 |
|          303 | Critical Illness |                   1 |
|          401 | Natural Causes   |                   1 |
|          402 | Burglaries       |                   1 |
+--------------+------------------+---------------------+
*/
#Clients sorted by total expences, descending
SELECT contract.CUSTCODE"Code",CNAME"Name", CSURNAME"Surname", SUM(COST)"Total contract cost"
FROM contract, customer
WHERE contract.CUSTCODE = customer.CUSTCODE
GROUP BY contract.CUSTCODE
ORDER BY SUM(COST) DESC;
/*
Results
+------+----------+-----------+---------------------+
| Code | Name     | Surname   | Total contract cost |
+------+----------+-----------+---------------------+
| 1004 | Dolores  | Askew     |               12400 |
| 1001 | Chiquita | Cline     |               10800 |
| 1007 | Henry    | Smith     |               10150 |
| 1005 | Rebekah  | Broussard |                9350 |
| 1003 | Armando  | Johnson   |                2400 |
| 1006 | Imogene  | Slack     |                2000 |
| 1002 | Victoria | Hobbs     |                 600 |
+------+----------+-----------+---------------------+
*/
