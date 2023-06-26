use market_db;

SELECT mem_id, mem_name, addr FROM member;

-- 뷰를 만드는 형식
CREATE VIEW V_memberv_memberv_memberv_member
	AS SELECT mem_id, mem_name, addr FROM member;

SELECT * FROM V_member;

SELECT mem_name, addr FROM V_member
	WHERE addr IN ('서울', '경기');
    
SELECT B.mem_id, M.mem_name, B.Prod_name, M.addr, CONCAT(M.phone1, M.phone2) AS "연락처"
	FROM buy AS B
    INNER JOIN member AS M
    ON B.mem_id = M.mem_id;

CREATE VIEW V_memberbuy
	AS SELECT B.mem_id, M.mem_name, B.Prod_name, M.addr, CONCAT(M.phone1, M.phone2) AS "연락처"
		FROM buy AS B
		INNER JOIN member AS M
		ON B.mem_id = M.mem_id;
        
SELECT * FROM V_member WHERE mem_name = "블랙핑크";

-- 뷰의 생성과 삭제
CREATE VIEW V_viewtest1
	AS SELECT B.mem_id "Member ID", M.mem_name "Member Name", B.Prod_name "Product Name", 
		CONCAT(M.phone1, M.phone2) AS "Office Phone"
		FROM buy AS B
		INNER JOIN member AS M
		ON B.mem_id = M.mem_id;

SELECT * FROM V_viewtest1;
SELECT `member ID`, `member Name` FROM V_viewtest1;		# 컬럼 이름에 공백이 있으면 백틱(`)으로 가져와야함

-- 수정
ALTER VIEW V_viewtest1
	AS SELECT B.mem_id "회원 아이디", M.mem_name "회원 이름", B.Prod_name "제품 이름", 
		CONCAT(M.phone1, M.phone2) AS "연락처"
		FROM buy AS B
		INNER JOIN member AS M
		ON B.mem_id = M.mem_id;
SELECT `회원 아이디`, `회원 이름` FROM V_viewtest1;

-- 삭제
DROP VIEW V_viewtest1;

CREATE OR REPLACE VIEW V_viewtest2
	AS SELECT mem_id, mem_name, addr FROM member;

DESCRIBE V_viewtest2;
DESC member;

SHOW CREATE VIEW V_viewtest2;

-- 뷰 테이블 수정
SELECT * FROM V_member;
UPDATE V_member SET addr = "부산" WHERE mem_id = "BLK";
SELECT * FROM V_member;

INSERT INTO V_member(mem_id, mem_name, addr)
	VALUES("BTS", "방탄소년단", "경기");
    
-- 키가 167이상인 뷰를 만들기
CREATE VIEW V_height167
	AS SELECT * FROM member WHERE height >= 167;
SELECT * FROM V_height167;

-- 키가 167이하인 데이터 삭제
SELECT @@sql_safe_updates;		# unsafe 옵션 : 지우기 방지 옵션
SET sql_safe_updates=0;			# 0 : 가능 / 1 : 불가능
DELETE FROM V_height167 WHERE height < 167;

-- 데이터를 입력
INSERT INTO V_height167 VALUES("TRA", "티아라", 6, "서울", null, null, 159, "2005-01-01");
SELECT * FROM V_height167;

ALTER VIEW V_height167
	AS SELECT * FROM member WHERE height >= 167
		WITH CHECK OPTION;		# 뷰에서 167이하는 입력이 안되도록함

INSERT INTO V_height167 VALUES("TOB", "텔레토비", 4, "영국", null, null, 140, "1995-01-01");

-- 테이블 삭제시 뷰는?
CREATE VIEW V_COMPLEX
	AS SELECT B.mem_id, M.mem_name, B.prod_name, M.addr
	FROM buy B INNER JOIN member M
    ON B.mem_id = M.mem_id;

DROP TABLE IF EXISTS buy, member;		# 원본 테이블 삭제

SELECT * FROM V_COMPLEX;