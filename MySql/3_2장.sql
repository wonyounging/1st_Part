use market_db;
SELECT * FROM member;
SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date;
SELECT mem_id, mem_name, debut_date FROM member ORDER BY  debut_date DESC;
SELECT mem_id, mem_name, debut_date FROM member ORDER BY  debut_date ASC;
SELECT mem_id, mem_name, debut_date, height FROM member WHERE height > 164 ORDER BY  height DESC;
SELECT mem_id, mem_name, debut_date, height FROM member WHERE height >= 164 ORDER BY  height DESC, debut_date ASC;

-- LIMIT : 출력 개수를 제한
SELECT * FROM member LIMIT 3;
-- 데뷰 날짜로 오름차순 정렬 후 3개만 출력
SELECT mem_id, mem_name, debut_date FROM member ORDER BY debut_date ASC LIMIT 3;

-- 이름, 데뷰일을 내림차순(DESC) 키 순으로 정렬하는데 중간부터 시작(3번째부터 시작)하고 2개만 출력
SELECT mem_name, debut_date, height FROM member ORDER BY height DESC LIMIT 3, 2;

-- DISTINCT
SELECT * FROM member;
-- 주소만 뽑아서 오름차순 정렬
SELECT addr FROM member ORDER BY addr;
-- 주소의 중복을 제거하고 유니크한 값만 출럭
SELECT DISTINCT addr FROM member ORDER BY addr;
-- 멤버id 순으로 정렬하고 멤버id롸 id amount 출력
SELECT mem_id, amount FROM buy ORDER BY mem_id;
-- 그룹별 amount의 종합 조회
SELECT mem_id, sum(amount) FROM buy GROUP BY mem_id;
SELECT mem_id "회원 아이디", sum(amount) AS "총 구매 개수" FROM buy GROUP BY mem_id;

SELECT * FROM buy;
-- 총 구매 금액으로 조회
SELECT mem_id AS "회원 ID", sum(price * amount) "총 구매 금액" FROM buy GROUP BY mem_id;
-- 평균 구매 개수
SELECT avg(amount) AS "평균 구매 개수" FROM buy;
-- 그룹별 평균 구매 개수
SELECT mem_id, avg(amount) AS "평균 구매 개수" FROM buy GROUP BY mem_id;

-- count
SELECT * FROM member;
SELECT count(*) FROM member;
SELECT count(phone1) "연락처가 있는 회원" FROM member;

-- having
SELECT mem_id AS "회원 ID", sum(price * amount) "총 구매 금액" FROM buy GROUP BY mem_id;
-- 총 구매 금액이 1000원 이상 산 회원 조회
-- WHERE 조건, GROUP BY랑 사용 불가능
SELECT mem_id AS "회원 ID", sum(price * amount) "총 구매 금액" FROM buy WHERE sum(price * amount) > 1000 GROUP BY mem_id;
-- HAVING 조건, GROUP BY랑 사용 가능
SELECT mem_id AS "회원 ID", sum(price * amount) "총 구매 금액" FROM buy GROUP BY mem_id HAVING sum(price * amount) > 1000;
-- 순서대로 조회
SELECT mem_id AS "회원 ID", sum(price * amount) "총 구매 금액" FROM buy GROUP BY mem_id HAVING sum(price * amount) > 1000
ORDER BY sum(price * amount) DESC;


-- bookstore_db 선택
use bookstore;
SELECT * FROM book;
-- 1. 도서를 이름 순으로 검색
SELECT * FROM book ORDER BY bookname;
-- 2. 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색
SELECT * FROM book ORDER BY price, bookname;
-- 3. 도서를 가격의 내림차순으로 검색하고 만약 가격이 같다면 출판사의 오름차수능로 검색
SELECT * FROM book ORDER BY price DESC, publisher;
-- 4. 주문일자를 내림차순으로 정렬
SELECT * FROM orders ORDER BY orderdate DESC;
-- 5. book 테이블에서 bookname이 '썬'이 들어가있고 가격이 20000원 이하인 책을 출판사이름을 내림차순으로 조회(모든 컬럼 조회)
SELECT * FROM book WHERE bookname LIKE "%썬%" and price <= 20000 ORDER BY publisher DESC;
-- 6. order 테이블에서 saleprice가 1000원 이상인 데이터를 book id 오름차순으로 조회(모든 컬럼 조회)
SELECT * FROM orders WHERE salesprice >= 1000 ORDER BY bookid;