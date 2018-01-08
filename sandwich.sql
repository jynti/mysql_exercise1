
mysql> create table Tastes
    -> (
    -> Name varchar(20) not null,
    -> Filling varchar(20) not null,
    -> primary key(Name, Filling)
    -> )
    -> engine=innodb;
Query OK, 0 rows affected (0.70 sec)

    mysql> describe Tastes;
    +---------+-------------+------+-----+---------+-------+
    | Field   | Type        | Null | Key | Default | Extra |
    +---------+-------------+------+-----+---------+-------+
    | Name    | varchar(20) | NO   | PRI | NULL    |       |
    | Filling | varchar(20) | NO   | PRI | NULL    |       |
    +---------+-------------+------+-----+---------+-------+
    2 rows in set (0.00 sec)

mysql> insert into Tastes
    -> values ('Brown', 'Turkey'),
    -> ('Brown', 'Beef'),
    -> ('Brown', 'Ham'),
    -> ('Jones', 'Cheese'),
    -> ('Green', 'Beef'),
    -> ('Green', 'Turkey'),
    -> ('Green', 'Cheese');


///////////////////////////////////////////////////////////////
mysql> create table Locations
    -> (
    -> LName varchar(20) not null primary key,
    -> Phone varchar(20),
    -> Address varchar(40)
    -> )
    -> engine=innodb;
Query OK, 0 rows affected (0.73 sec)

mysql> describe Locations;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| LName   | varchar(20) | NO   | PRI | NULL    |       |
| Phone   | varchar(20) | YES  |     | NULL    |       |
| Address | varchar(40) | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> insert into Locations
    -> values ('Lincoln', '683 4523', 'Lincoln Place'),
    -> ('O\'Neill\'s', '674 2134', 'Pearse St'),
    -> ('Old Nag', '767 8132', 'Dame St'),
    -> ('Buttery', '702 3421', 'College St');
Query OK, 4 rows affected (0.08 sec)
Records: 4  Duplicates: 0  Warnings: 0

/////////////////////////////////////////////////////////////////
mysql> create table Sandwiches
    -> (
    -> Location varchar(20) not null references Locations (LName),
    -> Bread varchar(20) not null,
    -> Filling varchar(20) not null,
    -> Price float,
    -> primary key (Location, Bread, Filling)
    -> )
    -> engine=innodb;
Query OK, 0 rows affected (1.16 sec)

mysql> describe Sandwiches;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| Location | varchar(20) | NO   | PRI | NULL    |       |
| Bread    | varchar(20) | NO   | PRI | NULL    |       |
| Filling  | varchar(20) | NO   | PRI | NULL    |       |
| Price    | float       | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> insert into Sandwiches
    -> values ('Lincoln', 'Rye', 'Ham', 1.25),
    -> ('O\'Neill\'s', 'White', 'Cheese', 1.20),
    -> ('O\'Neill\'s', 'Whole', 'Ham', 1.25),
    -> ('Old Nag', 'Rye', 'Beef', 1.35),
    -> ('Buttery', 'White', 'Cheese', 1.00),
    -> ('O\'Neill\'s', 'White', 'Turkey', 1.35),
    -> ('Buttery', 'White', 'Ham', 1.10),
    -> ('Lincoln', 'Rye', 'Beef', 1.35),
    -> ('Lincoln', 'White', 'Ham', 1.30),
    -> ('Old Nag', 'Rye', 'Ham', 1.40);
Query OK, 10 rows affected (0.08 sec)
Records: 10  Duplicates: 0  Warnings: 0


/////////////////////////////////////////////////////////////////

1)
mysql> select Location
    -> from Sandwiches
    -> where Filling in
    -> (
    -> select Filling
    -> from Tastes
    -> where Name='Jones'
    -> )
    -> ;
+-----------+
| Location  |
+-----------+
| Buttery   |
| O'Neill's |
+-----------+
2 rows in set (0.00 sec)
////////////////////////////////////////////////////////////////////
2)
mysql> select Location
    -> from Tastes as t natural join Sandwiches as s
    -> where t.Name='Jones';
+-----------+
| Location  |
+-----------+
| Buttery   |
| O'Neill's |
+-----------+
2 rows in set (0.00 sec)
////////////////////////////////////////////////////////////////////
3)
mysql> select Location, count(distinct Name) as NumberOfPeople
    -> from Sandwiches natural join Tastes
    -> group by Location;

+-----------+----------------+
| Location  | NumberOfPeople |
+-----------+----------------+
| Buttery   |              3 |
| Lincoln   |              2 |
| O'Neill's |              3 |
| Old Nag   |              2 |
+-----------+----------------+
4 rows in set (0.00 sec)
