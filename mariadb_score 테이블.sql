create table tbl_score(
	name varchar(30) not null,
	kor int(3) not null ,
	eng int(3) not null,
	math int(3) not null,
	stu_num int(10) auto_increment,
	total int(3),
	average Float(5, 2), 
	grade char(1),
	constraint pr_stu_num
	primary key (stu_num)
);

select * from tbl_score;


create table tbl_board (
   board_no int(10) auto_increment primary key,
   title VARCHAR(80) not null,
-- --varchar(4000) -> 약 1200자 정도, 논문 그 이상은 clob으로 (용량차지up)   
   content VARCHAR(2000),
   view_count int(10) default 0,
   reg_date_time DATETIME default current_timestamp
);

select * from tbl_board;


  INSERT INTO tbl_board
         (title, content)
        values ('zzzzz', 'ㄴㄴㄴㄴㄴㄴㄴㄴ')  
        
        
update tbl_board 
set view_count = view_count +1 
where board_no=3;

update tbl_score 
set title = ${title},
	content = ${content},
where board_no = ${boardNo}


-- --최신글 10개 가져와
select *
from tbl_board
order by board_no desc
-- --index, 양
limit 0, 10 

;

       SELECT COUNT(*)
        FROM tbl_board;
        
select *
from tbl_board 
-- --검색기능 추가
where title like concat('%', '30','%') 
or content like '%30'
order by board_no desc 
limit 0, 6 
-- 1페이지 보여줘, 6,12 2페이지 보여줘
;



-- 회원 관리 테이블
CREATE TABLE tbl_member (
    account VARCHAR(50),
    password VARCHAR(150) NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    auth VARCHAR(20) DEFAULT 'COMMON',
    reg_date DATETIME DEFAULT current_timestamp,
    CONSTRAINT pk_member PRIMARY KEY (account)
);

insert into tbl_member 
(account, password, name, email)
values ('banana', 'bbb1234', '김바나나', 'aaa@bbb.com')
;

select count(*)
from tbl_member
where account = 'banana';

select *
from tbl_member;

-- 휴지통 비우기
truncate table tbl_member;

select *
from tbl_board 
where account = 'abc123';

create table tbl_reply(
	reply_no INT(10) auto_increment,
	reply_text VARCHAR(1000) not null,
	reply_writer VARCHAR(100) not null,
	reply_date DATETIME default current_timestamp,
	board_no int(10),
-- 1대 다 관계로 게시글 번호가 필수적으로 필요함 (PK)
	constraint pk_reply primary key (reply_no),
	constraint fk_reply
	foreign key (board_no)
	references tbl_board(board_no)
-- 	글 삭제하면 댓글도 다 삭제됨, 이거 없으면 댓글 있으면 게시물 다 삭제됨
-- 	--실무적으론 백업테이블에 넣어두고, 삭제하는 방식으로 하게 됨 - 조심해야함
	on delete cascade
);


create table tbl_reply (
   reply_no INT(10) auto_increment,
   reply_text VARCHAR(1000) not null,
   reply_writer VARCHAR(100) not null,
   reply_date DATETIME default current_timestamp,
   board_no INT(10),
   constraint pk_reply primary key (reply_no),
   constraint fk_reply 
   foreign key (board_no)
   references tbl_board (board_no)
   on delete cascade
);

drop table tbl_reply;

truncate table tbl_board; 

select * from tbl_board;
select * from tbl_reply;
-- 1
drop table tbl_reply  ;
-- 2 - 3>create table
truncate table tbl_board ;

select * from tbl_board;
select * from tbl_reply
where board_no=298;

-- --제목에 30이 있거나, 내용에도 30 있는 것들을 보여줘
select *
from tbl_board
where title like '%30%'
or content like '%30%'
order by board_no desc 
limit 0,6;
;

select *
from tbl_reply 
where board_no=45
;


-- 게시글에 회원 계정명을 FK로 추가
alter table tbl_board 
add account VARCHAR(50) not null;

alter table tbl_board 
add constraint fk_account 
foreign key (account) 
references tbl_member (account);

select * from tbl_board;
select * from tbl_member;

update tbl_member 
set auth = 'ADMIN'
where account = 'abc123';

update tbl_board 
set account = 'abc123';

select * from tbl_member;

alter table tbl_member 
add profile_image VARCHAR(200);

alter table tbl_reply 
add account VARCHAR(50) not null;

select * from tbl_reply tr ;
update tbl_reply
set account = 'abc123';
;

select A.reply_no , A.reply_text , A.account , B.profile_image 
from tbl_reply A
join tbl_member B  on A.account = B.account 
where board_no=305
;

alter table tbl_member 
add login_method VARCHAR(20);

select * from tbl_member tm ;

update tbl_member 
set profile_image = concat('/local', profile_image)
where profile_image is not null 
   and login_method is null;

