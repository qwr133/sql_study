create database eatingapple;

create table m_user(
user_num int(10) primary key auto_increment,
userid varchar(50) NOT NULL unique,
password varchar(150) NOT NULL,
email VARCHAR(100) NOT NULL,
gender varchar(50) NOT NULL,
age int(3) NOT NULL,
point int(10) NOT NULL,
grade varchar(50) NOT NULL,
movie_num int(10),
CONSTRAINT fk_user_movie_num foreign key (movie_num)
references m_movie(movie_num)
);

drop table m_user;

select * from m_user;


create table m_rate(
rate_num int(10) primary key auto_increment,
user_num int(10) , 
movie_num int(10), 
rate_review VARCHAR(2000) NOT NULL,
rate_score int(10) default 0,
rate_date DATETIME DEFAULT current_timestamp,
rate_like int(10) default 0,
CONSTRAINT fk_rate_user_num foreign key (user_num)
references m_user(user_num),
CONSTRAINT fk_rate_movie_num foreign key (movie_num)
references m_movie(movie_num)
);

drop table m_rate;

select * from m_rate;


create table m_movie(
movie_num int(10) primary key auto_increment, 
movie_title varchar(80) not null,
movie_info varchar(2000) not null,
movie_img_num int(10),
movie_runtime varchar(50) not null,
movie_director varchar(50) not null,
movie_genre varchar(50) not null,
movie_age varchar(50) not null, 
CONSTRAINT fk_movie_movie_img_num foreign key (movie_img_num)
references m_img(img_num)
);

drop table m_movie;

select * from m_movie;


create table m_img(
img_num int(10) primary key auto_increment,
img_name varchar(50) not null,
img_url varchar(80) not null
);

drop table m_img;

select * from m_img;


create table m_interest(
interest_num int(10) primary key auto_increment,
movie_num int(10) not null,
user_num int(10) not null, 
CONSTRAINT fk_interest_movie_num foreign key (movie_num)
references m_movie(movie_num),
CONSTRAINT fk_interest_user_num foreign key (user_num)
references m_user(user_num)
);

drop table m_interest;

select * from m_interest;


create table m_like(
like_num int(10) primary key auto_increment,
user_num int(10) not null,
rate_num int(10) not null,
CONSTRAINT fk_like_user_num foreign key (user_num)
references m_user(user_num),
CONSTRAINT fk_like_rate_num foreign key (rate_num)
references m_rate(rate_num)
);

drop table m_like;

select * from m_like;

SET foreign_key_checks = 0;    # 외래키 체크 설정 해제
