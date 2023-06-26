use market_db;
SELECT * FROM member;
SELECT * FROM market_db.member;
SELECT addr, debut_date, mem_name FROM member;
SELECT addr, debut_date "데뷰 일자", mem_name FROM member;
SELECT * FROM member WHERE mem_name = "블랙핑크";

SELECT * FROM member WHERE mem_number = 4;		-- 멤버수가 4명인 그룹의 모든 컬럼 가져오기
SELECT mem_id, mem_name FROM member WHERE height > 162;

-- 키가 165 이상이면서 멤버수가 6명 이상인 그룹
SELECT mem_name, height, mem_number FROM member WHERE height >= 165 and mem_number >= 6;
-- 키가 165 이상이거나 멤버수가 6명 이상인 그룹
SELECT mem_name, height, mem_number FROM member WHERE height >= 165 or mem_number >= 6;
-- 키가 163 이상 165 이하의 멤버 이름 키를 출력
SELECT mem_name, height FROM member WHERE height >= 163 and height <= 165;
SELECT mem_name, height FROM member WHERE height between 163 and 165;

-- addr 경기 전남 경남 셋중 하나인 그룹의 이름과 주소를 조회
SELECT mem_name, addr FROM member WHERE addr = "경기" or addr = "전남" or addr = "경남";
SELECT mem_name, addr FROM member WHERE addr IN("경기", "전남", "경남");

SELECT * FROM member WHERE mem_name LIKE "우%";
SELECT * FROM member WHERE mem_name LIKE "%핑%";
SELECT * FROM member WHERE mem_name LIKE "__핑크";

SELECT height FROM member WHERE mem_name = "에이핑크";
-- 에이핑크의 키보다 큰 그룹을 찾는 쿼리
SELECT * FROM member WHERE height > (SELECT height FROM member WHERE mem_name = "에이핑크");