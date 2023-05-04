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
