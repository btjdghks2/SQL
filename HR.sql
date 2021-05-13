ALTER SESSION SET "_ORACLE_SCRIPT"=true;

@?\demo\schema\human_resources\hr_main.sql


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
SELECT first_name, salary
FROM employees
WHERE
    salary <= 14000 OR
    salary >= 17000;
    
--MANAGER_ID가 100, 120, 147인 사원의 명단
-- 비교 연산자 + 논 리연산자
SELECT first_name, manager_id
FROM employees
WHERE mamager_id = 100 OR
    mamager_id = 120 OR
    manager_id = 147;
    
-- in 연산자 활용
SELECT first_name, manger_id
FROM employees
WHERE manager_id IN (100,120,147);

--LIKE 검색
-- % : 임의의 길이의 지정되지 않은 문자열
-- _ : 한개의 임의의 문자

-- 이름에 am을 포함한 사원의 이름과 급여
SELECT first_name, salary
FROM employess
WHERE first_name LIKE '%am%'

-- 이름의 두번째 글자가 a인 사원의 이름과 급여
SELECT first_name, salary
FROM employess
WHERE first_name LIKE'_a%'

-- 이름의 네번째 글자가 a인 사원의 이름과 급여
SELECT first_name, salary
FROM employess
WHERE first_name LIKE '____a%'
    
-- 이름이 네 글자인 사원 중, 끝에서 두번째 글자가 a인 사원
SELECT first_name, salary
FROM employess
WHERE first_name LIKE '__a_'
    
-- ORDER BY : 정렬
-- ASC (오름차순, 기본)
-- DESC (내림차순, 큰 것 -> 작은 것 순)

-- 부서번호 오름차순 정렬 -> 부서번호, 급여, 이름
SELECT department_id, salary, first_name
FROM employees
ORDER BY department_id -- ASC는 생략 가능

--급여가 10000이상인 직원의 이름, 급여를 급여 내림차순으로
SELECT frist, salary
FROM employees
WHERE salary >= 10000
ORDER BY salary DESC;

-- 부서번혼, 급여 ,이름 SELECT,
-- 부서번호 오름차순, 급여 내림차순
SELECT department_id, salary, first_name
FROM employees
ORDER BY department_id, salary DESC;

SELECT first_nam, last_name, salary, phone_number,hire_date
FROM employees
ORDER BY hire_date;


---------------
--단일행 함수 : 레코드를 입력으로 받음
---------------

--문자열 단일행 함수
SELECT first_name, last name
    CONCAT(first_name, CONCAT(' ',LAST_NAME)) --결합
    INITCAP(first_name ||''|| last_name), -- 첫글자를 
    LOWER(first_name), -- 모두 소문자
    UPPER(first_name), -- 모두 대문자
    LPAD(first_name,20,'*'), -- 20자리 확보, 왼쪽을 *로 채움
    RPAD(first_name,20,'*') -- 20자리 확보, 오른쪽을 *로 채움

FROM employees;

SELECT '             Oracle                 '
        '***********Database***************'
    FROM dual;
    
