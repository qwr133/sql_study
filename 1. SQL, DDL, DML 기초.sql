SELECT * FROM TB_EMP;

--테이블(엔터티) 생성
-- 성적정보 저장 테이블

CREATE TABLE tbl_score(
	name varchar2(4) NOT NULL,
	kor number(3) NOT NULL check(kor>0 AND kor<=100),
	eng number(3) NOT NULL check(eng>0 AND eng<=100),	
	math number(3) NOT NULL check(math>0 AND math<=100),	
	total number(3) NULL,
	average number(5, 2),
	grade char(1),
	stu_num number(6),
	--pk 거는법 --table 생성시 거는 법
	CONSTRAINT pk_stu_num
	PRIMARY key(stu_num)

);

--테이블 생성 후 pk 적용하기
ALTER TABLE TBL_SCORE
ADD CONSTRAINT pk_stu_num
	PRIMARY key(stu_num)
	
--킬럼 추가하기
ALTER TABLE 
	TBL_SCORE 
	add(sci NUMBER(3) NOT NULL);

-- 칼럼 제거하기
ALTER TABLE
 TBL_SCORE 
 DROP COLUMN sci;
 

-- 테이블 복사 (tb_emp)
-- CTAS 
CREATE TABLE TB_EMP_copy
AS SELECT * FROM TB_EMP;

--복사 테이블 조회
SELECT * FROM tb_emp_copy;

--drop table
DROP TABLE TB_EMP_COPY;

--TRUNCATE table //drop 보다 살짝 약한 개념, 하지만 사용하면 안됨
-- 구조는 그대로, 내부 데이터만 전체삭제 (롤백안됨)
TRUNCATE TABLE tb_emp_copy;



--예시 테이블
CREATE TABLE goods(
	id NUMBER(6) PRIMARY KEY,
	g_name varchar2(10) NOT NULL,
	price number(10) DEFAULT 1000,
	reg_date date
);

SELECT  * FROM goods;

-- INSERT 
INSERT INTO goods
	(id, g_name, price, reg_date)
	values(1, '선풍기', '120000', sysdate
);

INSERT INTO goods
	(id, G_NAME, reg_date)
	values(2, '냉장고', sysdate
);


INSERT INTO goods
	(id, G_NAME, PRICE)
	values(3, '허니칩', 1500
);

--컬렁명 생략 시 모든 컬럼에 대해 순서대로 넣어야함 -- 사용하지 않기 
INSERT INTO goods
	values(4, '새콤달콤', 700
);


INSERT INTO goods
	(id, G_NAME, PRICE)
	values(5, '허니칩', '2300'),
	values(6, '오사쯔', '2500'),
	values(7, '포토테칩', '1800'),
);

--수정 UPDATE 
UPDATE goods 
SET g_name = '스피커'
WHERE id= 2;

-- 한 행 삭제 DELETE 
UPDATE FROM goods
WHERE id = 3
;

--모든 행 삭제
DELETE FROM goods;


SELECT * FROM goods;




--select 조회
SELECT
	CERTI_CD 
	, CERTI_NM 
	, ISSUE_INSTI_NM 
FROM TB_CERTI 

--all은 생략 가능
SELECT ALL
ISSUE_INSTI_NM
FROM TB_CERTI ;

--중복제거 distinct
SELECT DISTINCT 
ISSUE_INSTI_NM
FROM TB_CERTI 

--모든칼럼조회
-- 실무에서는 사용하지 마세요
SELECT * FROM TB_CERTI; 

--SELECT 열 별칭 부여 (alias) - 띄어쓰기 시 쌍따옴표 필요/ 이름, 주소 만 적을 시 그냥 문자만 / as는 생략 가능
SELECT 
emp_NM AS "사원이름",
ADDR AS "사원이 거주지 주소"
FROM TB_EMP;

--문자열 연결하기 (합쳐서 하나의 열로 보여주기) + 대신 || 으로 작성하기
SELECT 
certi_NM || '('|| ISSUE_INSTI_NM || ')'	 AS "자격증 정보"
FROM TB_CERTI ;