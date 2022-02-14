Create Table lprod (
    lprod_id number(5) Not Null,
    lprod_gu char(4) Not Null,
    lprod_nm varchar2(40) Not Null,
    CONSTRAINT pk_lprod Primary Key (lprod_gu)
);

-- 조회하기
Select *
From lprod;

-- 데이터 입력하기.
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (1, 'P101', '컴퓨터제품');
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (2, 'P102', '전자제품');                    
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (3, 'P201', '여성캐쥬얼');
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (4, 'P202', '남성캐쥬얼');
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (5, 'P301', '피혁잡화');
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (6, 'P302', '화장품');                    
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (7, 'P401', '음반/CD');                    
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (8, 'P402', '도서');
Insert into lprod( lprod_id, lprod_gu, lprod_nm) 
                    Values (5, 'P403', '문구류');
                    
                    
Select lprod_id, lprod_gu, lprod_nm
From lprod;

-- 상품분류정보에서 상품분류코드의 값이 P201인 데이터를 조회
SELECT *
FROM lprod
-- 조건 추가
WHERE lprod_gu='P201';

-- 상품분류코드가 P102에 대해서 상품분류명의 값을 향수로 수정
SELECT *
FROM lprod
WHERE lprod_gu = 'P102';

UPDATE lprod
    SET lprod_nm = '향수'
WHERE lprod_gu = 'P102';


-- 상품분류정보에서 상품분류코드가 P202에 대한 데이터를 삭제
SELECT *
FROM lprod
WHERE lprod_gu = 'P202';

DELETE FROM lprod 
WHERE lprod_gu='P202';

COMMIT;


-- 거래처정보테이블 생성
CREATE TABLE buyer( 
    buyer_id char(6) NOT NULL,          -- 거래처 코드
    buyer_name varchar2(40) NOT NULL,   -- 거래처명
    buyer_lgu char(4) NOT NULL,         -- 취급상품 대분류
    buyer_bank varchar2(60),            -- 은행
    buyer_bankno varchar2(60),          -- 계좌번호
    buyer_bankname varchar2(15),        -- 예금주
    buyer_zip char(7),                  -- 우편번호
    buyer_add1 varchar2(100),           -- 주소1 
    buyer_add2 varchar2(70),            -- 주소2
    buyer_comtel varchar2(14) NOT NULL, -- 전화번호
    buyer_fax varchar2(20) NOT NULL     -- fax번호
    );


ALTER TABLE buyer ADD(buyer_mail varchar(60) NOT NULL,
                        buyer_charger varchar2(20),
                        buyer_telect varchar2(2));

ALTER TABLE buyer MODIFY (buyer_name varchar(60));

ALTER TABLE buyer
    ADD( CONSTRAINT pk_buyer PRIMARY KEY(buyer_id),
         CONSTRAINT fk_buyer_lprod FOREIGN KEY (buyer_lgu)
                                   REFERENCES lprod(lprod_gu));
                                   
    

-- 상품 테이블로부터 상품코드와 상품명을 검색하시오
-- 1. 테이블 찾기
-- 2. 조건이 있는지?
-- 3. 어떤 컬럼을 사용하는지?

-- 특정 COLUMN의 검색
SELECT mem_id,mem_name
From member;

SELECT prod_id, prod_name
FROM prod;

-- 산술식을 사용한 검색
-- 회원테이블의 마일리지를 12로 나눈 값을 구하기
SELECT  mem_mileage, 
        (mem_mileage/12) AS mem_12
FROM member;


-- 상품 테이블의 상품코드, 상품명, 판매금액*55를 검색
SELECT prod_id, prod_name, (prod_sale*55) AS prod_sale
FROM prod;

SELECT (mem_mileage/12) AS MONTH_AVE
FROM member;

SELECT DISTINCT (prod_buyer) AS 거래처
FROM prod;


-- 회원테이블에서 회원ID, 회원명, 생일, 마일리지 검색
SELECT mem_id, mem_name, mem_bir, mem_mileage
FROM member
ORDER BY mem_id ASC;

SELECT mem_id AS id, mem_name AS nm , mem_bir, mem_mileage
FROM member
ORDER BY id ASC; -- 별칭, 위치번호로 정렬 가능


-- 판매가가 170,000원인 상품 조회
SELECT prod_name 상품, prod_sale 판매가
FROM prod
WHERE prod_sale = 170000;


-- 판매가가 170,000원을 초과하는 상품 아이디와 상품명 조회
SELECT prod_id 아이디, prod_name 상품
FROM prod
WHERE prod_sale > 170000;


-- 상품 중 매입가격이 200,000원 이하인 상품검색
-- 상품코드를 기준으로 내림차순
-- 조회컬럼은 상품코드, 매입가격, 상품명
SELECT prod_id, prod_cost, prod_name
FROM prod
WHERE prod_cost <= 200000
ORDER BY prod_id DESC;


-- 회원 중에 76년도 1월 1일 이후에 태어난 
-- 회원아이디, 회원이름, 주민등록번호 앞자리 조회
-- 단, 회원아이디 기준 오름차순
SELECT mem_id, mem_name, mem_regno1
FROM member
WHERE mem_regno1>=760101
ORDER BY mem_id ASC;


-- 상품 중 상품분류가 P201(여성 캐쥬얼)이고 판매가가 170,000원인 상품 조회
SELECT prod_name 상품, prod_lgu 상품분류, prod_sale 판매가
FROM prod
WHERE prod_lgu = 'P201' AND prod_sale = 170000;

-- 상품 중 상품분류가 P201(여성 캐쥬얼)이거나 판매가가 170,000원인 상품 조회
SELECT prod_name 상품, prod_lgu 상품분류, prod_sale 판매가
FROM prod
WHERE prod_lgu = 'P201' OR prod_sale = 170000;

-- 상품 중 상품분류가 P201(여성 캐쥬얼)도 아니고 판매가가 170,000원도 아닌 상품 조회
SELECT prod_name 상품, prod_lgu 상품분류, prod_sale 판매가
FROM prod
WHERE NOT(prod_lgu = 'P201' OR prod_sale = 170000);

-- 상품 중 판매가가 300,000원 이상, 500,000원 이하인 상품을 검색
SELECT prod_id 상품코드, prod_name 상품명, prod_sale 판매가
FROM prod
WHERE prod_sale BETWEEN 300000 AND 500000;

-- 상품 중 판매가격이 15만원, 17만원, 33만원인 상품정보 조회
-- 상품코드, 상품명, 판매가격 조회
-- 정렬은 상품명을 기준으로 오름차순
SELECT prod_id, prod_name, prod_sale
FROM prod
WHERE prod_sale in(150000, 170000, 330000)
ORDER BY prod_name ASC;

-- 회원 중에 아이디가 c001, f001, w001인 회원조회
-- 회원아이디, 회원이름 조회
-- 정렬은 주민번호 앞자리를 기준으로 내림차순
SELECT mem_id, mem_name
FROM member
WHERE mem_id in('c001', 'f001', 'w001')
ORDER BY mem_regno1 DESC;