SELECT LTRIM('       Oracle                 ') -- 왼쪽의 공백 제거
        RTRIM('       Oracle               ') -- 오른쪽 공백 제거
        TRIM('*''FROM'*********Database*****') -- 양족으로 지정된 문자 제거
        SUBSTR('Oracle Database', 8,4), -- 8번쨔 글자부터 4글자
        SUBSTR('Oracle Database', -8,4) -- 뒤에서 8번째 글자부터 4글자
FROM dual;

-- 수치형 단일행 함수
SELECT ABS(-3.14), -- 절댓값
        CELL(3.14), -- 소숫점 올림(천정)
        FLOOP(3.14), -- 소숫점 나머지(바닥)
        MOD(7.3), -- 나머지
        POWER(2.4), --제곱
        ROUND(3.5), --반올림
        ROUND(3.4567,2) -- 소숫점 2째자리까지 반올림으로 변환(소숫점 3째 자리에서 반올림)
        TRUNC(3.5), -- 소숫점 아래 버림
        TEUNC(3.4567,2) -- 소숫점 2째자리 까지 버림으로 표시
FROM dual;
        
----------------
--DATE Format
----------------

--날짜 형식 확인
SELECT * FROM nls_session_parmeters;
WHERE parameter = 'NLS_DATE_FORMAT';

-- 현재 날짜와 시간
SELECT sysdate
FROM dual; -- dual 가상테이블로부터 확인 -> 단일행

SELECT sysdate
FROM employees; --테이블로부터 받아오므로 테이블 내 향 갯수만큼을 반환

-- DATE 관련 함수
SELECT sysdate, -- 현재 날짜와 시간
    ADD_MONTHS(sysdate, 2), -- 2개월 후의 날짜
    MONTHS_BETWEEN('99/12/31',sysdate) --1999년 12월31일 ~현재의 달수
    NEXT_DAY(sysdate,7), -- 현재 날짜 이후의 첫번째 7요일
    ROUND(TO_DATE(21/05/17,'YYYY-MM-DD'),'MONTH'), -- MONTH 정보로 반올림
    TRUNC(TO_DATE(21/05/17,'YYYY-MM-DD'),'MONTH')
FROM dual;

--현재 날짜 기준, 입사한지 몇 개월 지났는가?
SELECT first_name,hire_date, MONTHS_BETWEEN(sysdate,hire_date);
FROM employees


---------------
--변환 함수
---------------

--   TO_NUMBER(s,frm) : 문자열 -> 수치형
--  TO_DATE(s,frm) : 문자열 -> 날짜형
-- TO_CHAR(o, fmt) : 숫자, 날짜 -> 문자형

-- TO_CHAT
SELECT first_name, hire_dat, TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS')
FROM employees;

-- 현재 날짜의 포맷
SELECT sysdate, TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS')
FROM dual;

SELECT TO_CHAR(123456789.0123,'999,999,999.99')
FROM dual;

--연봉 정보 문자열로 포메팅
SELECT first_name, TO_CHAR(salary * 12,'$999,999.99') SAL
FROM employees;

--급여의 정확한 단위를 모를때? 자릿수를 맞추는 것은 어렵지 않나? 그에 대한 대안은?

--  TO_NUMBER: 문자열 -> 숫자
SELECT TO_NUMBER('1,999','999,999'),TO_NUMBER('$1,350.99','$999,999.99)
FROM dual;

-- TO_DATE : 문자열 -> 날짜
SELECT TO_DATE('2021-05-05 14:30','YYYY-MM-DD HH24:MI')
FROM dual;

-- DATE 연산
-- DATE +(-) NUMBER : 날짜에 일수 더한다(뺀다) -> Date
-- Date - Date : 날짜에서 날짜를 뺀 일수
-- Date + Number / 24 : 날짜에 시간을 더할  때 일수를 24시간으로 나눈 값을 더한다(뺀다)

SELECT TO_CHAR(sysdate, 'YY/MM/DD HH:MI'),
    sysdate + 1, -- 1일 후
    sysdate - 1, -- 1일 전
    sysdate - TO_DATE('2012-09-24','YYYY-MM-DD'), -- 두 날짜의 차이 일수
    TO_CHAR(sysdate + 13 / 24, 'YYYY/MM/DD HH24:MI') -- 13시간 후
FROM dual;
    
---------------------
--NULL 관련 함수
---------------------

-- NVL  함수
SELECT first_name,
    salary,
    commission_pct,
    salary + (salary * nvl(commission_pct, 0)) -- commission_pct is null -? 0으로 변경
FROM employees;

-- nv12 함수
-- nv12(표현식, null이 아닐때의 식, null일때의 식)
SELECT first_name,
    salaey,
    commission_pct,
    salary + nv12(commission_pct, salary * commission_pct, 0)
FROM employees;

--CASE 함수
-- 보너스를 지급하기로 했습니다
-- AD 관련 직원에게는 20%,SA 관련 직원에게는 10%, IT관련 직원에게는 8%
--나머지에게는 5%의 보너스 지금

SELECT first_name, job_id, salary, SUBSTR(job_id, 1, 2),
    CASE SUBSTR(job_id,1,2) WHEN 'AD' THEN salary * 0.2
                            WHEN 'SA' THEN salary * 0.08
                            ELSE salary * 0.05
        END as bonus
FROM employees;

-- Decode
SELECT first_name, job_id, salary, SUBSTR(job_id, 1,2),
    DECODE(SUBSTR (JOB_ID,1,2),
            'AD', salary * 0.2,
            'SA', salaey * 0.1,
            'IT', salary * 0.08,
            salary * 0.05) as bonus
FROM employees;

-- 연습문제
--department_id <= 30 -> A-group 
--department_id <= 50 -> B-group 
--department_id <= 100 -> C-group
-- 나머지 : REMAINDER
SELECT firs_name, department_id
    CASE WHEN department_id <= 30 THEN'A-group' 
         WHEN department_id <= 50 THEN'B-group' 
         WHEN department_id <= 100 THEN'C-group' 
          ELSE 'REMAINDER'
        END as team
FROM employees
ORDER BY team;


