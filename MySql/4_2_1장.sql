SELECT * FROM buy INNER JOIN member ON buy.mem_id = member.mem_id;
SELECT * FROM buy INNER JOIN member ON buy.mem_id = member.mem_id WHERE buy.mem_id = "GRL";
SELECT buy.mem_id, mem_name, prod_name, addr, concat(phone1, phone2) AS "연락처" FROM buy
	INNER JOIN member ON buy.mem_id = member.mem_id;
    
-- 테이블 위치를 모두 쓰면 콬드가 복잡해지기 때문에 별칭을 씀
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, concat(M.phone1, M.phone2) AS "연락처"
	FROM buy AS B INNER JOIN member AS M ON B.mem_id = M.mem_id;
    
-- 중복 제거 : 1번이라도 구매한 이력이 있는 회원
SELECT DISTINCT M.mem_id, M.mem_name, M.addr FROM buy AS B INNER JOIN member AS M ON B.mem_id = M.mem_id
	ORDER BY M.mem_id;
    
-- 회원가입 후 한 번도 구매한 적이 없는 회원
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM member AS M LEFT OUTER JOIN buy AS B ON B.mem_id = M.mem_id
	ORDER BY M.mem_Id;
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr FROM buy AS B RIGHT OUTER JOIN member AS M ON B.mem_id = M.mem_id
	ORDER BY M.mem_Id;

SELECT DISTINCT M.mem_id, M.mem_name, B.prod_name, M.addr FROM member AS M LEFT OUTER JOIN buy AS B 
	ON B.mem_id = M.mem_id WHERE prod_name IS NULL ORDER BY M.mem_id;
    
-- 기타 조인 : 내용적인 의미는 없지만 대용량 데이터를 만들때 사용
SELECT * FROM buy CROSS JOIN member;

SELECT count(*) FROM sakila.inventory;
SELECT count(*) FROM world.city;
SELECT count(*) FROM sakila.inventory CROSS JOIN world.city;

SELECT * FROM member;
SELECT * FROM buy;
SELECT * FROM member AS M LEFT OUTER JOIN buy AS B ON B.mem_id = M.mem_id;

CREATE TABLE emp_table (emp CHAR(4), manager CHAR(4), phone VARCHAR(8));
INSERT INTO emp_table VALUE ('대표', null, '0000');
INSERT INTO emp_table VALUE ('영업이사', '대표', '1111');
INSERT INTO emp_table VALUE ('관리이사', '대표', '2222');
INSERT INTO emp_table VALUE ('정보이사', '대표', '3333');
INSERT INTO emp_table VALUE ('영업과장', '영업이사', '1111-1');
INSERT INTO emp_table VALUE ('경리부장', '관리이사', '2222-1');
INSERT INTO emp_table VALUE ('인사부장', '관리이사', '2222-2');
INSERT INTO emp_table VALUE ('개발팀장', '정보이사', '3333-1');
INSERT INTO emp_table VALUE ('개발주임', '정보이사', '3333-2');

SELECT *
	FROM emp_table A
		INNER JOIN emp_table B
		ON A.manager = B.emp
        WHERE A.emp = '경리부장';
        
use bookstore;


-- 구매 고객이 가격 8000원 이상 도서를 2권이상 주문한 고객 이름, 수량, 판매 금액을 조회
SELECT * FROM book;
SELECT * FROM orders;
SELECT * FROM customer;

SELECT C.username, O.custid, count(*) AS 수량, sum(O.salesprice) AS "판매금액"  FROM orders AS O
	LEFT JOIN customer AS C ON O.custid = C.custid WHERE salesprice > 8000 GROUP BY custid
		HAVING count(*) >= 2;