-- 상품 분류테이블에서 현재 상품테이블에 존재하는 분류만 검색
SELECT lprod_gu 분류코드, lprod_nm 분류명
FROM lprod
WHERE lprod_gu IN(SELECT prod_lgu FROM prod);

-- 상품 분류테이블에서 현재 상품테이블에 존재하지 않는 분류만 검색
SELECT lprod_gu 분류코드, lprod_nm 분류명
FROM lprod
WHERE lprod_gu NOT IN(SELECT prod_lgu FROM prod);

-- 한번도 상품을 구매한적이 없는 회원아이디, 이름 조회
-- 테이블 찾기 : prod, cart, member
-- 조회할 컬럼 찾기 : mem_id, mem_name
-- 조건 있는지 확인
SELECT mem_id, mem_name
FROM member
WHERE mem_id NOT IN(SELECT cart_member FROM cart);

-- 한번도 판매된 적이 없는 상품을 조회
-- 판매된 적이 없는 상품이름을 조회
-- 테이블 : prod, cart
-- 조건 : 
-- 조회컬럼 : prod_name
SELECT prod_name
FROM prod
WHERE prod_id NOT IN(SELECT cart_prod FROM cart);


-- 회원 중에 김은대 회원이 지금까지 구매했던 모든 상품명을 조회
-- 테이블 prod, member, cart
-- 조건 : mem_name = '김은대'
-- 컬럼 : prod_name
SELECT prod_name
FROM prod
WHERE prod_id IN(
    SELECT cart_prod FROM cart WHERE cart_member IN(
        SELECT mem_id FROM member WHERE mem_name = '김은대'));
        

-- 상품 중 판매가격이 10만원 이상이고 30만원 이하인 상품을 조회
-- 조회 컬럼은 상품명, 판매가격
-- 정렬은 판매가격을 기준으로 내림차순
SELECT prod_name, prod_sale
FROM prod
WHERE prod_sale BETWEEN 100000 AND 300000
ORDER BY prod_sale DESC;

-- 회원 중 생일이 1975-01-01에서 1976-12-31사이에 태어난 회원을 검색
SELECT mem_id, mem_name, mem_bir
FROM member
WHERE mem_bir BETWEEN '1975-01-01' AND '1976-12-31';

-- 거래처 담당자 강남구씨가 담당하는 상품을 구매한 회원들을 조회
-- 회원아이디, 회원이름 조회
-- 테이블 : member, cart, prod, buyer 
-- 조건 : buyer_charger
-- 조회컬럼 : mem_id, mem_name
SELECT mem_id, mem_name
FROM member
WHERE mem_id IN (
    SELECT cart_member FROM cart WHERE cart_prod IN(
        SELECT prod_id FROM prod WHERE prod_buyer IN(
            SELECT buyer_id FROM buyer WHERE buyer_charger='강남구')));
            
SELECT mem_id, mem_name
FROM member
WHERE mem_id IN (
    SELECT cart_member FROM cart WHERE cart_prod IN(
        SELECT prod_id FROM prod WHERE prod_lgu IN(
            SELECT lprod_gu FROM lprod WHERE lprod_gu IN(
                SELECT buyer_lgu FROM buyer WHERE buyer_charger='강남구'))));
                
-- 상품 중 매입가가 300,000~1,500,000이고 판매가가 800,000~2,000,000인 상품을 검색
SELECT prod_name, prod_cost, prod_sale
FROM prod
WHERE (prod_cost BETWEEN 300000 AND 1500000) AND (prod_sale BETWEEN 800000 AND 2000000);

-- 회원 중 생일이 1975년도 생이 아닌 회원을 검색하시오
SELECT mem_id, mem_name, mem_bir
FROM member
WHERE mem_bir NOT BETWEEN '1975/01/01' AND '1975/12/31';

-- 회원테이블에서 김씨 성을 가진 회원을 검색
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '김%';

-- 회원테이블의 주민등록번호 앞자리를 검색하여 1975년생을 제외한 회원을 검색
SELECT mem_id, mem_name, mem_regno1
FROM member
WHERE mem_regno1 NOT LIKE '75%';

-- CONCAT 두 문자열을 연결하여 반환
SELECT CONCAT('My name is', mem_name)
FROM member

-- CHR,ASCII : ASCII값을 문자로, 문자를 ASCII값으로 반환
SELECT CHR(6) "CHR",ASCII('A')"ASCII" FROM dual;
SELECT ASCII(CHR(65)) RESULT FROM dual;
SELECT CHR(75) "CHR", ASCII('K') "ASCII" FROM dual;

-- LOWER, UPPER, INITCAP(첫 글자를 대문자로 나머지는 소문자로 반환)
SELECT LOWER('DATA manipulation Language') "LOWER",
        UPPER('DATA manipulation Language') "UPPER",
        INITCAP('DATA manipulation Language')"INITCAP"
