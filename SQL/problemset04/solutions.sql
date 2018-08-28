problemset04 28th aug 2018
submission by j.varadharajulu@accenture.com


create table Highschooler(ID int constraint ikey primary key, name text, grade int);

create table Friend(ID1 int constraint ifk references Highschooler(ID), ID2 int);

create table Likes(ID1 int constraint ifk1 references Highschooler(ID), ID2 int);



insert into Highschooler values (1510, 'Jordan', 9);

insert into Highschooler values (1689, 'Gabriel', 9);

insert into Highschooler values (1381, 'Tiffany', 9);

insert into Highschooler values (1709, 'Cassandra', 9);

insert into Highschooler values (1101, 'Haley', 10);

insert into Highschooler values (1782, 'Andrew', 10);

insert into Highschooler values (1468, 'Kris', 10);

insert into Highschooler values (1641, 'Brittany', 10);

insert into Highschooler values (1247, 'Alexis', 11);

insert into Highschooler values (1316, 'Austin', 11);

insert into Highschooler values (1911, 'Gabriel', 11);

insert into Highschooler values (1501, 'Jessica', 11);

insert into Highschooler values (1304, 'Jordan', 12);

insert into Highschooler values (1025, 'John', 12);

insert into Highschooler values (1934, 'Kyle', 12);

insert into Highschooler values (1661, 'Logan', 12);



insert into Friend values (1510, 1381);

insert into Friend values (1510, 1689);

insert into Friend values (1689, 1709);

insert into Friend values (1381, 1247);

insert into Friend values (1709, 1247);

insert into Friend values (1689, 1782);

insert into Friend values (1782, 1468);

insert into Friend values (1782, 1316);

insert into Friend values (1782, 1304);

insert into Friend values (1468, 1101);

insert into Friend values (1468, 1641);

insert into Friend values (1101, 1641);

insert into Friend values (1247, 1911);

insert into Friend values (1247, 1501);

insert into Friend values (1911, 1501);

insert into Friend values (1501, 1934);

insert into Friend values (1316, 1934);

insert into Friend values (1934, 1304);

insert into Friend values (1304, 1661);

insert into Friend values (1661, 1025);

insert into Friend select ID2, ID1 from Friend;


insert into Likes values(1689, 1709);

insert into Likes values(1709, 1689);

insert into Likes values(1782, 1709);

insert into Likes values(1911, 1247);

insert into Likes values(1247, 1468);

insert into Likes values(1641, 1468);

insert into Likes values(1316, 1304);

insert into Likes values(1501, 1934);

insert into Likes values(1934, 1501);

insert into Likes values(1025, 1101);

1.Find the names of all students who are friends with someone named Gabriel.
select h1.name from Highschooler h1 inner join Friend f on h1.ID=f.ID1 inner join highschooler h2 on f.ID2=h2.ID where h2.name='Gabriel';
Jordan
Alexis
Cassandra
Andrew
Jessica

2.For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.
 select h1.name,h1.grade,h2.name,h2.grade from Highschooler h1 inner join likes l on h1.ID=l.ID1 inner join Highschooler h2 on h2.ID=l.ID2 where (h1.grade-h2.grade)>=2;
John|12|Haley|10

3.For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.
select h.name,h1.name from Highschooler h inner join likes l on h.id=l.id1 inner join highschooler h1 on h1.id=l.id2 inner join likes l1 on l1.id1=l.id2 and l.id1=l1.id2 and l1.id1>l.id1;
Gabriel|Cassandra
Jessica|Kyle

4.Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade
select h.name,h.grade from Highschooler h inner join(select ID from Highschooler where ID not in(select ID1 from Likes) and ID not in(select ID2 from Likes)) as tab on tab.ID=h.ID;
Tiffany|9
Jordan|9
Logan|12

5.For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. (1 point possible)
select h.name,h.grade,h1.name,h1.grade from Highschooler h inner join (select ID1,ID2 from likes where ID2 not in(select ID1 from likes)) as A on h.ID=A.ID1 inner join Highschooler h1 on h1.ID=A.ID2;
Alexis|11|Kris|10
Brittany|10|Kris|10
Austin|11|Jordan|12
John|12|Haley|10

6.Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.
 select h.name,h.grade from Highschooler h where h.ID not in(select f.ID1 from Friend f inner join Highschooler h1 on h1.ID=f.ID2 and h.ID=f.ID1 where h.grade<>h1.grade);
Jordan|9
Haley|10
Kris|10
Brittany|10
Gabriel|11
John|12
Logan|12

7.For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C. (1 point possible)
select h1.name,h2.name,h3.name from highschooler h1 inner join likes l1 on h1.id=l1.id1 inner join highschooler h2 on h2.id=l1.id2 inner join highschooler h3 on h3.id=f.id2 inner join friend f on l1.id1=f.id1 inner join friend f1 on l1.id2=f1.id1 where f.id2=f1.id2 and not exists(select f.id1 from friend f inner join friend f1 on f.id1=l1.id1 and f.id2=l1.id2);
Andrew|Cassandra|Gabriel
Austin|Jordan|Andrew
Austin|Jordan|Kyle

8.Find the difference between the number of students in the school and the number of different first names. 
 select count(ID)-count(distinct name) from Highschooler;
2

9.Find the name and grade of all students who are liked by more than one other student.
select name,ID from Highschooler where ID in(select ID2 from Likes group by ID2  having count(ID2)>1);
Kris|1468
Cassandra|1709

10.For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C.
 select h1.name,h1.grade,h2.name,h2.grade,h3.name,h3.grade from Highschooler h1 inner join likes l1 on h1.id=l1.id1 inner join highschooler h2 on h2.id=l1.id2 inner join highschooler h3 on h3.id=l2.id2 inner join likes l2 on l1.id1!=l2.id2 and l1.id2=l2.id1;
Andrew|10|Cassandra|9|Gabriel|9
Gabriel|11|Alexis|11|Kris|10

11.Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades.
 select h.name,h.grade from Highschooler h where h.ID not in(select f.ID1 from Friend f inner join Highschooler h1 on h1.ID=f.ID2 and h.ID=f.ID1 where h.grade=h1.grade);
Austin|11

12.What is the average number of friends per student?
select round(avg(a)) from (select count(id2) as a,id1 from friend group by id1) ;
3.0

13.Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend.
select a+b from (select count(distinct id2) as a from friend where id1 in (select ID2 from friend f where id1=(select id from highschooler where name='Cassandra')) and id2 not in (select id from highschooler where name='Cassandra')), (select count(id2)as b from friend  where id1=(select id from highschooler where name='Cassandra'));
7


14.Find the name and grade of the student(s) with the greatest number of friends.
select h.name,h.grade,id from highschooler h inner join Friend f on h.ID=f.ID1 group by f.ID2 having count(ID2)=(select max(a) from (select count(id2) as a from friend group by id1)) ;
Alexis|11|1247
Andrew|10|1782
