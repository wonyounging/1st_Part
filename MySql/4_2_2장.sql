-- TRIN() 문자열 좌우 공백 제거 -> 파이썬 strip과 같음
SELECT TRIM('  안녕하세요  ');
-- 문자열 좌우 문자 제거(both)
SELECT trim(both "안" from "안녕하세요안");
-- 문자열 좌측 공백 제거
SELECT trim(leading from "    안녕하세요    "); 
-- 문자열 우측 공백 제거
SELECT trim(trailing  from "     안녕하세요      ");
-- 문자열 좌측 문자 제거
SELECT trim(leading '안' from "안녕하세요"); 
-- 문자열 우측 문자 제거
SELECT trim(trailing '안' from "안녕하세요안");

SELECT ltrim("         안녕         ");
SELECT rtrim("         안녕         ");

SELECT length("hello");
SELECT char_length("hello");
SELECT character_length("hello");

SELECT length("안녕");
SELECT char_length("안녕");
SELECT character_length("안녕");

-- 대소문자
SELECT upper("sql로 시작하는 하루");
SELECT lower("SQL로 시작하는 하루");

SELECT upper("a에서 Z까지!");

-- 추출
SELECT substring("안녕하세요", 2, 3);
SELECT substring_index("안.녕.하.세.요", ".", 2);
SELECT substring_index("안.녕.하.세.요", ".", -3);

SELECT left("안녕하세요", 3);
SELECT right("안녕하세요", 3);

-- 결합
SELECT concat("홍길동", "모험");
SELECT concat_ws(',', '홍길동', '모험');
SELECT'홍길동', '모험';

SELECT concat_ws(" : ", bookname, publisher) from book;
SELECT bookname, " : ", publisher from book;

-- customer의 name과 phone을 ':'로 묶기
SELECT group_concat(username, " : ", phone) AS "전화" FROM customer;
SELECT concat_ws(" : ", username, phone) AS "전화" FROM customer;

SELECT Now(), sysdate(), current_timestamp();
SELECT curtime(), current_time;

-- 날짜, 시간 증감 함수
SELECT adddate('2021-08-31', interval 5 day);
SELECT adddate('2021-08-31', interval 1 month);
SELECT addtime('2021-08-31 23:59:59', '1:1:1');
SELECT addtime('09:00:00', '2:10:10');

-- 날짜, 시간 사이 차이
SELECT datediff('2022-01-01', now());
SELECT timediff('23:23:59', '2:1:1');

-- 날짜, 시간 생성
SELECT makedate(2021, 55);
SELECT date_format(makedate(2021,55), '%Y.%m.%d');
SELECT maketime(11,11,10);
SELECT quarter('2021-04-04');

-- 데이터 형식 변환 함수
SELECT avg(salesprice) AS "평균 구매 가격" FROM orders;

-- 가격 평균을 정수로
SELECT cast(avg(salesprice) AS signed integer) AS "평균 구매 가격" FROM orders;

-- 조인을 쓰지않고 테이블 결합
SELECT username, salesprice FROM customer AS C, orders AS O WHERE C.custid = O.custid;
-- 조인을 활용
SELECT username, salesprice FROM customer AS C JOIN orders AS O ON C.custid = O.custid;

-- 도서 가격이 20000원 이상인 도서를 주문한 고객의 이름, 주문 도서 이름을 출력 where 조건만 사용
SELECT C.username AS "이름", B.bookname AS "도서명" FROM book AS B, customer AS C, orders AS O
	WHERE C.custid = O.custid and O.bookid = B.bookid and B.price >= 20000;

-- 고객별로 주문도서의 총 판매액, 고객 이름을 주문일자로 정렬(group by 집계 후 oreder by로 정렬)
SELECT username, sum(salesprice) AS "총 판매액", orderdate FROM customer AS C, orders AS O WHERE C.custid = O.custid 
	GROUP BY C.username ORDER BY O.orderdate;
    
-- 외부조인 도서를 구매하지 않은 고객을 포함해 고객 이름, 주문도서의 판매가격을 출력
SELECT username, O.salesprice FROM customer AS C LEFT JOIN orders AS O ON C.custid = O.custid