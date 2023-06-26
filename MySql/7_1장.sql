DROP PROCEDURE IF EXISTS user_proc;
DELIMITER $$
CREATE PROCEDURE user_proc()
BEGIN
	SELECT * FROM member;
END $$
DELIMITER ;

CALL user_proc();

-- 입력 매개변수 활용
DELIMITER $$
CREATE PROCEDURE user_proc1(IN userName VARCHAR(10))
BEGIN
	SELECT * FROM member WHERE mem_name = userName;
END $$
DELIMITER ;

CALL user_proc1("에이핑크");

DELIMITER $$
CREATE PROCEDURE user_proc2(IN userNumber INT, IN userHeight INT)
BEGIN
	SELECT * FROM member WHERE mem_number > userNumber and height > userHeight;
END $$
DELIMITER ;

CALL user_proc2(6, 165);

-- 출력 매개변수 활용
DROP PROCEDURE IF EXISTS user_proc3;
DELIMITER $$
CREATE PROCEDURE user_proc3(IN txtValue CHAR(10), OUT outValue INT)
BEGIN
	INSERT INTO noTable VALUES(null, txtValue);
    SELECT MAX(id) INTO outvalue FROM noTable;
END $$
DELIMITER ;

DESC noTable;
CREATE TABLE IF NOT EXISTS noTable(
	id INT AUTO_INCREMENT PRIMARY KEY,
    txt CHAR(10));
    
CALL user_proc3('테스트1', @myValue);
SELECT CONCAT('입력된 ID 값 ==> ', @myValue);

-- SQL 프로그래밍 활용 - 조건문
DELIMITER $$
CREATE PROCEDURE ifelse_proc(IN memName VARCHAR(10))
BEGIN
	DECLARE debutYear INT;
    SELECT YEAR(debut_date) INTO debutYear FROM member
		WHERE mem_name = memName;
	
    IF(debutYear >= 2015) THEN
		SELECT "신인 가수네요. 화이팅하세요." AS "메시지";
	ELSE
		SELECT "고참 가수네요. 그동안 수고했어요." AS "메시지";
	END IF;
END $$
DELIMITER ;

CALL ifelse_proc("오마이걸");

-- while 1~100까지 합
-- 1 기본 구조, 2 변수 선언 합, 3 i while문 작성, 4 콜
DROP PROCEDURE IF EXISTS sum_proc;
DELIMITER $$
CREATE PROCEDURE sum_proc()
BEGIN
	DECLARE hap INT;
    DECLARE i INT;
    SET hap = 0;
    SET i = 1;
    
    WHILE (i <= 100) DO
		SET hap = hap + i;
        SET i = i + 1;
    END WHILE;
    SELECT hap AS "합계";
END $$
DELIMITER ;

CALL sum_proc();

-- 4의 배수 제외, 합 1000넘으면 종료
DROP PROCEDURE IF EXISTS sum4_proc;
DELIMITER $$
CREATE PROCEDURE sum4_proc()
BEGIN
	DECLARE hap INT;
    DECLARE i INT;
    SET hap = 0;
    SET i = 1;
    
    
	WHILE (i <= 100) DO
		IF(i / 4 != 0) THEN
			SET hap = hap + i;
			SET i = i + 1;
		END IF;
	END WHILE;
	SELECT hap AS "합계";
END $$
DELIMITER ;

CALL sum4_proc();

-- 동적 SQL
DROP PROCEDURE IF EXISTS dynamic_proc;
DELIMITER $$
CREATE PROCEDURE dynamic_proc(IN tableName VARCHAR(10))
BEGIN
	SET @sqlQuery = concat('select * from ', tableName);
    PREPARE myQuery FROM @sqlQuery;
    EXECUTE myQuery;
    DEALLOCATE PREPARE myQuery;
END $$
DELIMITER ;

CALL dynamic_proc("member");