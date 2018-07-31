ProblemSet01 July 31 2018
submission by j.varadharajulu@accenture.com

create table Hotel(Hotel_No varchar2(5) constraint hkey primary key,Name varchar2(15),City varchar2(15));
create table Room(Room_No  number(5) constraint rkey primary key,Hotel_No varchar2(5) constraint hfkey references Hotel(Hotel_No),Type varchar2(2),Price double(5,2));
create table Guest(Guest_No varchar2(5) constraint gkey primary key,Name varchar2(15),City varchar2(15));
create table Booking(Hotel_No varchar2(5) constraint hf1key references Room(Hotel_No),Guest_No  varchar2(5) constraint gfkey references Guest(Guest_No),Date_From date,Date_To date,Room_No number(5) constraint rfkey references Room(Room_No));

insert into Hotel values('H111','Empire Hotel','New York');
insert into Hotel values('H235','Park Place','New York');
insert into Hotel values('H432','Brownstone Hotel','Toronto');
insert into Hotel values('H498','James Plaza','Toronto');
insert into Hotel values('H193','Devon Hotel','Boston');
insert into Hotel values('H437','Clairmont Hotel','Boston');

insert into Room values(313,'H111','S',145.00);
insert into Room values(412,'H111','N',145.00);
insert into Room values(1267,'H235','N',175.00);
insert into Room values(1289,'H235','N',195.00);
insert into Room values(876,'H432','S',124.00);
insert into Room values(898,'H432','S',124.00);
insert into Room values(345,'H498','N',160.00);
insert into Room values(467,'H498','N',180.00);
insert into Room values(1001,'H193','S',150.00);
insert into Room values(1201,'H193','N',175.00);
insert into Room values(257,'H437','N',140.00);
insert into Room values(223,'H437','N',155.00);

insert into Guest values('G256','Adam Wayne','Pittsburgh');
insert into Guest values('G367','Tara Cummings','Baltimore');
insert into Guest values('G879','Vanessa Parry','Pittsburgh');
insert into Guest values('G230','Tom Hancock','Philadelphia');
insert into Guest values('G467','Robert Swift','Atlanta');
insert into Guest values('G190','Edward Cane','Baltimore');

insert into Booking values('H111','G256','1999-08-10','1999-08-15',412);
insert into Booking values('H111','G367','1999-08-18','1999-08-21',412);
insert into Booking values('H235','G879','1999-09-05','1999-09-12',1267);
insert into Booking values('H498','G230','1999-09-15','1999-09-18',467);
insert into Booking values('H498','G256','1999-11-31','1999-12-02',345);
insert into Booking values('H498','G467','1999-11-03','1999-11-05',345);
insert into Booking values('H193','G190','1999-11-15','1999-11-19',1001);
insert into Booking values('H193','G367','1999-09-12','1999-09-14',1001);
insert into Booking values('H193','G367','1999-10-01','1999-10-06',1201);
insert into Booking values('H437','G190','1999-10-04','1999-10-06',223);
insert into Booking values('H437','G879','1999-09-14','1999-09-17',223);

1.List full details of all hotels.
select * from Hotel h inner join Room r on h.Hotel_No=r.Hotel_No;
H111|Empire Hotel|New York|313|H111|S|145.0
H111|Empire Hotel|New York|412|H111|N|145.0
H235|Park Place|New York|1267|H235|N|175.0
H235|Park Place|New York|1289|H235|N|195.0
H432|Brownstone Hotel|Toronto|876|H432|S|124.0
H432|Brownstone Hotel|Toronto|898|H432|S|124.0
H498|James Plaza|Toronto|345|H498|N|160.0
H498|James Plaza|Toronto|467|H498|N|180.0
H193|Devon Hotel|Boston|1001|H193|S|150.0
H193|Devon Hotel|Boston|1201|H193|N|175.0
H437|Clairmont Hotel|Boston|257|H437|N|140.0
H437|Clairmont Hotel|Boston|223|H437|N|155.0

