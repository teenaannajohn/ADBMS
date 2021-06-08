use cycle1;

#QUESTION SET1

create table employee(
eid int primary key,
empno int,
ename varchar(25),
job varchar(12),
salary int,
commission int,
deptno int
);


describe employee;


insert into emp_tab(empno,ename,job,salary,deptno)
values(7369,'Smith','Clerk',800,20);
insert into emp_tab(empno,ename,job,salary,deptno)
values(7499,'Allen','Salesman',1600,30),(7521,'WARD','SALESMAN',1250,30),(7654,'MARTIN','SALESMAN',1250,30);
insert into emp_tab(empno,ename,job,salary,deptno)
values(7566,'JONES','MANAGER',2975,20),(7698,'BLAKE','MANAGER', 2850, 30),(7782,'CLARK','MANAGER',2450,10),
(7788,'SCOTT','ANALYST',3000,20),(7839,'KING','PRESIDENT',5000,10),(7844,'TURNER','SALESMAN',1500,30),
(7900,'JAMES',NULL,950,30),(7902,'FORD','ANALYST',3000,20),(7934,'MILLER','CLERK',1300,10);

SET SQL_SAFE_UPDATES=0;
update employee set job='Clerk' where job is NULL;
select * from employee;
alter table employee add column date_join varchar(10);
UPDATE employee
SET date_join='1980-12-17' WHERE empno='7369';
UPDATE employee 
SET date_join='1981-02-20' WHERE empno='7499';
UPDATE employee
SET date_join='1981-02-22' WHERE empno='7521';
UPDATE employee 
SET date_join='1981-04-02' WHERE empno='7566';
UPDATE employee
SET date_join='1981-09-28' WHERE empno='7654';
UPDATE employee 
SET date_join='1981-05-01' WHERE empno='7698';
UPDATE employee
SET date_join='1981-06-09' WHERE empno='7782';
UPDATE employee
SET date_join='1981-04-19' WHERE empno='7788';
UPDATE employee
SET date_join='1981-11-17'WHERE empno='7839';
UPDATE employee
SET date_join='1981-09-08' WHERE empno='7844';
UPDATE employee
SET date_join='1987-05-23' WHERE empno='7876';
UPDATE employee
SET date_join='1981-12-03' WHERE empno='7900';
UPDATE employee
SET date_join='1981-12-03' WHERE empno='7902';
UPDATE employee 
SET date_join='1982-01-23' WHERE empno='7934';

select * from employee;

select distinct empno,job from employee;

select ename,deptno from employee where deptno in (20,30);

select ename,salary+commission as total_salary from employee;

select ename,salary*12 as annual_salary from employee;

select  ename,date_join from employee where date_join='1981-12-03'; 

select ename,salary+coalesce(commission, 0) as total_salary from employee where ename='MILLER';

delete from employee where ename='MILLER';

select ename,deptno from employee;

alter table employee add total_salary int;
update employee set commission=0 where commission is null;
update employee set total_salary=(select salary+commission);
alter table employee drop commission;
select * from employee;

select distinct e.ename,e.salary from employee e, employee a
where e.total_salary = a.total_salary and e.ename != a.ename;

select ename as name ,empno as emp_id from employee;

alter table emp rename to employee;
describe employee;

create table employee as select * from emp_tab;
describe EMP_TAB;

select distinct * from employee join emp_tab;SELECT distinct e.empno,e.ename,e.job,e.salary,e.deptno,e.date_join,e.total_salary,
b.empno,b.ename,b.job,b.salary,b.deptno,b.date_join,b.total_salary FROM emp_tab e  JOIN 
employee b where e.empno=b.empno;

truncate table employee;
select * from employee;

drop table employee;
describe employee;

#QUESTION SET2

create table student(sid int,name varchar(20),dob varchar(10),mark_physics int,mark_chemistry int,mar_maths int);
describe student;
insert into student(sid,name,dob,mark_physics,mark_chemistry,mar_maths)
values(101,'Adam','1981-06-09',50,78,56),(102,'Anna','1981-12-03',90,88,76),(101,'Alex','1981-09-08',60,88,46),
(103,'Abhi','1981-11-17',70,98,86),(101,'Ankit','1981-09-08',44,58,36);
select * from student;

