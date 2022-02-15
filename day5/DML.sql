-- ��ǰ �з����̺��� ���� ��ǰ���̺� �����ϴ� �з��� �˻�
SELECT lprod_gu �з��ڵ�, lprod_nm �з���
FROM lprod
WHERE lprod_gu IN(SELECT prod_lgu FROM prod);

-- ��ǰ �з����̺��� ���� ��ǰ���̺� �������� �ʴ� �з��� �˻�
SELECT lprod_gu �з��ڵ�, lprod_nm �з���
FROM lprod
WHERE lprod_gu NOT IN(SELECT prod_lgu FROM prod);

-- �ѹ��� ��ǰ�� ���������� ���� ȸ�����̵�, �̸� ��ȸ
-- ���̺� ã�� : prod, cart, member
-- ��ȸ�� �÷� ã�� : mem_id, mem_name
-- ���� �ִ��� Ȯ��
SELECT mem_id, mem_name
FROM member
WHERE mem_id NOT IN(SELECT cart_member FROM cart);

-- �ѹ��� �Ǹŵ� ���� ���� ��ǰ�� ��ȸ
-- �Ǹŵ� ���� ���� ��ǰ�̸��� ��ȸ
-- ���̺� : prod, cart
-- ���� : 
-- ��ȸ�÷� : prod_name
SELECT prod_name
FROM prod
WHERE prod_id NOT IN(SELECT cart_prod FROM cart);


-- ȸ�� �߿� ������ ȸ���� ���ݱ��� �����ߴ� ��� ��ǰ���� ��ȸ
-- ���̺� prod, member, cart
-- ���� : mem_name = '������'
-- �÷� : prod_name
SELECT prod_name
FROM prod
WHERE prod_id IN(
    SELECT cart_prod FROM cart WHERE cart_member IN(
        SELECT mem_id FROM member WHERE mem_name = '������'));
        

-- ��ǰ �� �ǸŰ����� 10���� �̻��̰� 30���� ������ ��ǰ�� ��ȸ
-- ��ȸ �÷��� ��ǰ��, �ǸŰ���
-- ������ �ǸŰ����� �������� ��������
SELECT prod_name, prod_sale
FROM prod
WHERE prod_sale BETWEEN 100000 AND 300000
ORDER BY prod_sale DESC;

-- ȸ�� �� ������ 1975-01-01���� 1976-12-31���̿� �¾ ȸ���� �˻�
SELECT mem_id, mem_name, mem_bir
FROM member
WHERE mem_bir BETWEEN '1975-01-01' AND '1976-12-31';

-- �ŷ�ó ����� ���������� ����ϴ� ��ǰ�� ������ ȸ������ ��ȸ
-- ȸ�����̵�, ȸ���̸� ��ȸ
-- ���̺� : member, cart, prod, buyer 
-- ���� : buyer_charger
-- ��ȸ�÷� : mem_id, mem_name
SELECT mem_id, mem_name
FROM member
WHERE mem_id IN (
    SELECT cart_member FROM cart WHERE cart_prod IN(
        SELECT prod_id FROM prod WHERE prod_buyer IN(
            SELECT buyer_id FROM buyer WHERE buyer_charger='������')));
            
SELECT mem_id, mem_name
FROM member
WHERE mem_id IN (
    SELECT cart_member FROM cart WHERE cart_prod IN(
        SELECT prod_id FROM prod WHERE prod_lgu IN(
            SELECT lprod_gu FROM lprod WHERE lprod_gu IN(
                SELECT buyer_lgu FROM buyer WHERE buyer_charger='������'))));
                
-- ��ǰ �� ���԰��� 300,000~1,500,000�̰� �ǸŰ��� 800,000~2,000,000�� ��ǰ�� �˻�
SELECT prod_name, prod_cost, prod_sale
FROM prod
WHERE (prod_cost BETWEEN 300000 AND 1500000) AND (prod_sale BETWEEN 800000 AND 2000000);