2.select * from Hotel h inner join Room r on h.Hotel_No=r.Hotel_No where h.City='New York';
H111|Empire Hotel|New York|313|H111|S|145.0
H111|Empire Hotel|New York|412|H111|N|145.0
H235|Park Place|New York|1267|H235|N|175.0
H235|Park Place|New York|1289|H235|N|195.0

3.List the names and cities of all guests, ordered according to their cities.
select Name,City from Guest order by City;
Robert Swift|Atlanta
Tara Cummings|Baltimore
Edward Cane|Baltimore
Tom Hancock|Philadelphia
Adam Wayne|Pittsburgh
Vanessa Parry|Pittsburgh

4.List all details for non-smoking rooms in ascending order of price.
select * from Room where Type='N' order by Price;
257|H437|N|140.0
412|H111|N|145.0
223|H437|N|155.0
345|H498|N|160.0
1267|H235|N|175.0
1201|H193|N|175.0
467|H498|N|180.0
1289|H235|N|195.0

5.List the number of hotels there are.
select count(*) from Hotel;
6

6.List the cities in which guests live. Each city should be listed only once.
select distinct City from Guest; 
Pittsburgh
Baltimore
Philadelphia
Atlanta

7.List the average price of a room.
select Hotel_No,avg(Price) from Room group by Hotel_No;
H111|145.0
H193|162.5
H235|185.0
H432|124.0
H437|147.5
H498|170.0

8.List hotel names, their room numbers, and the type of that room.
select h.Name,r.Room_No,r.Type from Hotel h inner join Room r on h.Hotel_No=r.Hotel_No;
Empire Hotel|313|S
Empire Hotel|412|N
Park Place|1267|N
Park Place|1289|N
Brownstone Hotel|876|S
Brownstone Hotel|898|S
James Plaza|345|N
James Plaza|467|N
Devon Hotel|1001|S
Devon Hotel|1201|N
Clairmont Hotel|257|N
Clairmont Hotel|223|N

9.List the hotel names, booking dates, and room numbers for all hotels in New York.
select h.Name,b.Date_From,b.Room_No from Hotel h inner join Booking b on h.Hotel_No=b.Hotel_No where City='New York';
Empire Hotel|1999-08-10|412
Empire Hotel|1999-08-18|412
Park Place|1999-09-05|1267

10.What is the number of bookings that started in the month of September?
select count(*) from Booking where Date_From >= '1999-09-01' and Date_From <='1999-09-30';
4

11.List the names and cities of guests who began a stay in New York in August.
 select g.Name,g.City from Guest g inner join Booking b on g.Guest_No=b.Guest_No where b.Hotel_No in (select Hotel_No from Hotel where City='New York') and b.Date_From between '1999-08-01' and '1999-08-31';
Adam Wayne|Pittsburgh
Tara Cummings|Baltimore

12.List the hotel names and room numbers of any hotel rooms that have not been booked.
select h.Name,r.Room_No from Hotel h inner join Room r on h.Hotel_No=r.Hotel_No where r.Room_No not in(select Room_No from Booking);
Empire Hotel|313
Park Place|1289
Brownstone Hotel|876
Brownstone Hotel|898
Clairmont Hotel|257

13.List the hotel name and city of the hotel with the highest priced room.
select h.Name,h.City from Hotel h inner join Room r on h.Hotel_No=r.Hotel_no where r.Price in(select max(Price) from Room);
Park Place|New York

14.List hotel names, room numbers, cities, and prices for hotels that have rooms with prices lower than the lowest priced room in a Boston hotel.
select h.Name,r.Room_No,h.City,r.Price from hotel h inner join room r on h.Hotel_No=r.Hotel_No where r.price <(select min(r.Price) from Room r inner join Hotel h on h.hotel_No=r.Hotel_No where City='Boston');
Brownstone Hotel|876|Toronto|124.0
Brownstone Hotel|898|Toronto|124.0

15.List the average price of a room grouped by city.
select avg(r.price) from Room r inner join Hotel h on r.Hotel_No=h.Hotel_No group by h.City;
155.0
165.0
147.0
