use bookstore;
INSERT INTO book VALUES(12, "OpenCV 파이썬", "포웨이", 23500);
INSERT INTO book VALUES(13, "자연어 처리 시작하기", "투시즌", 20000);
INSERT INTO book VALUES(14, "SQL이해", "새미디어", 22000);

SELECT * FROM book;

INSERT INTO customer VALUES(6, "박보영", "서울 서초구", "010-9999-5555");
INSERT INTO customer VALUES(7, "오정세", "서울 중구", "010-8888-4444");
INSERT INTO customer VALUES(8, "이병헌", "서울 성북구", "010-7777-3333");

SELECT * FROM customer;

INSERT INTO orders VALUES(11, 6, 12, 23500, STR_TO_DATE("2020-02-01", "%Y-%m-%d"));
INSERT INTO orders VALUES(12, 6, 14, 44000, STR_TO_DATE("2020-02-03", "%Y-%m-%d"));
INSERT INTO orders VALUES(13, 8, 13, 20000, STR_TO_DATE("2020-02-03", "%Y-%m-%d"));
INSERT INTO orders VALUES(14, 3, 13, 20000, STR_TO_DATE("2020-02-04", "%Y-%m-%d"));
INSERT INTO orders VALUES(15, 4, 12, 23500, STR_TO_DATE("2020-02-05", "%Y-%m-%d"));
INSERT INTO orders VALUES(16, 5, 8, 35000, STR_TO_DATE("2020-02-07", "%Y-%m-%d"));

SELECT * FROM orders;

SELECT * FROM book WHERE bookid IN (12, 13, 14);

-- 1. v_order 테이블 만들기 : orderid, custid(0), username, bookid(0), salesprice, orderdate 가져와서
--    custid(c) = custid(o) and bookid(c) = bookid(o)
CREATE VIEW v_order
	AS SELECT O.orderid, O.custid, C.username, O.bookid, O.salesprice, O.orderdate
		FROM orders AS O, customer AS C, book AS B
        WHERE C.custid = O.custid and B.bookid = O.bookid;

SELECT * FROM v_order;

-- 2. v_order 도서 가격이 20000 이상인 레코드로 변경
-- CREATE OR REPLACE VIEW v_order(custid, username, address)
-- AS SELECT C.custid, username, address
-- 	FROM orders O, customer C, book B
--     WHERE B.price >= 20000;
    
-- SELECT * FROM v_order;

-- 3. v_cust_purchase 테이블 생성
-- username(c) '고객', sum(O.saleprice) '구매액'
-- customer C, orders O custid(C) = custid(o)
-- 집계 분석 - 고객을 기분으로 구매역을 내림차순 순서대로
CREATE OR REPLACE VIEW v_cust_purchase
AS SELECT C.username AS "고객", SUM(O.salesprice) AS "구매액"
	FROM customer C, orders O
    WHERE C.custid = O.custid
    GROUP BY 고객
    ORDER BY 구매액 DESC;

SELECT * FROM v_cust_purchase;