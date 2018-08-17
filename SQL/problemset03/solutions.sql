problemset03 aug 17 2018
submission by j.varadharajulu@accenture.com

create table movie(mid number(4) constraint mkey primary key,title varchar2(20),year number(5),director varchar2(15));
create table reviewer(rid number(4) constraint rkey primary key,name varchar2(15));
create table rating(rid number(4) constraint rfkey references reviewer(rid),mid number(4) constraint mfkey references movie(mid),stars number(1),ratingdate date);


insert into Movie values(101, 'Gone with the Wind', 1939, 'Victor Fleming');
insert into Movie values(102, 'Star Wars', 1977, 'George Lucas');
insert into Movie values(103, 'The Sound of Music', 1965, 'Robert Wise');
insert into Movie values(104, 'E.T.', 1982, 'Steven Spielberg');
insert into Movie values(105, 'Titanic', 1997, 'James Cameron');
insert into Movie values(106, 'Snow White', 1937, null);
insert into Movie values(107, 'Avatar', 2009, 'James Cameron');
insert into Movie values(108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');

insert into Reviewer values(201, 'Sarah Martinez');
insert into Reviewer values(202, 'Daniel Lewis');
insert into Reviewer values(203, 'Brittany Harris');
insert into Reviewer values(204, 'Mike Anderson');
insert into Reviewer values(205, 'Chris Jackson');
insert into Reviewer values(206, 'Elizabeth Thomas');
insert into Reviewer values(207, 'James Cameron');
insert into Reviewer values(208, 'Ashley White');

insert into Rating values(201, 101, 2, '2011-01-22');
insert into Rating values(201, 101, 4, '2011-01-27');
insert into Rating values(202, 106, 4, null);
insert into Rating values(203, 103, 2, '2011-01-20');
insert into Rating values(203, 108, 4, '2011-01-12');
insert into Rating values(203, 108, 2, '2011-01-30');
insert into Rating values(204, 101, 3, '2011-01-09');
insert into Rating values(205, 103, 3, '2011-01-27');
insert into Rating values(205, 104, 2, '2011-01-22');
insert into Rating values(205, 108, 4, null);
insert into Rating values(206, 107, 3, '2011-01-15');
insert into Rating values(206, 106, 5, '2011-01-19');
insert into Rating values(207, 107, 5, '2011-01-20');
insert into Rating values(208, 104, 3, '2011-01-02');

1.Find the titles of all movies directed by Steven Spielberg.
 select title from movie where director='Steven Spielberg';
 E.T.
 Raiders of the Lost Ark

2.Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.
 select m.title,m.year,r.stars from movie m inner join rating r on m.mid=r.mid where stars in(4,5) order by year;
 Snow White|1937|4
 Snow White|1937|5
 Gone with the Wind|1939|4
 Raiders of the Lost Ark|1981|4
 Raiders of the Lost Ark|1981|4
 Avatar|2009|5

3.Find the titles of all movies that have no ratings.
 select title from movie where mid not in(select mid from rating);
 Star Wars
 Titanic

4.Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
 select r.name from reviewer r inner join rating ra on r.rid=ra.rid where ra.ratingdate is null;
 Daniel Lewis
 Chris Jackson

5.Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.
 select r.name,m.title,ra.stars,ra.ratingdate from rating ra inner join reviewer r on ra.rid=r.rid inner join movie m on ra.mid=m.mid order by r.name,m.title,ra.stars;
 Ashley White|E.T.|3|2011-01-02
 Brittany Harris|Raiders of the Lost Ark|2|2011-01-30
 Brittany Harris|Raiders of the Lost Ark|4|2011-01-12
 Brittany Harris|The Sound of Music|2|2011-01-20
 Chris Jackson|E.T.|2|2011-01-22
 Chris Jackson|Raiders of the Lost Ark|4|
 Chris Jackson|The Sound of Music|3|2011-01-27
 Daniel Lewis|Snow White|4|
 Elizabeth Thomas|Avatar|3|2011-01-15
 Elizabeth Thomas|Snow White|5|2011-01-19
 James Cameron|Avatar|5|2011-01-20
 Mike Anderson|Gone with the Wind|3|2011-01-09
 Sarah Martinez|Gone with the Wind|2|2011-01-22
 Sarah Martinez|Gone with the Wind|4|2011-01-27

6.For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.

7.For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.
 select m.title,max(ra.stars) from rating ra inner join movie m on ra.mid=m.mid group by m.title order by m.title;
 Avatar|5
 E.T.|3
 Gone with the Wind|4
 Raiders of the Lost Ark|4
 Snow White|5
 The Sound of Music|3

8.For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. 
 select m.title,max(ra.stars)-min(ra.stars) as ratingspread from rating ra inner join movie m on ra.mid=m.mid group by m.title order by ratingspread desc,m.title;
 Avatar|2
 Gone with the Wind|2
 Raiders of the Lost Ark|2
 E.T.|1
 Snow White|1
 The Sound of Music|1

9.Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)
 select avg(B) from(select avg(ra.stars) as B from rating ra inner join movie m on ra.mid=m.mid where m.year<1980 group by ra.mid) except  select avg(A) from(select avg(ra.stars) as A from rating ra inner join movie m on ra.mid=m.mid where m.year>1980 group by ra.mid);
 3.33333333333333

