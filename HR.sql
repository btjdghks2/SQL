-- HR 계정
--계정내의 테이블 확인
SELECT * FROM tab; -- 키워드는 대분자로 쓰는것은 습관의 문제
--테이블의 구조 확인
DESC employees;
--SQL은 대소문자를 구분하지 않는다

---------------
--SELECT ~ FROM
---------------

-- 가장 기본적인 SELECT : 전체 데이터 조회
SELECT * FROM employees;
SELECT * FROM departments;

-- 테이블 내에 정의된 컬럼의 순서대로
-- 특정 컬럼만 선별적으로 projection
-- 모든 사원의 first_name, 입사일, 급여 출력
SELECT firsr_name, hire_date, salary
FROM employees;

-- 기본적 산술연산을 수행
-- 산술식 자체가 특정 테이블에 소속된 것이 아닐때 dual
SELECT 10 + 20 FROM dual;
-- 특정 컬럼 값을 수치로 산술계산을 할 수 있다.
-- 직원들의 연봉 salay * 12
SELECT first_name,
    salary,
    salary * 12
FROM employees;

--
SELECT first_name, job_id * 12 FROM employees; -- Error
DESC employees; -- job_id 는 문자열 -> 산술연산 수행 불가

--연습
-- employees 테이블, first_name, phone_nember,
-- hire_date, salary를 출력
SELECT first_name,
    phone_name,
    hire_date,
    salaey
    FROM employees;
    
    -- 사원의 first_name, last_name, salary,
    --phone_number, hire_date
    
    --문자열의 연결 ||
    --first_name last_name을 연결해서 출력해야 하는 상황
    SELECT first_name ||''|| last_name
    FROM employees;
    
    SELECT first_name, salary, commission_pct
    FROM employees;
    
    --커미션 포함, 실질 급여를 출력해 봅시다.
    SELECT
        first_name,
        salary,
        commission_pct,
        salary + salary * commission_pct
    FROM employees;
  --중요 : 산술 연산식에 null이 포함되어 있으면 결과 항상 null //vvvvvvvvvvvv
    --nvl(expr1,expr2) : expr1이 null이면 expr2 선택
    SELECT
        first_name,
        salary,
        commission_pct,
        salary + salary * nvl(commission_pct, 0)
    FROM employees;

--Alias(별칭)

SELECT
    first_name 이름,
    last_name as 성,
    first_name ||''|| last_name "Full Name"
    -- 별칭 내에 공백, 특수문자가 포함될 경우"로 묶는다
FROM employees;
    
        -- 필드 표시명은 일반적으로 한글 등은 쓰지 않는다
        
----------------------------
--where
--------
--조건을 기준으로 레코드 선택(Selection)
    
    -- 급여가 15000 이상인 사원의 이름과 연봉
SELECT first_name, salary * 12 "Annual Salary"
FROM employees
WHERE salary >= 15000;

-- 07/01/01 이후 입사한 사원의 이름과 입사일

SELECT first_name, hire_date
FROM employees
WHERE hire_date >= '07/01/01';

-- 이름이 Lex인 사원의 연봉, 입사일, 부서 id
SELECT first_name, salary * 12 "Annual Salary",
    hire_date, department_id
    FROM employees

WHERE first_name = 'Lex';

--부서id가 10인 사원의 명단
SELECT * FROM employees
WHERE department_id = 10;

-- 논리 조합
-- 급여가 14000이하 or 17000 이상인 사원의 이름과 급여
SELECT first_name, salary;
FROM employees;
WHERE salary >= 14000;
