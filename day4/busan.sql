Create Table lprod (
    lprod_id number(5) Not Null,
    lprod_gu char(4) Not Null,
    lprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_lprod Primary Key (lprod_gu)
);

-- ��ȸ�ϱ�
Select *
From lprod;

-- ������ �Է��ϱ�.
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (1, 'P101', '��ǻ����ǰ');
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (2, 'P102', '������ǰ');                    
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (3, 'P201', '����ĳ���');
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (4, 'P202', '����ĳ���');
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (5, 'P301', '������ȭ');
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (6, 'P302', 'ȭ��ǰ');                    
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (7, 'P401', '����/CD');                    
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (8, 'P402', '����');
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (5, 'P403', '������');
                    
                    
Select lprod_id, lprod_gu, lprod_nm
From lprod;

-- ��ǰ�з��������� ��ǰ�з��ڵ��� ���� P201�� �����͸� ��ȸ
SELECT *
FROM lprod
-- ���� �߰�
WHERE lprod_gu='P201';

-- ��ǰ�з��ڵ尡 P102�� ���ؼ� ��ǰ�з����� ���� ����� ����
SELECT *
FROM lprod
WHERE lprod_gu = 'P102';

UPDATE lprod
    SET lprod_nm = '���'
WHERE lprod_gu = 'P102';


-- ��ǰ�з��������� ��ǰ�з��ڵ尡 P202�� ���� �����͸� ����
SELECT *
FROM lprod
WHERE lprod_gu = 'P202';

DELETE FROM lprod 
WHERE lprod_gu='P202';

COMMIT;


-- �ŷ�ó�������̺� ����
CREATE TABLE buyer( 
    buyer_id char(6) NOT NULL,          -- �ŷ�ó �ڵ�
    buyer_name varchar2(40) NOT NULL,   -- �ŷ�ó��
    buyer_lgu char(4) NOT NULL,         -- ��޻�ǰ ��з�
    buyer_bank varchar2(60),            -- ����
    buyer_bankno varchar2(60),          -- ���¹�ȣ
    buyer_bankname varchar2(15),        -- ������
    buyer_zip char(7),                  -- �����ȣ
    buyer_add1 varchar2(100),           -- �ּ�1 
    buyer_add2 varchar2(70),            -- �ּ�2
    buyer_comtel varchar2(14) NOT NULL, -- ��ȭ��ȣ
    buyer_fax varchar2(20) NOT NULL     -- fax��ȣ
    );


ALTER TABLE buyer ADD(buyer_mail varchar(60) NOT NULL,
                        buyer_charger varchar2(20),
                        buyer_telect varchar2(2));

ALTER TABLE buyer MODIFY (buyer_name varchar(60));

ALTER TABLE buyer
    ADD( CONSTRAINT pk_buyer PRIMARY KEY(buyer_id),
         CONSTRAINT fk_buyer_lprod FOREIGN KEY (buyer_lgu)
                                   REFERENCES lprod(lprod_gu));
                                   
    

-- ��ǰ ���̺�κ��� ��ǰ�ڵ�� ��ǰ���� �˻��Ͻÿ�
-- 1. ���̺� ã��
-- 2. ������ �ִ���?
-- 3. � �÷��� ����ϴ���?

-- Ư�� COLUMN�� �˻�
SELECT mem_id,mem_name
From member;

SELECT prod_id, prod_name
FROM prod;

-- ������� ����� �˻�
-- ȸ�����̺��� ���ϸ����� 12�� ���� ���� ���ϱ�
SELECT  mem_mileage, 
        (mem_mileage/12) AS mem_12
FROM member;


-- ��ǰ ���̺��� ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ�*55�� �˻�
SELECT prod_id, prod_name, (prod_sale*55) AS prod_sale
FROM prod;

SELECT (mem_mileage/12) AS MONTH_AVE
FROM member;

SELECT DISTINCT (prod_buyer) AS �ŷ�ó
FROM prod;


-- ȸ�����̺��� ȸ��ID, ȸ����, ����, ���ϸ��� �˻�
SELECT mem_id, mem_name, mem_bir, mem_mileage
FROM member
ORDER BY mem_id ASC;

SELECT mem_id AS id, mem_name AS nm , mem_bir, mem_mileage
FROM member
ORDER BY id ASC; -- ��Ī, ��ġ��ȣ�� ���� ����


-- �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_sale �ǸŰ�
FROM prod
WHERE prod_sale = 170000;


-- �ǸŰ��� 170,000���� �ʰ��ϴ� ��ǰ ���̵�� ��ǰ�� ��ȸ
SELECT prod_id ���̵�, prod_name ��ǰ
FROM prod
WHERE prod_sale > 170000;


-- ��ǰ �� ���԰����� 200,000�� ������ ��ǰ�˻�
-- ��ǰ�ڵ带 �������� ��������
-- ��ȸ�÷��� ��ǰ�ڵ�, ���԰���, ��ǰ��
SELECT prod_id, prod_cost, prod_name
FROM prod
WHERE prod_cost <= 200000
ORDER BY prod_id DESC;


-- ȸ�� �߿� 76�⵵ 1�� 1�� ���Ŀ� �¾ 
-- ȸ�����̵�, ȸ���̸�, �ֹε�Ϲ�ȣ ���ڸ� ��ȸ
-- ��, ȸ�����̵� ���� ��������
SELECT mem_id, mem_name, mem_regno1
FROM member
WHERE mem_regno1>=760101
ORDER BY mem_id ASC;


-- ��ǰ �� ��ǰ�з��� P201(���� ĳ���)�̰� �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_lgu ��ǰ�з�, prod_sale �ǸŰ�
FROM prod
WHERE prod_lgu = 'P201' AND prod_sale = 170000;

-- ��ǰ �� ��ǰ�з��� P201(���� ĳ���)�̰ų� �ǸŰ��� 170,000���� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_lgu ��ǰ�з�, prod_sale �ǸŰ�
FROM prod
WHERE prod_lgu = 'P201' OR prod_sale = 170000;

-- ��ǰ �� ��ǰ�з��� P201(���� ĳ���)�� �ƴϰ� �ǸŰ��� 170,000���� �ƴ� ��ǰ ��ȸ
SELECT prod_name ��ǰ, prod_lgu ��ǰ�з�, prod_sale �ǸŰ�
FROM prod
WHERE NOT(prod_lgu = 'P201' OR prod_sale = 170000);

-- ��ǰ �� �ǸŰ��� 300,000�� �̻�, 500,000�� ������ ��ǰ�� �˻�
SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��, prod_sale �ǸŰ�
FROM prod
WHERE prod_sale BETWEEN 300000 AND 500000;

-- ��ǰ �� �ǸŰ����� 15����, 17����, 33������ ��ǰ���� ��ȸ
-- ��ǰ�ڵ�, ��ǰ��, �ǸŰ��� ��ȸ
-- ������ ��ǰ���� �������� ��������
SELECT prod_id, prod_name, prod_sale
FROM prod
WHERE prod_sale in(150000, 170000, 330000)
ORDER BY prod_name ASC;

-- ȸ�� �߿� ���̵� c001, f001, w001�� ȸ����ȸ
-- ȸ�����̵�, ȸ���̸� ��ȸ
-- ������ �ֹι�ȣ ���ڸ��� �������� ��������
SELECT mem_id, mem_name
FROM member
WHERE mem_id in('c001', 'f001', 'w001')
ORDER BY mem_regno1 DESC;