FROM dual;

-- 회원테이블의 회원ID를 대문자로 변환하여 검색
SELECT mem_id, UPPER(mem_id)
FROM member;

-- LPAD, RPAD
-- LTRIM, RTRIM(c1,[c2]) 좌측, 우측의 공백문자를 제거, c2문자가 있는 경우 일치하는 문자를 제거
-- substr(c,m,[n]) 문자열의 일부분을 선택, c문자열의 m위치부터 길이 n만큼의 문자 리턴
--                 m이 0 또는 1이면 첫 글자를 의미, m이 음수이면 뒤쪽에서부터 처리
-- TRANSLATE(c1,c2,c3) C1 문자열에 포함된 문자 중 c2에 지정된 문자가 c3문자로 각각 변경
--                     C3 문자가 c2보다 적은 경우 해당 문자 제거
-- REPLACE(c1,c2,[c3]) 문자나 문자열을 치환, c1에 포함된 c2문자를 c3값으로 치환,
--                     c3가 없는 경우 찾은 문자를 제거
SELECT REPLACE('SQL Project','SQL','SSQQLL') 문자치환1, 
       REPLACE('Java Flex Via','a') 문자치환2 --- 'a' 삭제
FROM dual;

-- 회원테이블의 회원성명 중 성씨 '이'-->'리'로 치환 검색
-- Alias명은 회원명, 회원명치환               예시) 이정원 --> 리정원으로 조회
SELECT mem_name 회원명, CONCAT(REPLACE(substr(mem_name,1,1), '이','리'), substr(mem_name,2)) 회원명치환
FROM member
WHERE mem_name LIKE ('이%%');

-- INSTR
-- LENGTH 문자열 길이 리턴
-- GREATEST, LEAST(m[,n1...]) 열거된 항목 중 가장 큰 또는 가장 작은 항목을 리턴
-- round(n, l) 지정된 자릿수(l) 밑에서 반올림
-- 숫자의 반올림 : ROUND(Column명, 위치)
-- Column값 1234.567일때 위치 : -3,-2,-1,0,1,2,3
-- TRUNC(n, l) ROUND와 동일. 단, 반올림이 아닌 절삭
-- MOD(c, n) n으로 나눈 나머지

-- SYSDATE 시스템에서 제공하는 현재 날짜와 시간 값
SELECT sysdate FROM dual;
SELECT sysdate+1 FROM dual;
SELECT sysdate-1 FROM dual;

-- ADD_MONTHS : data에 월을 더한 날짜
-- NEXT_DAY : 해당 날짜 이후의 가장 빠른 요일의 날짜
-- LAST_DAY : 월의 마지막 날짜
SELECT NEXT_DAY(SYSDATE, '월요일'),
        LAST_DAY(SYSDATE) FROM dual;
        
-- 이번달이 며칠이 남았는지 검색
SELECT LAST_DAY(SYSDATE) - SYSDATE
FROM dual;

-- EXTRACT(fmt FROM date) 날짜에서 필요한 부분만 추출
-- (fmt=YEAR, MONTH, DAY, HOUR, MINUTE, SECOND)
-- 생일이 3월인 회원을 검색
SELECT mem_name
FROM member
WHERE EXTRACT(MONTH FROM mem_bir)=3;

-- 회원 생일 중 1973년생이 주로 구매한 상품을 오름차순으로 조회
-- 조회컬럼 : 상품명
-- 단, 상품명이 삼성이 포함된 상품만 조회
-- 조회결과는 중복제거
-- 테이블 : prod, member, cart
-- 조회컬럼 : Distinct prod_name
-- 정렬 : prod_name ASC
-- 조건 : Extract(year from mem_ber) = 1973, prod_name LIKE '%삼성%'
SELECT DISTINCT(prod_name)
FROM prod
WHERE prod_id iN(
    SELECT cart_prod FROM cart WHERE cart_member IN(
        SELECT mem_id FROM member WHERE mem_bir BETWEEN '1973/01/01' AND '1973/12/31')) and prod_name like '%삼성%'
ORDER BY prod_name ASC;

-- 쿼리튜닝
SELECT DISTINCT(prod_name)
FROM prod
WHERE prod_name like '%삼성%' and prod_id iN(
    SELECT cart_prod FROM cart WHERE cart_member IN(
        SELECT mem_id FROM member WHERE mem_bir BETWEEN '1973/01/01' AND '1973/12/31'))
ORDER BY prod_name ASC;


-- CAST(expr AS type) : 명시적으로 형 변환

