
create database spring;
use spring; --우클릭 default 해놓으면 use spring 안해도됨

-- --auto_increment : mysql, maridb의 방언
-- 오라클의 시퀀스 기능 자동으로 첫번째 인서트데이트 1
-- 순차적으로 1씩 증가하는 데이터를 자동으로 삽입
create table person(
	id int(10) auto_increment, 
	person_name VARCHAR(50) not null,
	person_age int(3),
	constraint pk_person_id
	primary key(id)
);


select * from person;

