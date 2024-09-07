drop procedure if exists monthly_cost_proc;
delimiter //
CREATE procedure monthly_cost_proc(IN s_afm INT, IN s_date DATE, 
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
end //
delimiter ;


/*
select concode, contract.custcode, contract.prodcode, afm, startdate, enddate, anncost"Annual cost", cost"Total cost of contract", cost_of_contracts"Sum of total costs"
from contract 
inner join customer on contract.custcode = customer.custcode
inner join product on contract.prodcode = product.prodcode 
where AFM=100574954;
+---------+----------+----------+-----------+------------+------------+-------------+------------------------+--------------------+
| concode | custcode | prodcode | afm       | startdate  | enddate    | Annual cost | Total cost of contract | Sum of total costs |
+---------+----------+----------+-----------+------------+------------+-------------+------------------------+--------------------+
|   10007 |     1005 |      303 | 100574954 | 2020-05-03 | 2025-05-03 |         250 |                   1250 |               8750 |
|   10011 |     1005 |      302 | 100574954 | 2020-09-18 | 2025-09-18 |        1500 |                   7500 |               8750 |
+---------+----------+----------+-----------+------------+------------+-------------+------------------------+--------------------+
Αυτά είναι τα συμβόλαια του πελάτη με ΑΦΜ 100574954. Εάν, στην monthly_cost_proc βάλουμε το ΑΦΜ αυτό μαζί με την ημερομηνία 2020/11/07
θα επιστρέψει τα παρακάτω. 

call monthly_cost_proc(100574954, '2020/11/07', @active_contracts, @mcost);
select @active_contracts;
select @mcost;

mysql> select @active_contracts;
+-------------------+
| @active_contracts |
+-------------------+
|                 2 |
+-------------------+
1 row in set (0.00 sec)

mysql> select @mcost;
+--------+
| @mcost |
+--------+
| 145.83 |
+--------+

Πράγματι και τα δύο συμβόλαια είναι ενεργά για τον 11/2020 οπότε, το κόστος για κάθε συμβόλαιο θα είναι η ετήσια τιμη δια 12.
Στην προκειμένη περίπτωση 250/12 + 1500/12 = 20,83 + 125 = 145,83

Αν για το ίδιο ΑΦΜ βάλουμε ως ημερομηνία 2020/06/07, όπου μόνο το 10007 θα είναι ενεργό, τότε το μηνιαίο κόστος θα είναι 250/12 = 20.83
call monthly_cost_proc(100574954, '2020/06/07', @active_contracts, @mcost);
select @active_contracts;
select @mcost;

mysql> select @active_contracts;
+-------------------+
| @active_contracts |
+-------------------+
|                 1 |
+-------------------+
1 row in set (0.00 sec)

mysql> select @mcost;
+--------+
| @mcost |
+--------+
|  20.83 |
+--------+

*/