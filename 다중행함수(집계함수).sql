

SELECT * FROM TB_SAL_HIS 


-- 집계 함수 (다중행 함수)
-- : 여러 행을 묶어서 함수를 적용
SELECT * FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
ORDER BY emp_no, pay_de
;

SELECT * FROM tb_sal_his
WHERE emp_no = '1000000005'
;

--단일행 함수 -- 각각의 행마다 substr를 집계하기 때문에 41건이 나옴
SELECT
    SUBSTR(emp_nm, 1, 1) 성씨   --SUBSTR("문자열", "시작위치", "길이")
FROM tb_emp
;


-- GROUP BY로 소그룹화 하지 않으면 집계함수는 전체행수를 기준으로 집계한다.
SELECT 
    SUM(pay_amt) "지급 총액"
    , AVG(pay_amt) "평균 지급액"
    , COUNT(pay_amt) "지급 횟수"
FROM tb_sal_his
;

SELECT * FROM tb_emp;

SELECT 
    COUNT(emp_no) AS "총 사원수"
    , COUNT(direct_manager_emp_no) "dmen" --count에서 특정 null은 값이 들어가지 않기 때문에 40건으로 나옴 근데 SELECT ~ FROM tb_emp하면 NULL 값도 카운팅 됨
    , COUNT(*) --만약 2개값이 NULL 이면 39개를 나눔 (null은 아예 포함해주지 않음) == count * 빼고
    , MIN(birth_de) "최연장자의 생일"
    , MAX(birth_de) "최연소자의 생일"    
FROM tb_emp;


SELECT 
    direct_manager_emp_no
FROM tb_emp;


-- GROUP BY : 지정된 컬럼으로 소그룹화 한 후 집계함수 적용
-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일 부서별 총 사원 수를 조회

SELECT EMP_NO ,
		EMP_NM ,
		BIRTH_DE ,
		DEPT_CD 
FROM tb_emp
ORDER BY dept_cd
;

SELECT 
    dept_cd
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd
;


-- 사원별 누적 급여수령액 조회
SELECT *
FROM TB_SAL_HIS
ORDER BY EMP_NO , PAY_DE ;

SELECT SUM(pay_amt)
FROM TB_SAL_HIS ;


SELECT 
    emp_no "사번"
    , SUM(pay_amt) "누적 수령액"
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;

-- 사원별로 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
    -- , ROUND(pay_amt, 2)
FROM tb_sal_his
GROUP BY emp_no --사원별로 그룹묶기
ORDER BY emp_no
;

SELECT 
--	EMP_NO ,
	DEPT_CD 
FROM TB_EMP
GROUP BY DEPT_CD ;
-- group by로 묶은 dept는 14개 나오고, emp_no는 41개가 나오기 때문에 에러 발생
		--하지만 앞에 max, min인 경우는 코드가 진행되는 경우가 있음
		--grounpby에 해당되지 않은 컬럼을 select에 입력했을 시에 오류가 발생됨
		--에러발생이 안나게하려면 그룹바이를 여러개 입력해야함 

-- 사원별로 2019년에 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
--group by절에 있는 where 절은 그룹하 하기 전에 필터링
SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') "연봉"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;

-- HAVING : 그룹화된 결과에서 조건을 걸어 행 수를 제한
-- 그룹화해서 통계낸 이후에 필터링 

-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일, 부서별 총 사원 수를 조회
-- 그런데 부서별 사원이 1명인 부서의 정보는 조회하고 싶지 않음.
SELECT 
    dept_cd
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(emp_no) > 1
ORDER BY dept_cd
;


-- 사원별로 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
-- 평균 급여가 450만원 이상인 사람만 조회
SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

-- 사원별로 2019년 월평균 수령액이 450만원 이상인 사원의 사원번호와 2019년 연봉 조회
SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
;

-- 그룹화 대상 칼럼이 2개 이상인 경우
SELECT 
    emp_no
    , sex_cd
    , dept_cd
FROM tb_emp
ORDER BY dept_cd, sex_cd
;


SELECT 
    dept_cd
    , COUNT(*)
FROM tb_emp
GROUP BY dept_cd, sex_cd
ORDER BY dept_cd
;


-- ORDER BY : 정렬
-- ASC : 오름차 정렬 (기본값), DESC : 내림차 정렬
-- 항상 SELECT절의 맨 마지막에 위치

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_no DESC
;

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm DESC
;

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd ASC, emp_nm DESC --부서코드로 정렬하고 이후에 부서코드가 같으면 이름은 내림차
;


SELECT 
    emp_no AS 사번
    , emp_nm AS 이름
    , addr AS 주소
FROM tb_emp
ORDER BY 이름 DESC
;

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, 1 DESC --부서코드를 먼저 오름차 하고 , 부서명을 내림차 한다
;


SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, emp_no DESC
;

SELECT emp_no AS 사번, emp_nm AS 이름, addr AS 주소
FROM tb_emp
ORDER BY 이름, 1 DESC
;

SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;