select sid,name from student where dob=(select max(dob) from student);

select *from student where mar_maths > 40 and(mark_chemistry>40 or mark_physics>40); 

alter table student add (total int, average int);
describe student;

select name from student where mar_maths=(select max(mar_maths)from student);

select name from student where mark_chemistry=(select min(mark_chemistry)from student);

alter table student rename column total to total_marks;
describe student;

select * from student order by(select mar_maths+mark_physics+mark_chemistry)desc ;

alter table student rename column average to avg_mark;
describe student;

update student set total_marks=(select mar_maths+mark_physics+mark_chemistry);
update student set avg_mark=(select total_marks/3);
select * from student;
select avg(avg_mark) from student;

select * from student where avg_mark>(select avg(avg_mark));

select count(*) from student where avg_mark>(select avg(avg_mark));


#QUESTION SET 3

create table loan_accounts (accno char(4),cust_name varchar(15),loan_amount decimal(10,2),installments int,
int_rate decimal(10,2),start_date date,interest decimal(10,2));
describe loan_accounts;
alter table loan_accounts add column(category varchar(1));
insert into loan_accounts(accno,cust_name,loan_amount,installments,int_rate,start_date,interest) 
values('1001','R.K Gupta',300000.00,36,12.00,'2009-07-19',null),('1002','S.PSharma',500000.00,48,10.00,'2008-03-22',null),
('1003','K.P Jain',300000.00,36,NULL,'2007-08-03',null),('1004','M.PYadav',800000.00,60,10.00,'2008-06-12',null),
('1005','S.P Sinha',200000.00,36,12.50,'2010-03-01',null),('1006','P. Sharma',700000.00,60,12.50,'2008-05-06',null),
('1007','K.S Dhall', 500000.00, 48, NULL,'2008-05-03',null);
select * from loan_accounts;

update loan_accounts set int_rate=11.50 where int_rate is NULL;
select * from loan_accounts;

update loan_accounts set int_rate=int_rate+0.5 where loan_amount>400000;
select * from loan_accounts;

update loan_accounts set interest=(select (loan_amount*int_rate*installments)/(12*100) );
select * from loan_accounts;

delete from loan_accounts where start_date like '2008%';
select * from loan_accounts;

delete from loan_accounts where cust_name like 'S%';
select * from loan_accounts;

select * from loan_accounts where installments<40;

select accno,loan_amount,start_date from loan_accounts where start_date < '2009-04-01';

select int_rate,start_date from loan_accounts where start_date >'2009-04-01';

select accno,cust_name,loan_amount from loan_accounts where cust_name like '%Sharma';

select loan_amount,cust_name from loan_accounts where cust_name like '%a';

select accno,cust_name,loan_amount from loan_accounts where cust_name like '%a%';

select accno,cust_name,loan_amount from loan_accounts where cust_name not like '%p%';

describe loan_accounts;

select * from loan_accounts order by loan_amount asc;

select * from loan_accounts order by start_date desc;

select * from loan_accounts order by loan_amount asc,start_date desc;

select accno,cust_name,loan_amount from loan_accounts where cust_name like 'k%';

select * from loan_accounts where int_rate is null;

select * from loan_accounts where int_rate is not null;

select distinct loan_amount from loan_accounts;

select * from loan_accounts where start_date>'2008-12-31' and installments>=36;

select cust_name,loan_amount from loan_accounts where loan_amount<500000 or int_rate>12;

select * from loan_accounts where start_date like'2009%';

select * from loan_accounts where loan_amount between 400000 and 500000;

select cust_name,loan_amount from loan_accounts where installments in(26,36,48);

select cust_name,loan_amount,IFNULL(int_rate,0) as int_rate from loan_accounts;

select cust_name,loan_amount,ifnull(int_rate,'No Interest') as int_rate from loan_accounts;
