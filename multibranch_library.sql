mysql> create table Branch
    -> (
    -> BCode char(2) not null primary key,
    -> Librarian varchar(40),
    -> Address varchar(40)
    -> )
    -> engine=innodb;
Query OK, 0 rows affected (0.42 sec)

mysql> describe Branch;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| BCode     | char(2)     | NO   | PRI | NULL    |       |
| Librarian | varchar(40) | YES  |     | NULL    |       |
| Address   | varchar(40) | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

mysql> insert into Branch
    -> values ('B1', 'John Smith', '2 Anglesea Rd'),
    -> ('B2', 'Mary Jones', '34 Pearse St'),
    -> ('B3', 'Francis Owens', 'Grange X');
Query OK, 3 rows affected (0.35 sec)
Records: 3  Duplicates: 0  Warnings: 0

////////////////////////////////////////////////////////////////////////////

mysql> create table Titles
    -> (
    -> Title varchar(40) not null primary key,
    -> Author varchar(40),
    -> Publisher varchar(40)
    -> )
    -> engine=innodb;
Query OK, 0 rows affected (0.46 sec)

mysql> describe Titles;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| Title     | varchar(40) | NO   | PRI | NULL    |       |
| Author    | varchar(40) | YES  |     | NULL    |       |
| Publisher | varchar(40) | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> insert into Titles
    -> values ('Susannah', 'Ann Brown', 'Macmillan'),
    -> ('How to Fish', 'Amy Fly', 'Stop Press'),
    -> ('A History of Dublin', 'David Little', 'Wiley'),
    -> ('Computers', 'Blaise Pascal', 'Applewoods'),
    -> ('The Wife', 'Ann Brown', 'Macmillan');
Query OK, 5 rows affected (0.40 sec)
Records: 5  Duplicates: 0  Warnings: 0

///////////////////////////////////////////////////////////////////////////////////

mysql> create table Holdings
    -> (
    -> Branch char(2) not null,
    -> Title varchar(40) not null,
    -> NumberOfCopies int,
    -> primary key (Branch, Title),
    -> foreign key (Branch) references Branch (BCode),
    -> foreign key (Title) references Titles (Title)
    -> )
    -> engine=innodb;
Query OK, 0 rows affected (0.43 sec)

mysql> describe Holdings;
+----------------+-------------+------+-----+---------+-------+
| Field          | Type        | Null | Key | Default | Extra |
+----------------+-------------+------+-----+---------+-------+
| Branch         | char(2)     | NO   | PRI | NULL    |       |
| Title          | varchar(40) | NO   | PRI | NULL    |       |
| NumberOfCopies | int(11)     | YES  |     | NULL    |       |
+----------------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

mysql> insert into Holdings
    -> values ('B1', 'Susannah', 3),
    -> ('B1', 'How to Fish', 2),
    -> ('B1', 'A History of Dublin', 1),
    -> ('B2', 'How to Fish', 4),
    -> ('B2', 'Computers', 2),
    -> ('B2', 'The Wife', 3),
    -> ('B3', 'A History of Dublin', 1),
    -> ('B3', 'Computers', 4),
    -> ('B3', 'Susannah', 3),
    -> ('B3', 'The Wife', 1);
Query OK, 10 rows affected (0.16 sec)
Records: 10  Duplicates: 0  Warnings: 0

////////////////////////////////////////////////////////////////////////////////
1)
mysql> select Title
    -> from Titles
    -> where Publisher='Macmillan';
+----------+
| Title    |
+----------+
| Susannah |
| The Wife |
+----------+
2 rows in set (0.00 sec)

////////////////////////////////////////////////////////////////////////////////
2)
mysql> select distict Branch
    -> from Holdings
    -> where Title in
    -> (
    -> select t.Title
    -> from Titles as t
    -> where Author='Ann Brown'
    -> );
+--------+
| Branch |
+--------+
| B1     |
| B3     |
| B2     |
| B3     |
+--------+
4 rows in set (0.00 sec)

////////////////////////////////////////////////////////////////////////////////
3)
mysql> select distinct Branch
    -> from Holdings as h natural join Titles as t
    -> where Author='Ann Brown';
+--------+
| Branch |
+--------+
| B1     |
| B3     |
| B2     |
+--------+
3 rows in set (0.00 sec)

////////////////////////////////////////////////////////////////////////////////
4)
mysql> select Branch, sum(NumberOfCopies)
    -> from Holdings
    -> group by Branch;
+--------+---------------------+
| Branch | sum(NumberOfCopies) |
+--------+---------------------+
| B1     |                   6 |
| B2     |                   9 |
| B3     |                   9 |
+--------+---------------------+
3 rows in set (0.00 sec)
