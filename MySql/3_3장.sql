use market_db;
CREATE TABLE hongong1 (toy_id INT, toy_name CHAR(4), age INT);
INSERT INTO hongong1 VALUE(1, '우디', 25);
SELECT * FROM hongong1;
INSERT INTO hongong1(toy_id, toy_name) VALUE(2, '버즈');
INSERT INTO hongong1(toy_name, age, toy_id) VALUE('제시', 20, 3);

CREATE TABLE hongong2(
	toy_id INT auto_increment primary key,
    toy_name CHAR(4),
    age INT);
INSERT INTO hongong2 VALUE(null, "보핍", 25);
INSERT INTO hongong2 VALUE(null, "슬랭키", 22);
INSERT INTO hongong2 VALUE(null, "렉스", 21);
SELECT last_insert_id();		-- 마지막 인텍스 아이디 확인
ALTER TABLE hongong2 auto_increment=100;
INSERT INTO hongong2 VALUE(null, "재남", 35);
SELECT * FROM hongong2;
SELECT last_insert_id();		-- 마지막 인텍스 아이디 확인

CREATE TABLE hongong3(
	toy_id INT auto_increment primary key,
    toy_name CHAR(4),
    age INT);
ALTER TABLE hongong3 auto_increment=1000;
SET @@auto_increment_increment=3; # 증가값이 3씩 증가
-- 시스템 변수 확인
show global variables;
INSERT INTO hongong3 VALUE(null, "토마스", 20);
INSERT INTO hongong3 VALUE(null, "제임스", 23);
INSERT INTO hongong3 VALUE(null, "고든", 25);
SELECT * FROM hongong3;

SELECT count(*) FROM world.city;
DESC world.city;		# discribe / 정보 확인

SELECT * FROM world.city limit 5;
CREATE TABLE city_popul(city_name CHAR(35), population INT);
INSERT INTO city_popul SELECT Name, Population FROM world.city;
SELECT * FROM city_popul limit 5;

-- UPDATE
SET sql_safe_updates=0;

SELECT * FROM city_popul WHERE city_name = "Seoul";
UPDATE city_popul SET city_name = "서울" WHERE city_name = "Seoul";
SELECT * FROM city_popul WHERE city_name = "Seoul";
SELECT * FROM city_popul WHERE city_name = "서울";

-- New York을 찾아서 뉴욕으로 바꾸고 인구수도 0으로 변경
SELECT * FROM city_popul WHERE city_name = "New York";
UPDATE city_popul SET city_name = "뉴욕", population = 0 WHERE city_name = "New York";
SELECT * FROM city_popul WHERE city_name = "뉴욕";

UPDATE city_popul SET population = population / 10000;
SELECT * FROM city_popul LIMIT 5;

-- DELETE
DELETE FROM city_popul WHERE city_name LIKE 'New%';
SELECT * FROM city_popul WHERE city_name LIKE 'New%';

DELETE FROM city_popul WHERE city_name LIKE 'New%' LIMIT 5;


CREATE TABLE big_table1(SELECT * FROM world.city, sakila.country);
CREATE TABLE big_table2(SELECT * FROM world.city, sakila.country);
CREATE TABLE big_table3(SELECT * FROM world.city, sakila.country);
SELECT count(*) FROM big_table1;

-- DELETE TABLE (조건문 사용 가능)
DELETE FROM big_table1;

-- DROP TABLE
DROP TABLE big_table2;

-- TRUNCATE (조건문 사용 불가능)
TRUNCATE big_table3;
SELECT * FROM big_table3;
