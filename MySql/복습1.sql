use sakila;
-- actor, film, customer, staff, rental, inventory, country
SELECT * FROM actor LIMIT 5;
SELECT count(*) FROM film LIMIT 5;
SELECT count(*) FROM customer LIMIT 5;
SELECT count(*) FROM staff LIMIT 5;
SELECT count(*) FROM rental LIMIT 5;
SELECT count(*) FROM inventory LIMIT 5;
SELECT count(*) FROM country LIMIT 5;

-- 배우 이름을 합쳐서 '배우'컬럼으로 조회
SELECT UPPER(CONCAT(first_name, '  ', last_name)) AS '배우' FROM actor;

-- son으로 끝나는 성을 가지는 배우 조회
SELECT * FROM actor WHERE UPPER(last_name) LIKE "%SON";

-- 배우들이 출연한 영화를 배우 이름을 합쳐 '배우'컬럼으로 조회(배우, title, release_year)
SELECT UPPER(CONCAT(first_name, '  ', last_name)) AS '배우', F.title, F.release_year
	FROM actor A, film_actor FA, film F
    WHERE F.film_id = FA.film_id and A.actor_id = FA.actor_id;

-- 성(last_name)별 배우 숫자, 내림차순(DESC), 성 알파벳순 오름차순(ASC)
SELECT last_name, COUNT(*) AS "명" FROM actor
	GROUP BY last_name
    ORDER BY 명 DESC, last_name;

-- country 테이블 id와 국가를 조회 australia, germany
SELECT country_id, country FROM country WHERE country = "australia" or country = "germany";
SELECT country_id, country FROM country WHERE country IN("australia", "germany");

-- 스테프 테이블 성과 이름을 합치고 staff로 하고, staff와 address를 합치고, address, district, postal, code, city_id를 조회
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS "staff", ADR.address, ADR.district, ADR.postal_code, ADR.city_id 
	FROM staff STF
    LEFT JOIN address ADR
    ON STF.address_id = ADR.address_id;
    
-- 스테프의 성과 이름을 합치고 payment 테이블과 합치고 staff이름을 기준으로 그룹화하여 2005년 7월 데이터 조회
SELECT CONCAT(first_name, ' ', last_name) AS "staff", SUM(PAY.amount)
	FROM staff STF
    LEFT JOIN payment PAY
    ON STF.staff_id = PAY.staff_id
 	WHERE MONTH(PAY.payment_date) = 7 and YEAR(PAY.payment_date) = 2005
    GROUP BY STF.first_name, STF.last_name;

-- 영화별 출연 배우의 수 film, film_actor를 합치고 타이틀, 출연자 수 컬럼명 : 배우
SELECT F.title, COUNT(*) AS "출연자 수"
	FROM film F
    LEFT JOIN film_actor FA
    ON F.film_id = FA.film_id
    GROUP BY F.title
    ORDER BY "출연자 수" DESC;
    
-- 영화 제목이 'halloween nuts' 배우 이름이 성과 이름을 합쳐서 나오도록 조회
SELECT CONCAT(first_name, ' ', last_name) '배우'  FROM actor
	WHERE actor_id IN(SELECT actor_id FROM film_actor
    WHERE film_id IN(SELECT film_id FROM film WHERE LOWER(title) = lower('halloween nuts')));
        
-- 국가가 'Canada'인 고객 이름을 서브쿼리로 찾기
SELECT CONCAT(first_name, ' ', last_name) AS "고객", email FROM customer
	WHERE address_id IN
    (SELECT address_id FROM address WHERE city_id IN
    (SELECT city_id FROM city WHERE country_id IN
	(SELECT country_id FROM country WHERE country = "canada")));
    
-- join을 활용해서 국가가 canada인 고객 이름
SELECT CONCAT(first_name, ' ', last_name) AS "고객", email
	FROM customer CUS JOIN address ADR ON CUS.address_id = ADR.address_id
    JOIN city CIT ON ADR.city_id = CIT.city_id
    JOIN country COU ON CIT.country_id = COU.country_id
    WHERE COU.country = 'canada';
    
-- 1. 영화에서 PG등급 G등급 조회
-- rating, count(*) 수량 film
SELECT rating, COUNT(*) AS "수량"
	FROM film
    WHERE rating = "PG" or rating = "G"
    GROUP BY rating;
    
-- 2. pg 또는 g등급 영화 이름 rating, title, release_year
SELECT rating, title, release_year
	FROM film
    WHERE rating = "PG" or rating = "G";
    
-- 3. 등급별 rating, count
SELECT rating, COUNT(*) AS "수량"
	FROM film
    GROUP BY rating;
    
-- rental_rate가 1~6 사이인 등급별 영화의 수를 출력
SELECT rating, COUNT(*) FROM film
	WHERE rental_rate > 1.0 and rental_rate < 6.0
    GROUP BY rating;