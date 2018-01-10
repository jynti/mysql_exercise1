mysql> CREATE TABLE tastes
    -> (
    -> name VARCHAR(20) NOT NULL,
    -> filling VARCHAR(20) NOT NULL,
    -> PRIMARY KEY(name, filling)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.55 sec)

mysql> INSERT INTO tastes
    -> VALUES ('Brown', 'Turkey'),
    -> ('Brown', 'Beef'),
    -> ('Brown', 'Ham'),
    -> ('Jones', 'Cheese'),
    -> ('Green', 'Beef'),
    -> ('Green', 'Turkey'),
    -> ('Green', 'Cheese');
Query OK, 7 rows affected (0.72 sec)
Records: 7  Duplicates: 0  Warnings: 0

///////////////////////////////////////////////////////////////
mysql> CREATE TABLE locations
    -> (
    -> lname VARCHAR(20) NOT NULL PRIMARY KEY,
    -> phone VARCHAR(20),
    -> address VARCHAR(40)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.59 sec)

mysql> INSERT INTO locations
    -> VALUES ('Lincoln', '683 4523', 'Lincoln Place'),
    -> ("O'Neill's", '674 2134', 'Pearse St'),
    -> ('Old Nag', '767 8132', 'Dame St'),
    -> ('Buttery', '702 3421', 'College St');
Query OK, 4 rows affected (0.12 sec)
Records: 4  Duplicates: 0  Warnings: 0


/////////////////////////////////////////////////////////////////
mysql> CREATE TABLE sandwiches
    -> (
    -> location VARCHAR(20) NOT NULL,
    -> bread VARCHAR(20) NOT NULL,
    -> filling VARCHAR(20) NOT NULL,
    -> price FLOAT,
    -> PRIMARY KEY (location, bread, filling),
    -> FOREIGN KEY (location) REFERENCES locations (lname)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.42 sec)

mysql> INSERT INTO sandwiches
    -> VALUES ('Lincoln', 'Rye', 'Ham', 1.25),
    -> ("O'Neill's", 'White', 'Cheese', 1.20),
    -> ("O'Neill's", 'Whole', 'Ham', 1.25),
    -> ('Old Nag', 'Rye', 'Beef', 1.35),
    -> ('Buttery', 'White', 'Cheese', 1.00),
    -> ("O'Neill's", 'White', 'Turkey', 1.35),
    -> ('Buttery', 'White', 'Ham', 1.10),
    -> ('Lincoln', 'Rye', 'Beef', 1.35),
    -> ('Lincoln', 'White', 'Ham', 1.30),
    -> ('Old Nag', 'Rye', 'Ham', 1.40);
Query OK, 10 rows affected (0.07 sec)
Records: 10  Duplicates: 0  Warnings: 0

/////////////////////////////////////////////////////////////////

1)
mysql> SELECT location
    -> FROM sandwiches
    -> WHERE filling in
    -> (
    -> SELECT filling
    -> FROM tastes
    -> WHERE name='Jones'
    -> )
    -> ;
+-----------+
| location  |
+-----------+
| Buttery   |
| O'Neill's |
+-----------+
2 rows in set (0.00 sec)

////////////////////////////////////////////////////////////////////

2)
mysql> SELECT location
    -> FROM tastes NATURAL JOIN sandwiches
    -> WHERE name='Jones';
+-----------+
| location  |
+-----------+
| Buttery   |
| O'Neill's |
+-----------+
2 rows in set (0.00 sec)

////////////////////////////////////////////////////////////////////

3)
mysql> SELECT location, count(distinct name) AS number_of_people
    -> FROM sandwiches NATURAL JOIN tastes
    -> GROUP BY location;

+-----------+----------------+
| location  | number_of_people |
+-----------+----------------+
| Buttery   |              3 |
| Lincoln   |              2 |
| O'Neill's |              3 |
| Old Nag   |              2 |
+-----------+----------------+
4 rows in set (0.00 sec)
