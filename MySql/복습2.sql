-- 등급별 영화 수 합계, 평균, 최대, 최소	rental, rental_rate, 평균 내림차순
SELECT rating, COUNT(*) "수량", SUM(rental_rate), AVG(rental_rate) "평균", MAX(rental_rate) "최대", MIN(rental_rate) "최소"
	FROM film 
	GROUP BY rating, rental_rate
    ORDER BY AVG(rental_rate) DESC;
    
-- 등급별 영화 갯수, 등급, 평균 렌탈 rate를 조회하고 평균 rental rate를 내림차순으로 조회
SELECT rating, COUNT(*) "영화 수", AVG(rental_rate) "평균", MAX(rental_rate) "최대", MIN(rental_rate) "최소"
	FROM film 
	GROUP BY rating
    ORDER BY 평균 DESC; 

-- 분류가 family인 film 테이블에서 서브쿼리를 이용해 조회
-- film, film_category, category 테이블 활용
SELECT film_id, title, release_year FROM film WHERE film_id IN(
	SELECT film_id FROM film_category WHERE category_id IN(
    SELECT category_id FROM category WHERE name = "Family"));

-- action 영화 이름, 영화 수, 합계(rental_rate), 평균, 최소, 최대 집계
-- category, film, film_category 테이블 활용
SELECT C.name, count(F.film_id) AS "영화수", SUM(F.rental_rate), AVG(F.rental_rate), MIN(F.rental_rate), MAX(F.rental_rate)
	FROM film F, film_category FC
    JOIN category C
    ON FC.category_id = C.category_id
    WHERE FC.film_id = F.film_id
    GROUP BY C.name, F.rental_rate
    HAVING C.name = "Action"
    ORDER BY AVG(F.rental_rate) DESC;

-- 가장 대여비가 높은 영화 분류 조회 2개(name, sum(ifnull, 0으로)을 사용 payment 테이블에서 amount
-- name은 category_name으로 합계는 revenue로 별칭)
-- category, film_category, inventory, payment rental 테이블 join 후 name으로 그룹 분석 후 revenue로 내림차순
SELECT CAT.name AS categoty_name, SUM(ifnull(PAY.amount, 0)) AS "revenue"
	FROM category CAT
    LEFT JOIN film_category FLM_CAT
		ON CAT.category_id = FLM_CAT.category_id
    LEFT JOIN film FIL
		ON FLM_CAT.film_id = FIL.film_id
	LEFT JOIN inventory INV
		ON FIL.film_id = INV.film_id
	LEFT JOIN rental REN
		ON INV.inventory_id = REN.inventory_id
	LEFT JOIN payment PAY
		ON REN.rental_id = PAY.rental_id
	GROUP BY CAT.name
    ORDER BY revenue DESC;
 
-- 위의 쿼리문 결과를 뷰로 생성 v_cat_revenue로 하고 뷰를 조회
CREATE OR REPLACE VIEW v_cat_revenue AS
SELECT CAT.name AS categoty_name, SUM(ifnull(PAY.amount, 0)) AS "revenue"
	FROM category CAT
    LEFT JOIN film_category FLM_CAT
		ON CAT.category_id = FLM_CAT.category_id
    LEFT JOIN film FIL
		ON FLM_CAT.film_id = FIL.film_id
	LEFT JOIN inventory INV
		ON FIL.film_id = INV.film_id
	LEFT JOIN rental REN
		ON INV.inventory_id = REN.inventory_id
	LEFT JOIN payment PAY
		ON REN.rental_id = PAY.rental_id
	GROUP BY CAT.name
    ORDER BY revenue DESC;
    SELECT * FROM v_cat_revenue LIMIT 10;