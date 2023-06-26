DELIMITER $$
CREATE PROCEDURE ifProc1()
BEGIN
	if 100 = 100 then
		SELECT "100은 100과 같다";
    end if;
END $$
DELIMITER ;

CALL ifProc1();

DROP PROCEDURE IF EXISTS ifProc2;
DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE myNum INT;		-- @변수 함수 밖에서 선언 / DECLARE변수 함수 안에서 선언
    SET myNum = 200;
    if myNum = 100 then
		SELECT "100입니다.";
	else
		SELECT "100이 아닙니다.";
	end if;
END $$
DELIMITER ;

CALL ifProc2();

DROP PROCEDURE IF EXISTS ifProc3;
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE debutDate DATE;		-- 데뷰일
    DECLARE curDate DATE;		-- 오늘 날짜
    DECLARE days INT;			-- 활동한 일수
    
    SELECT debut_date INTO debutDate		-- 데뷰 데이트 컬럼을 변수에 대입
		FROM market_db.member
        WHERE mem_id = "APN";
	
	SET  curDate = current_date();		-- 현재 날짜
    SET days = datediff(curDate, debutDate);	-- 일 단위
    
    IF (days/365) >= 5 THEN
		SELECT CONCAT ("데뷔한 지", days, "일이나 지났습니다. 축하합니다!");
	else
		SELECT "데뷔한 지" + days + "일밖에 안되었네요. 화이팅!";
	END IF;
END $$
DELIMITER ;

CALL ifProc3();

SELECT IF (100 > 300, '크다', '작다');

-- 다중 분기
SELECT
CASE 100
	WHEN 10 THEN "십"
    WHEN 50 THEN "오십"
    WHEN 100 THEN "일백"
    ELSE "기타"
END
AS "결과";


DROP PROCEDURE IF EXISTS caseProc;
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
	DECLARE point INT;
    DECLARE credit CHAR(1);
    SET point = 88;
    
    CASE
		WHEN point > 90 THEN
			SET credit = "A";
		WHEN point > 80 THEN
			SET credit = "B";
		WHEN point > 70 THEN
				SET credit = "C";
		WHEN point > 60 THEN
			SET credit = "D";
		ELSE
			SET credit = "F";
	END CASE;
    SELECT CONCAT("취득 점수 --> ", point), CONCAT("학점 --> ", credit);
END $$
DELIMITER ;

CALL caseProc();

-- case문 활용 구매액 기준 회원 등급 만들기
SELECT mem_id, SUM(price * amount) AS "총구매액"
	FROM buy
    GROUP BY mem_id;
-- 내림차순으로 정렬
SELECT mem_id, SUM(price * amount) AS "총구매액"
	FROM buy
    GROUP BY mem_id
    ORDER BY SUM(price * amount) DESC;
-- 구매 테이블과 회원 테이블을 조인
SELECT M.mem_id, M.mem_name, SUM(price * amount) AS "총 구매액"
	FROM buy AS B
    INNER JOIN member M
    ON B.mem_id = M.mem_id
    GROUP BY M.mem_id
    ORDER BY SUM(price * amount) DESC;
-- 한 번도 안 산 사람도 나와야 하기 때문에 OUTER JOIN을 해야함
SELECT M.mem_id, M.mem_name, SUM(price * amount) AS "총 구매액"
	FROM buy AS B
    RIGHT OUTER JOIN member M
    ON B.mem_id = M.mem_id
    GROUP BY M.mem_id
    ORDER BY SUM(price * amount) DESC;
-- 셀렉트문 안에 조건문을 써줌
SELECT M.mem_id, M.mem_name, SUM(price * amount) AS "총 구매액",
	CASE
		WHEN SUM(price * amount) >= 1500 THEN "최우수고객"
        WHEN SUM(price * amount) >= 1000 THEN "우수고객"
        WHEN SUM(price * amount) >= 1 THEN "일반고객"
        ELSE "유령고객"
	END "회원등급"
	FROM buy AS B
    RIGHT OUTER JOIN member M
    ON B.mem_id = M.mem_id
    GROUP BY M.mem_id
    ORDER BY SUM(price * amount) DESC;
    
-- while문 1~100까지 더하는 프로시저 만들기
DROP PROCEDURE IF EXISTS whileProc;
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
    DECLARE i INT;		# 1~100까지 증가할 변수
    DECLARE hap INT;	# 합계를 넣어줄 변수
    SET i = 1;
    SET hap = 0;
    WHILE (i <= 100) DO
		SET hap = hap + i;
        SET i = i + 1;
	END WHILE;
    SELECT "1부터 100까지의 합 ==> ", hap;
END $$
DELIMITER ;

CALL whileProc();

-- while문의 응용
DROP PROCEDURE IF EXISTS whileProc2;
DELIMITER $$
CREATE PROCEDURE whileProc2()
BEGIN
    DECLARE i INT;		# 1~100까지 증가할 변수
    DECLARE hap INT;	# 합계를 넣어줄 변수
    SET i = 1;
    SET hap = 0;
    
    myWhile:		# 레이블 지정
    WHILE (i <= 100) DO
		IF (i % 4 = 0) THEN
			SET i = i + 1;
            ITERATE myWhile;
		END IF;
        SET hap = hap + i;
        IF (hap > 1000) THEN
			LEAVE myWhile;
		END IF;
        SET i = i + 1;
	END WHILE;
    SELECT "1부터 100까지의 합(4의 배수 제외), 1000 넘으면 종료 ==> ", hap;
END $$
DELIMITER ;

CALL whileProc2();

-- 동적 SQL
PREPARE myQuery
	FROM 'SELECT * FROM member WHERE mem_id = "BLK"';
EXECUTE myQuery;
DEALLOCATE PREPARE myQuery;		# 동적 sql 해제

-- 출립문 내역
CREATE TABLE gate_table(
	id INT AUTO_INCREMENT PRIMARY KEY,
    entry_time DATETIME);

SET @curDate = current_timestamp();
PREPARE myQuery
	FROM 'INSERT INTO gate_table VALUES(null, ?)';
EXECUTE myQuery USING @curDate;
DEALLOCATE PREPARE myQuery;
SELECT * FROM gate_table;