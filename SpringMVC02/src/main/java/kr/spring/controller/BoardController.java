package kr.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.entity.Board;
//**Controller 클래스들은 프로젝트 생성 시 설정한 kr.spring.controller 패키지 내에 위치해야 하며, 
            //그래야 HandlerMapping이 이를 올바르게 찾아서 정상적으로 작동할 수 있습니다.
import kr.spring.mapper.BoardMapper;

@Controller //**핸들러맵핑이 현재클래스를 찾기위해 컨트롤러로 등록하는 부분           
public class BoardController { //**BoardController를 Controller이고 POJO 라고 한다 
	
	@Autowired //스프링에 BoardMapper 객체가 생성된걸 가져다 쓰는것을 의미, @Autowired를 통해서 SqlSessionFactoryBean를 사용한다
	private BoardMapper mapper;// MyBatis한테 JDBC를 실행하게 요청하는 객체
							   // MyBatis에게 "이 메서드 = 이 SQL 실행" 이라고 요청하는 역할
							   // 개발자 ↔ BoardMapper ↔ MyBatis ↔ JDBC ↔ DB 이런 구조
	
	@RequestMapping("/") //요청 url로 들어왔을때 아래 기능을 수행하겠다
	public String home() {
		System.out.println("홈 기능 수행");
		return "main";         	                 		
	}
	
	
	@RequestMapping("/boardList.do")
	public @ResponseBody List<Board> boardList() { //비동기 요청에 JSON 형태로 응답하기 위해 List<Board>를 반환해야한다
		                                           //@ResponseBody로 명시 해야 비동기방식 메서드가 된다  
		System.out.println("게시글 전체보기 기능수행");
		List<Board> list = mapper.getLists();//게시글 목록 전체보는 기능
		return list; //비동기 방식의 서버는 JSON데이터를 반환한다 
	}
	
	@RequestMapping("/boardInsert.do")
	public @ResponseBody void boardInsert(Board board) { //writer, title, content 3개 데이터를 묶는 타입 Board
		System.out.println("게시글 작성 기능수행");
		mapper.boardInsert(board);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

