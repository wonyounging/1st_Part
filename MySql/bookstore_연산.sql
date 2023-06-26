/* 1. 산술 연산자*/
SELECT 1;
SELECT 1 + 1;
SELECT 0.1;
SELECT 1-1;
SELECT 100/20;
SELECT 5.0/2;

-- book 테이블에서 price 값에 0.05
SELECT price * 0.05 FROM book;
SELECT price / 2 FROM book;
SELECT (price / 2) * 100 FROM book;

/* 2. 비교 연산자*/
SELECT 1 > 100;
SELECT 1 < 100;
SELECT 10 = 10;
SELECT 101 <> 10;
SELECT 101 != 10;

/* 3. 논리 연산자*/
SELECT (10 >= 10) and (5 < 10);
SELECT (10 > 10) and (5 < 10);
SELECT (10 > 10) or (5 < 10);
SELECT not (10 > 10);

/* 4. 집계 함수 */
-- 북스토어에서 판매한 건수
SELECT count(*) FROM orders;
-- 고객이 주문한 도서의 총 판매액을 구하시오
SELECT sum(salesprice) FROM orders;
-- 고객이 주문한 도서의 총 판매액인데 '총매출'로 표시
SELECT sum(salesprice) AS 총매출 FROM orders;
SELECT avg(salesprice) AS 매출평균 FROM orders;
-- 판매액을 합계 평균, 최저, 최고가 구하기
SELECT sum(salesprice) AS 총매출액,
		avg(salesprice) AS 매출평균,
        min(salesprice) AS 최저가,
        max(salesprice) AS 최고가
FROM orders;

-- 1. 가격이 10000원보다 크고 20000원 이하인 도서를 검색
SELECT * FROM book WHERE price between 10000 and 20000;
-- 2. 주문일자가 2021-02-01에서 2021-02-07내 주문내역 검색
SELECT * FROM orders WHERE orderdate between "2021-02-01" and "2021-02-07";
-- 3. 도서번호가 3,4,5,6인 주문목록 검색
SELECT * FROM orders WHERE bookid between 3 and 6;
-- 4. 박씨 성을 가진 고객 검색
SELECT * FROM customer WHERE username LIKE "박%";
-- 5. 2번째 글자가 '지'인 고객 검색
SELECT * FROM customer WHERE username LIKE "_지%";
-- 6. '철학의 역사'를 출간한 출판사 검색
SELECT * FROM book WHERE bookname = "철학의 역사";
-- 7. 도서 이름에 썬이 포함되어 있고 20000원 이상인 도서
SELECT * FROM book WHERE bookname LIKE "%썬%" and price >= 7000;
-- 8. 출판사 이름이 '정론사' 혹은 '새미디어'인 도서를 검색
SELECT * FROM book WHERE publisher = "정론사" or publisher = "새미디어";