10.Find the names of all reviewers who rated Gone with the Wind.
 select distinct r.name from rating ra inner join reviewer r on ra.rid=r.rid inner join movie m on m.mid=ra.mid where m.title='Gone with the Wind';
 Sarah Martinez
 Mike Anderson

11.For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.
 select m.title,r.name,ra.stars from rating ra inner join movie m on m.mid=ra.mid inner join reviewer r on r.rid=ra.rid where m.director=r.name;
 Avatar|James Cameron|5

12.Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)
 select r.name,m.title from rating ra inner join reviewer r on ra.rid=r.rid inner join movie m on ra.mid=m.mid order by r.name,m.title;
 Ashley White|E.T.
 Brittany Harris|Raiders of the Lost Ark
 Brittany Harris|Raiders of the Lost Ark
 Brittany Harris|The Sound of Music
 Chris Jackson|E.T.
 Chris Jackson|Raiders of the Lost Ark
 Chris Jackson|The Sound of Music
 Daniel Lewis|Snow White
 Elizabeth Thomas|Avatar
 Elizabeth Thomas|Snow White
 James Cameron|Avatar
 Mike Anderson|Gone with the Wind
 Sarah Martinez|Gone with the Wind
 Sarah Martinez|Gone with the Wind

13.Find the titles of all movies not reviewed by Chris Jackson.
 select title  from movie where mid not in(select ra.mid from rating ra  inner join reviewer r on ra.rid=r.rid where r.name='Chris Jackson');
 Gone with the Wind
 Star Wars
 Titanic
 Snow White
 Avatar 

14.For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order. 

15.For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.
 select r.name,m.title,min(ra.stars) from rating ra inner join reviewer r on ra.rid=r.rid inner join movie m on ra.mid=m.mid group by m.title;
 Elizabeth Thomas|Avatar|3
 Chris Jackson|E.T.|2
 Sarah Martinez|Gone with the Wind|2
 Brittany Harris|Raiders of the Lost Ark|2
 Daniel Lewis|Snow White|4
 Brittany Harris|The Sound of Music|2

16.List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.
 select m.title,avg(ra.stars) as avgrat from rating ra inner join movie m on ra.mid=m.mid group by m.title order by avgrat desc,m.title;
 Snow White|4.5
 Avatar|4.0
 Raiders of the Lost Ark|3.33333333333333
 Gone with the Wind|3.0
 E.T.|2.5
 The Sound of Music|2.5

17.Find the names of all reviewers who have contributed three or more ratings.
 select r.name,count(ra.stars) from rating ra inner join reviewer r on ra.rid=r.rid group by ra.rid having count(ra.stars)>=3;
 Brittany Harris|3
 Chris Jackson|3

18.Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title.
 select director,title from movie where director in(select director from movie group by director having count(director)>1)order by director,title;
 James Cameron|Avatar
 James Cameron|Titanic
 Steven Spielberg|E.T.
 Steven Spielberg|Raiders of the Lost Ark

19.Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.)
 select m.title,avg(ra.stars) as aver from rating ra inner join movie m on m.mid=ra.mid group by m.title having aver>=(select avg(stars) from rating);
 Avatar|4.0
 Raiders of the Lost Ark|3.33333333333333
 Snow White|4.5

20.Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)
 select m.title,avg(ra.stars) as aver from rating ra inner join movie m on m.mid=ra.mid group by m.title having aver<=(select avg(stars) from rating);
 E.T.|2.5
 Gone with the Wind|3.0
 The Sound of Music|2.5

21.For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL.
 select m.title,m.director,max(ra.stars) from rating ra inner join movie m on ra.mid=m.mid where m.director is not null group by m.director;
 Avatar|James Cameron|5
 The Sound of Music|Robert Wise|3
 Raiders of the Lost Ark|Steven Spielberg|4
 Gone with the Wind|Victor Fleming|4 
