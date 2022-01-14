-- �⺻ INNER JOIN : ����Ǵ� ���븸 ã��
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

-- ����� : '=' ���
-- ��ü���� : �ϳ��� ���̺��� ���� ���̺�ó�� ���
-- �ܺ����� : ���� ������ NULL �����͵� ���(left, right)

-- PL/SQL �̳�����
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
  FROM emp e --����
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
  RIGHT OUTER JOIN dept d --����
     ON e.deptno = d.deptno;
-- Ű ���� NULL �̸� OUTER JOIN

SELECT e.empno
       , e.ename
       , e.job
       , TO_CHAR(e.hiredate,'yyyy-mm-dd') hriedate
       , e.deptno
       , d.dname
  FROM emp e, dept d
 WHERE e.deptno = d.deptno(+); -- PL/SQL ������ LFEF OUTER JOIN
-- WHERE e.deptno(+) = d.deptno; -- PL/SQL ������ RIGHT OUTER JOIN

-- 3�� ���̺� INNER JOIN(��ġ�ϴ� ���� ����)
SELECT e.empno
       , e.ename
       , e.job
       , TO_CHAR(e.hiredate,'yyyy-mm-dd') hriedate
       , e.deptno
       , d.dname
       , b.comm
  FROM emp e, dept d, bonus b
 WHERE e.deptno(+) = d.deptno -- right outer join
   and e.ename = b.ename(+); -- left outer join(MILLER�� ���� ��ġ)
   