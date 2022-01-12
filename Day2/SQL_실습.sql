-- 행단위로 조회하는 셀렉션
SELECT * FROM emp
    WHERE sal = 5000;
    
SELECT * FROM emp
    WHERE job = 'CLERK';
    
SELECT * FROM emp
    WHERE comm = 0 OR comm IS NULL;
    
SELECT * FROM emp
    WHERE COMM IS NOT NULL;
    
-- 보너스가 NULL이고 직업이 ANALYST인 사람만 셀렉션(대소문자 구분하기)
 SELECT * FROM emp
    WHERE comm IS NULL and job = 'ANALYST';
    
-- 프로젝션 : 열 단위로 조회
SELECT empno, ename, deptno
    FROM emp
    WHERE deptno = 30;


-- 조인 : 두 개 이상의 테이블을 하나의 테이블처럼 조인하는 방법(가상의 테이블)
SELECT e.empno, e.ename, e.job, e.hiredate, e.sal, e.deptno, d.dname FROM emp e
     JOIN dept d
        ON e.deptno = d.deptno;
        
-- DISTINCFT
SELECT DISTINCT job FROM emp;

-- 별칭(ALIAS)
SELECT ename, job, sal, sal * 12  연봉 FROM emp;

SELECT ename, job, sal, sal * 12  AS 연봉 
    FROM emp `
    ORDER BY 연봉 DESC, ename ASC ; --ASC 오름차순 DESC 내림차순
    
-- WHERE
SELECT ename, job, sal, sal * 12  AS 연봉
    FROM emp
    WHERE sal != 1000; -- <>, =! 많이 쓰임 ^= 거의 안쓰임

SELECT ename, job, sal, sal * 12  AS 연봉
    FROM emp
    WHERE NOT sal = 1000;

-- IN
SELECT ename, job, sal, sal * 12  AS 연봉
    FROM emp
    WHERE sal IN (800, 1600, 5000);

SELECT ename, job, sal, sal * 12  AS 연봉
    FROM emp
    WHERE sal = 800 OR sal = 1600 OR sal = 5000;

-- BETWEEN A AND B
SELECT ename, job, sal, sal * 12  AS 연봉
    FROM emp
    WHERE sal > 1600 AND sal <= 2975;
    
SELECT ename, job, sal, sal * 12  AS 연봉
    FROM emp
    WHERE sal BETWEEN 1600 AND 2975;
    
-- LIKE
SELECT ename, job, sal, sal * 12  AS 연봉
    FROM emp
    WHERE ename LIKE '%E%' ; -- J% %ER%, %E%, __RD

SELECT ename, job, sal, sal * 12  AS 연봉
    FROM emp
    WHERE ename LIKE '__RD' ;




