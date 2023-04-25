--트랜젝션
CREATE TABLE employees (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    salary NUMBER(8,2)
);

DROP TABLE EMPLOYEES;

INSERT INTO employees VALUES (1, 'Alice', 5000);
INSERT INTO employees VALUES (2, 'Bob', 6000);
INSERT INTO employees VALUES (3, 'Charlie', 7000);

--급여 총합 조회
SELECT sum(SALARY) FROM EMPLOYEES

COMMIT; --변경사항을 완전히 db에 반영  -- COMMIT  후 값 추가한 후 롤백 해야함

--트랜잭션 시작
BEGIN
	--모든 사원들의 급여를 1000씩 올려줄 것이다
	UPDATE EMPLOYEES 
	SET SALARY = SALARY +1000;

	ROLLBACK; --뒤로가기 COMMIT 전에는 언제든지 ROLLBACK 가능(커밋이후에는 불가) -- 이전단계가 아니라 이전에 한 커밋 단계로 돌아감
	END;

--where 조건절
SELECT 
	EMP_NO , EMP_NM , ADDR , SEX_CD 
FROM TB_EMP
WHERE SEX_CD =2;

--whwew절로 pk 동등조건을 걸면
--무조건 단일행이 조회된다.
SELECT 
	EMP_NO , EMP_NM , ADDR , SEX_CD 
FROM TB_EMP
WHERE EMP_NO = 1000000003

--비교연산자
SELECT 
EMP_NO , EMP_NM , BIRTH_DE , TEL_NO 
FROM TB_EMP 
WHERE BIRTH_DE >= '19900101' AND BIRTH_DE <='19991231'


--BETWEEN 연산자
SELECT 
EMP_NO , EMP_NM , BIRTH_DE , TEL_NO 
FROM TB_EMP 
WHERE BIRTH_DE BETWEEN '19900101' AND '19991231'


--or 연산
SELECT 
EMP_NO , EMP_NM , DEPT_CD
FROM	TB_EMP 
WHERE DEPT_CD = '100004'
OR DEPT_CD = '100006'

-- in 연산 -- or대체 가능
SELECT 
EMP_NO , EMP_NM , DEPT_CD
FROM	TB_EMP 
WHERE DEPT_CD in('100004', '100006') 

--in 부정
SELECT 
EMP_NO , EMP_NM , DEPT_CD
FROM	TB_EMP 
WHERE DEPT_CD NOT in('100004', '100006') 

--like 연산자
--검색에서 주로 사용
--와일드 카드 매핑 (%:0글자 이상,  _ : 딱 1글자 )
SELECT 
emp_NO, emp_NM
FROM TB_EMP 
WHERE EMP_NM LIKE '%심' --심으로 끝나는것

SELECT 
emp_NO, emp_NM, addr
FROM TB_EMP 
WHERE addr LIKE '%용인%'

--성씨가 김씨면서 부서가 100003, 100004, 100006번 중에 하나이면서,
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드 조회
SELECT emp_no, emp_nm, BIRTH_DE, DEPT_CD
FROM TB_EMP 
WHERE emp_nm LIKE '김%' AND DEPT_CD IN ('100003', '100004', '100006') AND 
	BIRTH_DE BETWEEN '19900101' AND '19991231'
	
	
SELECT 
emp_NO, emp_NM
FROM TB_EMP 
WHERE EMP_NM LIKE '이__ --'_비% --두번쨰 글자가 비로 시작하는 사람'

--부정일치 비교연산자
SELECT emp_no, emp_nm, addr, sex_cd
FROM TB_EMP 
WHERE SEX_CD !=2 --!=, ^=, <>

--성별코드가 1이 아니면서 성씨가 이씨가 아닌 사람들의 사번 이름 성별코드를 조회하세요
SELECT 
emp_no, emp_nm, sex_cd
FROM TB_EMP 
WHERE 1=1
AND SEX_CD <> 1 
AND emp_nm NOT like '이%'

--null 값 조회
-- 반드시 is null 연산자로 조회해야한다
SELECT 
emp_no, emp_nm, Direct_manager_emp_no
FROM TB_EMP 
WHERE DIRECT_MANAGER_EMP_NO IS NULL --(= null은 값이 안나옴) 부정문은 IS NOT NULL 


--연산자 우선순위
--not > and > OR  (and가 or 보다 쎼다)
SELECT emp_no, emp_nm, addr
FROM TB_EMP 
WHERE 1=1
AND emp_nm LIKE '김%'
AND (ADDR LIKE '%수원%' OR addr LIKE '%일산%')





create table example(
	employee_id varchar(50) NOT null, 
	first_name VARCHAR(50) not null,
	last_name VARCHAR(50) not null,
	email VARCHAR(50) not null,
	salary number(8,2)

);
DROP TABLE	example
 
-- 트랜잭션 시작
BEGIN;

-- 테이블에 데이터를 삽입
INSERT INTO employees (employee_id, first_name, last_name, salary)
VALUES (301, 'John', 'Doe', 5000);

-- 테이블에서 데이터를 갱신
UPDATE employees SET salary = 6000 WHERE employee_id = 301;

-- 저장점 설정
SAVEPOINT before_delete;

-- 테이블에서 데이터를 삭제
DELETE FROM employees WHERE employee_id = 301;

-- 저장점 이전 상태로 롤백
ROLLBACK TO SAVEPOINT before_delete;

-- 트랜잭션 종료
COMMIT;