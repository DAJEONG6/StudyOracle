-- ������� ��ȸ�ϴ� ������
SELECT * FROM emp
    WHERE sal = 5000;
    
SELECT * FROM emp
    WHERE job = 'CLERK';
    
SELECT * FROM emp
    WHERE comm = 0 OR comm IS NULL;
    
SELECT * FROM emp
    WHERE COMM IS NOT NULL;
    
-- ���ʽ��� NULL�̰� ������ ANALYST�� ����� ������(��ҹ��� �����ϱ�)
 SELECT * FROM emp
    WHERE comm IS NULL and job = 'ANALYST';
    
-- �������� : �� ������ ��ȸ
SELECT empno, ename, deptno
    FROM emp
    WHERE deptno = 30;


-- ���� : �� �� �̻��� ���̺��� �ϳ��� ���̺�ó�� �����ϴ� ���(������ ���̺�)
SELECT e.empno, e.ename, e.job, e.hiredate, e.sal, e.deptno, d.dname FROM emp e
     JOIN dept d
        ON e.deptno = d.deptno;
        
-- DISTINCFT
SELECT DISTINCT job FROM emp;

-- ��Ī(ALIAS)
SELECT ename, job, sal, sal * 12  ���� FROM emp;

SELECT ename, job, sal, sal * 12  AS ���� 
    FROM emp `
    ORDER BY ���� DESC, ename ASC ; --ASC �������� DESC ��������
    
-- WHERE
SELECT ename, job, sal, sal * 12  AS ����
    FROM emp
    WHERE sal != 1000; -- <>, =! ���� ���� ^= ���� �Ⱦ���

SELECT ename, job, sal, sal * 12  AS ����
    FROM emp
    WHERE NOT sal = 1000;

-- IN
SELECT ename, job, sal, sal * 12  AS ����
    FROM emp
    WHERE sal IN (800, 1600, 5000);

SELECT ename, job, sal, sal * 12  AS ����
    FROM emp
    WHERE sal = 800 OR sal = 1600 OR sal = 5000;

-- BETWEEN A AND B
SELECT ename, job, sal, sal * 12  AS ����
    FROM emp
    WHERE sal > 1600 AND sal <= 2975;
    
SELECT ename, job, sal, sal * 12  AS ����
    FROM emp
    WHERE sal BETWEEN 1600 AND 2975;
    
-- LIKE
SELECT ename, job, sal, sal * 12  AS ����
    FROM emp
    WHERE ename LIKE '%E%' ; -- J% %ER%, %E%, __RD

SELECT ename, job, sal, sal * 12  AS ����
    FROM emp
    WHERE ename LIKE '__RD' ;




