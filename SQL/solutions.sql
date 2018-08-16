problemset02 aug 16
submitted by j.varadharajulu@accenture.com

1.Write a valid SQL statement that calculates the total weight of all corn cobs that were picked from the garden:
 select sum(pi.weight) from picked pi inner join plant p on pi.plantFK=p.plantid where p.name='Corn';
 17.54
2.For some reason Erin has change his location for picking the tomato to North. Write the corresponding query.
 update picked set locationFK=(select locationid from location where name='North') where gardenerFK=(select gardenerid from  gardener where name='Erin') and plantFK=(select plantid from plant where name='Tomato');
3.Insert a new column 'Exper' of type Number (30) to the 'gardener' table which stores Experience of the of person. How will you modify this to varchar2(30).
 alter table gardener add Exper number(30);
4.Write a query to find the plant name which required seeds less than 20 which plant on 14-APR
 select p.name from plant p inner join planted pd on p.plantid=pd.plantFK where seeds<20 and date='14-APR-2012';
5.List the amount of sunlight and water to all plants with names that start with letter 'c' or letter 'r'.
 select name,sunlight,water from plant where name like 'C%' or name like 'R%';
 Carrot|0.26|0.82
 Corn|0.44|0.76
 Radish|0.28|0.84
6.Write a valid SQL statement that displays the plant name and the total amount of seed required for each plant that were plant in the garden. The output should be in descending order of plant name.
 select p.name,pd.seeds from planted pd inner join plant p on pd.plantFK=p.plantid order by p.name desc;
 Tomato|38
 Radish|30
 Lettuce|30
 Corn|32
 Carrot|42
 Beet|36
7.Write a valid SQL statement that calculates the average number of items produced per seed planted for each plant type:( (Average Number of Items = Total Amount Picked / Total Seeds Planted.)
 select p.name,sum(pi.amount)/sum(pd.seeds) as average from picked pi inner join planted pd on pi.plantFK=pd.plantFK inner  join plant p on p.plantid=pi.plantFK group by p.name;
8.Write a valid SQL statement that would produce a result set like the following:

 name |  name  |    date    | amount 
------|--------|------------|-------- 
 Tim  | Radish | 2012-07-16 |     23 
 Tim  | Carrot | 2012-08-18 |     28 
 select g.name,p.name,pi.date1,pi.amount from picked pi inner join gardener g on pi.gardenerFK=g.gardenerid inner join  plant p on pi.plantFK=p.plantid where p.name='Tim' and amount>20 order by amount;
9.Find out persons who picked from the same location as he/she planted.
 select g.name from gardener g inner join planted pd on pd.gardenerFK=g.gardenerid inner join picked pi on  pi.plantFK=pd.plantFK where pi.locationFK=pd.locationFK;




