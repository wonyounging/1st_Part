-- 클러스터형 인덱스
CREATE TABLE cluster(mem_id CHAR(8), mem_name VARCHAR(10));
INSERT INTO cluster VALUES("TWC", "트와이스");
INSERT INTO cluster VALUES("BLK", "블랙핑크");
INSERT INTO cluster VALUES("WMN", "여자친구");
INSERT INTO cluster VALUES("OMY", "오마이걸");
INSERT INTO cluster VALUES("GRL", "소녀시대");
INSERT INTO cluster VALUES("ITZ", "있지");
INSERT INTO cluster VALUES("RED", "레드벨벳");
INSERT INTO cluster VALUES("APN", "에이핑크");
INSERT INTO cluster VALUES("SPC", "우주소녀");
INSERT INTO cluster VALUES("MMU", "마마무");

SELECT * FROM market_db.cluster;

ALTER TABLE cluster
	ADD CONSTRAINT PRIMARY KEY(mem_id);
SELECT * FROM cluster;

-- 보조 인덱스
CREATE TABLE second(mem_id CHAR(8), mem_name VARCHAR(10));
INSERT INTO second VALUES("TWC", "트와이스");
INSERT INTO second VALUES("BLK", "블랙핑크");
INSERT INTO second VALUES("WMN", "여자친구");
INSERT INTO second VALUES("OMY", "오마이걸");
INSERT INTO second VALUES("GRL", "소녀시대");
INSERT INTO second VALUES("ITZ", "있지");
INSERT INTO second VALUES("RED", "레드벨벳");
INSERT INTO second VALUES("APN", "에이핑크");
INSERT INTO second VALUES("SPC", "우주소녀");
INSERT INTO second VALUES("MMU", "마마무");
SELECT * FROM second;

ALTER TABLE second
	ADD CONSTRAINT UNIQUE (mem_id);
SELECT * FROM second;