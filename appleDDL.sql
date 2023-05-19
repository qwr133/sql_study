create database eatingapple;
use eatingapple;

create table m_user(
user_num int(8) primary key auto_increment,
user_id varchar(50) NOT NULL unique,
user_password varchar(200) NOT NULL,
user_email VARCHAR(200) NOT null unique,
user_gender varchar(50) NOT NULL,
user_age int(3) NOT NULL,
user_point int(8) default 0,
user_grade varchar(50) default '일반'
);

insert into m_user 
(user_id, user_password, user_email, user_gender, user_age)
values ('유저1','1234','email@a.com', 'M', 15);
insert into m_user 
(user_id, user_password, user_email, user_gender, user_age)
values ('유저2','1234','1aail@a.com', 'F', 24);
insert into m_user 
(user_id, user_password, user_email, user_gender, user_age)
values ('유저3','1234','1123ail@a.com', 'M', 24);
insert into m_user 
(user_id, user_password, user_email, user_gender, user_age, user_grade)
values ('평론가1','1234','asdil@a.com', 'M', 15, '평론가');
insert into m_user 
(user_id, user_password, user_email, user_gender, user_age, user_grade) 
values ('평론가2','1234','master@a.com', 'M', 30, '평론가');

drop table m_user;

select * from m_user;


      select user_id, user_password, user_email, user_gender, user_age
      from  m_user ;
     
     alter table m_user 
add login_method VARCHAR(20);

 alter table m_user 
add profile_image VARCHAR(20);
     
update m_user 
set profile_image = concat('/local', profile_image)
where profile_image is not null 
   and login_method is null;   


create table m_rate(
rate_num int(8) primary key auto_increment,
user_num int(8), 
movie_num int(8), 
rate_review VARCHAR(2000) NOT NULL,
rate_date DATETIME DEFAULT current_timestamp,
rate_like int(8) default 0,
 CONSTRAINT fk_rate_user_num foreign key (user_num)
 references m_user(user_num),
 CONSTRAINT fk_rate_movie_num foreign key (movie_num)
 references m_movie(movie_num)
);


drop table m_rate;

select * from m_rate;


create table m_movie(
movie_num int(8) primary key auto_increment, 
movie_title varchar(80) not null,
movie_info varchar(2000) not null,
movie_runtime varchar(50) not null,
movie_director varchar(50) not null,
movie_genre varchar(500) not null,
movie_age varchar(50) not null,
movie_score int(8) default 0 
);

insert into m_movie (movie_title, movie_info, movie_runtime, movie_director, movie_genre, movie_age)
values ('영화1','정보1','1h 20m', '김감독', 'SF', '15세 이용가');
insert into m_movie (movie_title, movie_info, movie_runtime, movie_director, movie_genre, movie_age)
values ('영화2','정보2','1h 20m', 'admin', '로맨스', '19세 이용가');
insert into m_movie (movie_title, movie_info, movie_runtime, movie_director, movie_genre, movie_age)
values ('영화3','정보3','2h 20m', '홍길동', '멜로', '12세 이용가');
insert into m_movie (movie_title, movie_info, movie_runtime, movie_director, movie_genre, movie_age)
values ('영화4','정보4','5h 20m', '외국인', '다큐멘터리', '15세 이용가');
insert into m_movie (movie_title, movie_info, movie_runtime, movie_director, movie_genre, movie_age)
values ('영화5','정보5','1h 20m', 'kris', 'SF', '19세 이용가');

drop table m_movie;

select * from m_movie;
alter table m_movie add movie_score int(8) default 0;

create table m_img(
img_num int(8) primary key auto_increment,
movie_num int(8),
img_name varchar(50) not null,
img_url varchar(80) not null,
constraint fk_movie_img foreign key (movie_num) 
references m_movie(movie_num)

);

drop table m_img;

select * from m_img;


create table m_interest(
interest_num int(8) primary key auto_increment,
movie_num int(8) not null,
user_num int(8) not null, 
 CONSTRAINT fk_interest_movie_num foreign key (movie_num)
 references m_movie(movie_num),
 CONSTRAINT fk_interest_user_num foreign key (user_num)
 references m_user(user_num)
);

insert into m_interest (interest_num , movie_num , user_num)
values ('1','2','2');

drop table m_interest;

select * from m_interest;


create table m_like(
like_num int(8) primary key auto_increment,
user_num int(8) not null,
rate_num int(8) not null,
 CONSTRAINT fk_like_user_num foreign key (user_num)
 references m_user(user_num),
 CONSTRAINT fk_like_rate_num foreign key (rate_num)
 references m_rate(rate_num)
);

drop table m_like;

select * from m_like;

SET foreign_key_checks = 0;    # 외래키 체크 설정 해제


update m_user 
set user_gender = 'FEMALE'
where user_gender = 'F';

       SELECT mu.user_num, mu.user_id, mu.user_point, mu.user_grade,
        mm.movie_num, mm.movie_title, mr.rate_review
        FROM m_user mu
        JOIN m_rate mr ON mu.user_num = mr.user_num
        JOIN m_movie mm ON mr.movie_num = mm.movie_num
        where mu.user_id = #{userId};