-- ȸ�� �� ������ 1975�⵵ ���� �ƴ� ȸ���� �˻��Ͻÿ�
SELECT mem_id, mem_name, mem_bir
FROM member
WHERE mem_bir NOT BETWEEN '1975/01/01' AND '1975/12/31';

-- ȸ�����̺��� �达 ���� ���� ȸ���� �˻�
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

-- ȸ�����̺��� �ֹε�Ϲ�ȣ ���ڸ��� �˻��Ͽ� 1975����� ������ ȸ���� �˻�
SELECT mem_id, mem_name, mem_regno1
FROM member
WHERE mem_regno1 NOT LIKE '75%';

-- CONCAT �� ���ڿ��� �����Ͽ� ��ȯ
SELECT CONCAT('My name is', mem_name)
FROM member

-- CHR,ASCII : ASCII���� ���ڷ�, ���ڸ� ASCII������ ��ȯ
SELECT CHR(6) "CHR",ASCII('A')"ASCII" FROM dual;
SELECT ASCII(CHR(65)) RESULT FROM dual;
SELECT CHR(75) "CHR", ASCII('K') "ASCII" FROM dual;

-- LOWER, UPPER, INITCAP(ù ���ڸ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ)
SELECT LOWER('DATA manipulation Language') "LOWER",
        UPPER('DATA manipulation Language') "UPPER",
        INITCAP('DATA manipulation Language')"INITCAP"
FROM dual;

-- ȸ�����̺��� ȸ��ID�� �빮�ڷ� ��ȯ�Ͽ� �˻�
SELECT mem_id, UPPER(mem_id)
FROM member;

-- LPAD, RPAD
-- LTRIM, RTRIM(c1,[c2]) ����, ������ ���鹮�ڸ� ����, c2���ڰ� �ִ� ��� ��ġ�ϴ� ���ڸ� ����
-- substr(c,m,[n]) ���ڿ��� �Ϻκ��� ����, c���ڿ��� m��ġ���� ���� n��ŭ�� ���� ����
--                 m�� 0 �Ǵ� 1�̸� ù ���ڸ� �ǹ�, m�� �����̸� ���ʿ������� ó��
-- TRANSLATE(c1,c2,c3) C1 ���ڿ��� ���Ե� ���� �� c2�� ������ ���ڰ� c3���ڷ� ���� ����
--                     C3 ���ڰ� c2���� ���� ��� �ش� ���� ����
-- REPLACE(c1,c2,[c3]) ���ڳ� ���ڿ��� ġȯ, c1�� ���Ե� c2���ڸ� c3������ ġȯ,
--                     c3�� ���� ��� ã�� ���ڸ� ����
SELECT REPLACE('SQL Project','SQL','SSQQLL') ����ġȯ1, 
       REPLACE('Java Flex Via','a') ����ġȯ2 --- 'a' ����
FROM dual;

-- ȸ�����̺��� ȸ������ �� ���� '��'-->'��'�� ġȯ �˻�
-- Alias���� ȸ����, ȸ����ġȯ               ����) ������ --> ���������� ��ȸ
SELECT mem_name ȸ����, CONCAT(REPLACE(substr(mem_name,1,1), '��','��'), substr(mem_name,2)) ȸ����ġȯ
FROM member
WHERE mem_name LIKE ('��%%');

-- INSTR
-- LENGTH ���ڿ� ���� ����
-- GREATEST, LEAST(m[,n1...]) ���ŵ� �׸� �� ���� ū �Ǵ� ���� ���� �׸��� ����
-- round(n, l) ������ �ڸ���(l) �ؿ��� �ݿø�
-- ������ �ݿø� : ROUND(Column��, ��ġ)
-- Column�� 1234.567�϶� ��ġ : -3,-2,-1,0,1,2,3
-- TRUNC(n, l) ROUND�� ����. ��, �ݿø��� �ƴ� ����
-- MOD(c, n) n���� ���� ������

