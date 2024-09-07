#Alter the customer table to enter a new collumn and update the rows of the new collumn
alter table customer add cost_of_contracts int;
update customer set cost_of_contracts = (select sum(cost) from contract where contract.custcode = customer.custcode);

#Trigger to update cost_of_contracts in case of new insert
drop trigger if exists contract_insert;
delimiter // 
create trigger contract_insert
after insert on contract
for each row
begin
update customer
set cost_of_contracts = (select sum(cost) from contract where contract.custcode = customer.custcode)
where custcode = new.custcode;
end;
//
delimiter ;

#Trigger to update cost_of_contracts in case of update
drop trigger if exists contract_update;
delimiter // 
create trigger contract_update
after update on contract
for each row
begin
update customer
set cost_of_contracts = (select sum(cost) from contract where contract.custcode = customer.custcode)
where custcode = new.custcode;
end;
//
delimiter ;

#Trigger to update cost_of_contracts in case of delete
delimiter ;
drop trigger if exists contract_delete;
delimiter // 
create trigger contract_delete
after delete on contract
for each row
begin
update customer
set cost_of_contracts = (select sum(cost) from contract where contract.custcode = customer.custcode)
where old.custcode = custcode;
end;
//
delimiter ;

/*
Αρχικά θα προσθέσουμε μια νέα στήλη στον πίνακα customer με την εντολή alter table. 
select * from customer;
+----------+-----------+----------+-----------+-------------------------+-----------+-------+------------+---------------+
| CUSTCODE | AFM       | CNAME    | CSURNAME  | ADDRESS                 | CITY      | TK    | PHONE      | DOY           |
+----------+-----------+----------+-----------+-------------------------+-----------+-------+------------+---------------+
|     1001 | 100028428 | Chiquita | Cline     | Nestoros 13             | MAROUSI   | 14121 | 6945550000 | AMAROUSIOU    |
|     1002 | 100785388 | Victoria | Hobbs     | Chrisostomou Smirnis 95 | AIGALEO   | 11855 | 6047367951 | AIGALEO       |
|     1003 | 100087609 | Armando  | Johnson   | Lamprou Katsoni 34      | ALIMOS    | 13671 | 6738630856 | GLYFADAS      |
|     1004 | 101654032 | Dolores  | Askew     | Salaminos 44            | ILIOUPOLI | 17236 | 6689665868 | ILIOUPOLIS    |
|     1005 | 100574954 | Rebekah  | Broussard | Kapodistriou 20         | VOULA     | 16673 | 6213508686 | GLYFADAS      |
|     1006 | 110058098 | Imogene  | Slack     | Chomateri 13            | NIKAIA    | 18122 | 6457764664 | NIKAIAS       |
|     1007 | 101750611 | Henry    | Smith     | Kritika 31              | GALATSI   | 14232 | 6002598899 | IG’ ATHINON   |
+----------+-----------+----------+-----------+-------------------------+-----------+-------+------------+---------------+

alter table customer add cost_of_contracts int;
+----------+-----------+----------+-----------+-------------------------+-----------+-------+------------+---------------+-------------------+
| CUSTCODE | AFM       | CNAME    | CSURNAME  | ADDRESS                 | CITY      | TK    | PHONE      | DOY           | cost_of_contracts |
+----------+-----------+----------+-----------+-------------------------+-----------+-------+------------+---------------+-------------------+
|     1001 | 100028428 | Chiquita | Cline     | Nestoros 13             | MAROUSI   | 14121 | 6945550000 | AMAROUSIOU    |              NULL |
|     1002 | 100785388 | Victoria | Hobbs     | Chrisostomou Smirnis 95 | AIGALEO   | 11855 | 6047367951 | AIGALEO       |              NULL |
|     1003 | 100087609 | Armando  | Johnson   | Lamprou Katsoni 34      | ALIMOS    | 13671 | 6738630856 | GLYFADAS      |              NULL |
|     1004 | 101654032 | Dolores  | Askew     | Salaminos 44            | ILIOUPOLI | 17236 | 6689665868 | ILIOUPOLIS    |              NULL |
|     1005 | 100574954 | Rebekah  | Broussard | Kapodistriou 20         | VOULA     | 16673 | 6213508686 | GLYFADAS      |              NULL |
|     1006 | 110058098 | Imogene  | Slack     | Chomateri 13            | NIKAIA    | 18122 | 6457764664 | NIKAIAS       |              NULL |
|     1007 | 101750611 | Henry    | Smith     | Kritika 31              | GALATSI   | 14232 | 6002598899 | IG’ ATHINON   |              NULL |
+----------+-----------+----------+-----------+-------------------------+-----------+-------+------------+---------------+-------------------+

Έπειτα, θα κάνουμε update την στήλη αυτή ώστε κάθε γραμμή της να περιέχει το συνολικό κόστος των σθμβολαίων του κάθε πελάτη.
update customer set cost_of_contracts = (select sum(cost) from contract where contract.custcode = customer.custcode);
+----------+-----------+----------+-----------+-------------------------+-----------+-------+------------+---------------+-------------------+
| CUSTCODE | AFM       | CNAME    | CSURNAME  | ADDRESS                 | CITY      | TK    | PHONE      | DOY           | cost_of_contracts |
+----------+-----------+----------+-----------+-------------------------+-----------+-------+------------+---------------+-------------------+
|     1001 | 100028428 | Chiquita | Cline     | Nestoros 13             | MAROUSI   | 14121 | 6945550000 | AMAROUSIOU    |             10800 |
|     1002 | 100785388 | Victoria | Hobbs     | Chrisostomou Smirnis 95 | AIGALEO   | 11855 | 6047367951 | AIGALEO       |               600 |
|     1003 | 100087609 | Armando  | Johnson   | Lamprou Katsoni 34      | ALIMOS    | 13671 | 6738630856 | GLYFADAS      |              2400 |
|     1004 | 101654032 | Dolores  | Askew     | Salaminos 44            | ILIOUPOLI | 17236 | 6689665868 | ILIOUPOLIS    |             12400 |
|     1005 | 100574954 | Rebekah  | Broussard | Kapodistriou 20         | VOULA     | 16673 | 6213508686 | GLYFADAS      |              9350 |
|     1006 | 110058098 | Imogene  | Slack     | Chomateri 13            | NIKAIA    | 18122 | 6457764664 | NIKAIAS       |              2000 |
|     1007 | 101750611 | Henry    | Smith     | Kritika 31              | GALATSI   | 14232 | 6002598899 | IG’ ATHINON   |             10150 |
+----------+-----------+----------+-----------+-------------------------+-----------+-------+------------+---------------+-------------------+

Τέλος, θα δημιουργήσουμε triggers. Θα χρείαστούμε 3, έναν σε περίπτωση που γίνει insert στον πίνακα contract, έναν σε περίπτωση update και έναν σε περίπτωση delete.
Θα χρησιμοποιήσουμε τον πελάτη με κωδικό 1006 στα παραδείγματα
Αρχικά:

select * from customer where custcode = 1006;
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+
| CUSTCODE | AFM       | CNAME   | CSURNAME | ADDRESS      | CITY   | TK    | PHONE      | DOY     | cost_of_contracts |
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+
|     1006 | 110058098 | Imogene | Slack    | Chomateri 13 | NIKAIA | 18122 | 6457764664 | NIKAIAS |              2000 |
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+

Μετά το παρακάτω insert:

INSERT INTO CONTRACT
	VALUES(10015, 1006, 101, '2020/02/23', '2050/02/23', 9000);

select * from customer where custcode = 1006;
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+
| CUSTCODE | AFM       | CNAME   | CSURNAME | ADDRESS      | CITY   | TK    | PHONE      | DOY     | cost_of_contracts |
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+
|     1006 | 110058098 | Imogene | Slack    | Chomateri 13 | NIKAIA | 18122 | 6457764664 | NIKAIAS |             11000 |
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+

Μετά το παρακάτω update:
update contract set cost = 10000 where concode = 10015;
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+
| CUSTCODE | AFM       | CNAME   | CSURNAME | ADDRESS      | CITY   | TK    | PHONE      | DOY     | cost_of_contracts |
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+
|     1006 | 110058098 | Imogene | Slack    | Chomateri 13 | NIKAIA | 18122 | 6457764664 | NIKAIAS |             12000 |
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+

Και τελικά μετα την διαγραφή του contract το cost_of_contracts επιστρέφει στην αρχική τιμή του:
delete contract where concode = 10015;
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+
| CUSTCODE | AFM       | CNAME   | CSURNAME | ADDRESS      | CITY   | TK    | PHONE      | DOY     | cost_of_contracts |
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+
|     1006 | 110058098 | Imogene | Slack    | Chomateri 13 | NIKAIA | 18122 | 6457764664 | NIKAIAS |              2000 |
+----------+-----------+---------+----------+--------------+--------+-------+------------+---------+-------------------+
*/