----------------------------------------------------------------------
/*
�ܷ�Ű���� in (select), group by having, 
buyer-buyprod-prod-lprod-cart-member
�ŷ�ó ������ ��ǰ�� �ֹ��� ���� ��ġ�� ���� ���� �˻��Ͽ�,
���� �����̸� ��ۺ� ����,
Ÿ �����Ͻ� ��ۺ� �ǸŰ� + 3000
�� �̸�, �� ����
*/
select mem_name, substr(mem_add1,1,2) ������
from member
where mem_id in
(select cart_member
from cart
where cart_prod in
( select prod_id
from prod
where prod_lgu in
(select buyer_lgu
from buyer
where )))
;

select count(prod_sale) * 3000 ��ۺ�����
from prod
where prod_id in
(select cart_prod
from cart
where cart_member in
( select mem_id
from member
where substr(mem_add1,1,2) != '����')) or prod_sale < 250000;




-- -�԰� ����- 6���� ����(5���ޱ���)�� �԰�� ��ǰ�߿� 
-- -��������- ���Ư������� '��Ź ����'�̸鼭 ������ null���� ��ǰ�� �߿� �Ǹŷ��� ��ǰ �Ǹŷ��� ��պ��� ���� �ȸ��� ������
-- -ȸ������- �达 ���� ���� �մ��� �̸��� ���� ���ϸ����� ���ϰ� ������ ����Ͻÿ�
SELECT mem_name, mem_mileage , DECODE(SUBSTR(mem_regno2,1,1), 1,'��', '��') as ���� FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_qty >= (SELECT AVG(cart_qty) FROM cart)
                AND cart_prod IN(
                    SELECT prod_id FROM prod
                        WHERE prod_delivery = '��Ź ����'
                            AND prod.prod_color IS NULL
                            AND prod_id IN (
                                SELECT buy_prod FROM buyprod
                                    WHERE buy_date < TO_DATE('050601', 'yymmdd'))
                )
    AND mem_name LIKE '��%'
    );
/*

lprod : ���� ĳ�־��̸鼭 
prod :���� �Ƿ��̰�, 
buyprod :���Լ����� 10���̻�
prod : 6���� �԰��� ��ǰ��
�̸�,�ǸŰ�����ȸ
*/

select prod_name, prod_sale
from prod
where prod_id in
(select buy_prod
from buyprod
where buy_qty >=30 and
to_char(buy_date,'mm')='06') and
prod_lgu in
(select lprod_gu
from lprod
where lprod_nm ='����ĳ�־�')and prod_name like '%����%'
;


*/
�ŷ�ó �ڵ尡 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
����� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ ���Դܰ��� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ����� 2500�̻��̸� ���ȸ�� �ƴϸ� �Ϲ�ȸ������ ����϶�
�÷� ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
/*


SELECT mem_id,mem_mileage,CASE 
          WHEN mem_mileage >= '2500' THEN '���ȸ��'
          ELSE '�Ϲ�ȸ��' END as "ȸ�� ���"
            FROM member
                WHERE mem_id IN(
                     SELECT cart_member FROM cart
                        WHERE cart_prod IN (
                            SELECT prod_id FROM prod
                                WHERE prod_insdate > TO_DATE('050131','yymmdd')
                                    AND prod_id IN (
                                        SELECT buy_prod FROM buyprod
                                            WHERE buy_cost >= 200000
                                                AND prod_buyer IN(
                                                    SELECT buyer_id FROM buyer
                                                        WHERE SUBSTR(buyer_id,1,3) = 'P20'
                                                )
                                    )
                        )
                );
                
                
                
                
select prod_name �̸�
, prod_sale �ǸŰ���
, nvl(prod_mileage,0)+prod_sale as "�ǸŰ���+���ϸ���"
from prod
where prod_id in
(select buy_prod
from buyprod
where buy_qty >=30 and
to_char(buy_date,'mm')='06') and
prod_lgu in
(select lprod_gu
from lprod
where lprod_nm ='����ĳ�־�')and prod_name like '%����%';