-- SYSDATE �ý��ۿ��� �����ϴ� ���� ��¥�� �ð� ��
SELECT sysdate FROM dual;
SELECT sysdate+1 FROM dual;
SELECT sysdate-1 FROM dual;

-- ADD_MONTHS : data�� ���� ���� ��¥
-- NEXT_DAY : �ش� ��¥ ������ ���� ���� ������ ��¥
-- LAST_DAY : ���� ������ ��¥
SELECT NEXT_DAY(SYSDATE, '������'),
        LAST_DAY(SYSDATE) FROM dual;
        
-- �̹����� ��ĥ�� ���Ҵ��� �˻�
SELECT LAST_DAY(SYSDATE) - SYSDATE
FROM dual;

-- EXTRACT(fmt FROM date) ��¥���� �ʿ��� �κи� ����
-- (fmt=YEAR, MONTH, DAY, HOUR, MINUTE, SECOND)
-- ������ 3���� ȸ���� �˻�
SELECT mem_name
FROM member
WHERE EXTRACT(MONTH FROM mem_bir)=3;

-- ȸ�� ���� �� 1973����� �ַ� ������ ��ǰ�� ������������ ��ȸ
-- ��ȸ�÷� : ��ǰ��
-- ��, ��ǰ���� �Ｚ�� ���Ե� ��ǰ�� ��ȸ
-- ��ȸ����� �ߺ�����
-- ���̺� : prod, member, cart
-- ��ȸ�÷� : Distinct prod_name
-- ���� : prod_name ASC
-- ���� : Extract(year from mem_ber) = 1973, prod_name LIKE '%�Ｚ%'
SELECT DISTINCT(prod_name)
FROM prod
WHERE prod_id iN(
    SELECT cart_prod FROM cart WHERE cart_member IN(
        SELECT mem_id FROM member WHERE mem_bir BETWEEN '1973/01/01' AND '1973/12/31')) and prod_name like '%�Ｚ%'
ORDER BY prod_name ASC;

-- ����Ʃ��
SELECT DISTINCT(prod_name)
FROM prod
WHERE prod_name like '%�Ｚ%' and prod_id iN(
    SELECT cart_prod FROM cart WHERE cart_member IN(
        SELECT mem_id FROM member WHERE mem_bir BETWEEN '1973/01/01' AND '1973/12/31'))
ORDER BY prod_name ASC;


-- CAST(expr AS type) : ��������� �� ��ȯ

-- TO_CHAR : ����, ����, ��¥�� ������ ������ ���ڿ� ��ȯ
-- ��¥ format
-- (char) : CHAR, CLOB Ÿ���� VARCHAR2�� ��ȯ
-- (date[, fmt]) : ��¥�� Ư�� ������ ���ڿ��� ��ȯ
SELECT TO_CHAR(CAST('2008-12-25' AS DATE),'YYYY.MM.DD HH24:MI') 
FROM dual;

-- ��ǰ���̺��� ��ǰ�԰����� '2008-09-28'�������� ������ �˻�
SELECT prod_name, prod_sale, TO_CHAR(prod_insdate,'YYYY-mm-dd') ��ǰ�԰���
FROM prod;

-- ȸ���̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ�
SELECT concat(concat(concat(concat(mem_name,'���� '), concat(substr(to_char(mem_bir, 'YYYYMM'),1,4),'�� ')),
    concat(substr(to_char(mem_bir,'YYYYfmMM'),5,6),'�� ����̰� �¾ ������ ')),
    to_char(mem_bir,'day')) member
FROM member;

SELECT mem_name, mem_bir,
        (
        mem_name || '��(��)' ||
        TO_char(mem_bir, 'yyyy') || '��' ||
        TO_CHAR(mem_bir, 'mon') ||  --- mon -��
        ' ����̰� �¾ ������' ||
        TO_CHAR(mem_bir, 'day') || '�Դϴ�.'
        ) as sumStr
