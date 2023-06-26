use market_db;
CREATE TABLE table1(
	col1 INT PRIMARY KEY,		# 기본키로 생성하면 자동으로 클러스터형 인덱스가 생산됨
	col2 INT,
    col3 INT);
    
SHOW INDEX FROM table1;

CREATE TABLE table2(
	col1 INT PRIMARY KEY,		# 기본키로 생성하면 자동으로 클러스터형 인덱스가 생산됨
	col2 INT UNIQUE,
    col3 INT UNIQUE);
    
SHOW INDEX FROM table2;

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member(
	mem_id CHAR(8),
    mem_name VARCHAR(10),
    mem_number INT,
    addr CHAR(2));

INSERT INTO member VALUES ("TWC", "트와이스", 9, "서울");
INSERT INTO member VALUES ("BLK", "블랙핑크", 4, "경남");
INSERT INTO member VALUES ("WMN", "여자친구", 6, "경기");
INSERT INTO member VALUES ("OMY", "오마이걸", 7, "서울");
SELECT * FROM member;

ALTER TABLE member
	ADD CONSTRAINT
    PRIMARY KEY (mem_id);
SELECT * FROM member;

ALTER TABLE member DROP PRIMARY KEY;		# 기본키 제거
SELECT * FROM member;

ALTER TABLE member
	ADD CONSTRAINT
    PRIMARY KEY (mem_name);
SELECT * FROM member;

-- 보조 인덱스
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member(
	mem_id CHAR(8),
    mem_name VARCHAR(10),
    mem_number INT,
    addr CHAR(2));
    
INSERT INTO member VALUES ("TWC", "트와이스", 9, "서울");
INSERT INTO member VALUES ("BLK", "블랙핑크", 4, "경남");
INSERT INTO member VALUES ("WMN", "여자친구", 6, "경기");
INSERT INTO member VALUES ("OMY", "오마이걸", 7, "서울");
SELECT * FROM member;

ALTER TABLE member
	ADD CONSTRAINT
    UNIQUE (mem_id);		# 유니크는 찾아보기가 여러개 만들어지는 것이지 내용의 순서가 바뀌지는 않음
SELECT * FROM member;

ALTER TABLE member
	ADD CONSTRAINT
    UNIQUE (mem_name);		# 유니크는 찾아보기가 여러개 만들어지는 것이지 내용의 순서가 바뀌지는 않음
SELECT * FROM member;

INSERT INTO member VALUES("GRL", "소녀시대", 8, "서울");
SELECT * FROM member;