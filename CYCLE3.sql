USE CYCLE3;
SET SQL_SAFE_UPDATES=0;

#QUESTION SET 3
CREATE TABLE EMPLOYEE(SSN INT PRIMARY KEY,ENAME VARCHAR(20) NOT NULL,DESIGN VARCHAR(20),DNO INT,DOJ DATE,SALARY INT);

CREATE TABLE DEPARTMENT(DNUMBER INT PRIMARY KEY,DNAME VARCHAR(20),LOC VARCHAR(40),MGRSSN INT REFERENCES EMPLOYEE(SSN));

CREATE TABLE PROJ(PNUMBER INT PRIMARY KEY,PNAME VARCHAR(15),DNUM INT,FOREIGN KEY(DNUM) REFERENCES DEPARTMENT(DNUMBER));

CREATE TABLE WOORK_IN(ESSN INT,PNO INT,HOURS INT,FOREIGN KEY(ESSN) REFERENCES EMPLOYEE(SSN),FOREIGN KEY(PNO) REFERENCES PROJ(PNUMBER),
FOREIGN KEY(HOURS) REFERENCES DEPARTMENT(DNUMBER));
ALTER TABLE WOORK_IN RENAME TO WORK_IN;

INSERT INTO DEPARTMENT(DNUMBER,DNAME,LOC)VALUES(1,'Admin','Chennai'),(2,'HR','Banglore'),(3,'Sales','Kochi'),(4,'Finance','Delhi'),(5,'Production','Trivanrum');
SELECT * FROM DEPARTMENT;

INSERT INTO EMPLOYEE (ssn,ename,design,dno,doj,salary) VALUES
(1,'Abhi','HR',2,'2009/04/12',70000),(2,'Bhama','Admin',1,'2008/03/10',75000),(3,'Chriz','Sales',3,'2011/06/23',35000),(4,'Diya','Productin',5,'2015/08/21',70000),
(5,'Govind','Production',5,'2011/10/12',35000),(6,'Hima','Finance',4,'2013/01/19',51000),(7,'Ira','HR',2,'2010/03/15',45000),
(8,'Sandeep','Finance',4,'2010/07/26',49000);
SELECT * FROM EMPLOYEE;

UPDATE DEPARTMENT SET MGRSSN=2 WHERE dnumber=1;
UPDATE DEPARTMENT SET MGRSSN=1 WHERE dnumber=2;
UPDATE DEPARTMENT SET MGRSSN=3 WHERE dnumber=3;
UPDATE DEPARTMENT SET MGRSSN=6 WHERE dnumber=4;
UPDATE DEPARTMENT SET MGRSSN=7 WHERE dnumber=2;
UPDATE DEPARTMENT SET MGRSSN=4 WHERE dnumber=5;
UPDATE DEPARTMENT SET MGRSSN=5 WHERE dnumber=5;

INSERT INTO PROJ(PNUMBER,PNAME,DNUM)VALUES(11,'Bancs Trsry',3),(12,'Nielesan',5),(13,'World Bnk',1),(14,'Airlines',2),(15,'Amex',4);
SELECT * FROM PROJ;

INSERT INTO WORK_IN(ESSN,PNO,HOURS) VALUES(1,14,NULL),(4,13,NULL),(8,12,NULL),(6,15,NULL),(2,11,NULL),(3,13,NULL);
SELECT * FROM WORK_IN;

#1.Retrieve all employees in department 5 whose salary is between Rs30,000 and Rs 40,000.
SELECT * FROM EMPLOYEE WHERE SALARY BETWEEN 30000 AND 40000 AND DNO=5; 

#2.Retrieve a list of employees and the projects they are working on, where the departments and the employees within the department are alphabetically by name.
SELECT E.ENAME,D.DNAME FROM EMPLOYEE E JOIN DEPARTMENT D ON E.DNO=D.DNUMBER ORDER BY D.DNAME ASC,E.ENAME ASC;

#3. Retrieve the project number, the project name, and the number of employees who work in each project.
SELECT P.PNUMBER,P.PNAME,COUNT(E.SSN) AS NO_OF_EMPLOYEES FROM WORK_IN W JOIN PROJ P ON W.PNO=P.PNUMBER JOIN EMPLOYEE E ON W.ESSN=E.SSN GROUP BY P.PNAME,P.PNUMBER;

#4. For the project on which more than two employees work, retrieve the project number, the project name, and the number of employees who work on the project.
SELECT P.PNUMBER,P.PNAME,COUNT(E.SSN) AS NO_OF_EMPLOYEES FROM WORK_IN W JOIN PROJ P ON W.PNO=P.PNUMBER JOIN EMPLOYEE E ON W.ESSN=E.SSN HAVING COUNT(E.SSN)> 2;

#5. For each project, retrieve the project number, the project name, and the number of employees from department 5 who work on the project.
SELECT P.PNUMBER,P.PNAME,D.DNUMBER,COUNT(E.SSN) FROM PROJ P JOIN DEPARTMENT D  ON D.DNUMBER=P.DNUM JOIN EMPLOYEE E ON E.DNO=P.DNUM 
GROUP BY P.PNAME,P.PNUMBER,D.DNUMBER HAVING D.DNUMBER=5;

#6. For the departments having more than five employees, display the department id and the number and details of employees earning more than Rs 40,000 per month.
SELECT D.DNAME,D.DNUMBER,E.SSN,E.ENAME,E.DESIGN,E.DOJ,E.SALARY FROM DEPARTMENT D, EMPLOYEE E WHERE
(SELECT COUNT(*) FROM EMPLOYEE E WHERE E.DNO=D.DNUMBER AND E.SALARY>40000)>4 AND E.DNO=D.DNUMBER 
GROUP BY D.DNAME,D.DNUMBER,E.SSN,E.ENAME,E.DESIGN,E.DOJ,E.SALARY;

#7. Create a synonym for the VIEW created on natural join of emp and dept tables.
create VIEW emp_dept_view as select * from employee NATURAL JOIN department;

#8. (a)Display the employee details, departments that the departments are same in both the emp and dept. (Equi-join)
SELECT * FROM EMPLOYEE E,DEPARTMENT D WHERE E.DNO=D.DNUMBER;

#(b)Display the employee details, departments that the departments are not same in both the emp and dept. (Non Equi-join)
SELECT DISTINCT * FROM EMPLOYEE E,DEPARTMENT D WHERE NOT(E.DNO=D.DNUMBER);

#(c)Perform Left outer join on the emp and dept tables.
SELECT * FROM EMPLOYEE E LEFT OUTER JOIN DEPARTMENT D ON E.DNO=D.DNUMBER;

#(d)Perform Right outer join on the emp and dept tables.
SELECT * FROM EMPLOYEE E RIGHT OUTER JOIN DEPARTMENT D ON E.DNO=D.DNUMBER;

#(e) Perform inner join on the emp and dept tables.
SELECT * FROM EMPLOYEE E INNER JOIN DEPARTMENT D ON E.DNO=D.DNUMBER;










