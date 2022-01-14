-- 1��.
SELECT Lower(email)email
     , MOBILE
     , names
     , addr
     , levels
  FROM membertbl
  ORDER BY names DESC;

-- 2��.
SELECT names å����
     , Author ���ڸ�
     , TO_CHAR(releasedate,'yyyy-mm-dd') ������
     , price ����
  FROM BOOKSTBL
  ORDER BY idx;

-- 3��.
SELECT d.names �帣
     , b.names å����
     , b.author ����
     , TO_CHAR(b.releasedate,'yyyy-mm-dd') ������
     , b.ISBN å�ڵ��ȣ
     , TO_CHAR(b.price, '00000')||'��'  ����
     -- CONCAT(b.price, '��') ����
  FROM bookstbl b
  INNER JOIN divtbl d
  ON b.division = d.division
  ORDER BY idx desc;
  
-- 4��.
SELECT MEMBER_SEQ.CURRVAL FROM dual;

INSERT INTO membertbl
    (idx, names, levels, addr, mobile, email, userid, password)
    VALUES(MEMBER_SEQ.NEXTVAL
         , 'ȫ�浿'
         , 'A'
         , '�λ�� ���� �ʷ���'
         , '010-7989-0909'
         , 'HGD09@naver.com'
         , 'HGD7989'
         , '12345'
         );
COMMIT;

-- 5��.
SELECT NVL(d.names, '--�հ�--') �帣
     , sum(b.price) �帣���հ�ݾ�
  FROM bookstbl b
  INNER JOIN divtbl d
  ON b.division = d.division
  GROUP BY ROLLUP(d.names);