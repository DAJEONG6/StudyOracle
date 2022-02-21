----------------------------------------------------------------------
/*
외래키연결 in (select), group by having, 
buyer-buyprod-prod-lprod-cart-member
거래처 지역과 상품을 주문한 고객의 위치가 같은 곳만 검색하여,
같은 지역이면 배송비 무료,
타 지역일시 배송비 판매가 + 3000
고객 이름, 고객 지역
*/
select mem_name, substr(mem_add1,1,2) 고객지역
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

select count(prod_sale) * 3000 배송비총합
from prod
where prod_id in
(select cart_prod
from cart
where cart_member in
( select mem_id
from member
where substr(mem_add1,1,2) != '서울')) or prod_sale < 250000;




-- -입고 정보- 6월달 이전(5월달까지)에 입고된 상품중에 
-- -구매정보- 배달특기사항이 '세탁 주의'이면서 색상이 null값인 제품들 중에 판매량이 제품 판매량의 평균보다 많이 팔린걸 구매한
-- -회원정보- 김씨 성을 가진 손님의 이름과 보유 마일리지를 구하고 성별을 출력하시오
SELECT mem_name, mem_mileage , DECODE(SUBSTR(mem_regno2,1,1), 1,'남', '여') as 성별 FROM member
    WHERE mem_id IN (
        SELECT cart_member FROM cart
            WHERE cart_qty >= (SELECT AVG(cart_qty) FROM cart)
                AND cart_prod IN(
                    SELECT prod_id FROM prod
                        WHERE prod_delivery = '세탁 주의'
                            AND prod.prod_color IS NULL
                            AND prod_id IN (
                                SELECT buy_prod FROM buyprod
                                    WHERE buy_date < TO_DATE('050601', 'yymmdd'))
                )
    AND mem_name LIKE '김%'
    );
/*

lprod : 여성 캐주얼이면서 
prod :여름 의류이고, 
buyprod :매입수량이 10개이상
prod : 6월에 입고한 제품의
이름,판매가격조회
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
where lprod_nm ='여성캐주얼')and prod_name like '%여름%'
;


*/
거래처 코드가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
등록이 2005년 1월 31일(2월달) 이후에 이루어졌고 매입단가가 20만원이 넘는 상품을
구매한 고객의 마일리지가 2500이상이면 우수회원 아니면 일반회원으로 출력하라
컬럼 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
/*


SELECT mem_id,mem_mileage,CASE 
          WHEN mem_mileage >= '2500' THEN '우수회원'
          ELSE '일반회원' END as "회원 등급"
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
                
                
                
                
select prod_name 이름
, prod_sale 판매가격
, nvl(prod_mileage,0)+prod_sale as "판매가격+마일리지"
from prod
where prod_id in
(select buy_prod
from buyprod
where buy_qty >=30 and
to_char(buy_date,'mm')='06') and
prod_lgu in
(select lprod_gu
from lprod
where lprod_nm ='여성캐주얼')and prod_name like '%여름%';