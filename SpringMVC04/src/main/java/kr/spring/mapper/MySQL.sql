-- SQL파일 설정 경로: new → SQL File 

-- SQL 문장 작성 
-- *조건:  MyBatis가 자동으로 매핑해주기 위해서는 VO 클래스의 필드명이 데이터베이스 테이블의 컬럼명과 동일해야 한다
--실행: 드래그 → Alt + X → Execute Selected Text

CREATE TABLE BOARD(
	IDX INT NOT NULL AUTO_INCREMENT, -- 기본키, 자동 증가되는 유일한 번호--
	MEMID VARCHAR(20) NOT NULL, -- 해당 사람만 수정삭제 할 수 있게 판별할 수 있는 컬럼--
	TITLE VARCHAR(100) NOT NULL,
	CONTENT VARCHAR(2000) NOT NULL,
	WRITER VARCHAR(30) NOT NULL,
	INDATE DATETIME DEFAULT NOW(), -- 기본값으로 현재 날짜와 시간 저장--
	COUNT INT DEFAULT 0,
	PRIMARY KEY(IDX)
);

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


-- 회원 테이블 --
CREATE TABLE MEMBER(
	MEMIDX INT AUTO_INCREMENT,
	MEMID VARCHAR(20) NOT NULL,
	MEMPASSWORD VARCHAR(20) NOT NULL,
	MEMNAME VARCHAR(20) NOT NULL,
	MEMAGE INT,
	MEMGENDER VARCHAR(20),
	MEMEMAIL VARCHAR(50),
	MEMPROFILE VARCHAR(50), 
	PRIMARY KEY(MEMIDX)
);


SELECT * FROM MEMBER;

DELETE FROM MEMBER;

INSERT INTO MEMBER (MEMID, MEMPASSWORD, MEMNAME, MEMAGE, MEMGENDER, MEMEMAIL, MEMPROFILE)
VALUES ('admin','1234','관리자', 38, '남자', 'admin@gmail.com', '');