-- TO_CHAR : 숫자, 문자, 날짜를 지정한 형식의 문자열 반환
-- 날짜 format
-- (char) : CHAR, CLOB 타입을 VARCHAR2로 변환
-- (date[, fmt]) : 날짜를 특정 형식의 문자열로 변환
SELECT TO_CHAR(CAST('2008-12-25' AS DATE),'YYYY.MM.DD HH24:MI') 
FROM dual;

-- 상품테이블에서 상품입고일을 '2008-09-28'형식으로 나오게 검색
SELECT prod_name, prod_sale, TO_CHAR(prod_insdate,'YYYY-mm-dd') 상품입고일
FROM prod;

-- 회원이름과 생일로 다음처럼 출력되게 작성
SELECT concat(concat(concat(concat(mem_name,'님은 '), concat(substr(to_char(mem_bir, 'YYYYMM'),1,4),'년 ')),
    concat(substr(to_char(mem_bir,'YYYYfmMM'),5,6),'월 출생이고 태어난 요일은 ')),
    to_char(mem_bir,'day')) member
FROM member;

SELECT mem_name, mem_bir,
        (
        mem_name || '은(는)' ||
        TO_char(mem_bir, 'yyyy') || '년' ||
        TO_CHAR(mem_bir, 'mon') ||  --- mon -월
        ' 출생이고 태어난 요일은' ||
        TO_CHAR(mem_bir, 'day') || '입니다.'
        ) as sumStr
FROM member;

-- 숫자 Format
-- 9 : 출력형식의 자리, 유효한 숫자인 경우 출력
-- 0 : 출력형식의 자리, 무효한 숫자인 경우 0 출력
-- $, L : 달러 및 지역 화폐 기호
-- MI : 음수인 경우 우측에 마이너스 표시, 우측에 표시
-- PR : 음수인 경우 "<>" 괄호로 묶는다, 우측에 표시
SELECT TO_CHAR(1234.6, '99,999.00')
FROM dual;

SELECT TO_CHAR(-1234.5, 'L9999.00PR')
FROM dual;

-- 상품테이블에서 상품코드, 상품명, 매입가격, 소비자가격, 판매가격을 출력
-- 단, 가격은 천단위 구분 및 원화표시
SELECT prod_id, prod_name, TO_CHAR(prod_cost,'L99,999,999') 매입가격, 
        TO_CHAR(prod_price,'L99,999,999') 소비자가격,
        TO_CHAR(prod_sale,'L99,999,999') 판매가격
FROM prod;

-- TO_NUMBER : 숫자형식의 문자열을 숫자로 반환
-- (char[,fmt]) fmt는 TO_CHAR에서 사용했던 숫자형식과 동일

-- 회원테이블에서 이쁜이회원의 회원 ID 2~4 문자열을 숫자형으로 치환한 후
-- 10을 더하여 새로운 회원 ID로 조합

SELECT mem_id 회원ID, concat(substr(mem_id,1,2), to_char(to_number(substr(mem_id,2))+10)) as 조합회원ID
FROM member
WHERE mem_name ='이쁜이';


SELECT mem_id 회원ID,
        substr(mem_id, 1, 2) ||
        (substr(mem_id, 3, 4)+10) as 조합회원ID
FROM member
WHERE mem_name ='이쁜이';

-- concat은 2개만 연결
-- || 는 여러가지 연결 가능

-- TO_DATE : 날짜형식의 문자열을 날짜로 변환

-- 함수 GROUP
-- AVG(column)
-- ALL : Default로써 모든 값을 포함
-- column명 : NULL값은 제외
-- * : NULL값도 포함(count함수만 사용)
/*
[규칙]
일반컬럼과 그룹함수를 같이 사용할 경우에는
꼭 GROUP BY절을 넣어 주어야 합니다.
그리고 GROUP BY절에는 일반컬럼이 모두 들어가야 합니다.
*/

-- 상품 테이블의 상품분류별 매입가격 평균 값
SELECT prod_lgu,
        ROUND(AVG(prod_cost),2) "분류별 매입가격 평균"
FROM prod
GROUP BY prod_lgu;

-- 상품테이블의 판매가격 평균 값
SELECT ROUND(avg(prod_sale),2) "상품 총 판매가격 평균값"
FROM prod;

-- 상품테이블의 상품분류별 판매가격 평균 값
SELECT prod_lgu, ROUND(avg(prod_sale),2) "분류별 판매가격 평균"
FROM prod
GROUP BY prod_lgu;

-- 장바구니테이블의 회원별 COUNT 집계
SELECT cart_member, count(cart_member) as mem_count
FROM cart
GROUP BY cart_member;

-- 구매수량의 전체평균 이상을 구매한 회원들의 아이디와 이름을 조회
-- 단, 정렬은 주민번호(앞)를 기준으로 오름차순
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