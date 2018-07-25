-- ProblemSet00 july 25 2018
-- Submission by j.varadharajulu 

2.Select the Employee with the least salary:
 select NAME,SALARY from EMPLOYEE where SALARY=(select min(SALARY) from EMPLOYEE);
 JOHN HELLEN|15380

3.Select the Employee who does not have a manager in the department table:
 select E_ID,NAME from EMPLOYEE where MANAGER_ID not in (select E_ID from EMPLOYEE);
 A178|BRUCE WILLS
 A120|TIM ARCHER
 A187|ADAM JUSTIN
 A187|ROBERT SWIFT
 A165|NATASHA STEVENS
 
4.Select the Employee who is also a Manager:
 select distinct e1.MANAGER_ID,e2.NAME from EMPLOYEE e1 inner join EMPLOYEE e2 where e1.MANAGER_ID=e2.E_ID;
 A120|TIM ARCHER
 A187|ADAM JUSTIN
 A187|ROBERT SWIFT
 A165|NATASHA STEVENS
 A178|BRUCE WILLS
 
5.Select the Employee who is a Manager and has least salary:
 select min(SALARY),NAME from EMPLOYEE e1 inner join DEPT d1 on d1.DEP_ID=e1.DEP_ID where e1.NAME=d1.DEP_MANAGER;
 27700|ROBERT SWIFT

6.Select the total number of Employees in Communications departments
 select count(*) from EMPLOYEE e1 inner join DEPT d1 on e1.DEP_ID=d1.DEP_ID where DEP_NAME='COMMUNICATIONS';
 6

7.Select the Employee in Finance Department who has the top salary
 select e1.NAME,max(SALARY) from EMPLOYEE e1 inner join DEPT d1 on d1.DEP_ID=e1.DEP_ID where d1.DEP_NAME='FINANCE';
 ADAM WAYNE|94324

9.Select the count of Empolyees in Health with maximum salary
 select count(*),max(SALARY) from EMPLOYEE e1 inner join DEPT d1 on d1.DEP_ID=e1.DEP_ID where DEP_NAME='HEALTH';
 5|94791

10.Select the Employees who report to Natasha Stevens
  select E_ID,NAME from EMPLOYEE where MANAGER_ID in(select E_ID from EMPLOYEE where NAME='NATASHA STEVENS');
  A128|ADAM WAYNE
  A129|JOSEPH ANGELIN

11.Display the Employee name,Dep name,Dept manager in the Health department
  select e.NAME,d.DEP_NAME,d.DEP_MANAGER from EMPLOYEE e inner join DEPT d on e.DEP_ID=d.DEP_ID where d.DEP_NAME='HEALTH';
  MARTIN TREDEAU|HEALTH|TIM ARCHER
  PAUL VINCET|HEALTH|TIM ARCHER
  BRAD MICHAEL|HEALTH|TIM ARCHER
  EDWARD CANE|HEALTH|TIM ARCHER
  JOHN HELLEN|HEALTH|TIM ARCHER

12.Display the Department id,Employee ids and Manager ids for the Communications department
  select d.DEP_ID,e.E_ID,e.MANAGER_ID from EMPLOYEE e inner join DEPT d on e.DEP_ID=d.DEP_ID where DEP_NAME='COMMUNICATIONS';
  D02|A116|A187
  D02|A198|A187
  D02|A187|A298
  D02|A121|A187
  D02|A194|A187
  D02|A133|A187

13.Select the Average Expenses for Each dept with Dept id and Dept name
 select avg(SALARY),d.DEP_ID,d.DEP_NAME from EMPLOYEE e inner join DEPT d on e.DEP_ID=d.DEP_ID group by e.DEP_ID;
 55666.4|D01|HEALTH
 48271.3333333333|D02|COMMUNICATIONS
 55289.6666666667|D03|PRODUCT
 51913.3333333333|D04|INSURANCE
 56660.3333333333|D05|FINANCE

14.Select the total expense for the department finance
  select sum(SALARY),d.DEP_NAME FROM EMPLOYEE e inner join DEPT d on e.DEP_ID=d.DEP_ID where DEP_NAME='FINANCE';
  169981|FINANCE

16.Select the count of Employees in each department
  select count(*),DEP_ID from EMPLOYEE group by DEP_ID;
  5|D01
  6|D02
  3|D03
  3|D04
  3|D05

17.Select the count of Employees in each department having salary <10000
  select count(*),DEP_ID from EMPLOYEE where SALARY<10000 group by DEP_ID;
  no record found

18.Select the total number of Employees in Dept id D04
  select count(*) from EMPLOYEE where DEP_ID='D04' group by DEP_ID;
  3

20.Select the Employees who has Tim Cook as their manager
  select e.E_ID,e.NAME from EMPLOYEE e inner join DEPT d on e.DEP_ID=d.DEP_ID where d.DEP_MANAGER='TIM COOK';
  no record found

  


