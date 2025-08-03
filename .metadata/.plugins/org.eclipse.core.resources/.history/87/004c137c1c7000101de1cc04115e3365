-- SQL파일 설정 경로: new → SQL File 

-- SQL 문장 작성 
-- *조건:  MyBatis가 자동으로 매핑해주기 위해서는 VO 클래스의 필드명이 데이터베이스 테이블의 컬럼명과 동일해야 한다
--실행: 드래그 → Alt + X → Execute Selected Text

CREATE TABLE BOARD(
	IDX INT NOT NULL AUTO_INCREMENT, 
	TITLE VARCHAR(100) NOT NULL,
	CONTENT VARCHAR(2000) NOT NULL,
	WRITER VARCHAR(30) NOT NULL,
	INDATE DATETIME DEFAULT NOW(), 
	COUNT INT DEFAULT 0,
	PRIMARY KEY(IDX)
)

SELECT * FROM BOARD;

DROP TABLE BOARD;


