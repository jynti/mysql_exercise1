mysql> CREATE TABLE Tastes
    -> (
    -> Name VARCHAR(20) NOT NULL,
    -> Filling VARCHAR(20) NOT NULL,
    -> PRIMARY KEY(Name, Filling)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.70 sec)

mysql> INSERT INTO Tastes
    -> VALUES ('Brown', 'Turkey'),
    -> ('Brown', 'Beef'),
    -> ('Brown', 'Ham'),
    -> ('Jones', 'Cheese'),
    -> ('Green', 'Beef'),
    -> ('Green', 'Turkey'),
    -> ('Green', 'Cheese');


///////////////////////////////////////////////////////////////
mysql> CREATE TABLE Locations
    -> (
    -> LName VARCHAR(20) NOT NULL PRIMARY KEY,
    -> Phone VARCHAR(20),
    -> Address VARCHAR(40)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.73 sec)

mysql> INSERT INTO Locations
    -> VALUES ('Lincoln', '683 4523', 'Lincoln Place'),
    -> ('O\'Neill\'s', '674 2134', 'Pearse St'),
    -> ('Old Nag', '767 8132', 'Dame St'),
    -> ('Buttery', '702 3421', 'College St');
Query OK, 4 rows affected (0.08 sec)
Records: 4  Duplicates: 0  Warnings: 0

/////////////////////////////////////////////////////////////////
mysql> CREATE TABLE Sandwiches
    -> (
    -> Location VARCHAR(20) NOT NULL REFERENCES Locations (LName),
    -> Bread VARCHAR(20) NOT NULL,
    -> Filling VARCHAR(20) NOT NULL,
    -> Price FLOAT,
    -> PRIMARY KEY (Location, Bread, Filling)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (1.16 sec)

mysql> INSERT INTO Sandwiches
    -> VALUES ('Lincoln', 'Rye', 'Ham', 1.25),
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
mysql> SELECT Location
    -> FROM Sandwiches
    -> WHERE Filling in
    -> (
    -> SELECT Filling
    -> FROM Tastes
    -> WHERE Name='Jones'
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
mysql> SELECT Location
    -> FROM Tastes AS t NATURAL JOIN Sandwiches AS s
    -> WHERE t.Name='Jones';
+-----------+
| Location  |
+-----------+
| Buttery   |
| O'Neill's |
+-----------+
2 rows in set (0.00 sec)

////////////////////////////////////////////////////////////////////

3)
mysql> SELECT Location, count(distinct Name) AS NumberOfPeople
    -> FROM Sandwiches NATURAL JOIN Tastes
    -> GROUP BY Location;

+-----------+----------------+
| Location  | NumberOfPeople |
+-----------+----------------+
| Buttery   |              3 |
| Lincoln   |              2 |
| O'Neill's |              3 |
| Old Nag   |              2 |
+-----------+----------------+
4 rows in set (0.00 sec)
