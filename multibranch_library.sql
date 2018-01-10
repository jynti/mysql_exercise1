mysql> CREATE TABLE branches
    -> (
    -> bcode CHAR(2) NOT NULL PRIMARY KEY,
    -> librarian VARCHAR(40),
    -> address VARCHAR(40)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.42 sec)

mysql> INSERT INTO branches
    -> VALUES ('B1', 'John Smith', '2 Anglesea Rd'),
    -> ('B2', 'Mary Jones', '34 Pearse St'),
    -> ('B3', 'Francis Owens', 'Grange X');
Query OK, 3 rows affected (0.08 sec)
Records: 3  Duplicates: 0  Warnings: 0


////////////////////////////////////////////////////////////////////////////

mysql> CREATE TABLE titles
    -> (
    -> title VARCHAR(40) NOT NULL PRIMARY KEY,
    -> author VARCHAR(40),
    -> publisher VARCHAR(40)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.54 sec)

mysql> INSERT INTO titles
    -> VALUES ('Susannah', 'Ann Brown', 'Macmillan'),
    -> ('How to Fish', 'Amy Fly', 'Stop Press'),
    -> ('A History of Dublin', 'David Little', 'Wiley'),
    -> ('Computers', 'Blaise Pascal', 'Applewoods'),
    -> ('The Wife', 'Ann Brown', 'Macmillan');
Query OK, 5 rows affected (0.09 sec)
Records: 5  Duplicates: 0  Warnings: 0


///////////////////////////////////////////////////////////////////////////////////

mysql> CREATE TABLE holdings
    -> (
    -> branch CHAR(2) NOT NULL,
    -> title VARCHAR(40) NOT NULL,
    -> number_of_copies INT,
    -> PRIMARY KEY (branch, title),
    -> FOREIGN KEY (branch) REFERENCES branches (bcode),
    -> FOREIGN KEY (title) REFERENCES titles (title)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.50 sec)

mysql> INSERT INTO holdings
    -> VALUES ('B1', 'Susannah', 3),
    -> ('B1', 'How to Fish', 2),
    -> ('B1', 'A History of Dublin', 1),
    -> ('B2', 'How to Fish', 4),
    -> ('B2', 'Computers', 2),
    -> ('B2', 'The Wife', 3),
    -> ('B3', 'A History of Dublin', 1),
    -> ('B3', 'Computers', 4),
    -> ('B3', 'Susannah', 3),
    -> ('B3', 'The Wife', 1);
Query OK, 10 rows affected (0.18 sec)
Records: 10  Duplicates: 0  Warnings: 0


////////////////////////////////////////////////////////////////////////////////
1)
mysql> SELECT title
    -> FROM titles
    -> WHERE publisher='Macmillan';
+----------+
| title    |
+----------+
| Susannah |
| The Wife |
+----------+
2 rows in set (0.00 sec)

////////////////////////////////////////////////////////////////////////////////
2)
mysql> SELECT DISTINCT branch
    -> FROM holdings
    -> WHERE title IN
    -> (
    -> SELECT title
    -> FROM titles
    -> WHERE author='Ann Brown'
    -> );
+--------+
| branch |
+--------+
| B1     |
| B3     |
| B2     |
+--------+
3 rows in set (0.00 sec)


////////////////////////////////////////////////////////////////////////////////
3)
mysql> SELECT DISTINCT branch
    -> FROM holdings NATURAL JOIN titles
    -> WHERE author='Ann Brown';
+--------+
| branch |
+--------+
| B1     |
| B3     |
| B2     |
+--------+
3 rows in set (0.00 sec)

////////////////////////////////////////////////////////////////////////////////
4)
mysql> SELECT branch, SUM(number_of_copies) AS total_copies
    -> FROM holdings
    -> GROUP BY branch;
+--------+--------------+
| branch | total_copies |
+--------+--------------+
| B1     |            6 |
| B2     |            9 |
| B3     |            9 |
+--------+--------------+
3 rows in set (0.00 sec)
