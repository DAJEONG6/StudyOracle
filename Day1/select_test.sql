DESC emp;

-- �ּ�, �Ʒ��� Select ������ ����
SELECT * FROM emp;

-- �÷��� �����ؼ� select
SELECT ename, job, hiredate
    FROM emp;
    
--  �μ��� ���
SELECT DISTINCT deptno 
    FROM emp;
    
-- �� ���� �ߺ����Ű� �ȵ�    
SELECT DISTINCT empno, deptno
    FROM emp;
    
SELECT DISTINCT job, deptno
    FROM emp;
    
-- ������ where
SELECT * FROM emp
    WHERE empno = 7499;
    
SELECT * FROM emp
    WHERE ename = 'ȫ�浿';
    
SELECT * FROM emp
    WHERE job = 'CLERK';

-- �޿� SAL�� 1500 �̻��� ��� ��ȸ
SELECT * FROM emp
    WHERE SAL >= 1500;