FROM member;

-- ���� Format
-- 9 : ��������� �ڸ�, ��ȿ�� ������ ��� ���
-- 0 : ��������� �ڸ�, ��ȿ�� ������ ��� 0 ���
-- $, L : �޷� �� ���� ȭ�� ��ȣ
-- MI : ������ ��� ������ ���̳ʽ� ǥ��, ������ ǥ��
-- PR : ������ ��� "<>" ��ȣ�� ���´�, ������ ǥ��
SELECT TO_CHAR(1234.6, '99,999.00')
FROM dual;

SELECT TO_CHAR(-1234.5, 'L9999.00PR')
FROM dual;

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, ���԰���, �Һ��ڰ���, �ǸŰ����� ���
-- ��, ������ õ���� ���� �� ��ȭǥ��
SELECT prod_id, prod_name, TO_CHAR(prod_cost,'L99,999,999') ���԰���, 
        TO_CHAR(prod_price,'L99,999,999') �Һ��ڰ���,
        TO_CHAR(prod_sale,'L99,999,999') �ǸŰ���
FROM prod;

-- TO_NUMBER : ���������� ���ڿ��� ���ڷ� ��ȯ
-- (char[,fmt]) fmt�� TO_CHAR���� ����ߴ� �������İ� ����

-- ȸ�����̺��� �̻���ȸ���� ȸ�� ID 2~4 ���ڿ��� ���������� ġȯ�� ��
-- 10�� ���Ͽ� ���ο� ȸ�� ID�� ����

SELECT mem_id ȸ��ID, concat(substr(mem_id,1,2), to_char(to_number(substr(mem_id,2))+10)) as ����ȸ��ID
FROM member
WHERE mem_name ='�̻���';


SELECT mem_id ȸ��ID,
        substr(mem_id, 1, 2) ||
        (substr(mem_id, 3, 4)+10) as ����ȸ��ID
FROM member
WHERE mem_name ='�̻���';

-- concat�� 2���� ����
-- || �� �������� ���� ����

-- TO_DATE : ��¥������ ���ڿ��� ��¥�� ��ȯ

-- �Լ� GROUP
-- AVG(column)
-- ALL : Default�ν� ��� ���� ����
-- column�� : NULL���� ����
-- * : NULL���� ����(count�Լ��� ���)
/*
[��Ģ]
�Ϲ��÷��� �׷��Լ��� ���� ����� ��쿡��
�� GROUP BY���� �־� �־�� �մϴ�.
�׸��� GROUP BY������ �Ϲ��÷��� ��� ���� �մϴ�.
*/

-- ��ǰ ���̺��� ��ǰ�з��� ���԰��� ��� ��
SELECT prod_lgu,
        ROUND(AVG(prod_cost),2) "�з��� ���԰��� ���"
FROM prod
GROUP BY prod_lgu;

-- ��ǰ���̺��� �ǸŰ��� ��� ��
SELECT ROUND(avg(prod_sale),2) "��ǰ �� �ǸŰ��� ��հ�"
FROM prod;

-- ��ǰ���̺��� ��ǰ�з��� �ǸŰ��� ��� ��
SELECT prod_lgu, ROUND(avg(prod_sale),2) "�з��� �ǸŰ��� ���"
FROM prod
GROUP BY prod_lgu;

-- ��ٱ������̺��� ȸ���� COUNT ����
SELECT cart_member, count(cart_member) as mem_count
FROM cart
GROUP BY cart_member;

-- ���ż����� ��ü��� �̻��� ������ ȸ������ ���̵�� �̸��� ��ȸ
-- ��, ������ �ֹι�ȣ(��)�� �������� ��������
SELECT mem_id, mem_name
FROM member 
WHERE mem_id IN(
    SELECT cart_member  
    FROM cart 
    WHERE cart_qty>=(
        SELECT AVG(cart_qty)
        FROM cart
        )
    )
ORDER BY mem_regno1 ASC;