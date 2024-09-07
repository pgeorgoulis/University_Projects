drop function if exists timediffs;
delimiter //
CREATE function timediffs(STARTDATE date,  ENDDATE date)
RETURNS SMALLINT NOT DETERMINISTIC
begin
return timestampdiff(MONTH,STARTDATE,ENDDATE);
end //
delimiter ;

/*
Έχοντας τα παρακάτω συμβόλαια στον πίνακα contracts:
mysql> select concode, startdate, enddate from contract;
+---------+------------+------------+
| concode | startdate  | enddate    |
+---------+------------+------------+
|   10001 | 2018-02-23 | 2048-02-23 |
|   10002 | 2019-05-01 | 2021-05-01 |
|   10003 | 2019-09-05 | 2029-09-05 |
|   10004 | 2020-02-01 | 2022-02-01 |
|   10005 | 2020-03-08 | 2022-03-08 |
|   10006 | 2020-03-14 | 2040-03-14 |
|   10007 | 2020-05-03 | 2025-05-03 |
|   10008 | 2020-05-16 | 2021-05-16 |
|   10009 | 2020-08-12 | 2023-08-12 |
|   10010 | 2020-08-23 | 2021-02-23 |
|   10011 | 2020-09-18 | 2025-09-18 |
|   10012 | 2020-09-23 | 2022-09-23 |
|   10013 | 2021-09-25 | 2022-09-25 |
|   10014 | 2021-12-22 | 2031-12-22 |
+---------+------------+------------+

Η συνάρτηση θα επιστρέψει:
select timediffs(STARTDATE, ENDDATE) AS months from contract;
+--------+
| months |
+--------+
|    360 |
|     24 |
|    120 |
|     24 |
|     24 |
|    240 |
|     60 |
|     12 |
|     36 |
|      6 |
|     60 |
|     24 |
|     12 |
|    120 |
+--------+
*/