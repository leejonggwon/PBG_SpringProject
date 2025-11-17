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
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '학부모 상담 주간 안내', '다음 주 월요일부터 금요일까지 학부모 상담 주간이 진행됩니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 전산 점검 안내', '이번 주 금요일 오후 6시부터 전산 시스템 점검이 있을 예정입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 보안 교육 일정 안내', '전 직원 대상 보안 교육이 다음 주 수요일에 진행됩니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '연말 정산 서류 제출 안내', '연말 정산 관련 서류를 이번 주 금요일까지 인사팀에 제출 바랍니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 네트워크 점검 공지', '일부 부서의 네트워크가 일시적으로 중단될 예정입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 워크숍 일정 공지', '다음 달 사내 워크숍이 예정되어 있으니 일정 확인 바랍니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '복지포인트 사용 마감 안내', '복지포인트는 이번 달 말일까지 사용 가능합니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '명절 선물 신청 안내', '명절 선물은 금주 내로 신청서 작성 후 제출 바랍니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 식당 운영시간 변경 안내', '사내 식당 운영시간이 오전 11시 30분부터 오후 1시 30분으로 변경됩니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '회식 일정 공지', '팀별 회식이 다음 주 금요일에 진행됩니다. 참석 여부를 알려주세요.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '업무용 차량 이용 안내', '업무용 차량은 사전 예약 후 이용 가능합니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '휴가 신청 절차 변경 안내', '휴가 신청은 전자결재 시스템을 통해 진행 바랍니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '출퇴근 기록 시스템 점검', '출퇴근 기록 시스템이 이번 주 토요일 오전에 점검 예정입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 메신저 업데이트 안내', '사내 메신저 프로그램이 최신 버전으로 업데이트됩니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '에어컨 정기 점검 일정', '본사 전층 에어컨 점검이 다음 주 화요일에 진행됩니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '소방 대피 훈련 안내', '전 직원 대상 소방 대피 훈련이 다음 주 수요일에 실시됩니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 복지몰 오픈 안내', '새로운 복지몰이 오픈되었습니다. 많은 이용 바랍니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '개인정보 보호 교육 안내', '개인정보 보호 관련 의무 교육이 진행될 예정입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '복장 규정 안내', '여름철 복장 완화 기간이 다음 주부터 시작됩니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 게시판 이용 안내', '사내 게시판은 공지 외 개인 글 게시를 금합니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;

INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '주차장 이용 안내', '주차장 이용 시 지정 구역에만 주차 바랍니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '임직원 건강검진 일정 안내', '전 직원 건강검진이 다음 달 10일부터 시작됩니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '노트북 보안 점검', '노트북 보안 프로그램 설치 여부를 점검할 예정입니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 클린데이 행사 안내', '사무실 정리 및 환경 정비를 위한 클린데이를 진행합니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '비품 신청 절차 안내', '비품 신청은 인트라넷을 통해 진행 바랍니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '신입사원 환영식 안내', '이번 주 금요일 오전 10시, 신입사원 환영식이 열립니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 팀 빌딩 행사 안내', '팀 간 소통 강화를 위한 빌딩 행사가 다음 주에 열립니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '출입카드 재발급 안내', '분실 시 인사팀을 통해 출입카드를 재발급받을 수 있습니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '근태 관리 시스템 변경 안내', '새로운 근태 관리 시스템이 다음 달부터 적용됩니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '사내 봉사활동 모집 안내', '다음 달 사내 봉사활동 참여자를 모집합니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;
INSERT INTO TBLBOARD SELECT IFNULL(MAX(IDX)+1,1), 'admin', '전사 회의 일정 안내', '전사 회의가 다음 주 월요일 오전 9시에 진행됩니다.', '관리자', NOW(), 0, IFNULL(MAX(BOARDGROUP)+1,1), 0, 0, 1 FROM TBLBOARD;






