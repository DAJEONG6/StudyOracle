-- 기본 INNER JOIN : 공통되는 내용만 찾음
SELECT e.empno
       , e.ename
       , e.job
       , TO_CHAR(e.hiredate,'yyyy-mm-dd') hriedate
       , e.deptno
       , d.dname
  FROM emp e
 INNER JOIN dept d
    ON e.deptno = d.deptno
 WHERE e.job='SALESMAN';
 
-- SELECT d.deptno, d.dname
-- FROM dept d

-- 등가조인 : '=' 사용
-- 자체조인 : 하나의 테이블을 여러 테이블처럼 사용
-- 외부조인 : 조인 조건의 NULL 데이터도 출력(left, right)

-- PL/SQL 이너조인
SELECT e.empno
      , e.ename
      , e.job
      , TO_CHAR(e.hiredate,'yyyy-mm-dd') hriedate
      , e.deptno
      , d.dname
  FROM emp e, dept d
  WHERE 1 = 1 -- TIP
    and e.deptno = d.deptno
    and e.job='SALESMAN';
    
-- LEFT OUTER JOIN
SELECT e.empno
       , e.ename
       , e.job
       , TO_CHAR(e.hiredate,'yyyy-mm-dd') hriedate
       , e.deptno
       , d.dname
  FROM emp e --기준
  LEFT OUTER JOIN dept d
    ON e.deptno = d.deptno;
    
-- RIGHT OUTER JOIN
SELECT e.empno
       , e.ename
       , e.job
       , TO_CHAR(e.hiredate,'yyyy-mm-dd') hriedate
       , e.deptno
       , d.dname
  FROM emp e
  RIGHT OUTER JOIN dept d --기준
     ON e.deptno = d.deptno;
-- 키 값이 NULL 이면 OUTER JOIN

SELECT e.empno
       , e.ename
       , e.job
       , TO_CHAR(e.hiredate,'yyyy-mm-dd') hriedate
       , e.deptno
       , d.dname
  FROM emp e, dept d
 WHERE e.deptno = d.deptno(+); -- PL/SQL 형식의 LFEF OUTER JOIN
-- WHERE e.deptno(+) = d.deptno; -- PL/SQL 형식의 RIGHT OUTER JOIN

-- 3개 테이블 INNER JOIN(일치하는 값만 나옴)
SELECT e.empno
       , e.ename
       , e.job
       , TO_CHAR(e.hiredate,'yyyy-mm-dd') hriedate
       , e.deptno
       , d.dname
       , b.comm
  FROM emp e, dept d, bonus b
 WHERE e.deptno(+) = d.deptno -- right outer join
   and e.ename = b.ename(+); -- left outer join(MILLER만 값이 일치)
   