-- 회원제 게시판 --
CREATE TABLE TBLBOARD(
   IDX INT NOT NULL,
   MEMID VARCHAR(20) NOT NULL,
   TITLE VARCHAR(100) NOT NULL,
   CONTENT VARCHAR(2000) NOT NULL,
   WRITER VARCHAR(30) NOT NULL,
   INDATE DATETIME DEFAULT NOW(),
   COUNT INT DEFAULT 0,
   -- 댓글기능 추가 --
   BOARDGROUP INT,     -- 어떤 그룹에 댓글을 달았는지 알수있는 --
   BOARDSEQUENCE INT,  -- 같은 그룹안에서 댓글의 순서를 저장하는 변수 --
   BOARDLEVEL INT,     -- 1단계(원본글댓글) 2단계(댓글에댓글) 인지에 대한 정보 --   
   BOARDAVAILABLE INT, -- 삭제된 글인지 여부 판별한다 --
   PRIMARY KEY(IDX)
);

SELECT * FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX) + 1, 1),
'admin', '공지사항입니다', '다음주 월요일 정상 등원하겠습니다', '관리자',
NOW(), 0, IFNULL(MAX(BOARDGROUP) + 1, 1), 0 , 0, 1
FROM TBLBOARD;
--MAX(IDX) 와 MAX(BOARDGROUP) 모두 같은 FROM TBLBOARD에서 계산되기 때문에 SELECT는 한 번만 필요하다--


INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX) + 1, 1),
'admin', '가을 운동회 안내', '10월 25일(금) 전교생 운동회가 열립니다. 편한 복장으로 참여해주세요!', '관리자',
NOW(), 0, IFNULL(MAX(BOARDGROUP) + 1, 1), 0, 0, 1
FROM TBLBOARD;


INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX) + 1, 1),
'admin', '10월 급식 일정 안내', '10월 급식표를 홈페이지 자료실에 업로드했습니다. 참고 부탁드립니다.', '관리자',
NOW(), 0, IFNULL(MAX(BOARDGROUP) + 1, 1), 0, 0, 1
FROM TBLBOARD;


INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX) + 1, 1),
'admin', '학부모 상담 주간 안내', '다음 주 월요일부터 금요일까지 학부모 상담 주간이 진행됩니다.', '관리자',
NOW(), 0, IFNULL(MAX(BOARDGROUP) + 1, 1), 0, 0, 1
FROM TBLBOARD;


SELECT * FROM TBLBOARD;

DELETE FROM TBLBOARD;


CREATE TABLE TBLMEMBER(
   MEMID VARCHAR(50) NOT NULL,
   MEMPWD VARCHAR(50) NOT NULL,
   MEMNAME VARCHAR(50) NOT NULL,
   MEMPHONE VARCHAR(50) NOT NULL,
   MEMADDR VARCHAR(100),
   LATITUDE DECIMAL(13, 10),  -- 현재위치위도, 카카오지도에 내위치 기록 37.5665350000
   LONGITUDE DECIMAL(13, 10), -- 현재위치경도 --
   PRIMARY KEY(MEMID)
);

SELECT * FROM TBLMEMBER;

DELETE FROM TBLMEMBER;

INSERT INTO TBLMEMBER(MEMID, MEMPWD, MEMNAME, MEMPHONE)
VALUES('admin', '1234', '관리자', '010-1234-1234');


INSERT INTO TBLMEMBER(MEMID, MEMPWD, MEMNAME, MEMPHONE)
VALUES('user01', '1234', '손흥민', '010-1234-1234');

INSERT INTO TBLMEMBER(MEMID, MEMPWD, MEMNAME, MEMPHONE)
VALUES('user02', '1234', '김연아', '010-1234-1234');




--게시글 입력--
INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '퇴근 후 시스템 점검 안내', '퇴근 후 시스템 점검이 진행될 예정입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 이메일 필터링 안내', '사내 이메일 필터링 정책 변경 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '회의실 예약 시스템 안내', '회의실 예약 시스템 사용법 변경 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 보안 강화 안내', '사내 보안 정책 강화 및 비밀번호 변경 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '연말 휴가 안내', '연말 휴가 일정 및 신청 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 시스템 점검 안내', '서버 점검 일정 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 복지 제도 안내', '사내 복지 제도 변경 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '연차 사용 안내', '연차 사용 및 승인 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 교육 안내', '사내 교육 일정 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 이메일 사용 안내', '이메일 사용 규정 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 근태 관리 안내', '근태 관리 및 출퇴근 기록 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 회식 일정 안내', '사내 회식 일정 및 장소 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 출장 보고 안내', '출장 보고서 제출 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 보안 교육 안내', '보안 교육 일정 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 자료실 이용 안내', '자료실 이용 규정 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 회의 일정 안내', '회의 일정 및 회의실 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공용 장비 사용 안내', '프린터 및 공용 장비 사용 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 회의록 공유 안내', '회의록 공유 및 기록 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 전자결재 안내', '전자결재 사용법 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 근무 규정 안내', '근무 시간 및 규정 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 시스템 점검 안내(월별)', '월별 시스템 점검 안내입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공지사항 테스트', '사내 게시판 테스트 글 21입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공지사항 테스트', '사내 게시판 테스트 글 22입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공지사항 테스트', '사내 게시판 테스트 글 23입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공지사항 테스트', '사내 게시판 테스트 글 24입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공지사항 테스트', '사내 게시판 테스트 글 25입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공지사항 테스트', '사내 게시판 테스트 글 26입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공지사항 테스트', '사내 게시판 테스트 글 27입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공지사항 테스트', '사내 게시판 테스트 글 28입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공지사항 테스트', '사내 게시판 테스트 글 29입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD
SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 공지사항 테스트', '사내 게시판 테스트 글 30입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;





