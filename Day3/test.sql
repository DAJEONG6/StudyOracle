-- 1번.
SELECT Lower(email)email
     , MOBILE
     , names
     , addr
     , levels
  FROM membertbl
  ORDER BY names DESC;

-- 2번.
SELECT names 책제목
     , Author 저자명
     , TO_CHAR(releasedate,'yyyy-mm-dd') 출판일
     , price 가격
  FROM BOOKSTBL
  ORDER BY idx;

-- 3번.
SELECT d.names 장르
     , b.names 책제목
     , b.author 저자
     , TO_CHAR(b.releasedate,'yyyy-mm-dd') 출판일
     , b.ISBN 책코드번호
     , TO_CHAR(b.price, '00000')||'원'  가격
     -- CONCAT(b.price, '원') 가격
  FROM bookstbl b
  INNER JOIN divtbl d
  ON b.division = d.division
  ORDER BY idx desc;
  
-- 4번.
SELECT MEMBER_SEQ.CURRVAL FROM dual;

INSERT INTO membertbl
    (idx, names, levels, addr, mobile, email, userid, password)
    VALUES(MEMBER_SEQ.NEXTVAL
         , '홍길동'
         , 'A'
         , '부산시 동구 초량동'
         , '010-7989-0909'
         , 'HGD09@naver.com'
         , 'HGD7989'
         , '12345'
         );
COMMIT;

-- 5번.
SELECT NVL(d.names, '--합계--') 장르
     , sum(b.price) 장르별합계금액
  FROM bookstbl b
  INNER JOIN divtbl d
  ON b.division = d.division
  GROUP BY ROLLUP(d.names);
