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



       SELECT COUNT(*)
        FROM tbl_board
