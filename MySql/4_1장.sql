use market_db;
CREATE TABLE hongong4(
	tinyint_col TINYINT,
    smallint_col SMALLINT,
    int_col int,
    bigint_col BIGINT);
INSERT INTO hongong4 VALUE(127, 32767, 2147483647, 9000000000000000000);
INSERT INTO hongong4 VALUE(127, 32767, 2147483647, 90000000000000000000);
SELECT * FROM hongong4;

DROP TABLE if exists buy, member;
CREATE TABLE member(
	mem_id CHAR(8) NOT NULL PRIMARY KEY,
	mem_name VARCHAR(10) NOT NULL,
	mem_number TINYINT NOT NULL,
	addr CHAR(2) NOT NULL,
	phone1 CHAR(3), 
	phone2 CHAR(8),
	height TINYINT UNSIGNED,
	debut_date DATE
	);

CREATE DATABASE netflix_db;
use netflix_db;
CREATE TABLE movie(
	movie_id INT,
	movie_title VARCHAR(30),
	movie_director VARCHAR(30),
	movie_star VARCHAR(30),
	movie_script LONGTEXT,		-- 42억자
    movie_film LONGBLOB);		-- 4G


-- 변수의 사용
use market_db;
SET @myVar1 = 5;
SET @myVar2 = 4.52;
SELECT @myVar1;
SELECT @myVar1 + @myVar2;

SET @txt = "가수 이름 => ";
SET @height = 166;
SELECT @txt, mem_name FROM member WHERE height > @height;

SET @count = 3;
SELECT mem_name, height FROM member ORDER BY height LIMIT 3;		# LIMIT에서는 변수 사용 x

SET @count = 3;
PREPARE mysql FROM "SELECT mem_name, height FROM member ORDER BY height LIMIT ?";
EXECUTE mysql USING @count;

SELECT avg(price) "평균가격" FROM buy;

-- 형변환
SELECT cast(avg(price) AS signed)  "평균 가격" FROM buy;
SELECT convert(avg(price), signed)  "평균 가격" FROM buy;

SELECT cast("2022$12$12" AS Date);
SELECT cast("2022/12/12" AS Date);
SELECT cast("2022%12%12" AS Date);
SELECT cast("2022@12@12" AS Date);

SELECT num, concat(cast(price AS CHAR), 'X', cast(amount AS CHAR), "="), price * amount FROM buy;

SELECT "100" + "200";
SELECT concat("100", "200");
SELECT concat(100, "200");
SELECT 1 > "2mega";		# 정수인 2로 변환되서 비교
SELECT 3 > "2mega";		# 정수인 2로 변환되서 비교
SELECT 0 = "mega2";		# 문자는 0으로 변환