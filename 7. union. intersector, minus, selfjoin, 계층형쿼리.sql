-- 집합 연산자
-- ## UNION -- 자동정렬, 자동중복삭제
-- 1. 합집합 연산의 의미입니다.
-- 2. 첫번째 쿼리와 두번째 쿼리의 중복정보는 한번만 보여줍니다.
-- 3. 첫번째 쿼리의 열의 개수와 타입이 두번째 쿼리의 열수와 타입과 동일해야 함.
-- 4. 자동으로 정렬이 일어남 (첫번째 컬럼 오름차가 기본값)

SELECT 
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT 
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;


SELECT 
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT 
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;

--위에있는 EN, BD 로만 나옴 EN2, BD2는 출력되지 않음
SELECT 
    emp_nm EN, birth_de BD
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT 
    emp_nm EN2, birth_de BD2
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
ORDER BY BD DESC
;


-- ## UNION ALL -- 중복제거가 되지않음, 실무에서는 union all로 조회하게됨
-- 1. UNION과 같이 두 테이블로 수직으로 합쳐서 보여줍니다.
-- 2. UNION과는 달리 중복된 데이터도 한번 더 보여줍니다.
-- 3. 자동 정렬 기능을 지원하지 않아 성능상 유리합니다.

SELECT 
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT 
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;

SELECT 
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT 
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231'
;

-- ## INTERSECT -- 교집합
-- 1. 첫번째 쿼리와 두번째 쿼리에서 중복된 행만을 출력합니다.
-- 2. 교집합의 의미입니다.
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE C.certi_nm = 'SQLD'
INTERSECT
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%';

--위 intersaction 대신 간단하게 쓰는 방법
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%'
    AND C.certi_nm = 'SQLD'
;

-- ## MINUS(EXCEPT) 오라클은 마이너스, sql에서는 except
-- 1. 두번째 쿼리에는 없고 첫번째 쿼리에만 있는 데이터를 보여줍니다.
-- 2. 차집합의 개념입니다.

SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE dept_cd = '100004'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd FROM tb_emp WHERE sex_cd = '1'
;


-- 계층형 쿼리 -- self조인이랑 연계됨
-- START WITH : 계층의 첫 단계를 어디서 시작할 것인지의 대한 조건
-- CONNECT BY PRIOR 자식 = 부모  -> 순방향 탐색
-- CONNECT BY 자식 = PRIOR 부모  -> 역방향 탐색
-- ORDER SIBLINGS BY : 같은 레벨끼리의 정렬을 정함.
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL -- 어디서부터 시작해서 내려갈지 정하는것
--START WITH A.emp_no = '1000000002' --바꾸면서 확인해보기
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no --김회장부터 아래로 내려가면 순방향전개 = 자식쪽에 붙으면 순방향 본문대로, 
			-- 말단직원부터 올라가는거면 역방향전개 = 부모쪽에 붙으면 역방향 -> connect by A.emp_no= prior A.DIRECT_MANAGER_EMP_NO  (prior위치에 따라 방향이 다름)
ORDER SIBLINGS BY A.emp_no DESC
;




SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    a.direct_manager_emp_no
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.emp_no = '1000000037'
CONNECT BY A.emp_no = PRIOR A.direct_manager_emp_no;


-- # SELF JOIN
-- 1. 하나의 테이블에서 자기 자신의 테이블끼리 조인하는 기법입니다.
-- 2. 자기 자신 테이블에서 pk와 fk로 동등조인합니다.

SELECT 
    A.emp_no
    , A.emp_nm "사원명"
    , A.addr "사원 주소"
    , A.direct_manager_emp_no
    , B.emp_nm "직속 상사 사원명"
    , B.addr "직속 상사 주소"
FROM tb_emp A
LEFT JOIN tb_emp B
ON A.direct_manager_emp_no = B.emp_no
ORDER BY A.emp_no
;

SELECT * FROM TB_EMP 
;


SELECT 
    A.emp_no, A.emp_nm, A.direct_manager_emp_no
FROM tb_emp A
ORDER BY A.emp_no
;

SELECT 
    B.emp_no, B.emp_nm, B.direct_manager_emp_no
FROM tb_emp B
ORDER BY B.emp_no
;

ALTER TABLE tb_emp
ADD CONSTRAINT fk_dm_emp_no
FOREIGN KEY (direct_manager_emp_no)
REFERENCES tb_emp(emp_no);