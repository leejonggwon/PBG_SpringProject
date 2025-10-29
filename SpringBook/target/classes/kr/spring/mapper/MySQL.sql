-- SQL파일 설정 경로: new → SQL File 

-- SQL 문장 작성 
-- *조건:  MyBatis가 자동으로 매핑해주기 위해서는 VO 클래스의 필드명이 데이터베이스 테이블의 컬럼명과 동일해야 한다
--실행: 드래그 → Alt + X → Execute Selected Text

CREATE TABLE BOARD(
	IDX INT NOT NULL AUTO_INCREMENT, -- 기본키, 자동 증가되는 유일한 번호--
	TITLE VARCHAR(100) NOT NULL,
	CONTENT VARCHAR(2000) NOT NULL,
	WRITER VARCHAR(30) NOT NULL,
	INDATE DATETIME DEFAULT NOW(), -- 기본값으로 현재 날짜와 시간 저장--
	COUNT INT DEFAULT 0,
	PRIMARY KEY(IDX)
)

--조회
SELECT * FROM BOARD;

--테이블 식제
DROP TABLE BOARD;

DELETE FROM BOARD WHERE IDX = 37;


--입력
INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES
('공지사항', '8월 서버 점검이 예정되어 있습니다.', '관리자'),
('자유게시판 오픈!', '이제 자유롭게 글을 남겨보세요.', '운영팀'),
('스프링 질문 있어요', 'Controller와 Service 차이점이 궁금합니다.', '초보개발자'),
('스터디 모집', '백엔드 스터디 함께하실 분 구합니다!', '개발자A'),
('오류 해결법 공유', 'MySQL 연결 오류 해결법 정리해봤어요.', '지식나눔이');


--테스트--
CREATE TABLE BOOK(
	NUM INT NOT NULL AUTO_INCREMENT, 
	TITLE VARCHAR(50) NOT NULL,
	AUTHOR VARCHAR(30) NOT NULL,
	COMPANY VARCHAR(50) NOT NULL,
	ISBN VARCHAR(30) NOT NULL,
	COUNT INT DEFAULT 0,
	PRIMARY KEY(NUM)
)


--입력--
INSERT INTO BOOK(TITLE, AUTHOR, COMPANY, ISBN, COUNT)
VALUES
('해리포터와 아즈카반의 죄수', 'J.K 롤링', '문학수첩', '8983920726', 12),
('난중일기', '이순신', '서해문집', '8974832232', 8),
('수학 귀신', '한스 마그누스', '비룡소', '8949197310', 9),
('월리를 찾아라', '마틴 핸드포드', '예꿈', '8992882734', 20),
('오세암', '정채봉', '창비', '8936440195', 4);


SELECT * FROM BOOK;
DELETE FROM BOOK;












