CREATE DATABASE naver_db;
use naver_db;
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member(
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
    mem_name VARCHAR(10) NOT NULL,
    height TINYINT UNSIGNED NULL);
DESCRIBE member;		# 표를 요약해서 볼 수 있음

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member(
	mem_id CHAR(8) NOT NULL,
    mem_name VARCHAR(10) NOT NULL,
    height TINYINT UNSIGNED NULL,
    PRIMARY KEY (mem_id));
DESCRIBE member;		# 표를 요약해서 볼 수 있음

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member(
	mem_id CHAR(8) NOT NULL,
    mem_name VARCHAR(10) NOT NULL,
    height TINYINT UNSIGNED NULL);
ALTER TABLE member		# ALTER를 활용하여 기본키 지정
	ADD CONSTRAINT
    PRIMARY KEY (mem_id);
DESCRIBE member;		# 표를 요약해서 볼 수 있음

DROP TABLE IF EXISTS buy, member;
CREATE TABLE member(
	mem_id CHAR(8) NOT NULL,
    mem_name VARCHAR(10) NOT NULL,
    height TINYINT UNSIGNED NULL,
    CONSTRAINT PRIMARY KEY PK_member_mem_id (mem_id));
    DESCRIBE member;		# 표를 요약해서 볼 수 있음
    
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member(
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
    mem_name VARCHAR(10) NOT NULL,
    height TINYINT UNSIGNED NULL);
CREATE TABLE buy(
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    user_id CHAR(8) NOT NULL,
    prod_name CHAR(6) NOT NULL,
    FOREIGN KEY(user_id) REFERENCES member(mem_id));	# 기준 테이블과 참조 테이블의 외래키의 컬럼명이 같을 필요는 없음
    DESCRIBE member;		# 표를 요약해서 볼 수 있음
    DESCRIBE buy;
    
DROP TABLE IF EXISTS buy;
CREATE TABLE buy(
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    mem_id CHAR(8) NOT NULL,
    prod_name CHAR(6) NOT NULL);
ALTER TABLE buy
	ADD CONSTRAINT FOREIGN KEY(mem_id)
    REFERENCES member(mem_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

INSERT INTO member VALUES("BLK", "블랙핑크", 163);
INSERT INTO buy VALUES(null, "BLK", "지갑");
INSERT INTO buy VALUES(null, "BLK", "맥북");
UPDATE member SET mem_id = "PINK" WHERE mem_id = "BLK";
SELECT * FROM naver_db.buy;
DELETE FROM member WHERE mem_id="PINK";
SELECT * FROM member;

-- 유니크 제약조건
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member(
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
    mem_name VARCHAR(10) NOT NULL,
    height TINYINT UNSIGNED NULL,
    email CHAR(30) NULL UNIQUE);		# 이메일 중복 안됨
INSERT INTO member VALUES("BLK", "블랙핑크", 163, "pink@gmail.com");
INSERT INTO member VALUES("TWC", "트와이스", 167, null);
INSERT INTO member VALUES("APN", "에이핑크", 164, "pink@gmail.com");
    
-- 체크 제약조건
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member(
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
    mem_name VARCHAR(10) NOT NULL,
    height TINYINT UNSIGNED NULL CHECK(height >= 100),
    phone1 CHAR(3) null);
INSERT INTO member VALUES("BLK", "블랙핑크", 163, null);
INSERT INTO member VALUES("TWC", "트와이스", 99, null);

ALTER TABLE member
	ADD CONSTRAINT
    CHECK (phone1 IN('02', '031', '032', '054', '055', '061'));
INSERT INTO member VALUES("TWC", "트와이스", 167, '02');
INSERT INTO member VALUES("OMY", "오마이걸", 167, '010');

-- 기본값 제약조건
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member(
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
    mem_name VARCHAR(10) NOT NULL,
    height TINYINT UNSIGNED DEFAULT 160,
    phone1 CHAR(3) null);

ALTER TABLE member
	ALTER COLUMN phone1 SET DEFAULT '02';
    
INSERT INTO member VALUES("RED", "레드벨벳", 161, '054');
INSERT INTO member VALUES("SPC", "우주소녀", default, default); 