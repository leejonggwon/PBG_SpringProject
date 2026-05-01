package kr.spring;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Learning;
import kr.spring.entity.Member;
import kr.spring.entity.Role;
import kr.spring.mapper.LearningMapper;
import kr.spring.mapper.MemberMapper;
import kr.spring.repository.MemberRepository;
import kr.spring.service.BoardService;

@SpringBootTest
class SpringMvc11ApplicationTests {
	
	//DB관련 mapper 역할과 같다 
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private LearningMapper learningMapper;
	
	
	//비밀번호 암호화 처리 
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private BoardService boardService;


	
	@Test
	void registerMoreMembers() {
	
		// 취업지원부
		Member m2 = new Member();
		m2.setUsername("operation01");
		m2.setPassword(passwordEncoder.encode("!2qqqqqq"));
		m2.setRole(Role.STAFF);
		m2.setCourse("BACK");
		m2.setName("교육운영과");
		m2.setNick_name("교육운영과");
		m2.setAge(30);
		m2.setGender("남자");
		m2.setEmail("educationOperations@gmail.com");
		m2.setProfile("");
		m2.setEnabled(true);
		m2.setUser_code(generateRandomCode(5));
		mapper.join(m2);	
	}
	
	
	
	
	
	
	
	//User_code
	public String generateRandomCode(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        java.util.Random random = new java.util.Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append(characters.charAt(random.nextInt(characters.length())));
        }
        return sb.toString();
    }
	
	
	
	
	
	/*
	@Test
	void registerMoreLearning() {
		
		Learning vo = new Learning();
		vo.setUsername("shj944");
		vo.setRole(Role.INSTRUCTOR);
		vo.setLecture("DataBase");
		vo.setTitle("데이터베이스 소개");
		vo.setContent("완벽한 이해를 돕기 위해 Q&A 게시판이 열려 있습니다. 무엇이든 물어보세요");
		vo.setWriter("DB요정");
		learningMapper.register(vo);
	}
	*/
	
	/*
	@Test
	void registerMoreLearning() {
	    String[] titles = {
	        "데이터베이스 맛보기: DBMS란 무엇인가? (관계형 DB vs NoSQL 차이점)",
	        "데이터 모델링의 이해: 엔티티(Entity), 속성(Attribute), 관계(Relationship)의 개념",
	        "데이터 모델링 실전: 식별자 설정과 관계 차수(1:1, 1:N, N:M) 이해하기",
	        "정규화(Normalization): 1, 2, 3차 정규화를 통해 데이터 중복 제거하기",
	        "SELECT와 산술 연산: 데이터 조회 기초와 NULL 처리 함수(NVL, ISNULL)",
	        "WHERE절과 연산자: 비교, 논리, BETWEEN, IN, LIKE 연산자 완벽 정복",
	        "집계 함수와 그룹화: GROUP BY, HAVING, 그리고 통계 함수(SUM, AVG, COUNT)",
	        "JOIN의 모든 것: Inner Join, Outer Join(Left/Right), Self Join 실습",
	        "서브쿼리(Subquery): 중첩 서브쿼리, 스칼라 서브쿼리, 인라인 뷰(Inline View)",
	        "집합 연산자와 계층형 질의: UNION, INTERSECT와 계층 구조 데이터 다루기",
	        "DDL & DML: 테이블 생성(CREATE), 수정(ALTER), 데이터 삽입/수정/삭제(CUD)",
	        "트랜잭션과 제어(TCL): Commit, Rollback, 그리고 데이터 무결성 이해하기",
	        "인덱스(Index)와 성능: B-Tree 인덱스 원리와 검색 속도 개선 전략",
	        "뷰(View)와 시퀀스(Sequence): 가상 테이블 활용과 자동 번호 생성기",
	        "프로젝트 실전: Spring Boot(JPA/MyBatis)와 연동하기 위한 DB 스키마 최종 설계"
	    };

	    // 반복문을 돌면서 15개의 데이터를 DB에 저장
	    for (String title : titles) {
	        Learning vo = new Learning();
	        vo.setUsername("shj944");
	        vo.setRole(Role.INSTRUCTOR);
	        vo.setLecture("DataBase");
	        vo.setTitle(title); 
	        vo.setContent("학습하시다 막히는 부분이 있다면 언제든 Q&A를 통해 문의해 주세요.");
	        vo.setWriter("Primary Key");
	        
	        learningMapper.register(vo);
	    }
	}
	
	 */	
	
	
	
	


	/*
	@Test
	void registerMoreLearningSpring() {
	    String[] springTitles = {
	        "Spring Framework 개요: 제어의 역전(IoC)과 의존성 주입(DI)의 이해",
	        "Spring Bean Container: 빈(Bean)의 생명주기와 다양한 설정 방식 (XML vs Java)",
	        "의존 관계 주입: @Autowired를 이용한 생성자 주입과 필드 주입의 차이",
	        "Spring AOP: 관점 지향 프로그래밍을 이용한 공통 로직(로그, 트랜잭션) 분리",
	        "Spring MVC 구조: DispatcherServlet의 동작 원리와 컨트롤러 설계",
	        "Spring Boot 시작하기: Auto Configuration과 Starter 라이브러리 활용",
	        "Thymeleaf & JSP: 스프링 부트 환경에서의 뷰 템플릿 엔진 연동",
	        "Spring Data JPA 1: 엔티티 매핑과 공통 인터페이스(JpaRepository) 사용법",
	        "Spring Data JPA 2: QueryDSL을 이용한 동적 쿼리 해결 전략",
	        "MyBatis 연동: XML 매퍼와 어노테이션 방식을 이용한 SQL 핸들링",
	        "Spring Security 1: 인증(Authentication)과 권한(Authorization)의 기본 설정",
	        "Spring Security 2: SecurityFilterChain과 커스텀 로그인 페이지 구현",
	        "REST API 설계: @RestController와 ResponseEntity를 이용한 표준 API 구축",
	        "Spring Boot 배포: JAR 파일 빌드와 외부 서버 환경 설정 가이드"
	    };

	    for (String title : springTitles) {
	        Learning vo = new Learning();
	        vo.setUsername("kmj0211");
	        vo.setRole(Role.INSTRUCTOR);
	        vo.setLecture("Spring"); // 과목명 설정
	        vo.setTitle(title);
	        vo.setContent("학습하시다 막히는 부분이 있다면 언제든 Q&A를 통해 문의해 주세요.");
	        vo.setWriter("스프링마스터");
	        
	        learningMapper.register(vo);
	    }
	}
	
    */
	
	

	
	
	@Test
	void testGetList() {
		
		Criteria cri = new Criteria();
		
		List<Board> list = boardService.getList(cri);
		
		for(Board vo : list) {
			System.out.println(vo.toString());
		}
	}
	
}


