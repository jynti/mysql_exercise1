mysql> CREATE TABLE Branch
    -> (
    -> BCode CHAR(2) NOT NULL PRIMARY KEY,
    -> Librarian VARCHAR(40),
    -> Address VARCHAR(40)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.42 sec)

mysql> INSERT INTO Branch
    -> VALUES ('B1', 'John Smith', '2 Anglesea Rd'),
    -> ('B2', 'Mary Jones', '34 Pearse St'),
    -> ('B3', 'Francis Owens', 'Grange X');
Query OK, 3 rows affected (0.35 sec)
Records: 3  Duplicates: 0  Warnings: 0

////////////////////////////////////////////////////////////////////////////

mysql> CREATE TABLE Titles
    -> (
    -> Title VARCHAR(40) NOT NULL PRIMARY KEY,
    -> Author VARCHAR(40),
    -> Publisher VARCHAR(40)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.46 sec)

mysql> INSERT INTO Titles
    -> VALUES ('Susannah', 'Ann Brown', 'Macmillan'),
    -> ('How to Fish', 'Amy Fly', 'Stop Press'),
    -> ('A History of Dublin', 'David Little', 'Wiley'),
    -> ('Computers', 'Blaise Pascal', 'Applewoods'),
    -> ('The Wife', 'Ann Brown', 'Macmillan');
Query OK, 5 rows affected (0.40 sec)
Records: 5  Duplicates: 0  Warnings: 0

///////////////////////////////////////////////////////////////////////////////////

mysql> CREATE TABLE Holdings
    -> (
    -> Branch CHAR(2) NOT NULL,
    -> Title VARCHAR(40) NOT NULL,
    -> NumberOfCopies INT,
    -> PRIMARY KEY (Branch, Title),
    -> FOREIGN KEY (Branch) REFERENCES Branch (BCode),
    -> FOREIGN KEY (Title) REFERENCES Titles (Title)
    -> )
    -> ENGINE=INNODB;
Query OK, 0 rows affected (0.43 sec)

mysql> INSERT INTO Holdings
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
Query OK, 10 rows affected (0.16 sec)
Records: 10  Duplicates: 0  Warnings: 0

////////////////////////////////////////////////////////////////////////////////
1)
mysql> SELECT Title
    -> FROM Titles
    -> WHERE Publisher='Macmillan';
+----------+
| Title    |
+----------+
| Susannah |
| The Wife |
+----------+
2 rows in set (0.00 sec)

////////////////////////////////////////////////////////////////////////////////
2)
mysql> SELECT DISTINCT Branch
    -> FROM Holdings
    -> WHERE Title IN
    -> (
    -> SELECT t.Title
    -> FROM Titles AS t
    -> WHERE Author='Ann Brown'
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
mysql> SELECT DISTINCT Branch
    -> FROM Holdings AS h NATURAL JOIN Titles AS t
    -> WHERE Author='Ann Brown';
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
mysql> SELECT Branch, SUM(NumberOfCopies) AS  totalCopies
    -> FROM Holdings
    -> GROUP BY Branch;
+--------+---------------------+
| Branch | totalCopies |
+--------+---------------------+
| B1     |                   6 |
| B2     |                   9 |
| B3     |                   9 |
+--------+---------------------+
3 rows in set (0.00 sec)
