-- 스토어드 함수
-- 함수 생성을 위해 권한을 생성
SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS sumFunc;
DELIMITER $$
CREATE FUNCTION sumFunc(number1 INT, number2 INT)
	RETURNS INT
BEGIN
	RETURN number1 + number2;
END $$
DELIMITER ;

SELECT sumFunc(100, 200) AS '합계';

-- 데뷰 년도를 입력하면 활동기간 출력하는 함수
DROP FUNCTION IF EXISTS calcYearFunc;
DELIMITER $$
CREATE FUNCTION calcYearFunc(dYear INT)
	RETURNS INT
BEGIN
	DECLARE runYear INT;
    SET runYear = YEAR(CURDATE()) - dYear;
    RETURN runYear;
END $$
DELIMITER ;

SELECT calcYearFunc(2010) AS '활동 햇수';

SELECT calcYearFunc(2007) INTO @debut2007;
SELECT calcYearFunc(2013) INTO @debut2013;
SELECT @debut2007 - @debut2013 AS '차이'; 

SELECT mem_id, mem_name, calcYearFunc(YEAR(debut_date)) AS '활동 햇수'
	FROM member;
    
-- 함수 내용 확인
SHOW CREATE FUNCTION calcYearFunc;

DROP FUNCTION calcYearFunc;

-- 커서
-- 1. 사용할 변수 준비
DECLARE memNumber INT;		# 회원 인원수
DECLARE cnt INT DEFAULT 0;		# 읽은 행의 변수 개수
DECLARE totNumber INT DEFAULT 0;	# 인원의 합계
DECLARE endOfRow BOOLEAN DEFAULT FALSE;	# 마지막 행이면 T 

-- 2. 커서 선언
DECLARE memberCursor Cursor FOR
	SELECT mem_number FROM member;

-- 3. 반복 조건 선언하기
DECLARE CONTINUE HANDLER
	FOR NOT FOUND SET endOfRow = TRUE;
    
-- 4. 커서 열기
OPEN memberCursor;

-- 5. 행 반복하기
cursor_loop : LOOP
	FETCH memberCursor INTO memNumber;
	
    IF endOfRow THEN
		LEAVE cursor_loop;
	END IF;
    
    SET cnt = cnt + 1;
    SET totNumber = totNumber + memNumber;
END LOOP cursor_loop;

SELECT (tot?Number / cnt) AS '회원의 평균 인원 수';

-- 6. 커서 닫기
CLOSE memberCursor;

-- 7. 커서의 통합코드
DROP PROCEDURE IF EXISTS cursor_proc;
DELIMITER $$
CREATE PROCEDURE cursor_proc()
BEGIN
	DECLARE memNumber INT;		# 회원 인원수
	DECLARE cnt INT DEFAULT 0;		# 읽은 행의 변수 개수
	DECLARE totNumber INT DEFAULT 0;	# 인원의 합계
	DECLARE endOfRow BOOLEAN DEFAULT FALSE;	# 마지막 행이면 T 
    
	DECLARE memberCursor Cursor FOR
	SELECT mem_number FROM member;
    
    DECLARE CONTINUE HANDLER
	FOR NOT FOUND SET endOfRow = TRUE;
    
	OPEN memberCursor;

	cursor_loop : LOOP
		FETCH memberCursor INTO memNumber;
		
		IF endOfRow THEN
			LEAVE cursor_loop;
		END IF;
		
		SET cnt = cnt + 1;
		SET totNumber = totNumber + memNumber;
	END LOOP cursor_loop;

	SELECT (totNumber / cnt) AS '회원의 평균 인원 수';

	CLOSE memberCursor;
END $$
DELIMITER ;

CALL cursor_proc();