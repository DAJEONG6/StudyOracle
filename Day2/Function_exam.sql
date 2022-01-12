-- 문자열 함수

-- 대문자
SELECT * FROM emp   
    WHERE job =UPPER('analyst');
    
SELECT UPPER('analyst') FROM dual;

SELECT LOWER(ename) ename, 
          INITCAP(job) job -- INITCAP 첫번째 글자만 대문자로
    FROM emp
    WHERE comm IS NOT NULL;
    
-- LENGTH 길이
SELECT ename, LENGTH(ename) 글자수, LENGTHB(ename) 바이트수
    FROM emp;

-- SUBSTRING(문자열, 시작 위치, 추출 길이) : 문자열 일부 추출
SELECT SUBSTR('안녕하세요, 한가람IT전문학원 빅데이터반입니다.', 18, 4)  phase FROM dual; --dual 가상

-- INSTR : 문자열 데이터 내 특정 문자 위치 찾기

-- REPLACE(문자열, 단어, 바꿀 단어) : 특정 문자를 다른 문자로 대체
SELECT REPLACE('안녕하세요, 한가람IT전문학원 빅데이터반입니다.', '빅데이터', 'ICT')  phase FROM dual; 

-- CONCAT
SELECT 'A' || 'B' FROM dual;
SELECT CONCAT('A', 'B') FROM dual;

--TRIM 특정 문자열 제거
SELECT TRIM('     안녕하세요     ') res FROM dual;
SELECT LTRIM('     안녕하세요     ') res FROM dual;
SELECT RTRIM('     안녕하세요     ') res FROM dual;
SELECT TRIM('     안녕   하세요     ') res FROM dual; -- 중간 여백은 안사라짐

-- ROUND 반올림
SELECT ROUND(15.193, 1) FROM dual;
SELECT ROUND(15.193, -1) FROM dual;
-- TRUNC 버림
SELECT TRUNC(15.193, 1) FROM dual;


-- SYSDATE : 현재 날짜와 시간
SELECT SYSDATE FROM dual;

-- 자료형을 반환하는 형 변환 함수
-- TO_CHAR 숫자 또는 날짜 데이터를 문자 데이터로
SELECT ename, hiredate, TO_CHAR(hiredate, 'yyyy-mm-dd'), TO_CHAR(sal) || '$' FROM emp;

-- TO_NUMBER 문자 데이터를 숫자 데이터로
SELECT TO_NUMBER('2400') + 100 FROM dual;

SELECT TO_NUMBER('이천사백') FROM dual; -- 변경 x

SELECT TO_NUMBER(REPLACE('2400$', '$', '')) + 100 FROM dual;

-- TO_DATE 문자 데이터를 날짜 데이터로
SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22') FROM dual;
SELECT TO_DATE('01/12/22', 'mm/dd/yy') FROM dual;

-- NULL 처리 함수
-- NVL : NULL이 아니면 그대로, NULL이면 지정한 값
SELECT ename, job, sal, NVL(comm, 0) comm,
            (sal *12) + NVL(comm, 0) AS annsal
    FROM emp 
    ORDER BY sal DESC;
    
-- 집계함수 : 하나의 열에 출력 결과를 담는 다중행 함수(SUM, COUNT, MIN, MAX, AVG)
SELECT sal, NVL(comm,0) comm FROM emp;
SELECT SUM(sal) totalsalary FROM emp;
SELECT SUM(comm) totalcommision FROM emp;

SELECT MAX(sal) FROM emp;

SELECT MIN(sal) FROM emp;
SELECT ROUND(AVG(sal)) sal_avg FROM emp;

-- GROUP BY 
-- SELECT에 적은 행은 GROUP BY에 모두 적어줘야함(집계함수나 함수를 쓴 것 제외) **
SELECT MAX(sal) 월급최대, SUM(sal) 직업군단급여합계, job 
    FROM emp
    GROUP BY job;
    
-- HAVING 출력 그룹을 제한하는 조건식
SELECT MAX(sal) 월급최대, SUM(sal) 직업군단급여합계, job 
    FROM emp
    GROUP BY job
    HAVING avg(sal) > 4000;

-- WHERE에는 집계함수 사용 못함 **

SELECT deptno, job, AVG(sal), max(sal), min(sal), sum(sal), count(*)
    FROM emp
    GROUP BY deptno, job
    HAVING avg(sal) >= 3000
    ORDER BY deptno, job;
    
-- 그룹화와 관련된 여러함수 ROLLUP
SELECT deptno, NVL(job,'합계'), ROUND(AVG(sal), 2) 급여평균, max(sal) 급여최대, sum(sal) 급여합계, count(*) 그룹별직원수
    FROM emp
    GROUP BY ROLLUP(deptno, job);  --(deptno), (deptno, job)
-- HAVING avg(sal) >= 3000

