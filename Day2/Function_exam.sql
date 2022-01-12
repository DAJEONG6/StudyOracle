-- ���ڿ� �Լ�

-- �빮��
SELECT * FROM emp   
    WHERE job =UPPER('analyst');
    
SELECT UPPER('analyst') FROM dual;

SELECT LOWER(ename) ename, 
          INITCAP(job) job -- INITCAP ù��° ���ڸ� �빮�ڷ�
    FROM emp
    WHERE comm IS NOT NULL;
    
-- LENGTH ����
SELECT ename, LENGTH(ename) ���ڼ�, LENGTHB(ename) ����Ʈ��
    FROM emp;

-- SUBSTRING(���ڿ�, ���� ��ġ, ���� ����) : ���ڿ� �Ϻ� ����
SELECT SUBSTR('�ȳ��ϼ���, �Ѱ���IT�����п� �����͹��Դϴ�.', 18, 4)  phase FROM dual; --dual ����

-- INSTR : ���ڿ� ������ �� Ư�� ���� ��ġ ã��

-- REPLACE(���ڿ�, �ܾ�, �ٲ� �ܾ�) : Ư�� ���ڸ� �ٸ� ���ڷ� ��ü
SELECT REPLACE('�ȳ��ϼ���, �Ѱ���IT�����п� �����͹��Դϴ�.', '������', 'ICT')  phase FROM dual; 

-- CONCAT
SELECT 'A' || 'B' FROM dual;
SELECT CONCAT('A', 'B') FROM dual;

--TRIM Ư�� ���ڿ� ����
SELECT TRIM('     �ȳ��ϼ���     ') res FROM dual;
SELECT LTRIM('     �ȳ��ϼ���     ') res FROM dual;
SELECT RTRIM('     �ȳ��ϼ���     ') res FROM dual;
SELECT TRIM('     �ȳ�   �ϼ���     ') res FROM dual; -- �߰� ������ �Ȼ����

-- ROUND �ݿø�
SELECT ROUND(15.193, 1) FROM dual;
SELECT ROUND(15.193, -1) FROM dual;
-- TRUNC ����
SELECT TRUNC(15.193, 1) FROM dual;


-- SYSDATE : ���� ��¥�� �ð�
SELECT SYSDATE FROM dual;

-- �ڷ����� ��ȯ�ϴ� �� ��ȯ �Լ�
-- TO_CHAR ���� �Ǵ� ��¥ �����͸� ���� �����ͷ�
SELECT ename, hiredate, TO_CHAR(hiredate, 'yyyy-mm-dd'), TO_CHAR(sal) || '$' FROM emp;

-- TO_NUMBER ���� �����͸� ���� �����ͷ�
SELECT TO_NUMBER('2400') + 100 FROM dual;

SELECT TO_NUMBER('��õ���') FROM dual; -- ���� x

SELECT TO_NUMBER(REPLACE('2400$', '$', '')) + 100 FROM dual;

-- TO_DATE ���� �����͸� ��¥ �����ͷ�
SELECT TO_DATE('2022-01-12') FROM dual;
SELECT TO_DATE('01/12/22') FROM dual;
SELECT TO_DATE('01/12/22', 'mm/dd/yy') FROM dual;

-- NULL ó�� �Լ�
-- NVL : NULL�� �ƴϸ� �״��, NULL�̸� ������ ��
SELECT ename, job, sal, NVL(comm, 0) comm,
            (sal *12) + NVL(comm, 0) AS annsal
    FROM emp 
    ORDER BY sal DESC;
    
-- �����Լ� : �ϳ��� ���� ��� ����� ��� ������ �Լ�(SUM, COUNT, MIN, MAX, AVG)
SELECT sal, NVL(comm,0) comm FROM emp;
SELECT SUM(sal) totalsalary FROM emp;
SELECT SUM(comm) totalcommision FROM emp;

SELECT MAX(sal) FROM emp;

SELECT MIN(sal) FROM emp;
SELECT ROUND(AVG(sal)) sal_avg FROM emp;

-- GROUP BY 
-- SELECT�� ���� ���� GROUP BY�� ��� ���������(�����Լ��� �Լ��� �� �� ����) **
SELECT MAX(sal) �����ִ�, SUM(sal) �������ܱ޿��հ�, job 
    FROM emp
    GROUP BY job;
    
-- HAVING ��� �׷��� �����ϴ� ���ǽ�
SELECT MAX(sal) �����ִ�, SUM(sal) �������ܱ޿��հ�, job 
    FROM emp
    GROUP BY job
    HAVING avg(sal) > 4000;

-- WHERE���� �����Լ� ��� ���� **

SELECT deptno, job, AVG(sal), max(sal), min(sal), sum(sal), count(*)
    FROM emp
    GROUP BY deptno, job
    HAVING avg(sal) >= 3000
    ORDER BY deptno, job;
    
-- �׷�ȭ�� ���õ� �����Լ� ROLLUP
SELECT deptno, NVL(job,'�հ�'), ROUND(AVG(sal), 2) �޿����, max(sal) �޿��ִ�, sum(sal) �޿��հ�, count(*) �׷캰������
    FROM emp
    GROUP BY ROLLUP(deptno, job);  --(deptno), (deptno, job)
-- HAVING avg(sal) >= 3000

