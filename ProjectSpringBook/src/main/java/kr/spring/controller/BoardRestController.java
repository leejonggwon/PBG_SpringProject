package kr.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.entity.Board;
//**Controller 클래스들은 프로젝트 생성 시 설정한 kr.spring.controller 패키지 내에 위치해야 하며, 
            //그래야 HandlerMapping이 이를 올바르게 찾아서 정상적으로 작동할 수 있습니다.
import kr.spring.mapper.BoardMapper;

@RequestMapping("/board") //URL의 통일성을 위해 달아준다 
//“이 클래스 안의 모든 메서드는 /board로 시작하는 주소에서만 불러라” 라는 의미 
 //그래서 /all, /new, /{idx} 이런 게 실제 주소는 /board/all, /board/new, /board/3 이런 식이 된다.
@RestController //@Controller + @ResponseBody 합친 버전, 모든 메서드가 JSON이나 값 그대로 반환한다고 생각하면 된다       
public class BoardRestController { //**BoardController를 Controller이고 POJO 라고 한다 
	
	// RestController
	// 비동기 방식의 일만 처리하는 Controller
	// Rest 전송방식을 처리할 수 있다 
	// - 요청 url + 전송방식(상태)을 묶어서 처리가능하다
	// 사용이유 - url의 통일성 및 단순화 
	
	@Autowired
	private BoardMapper mapper; // MyBatis한테 JDBC 실행하게 요청하는 객체 
	
	//전체 글 목록 조회
	@GetMapping("/all")  // boardList.do --> all //@RequestMapping 은 get과 post다 받는다//GetMapping : Get방식만 받을수 있다 
	public List<Board> boardList() {                                    
		System.out.println("게시글 전체보기 기능수행");
		List<Board> list = mapper.getLists();//게시글 목록 전체보는 기능
		return list; //비동기 방식의 서버는 JSON데이터를 반환한다 
	}
	
	//새 글 작성
	@PostMapping("/new") // Post로 해야지 게시글 입력이 된다, boardInsert.do--> new
	public void boardInsert(Board board) { //writer, title, content 3개 데이터를 묶는 타입 Board
		System.out.println("게시글 작성 기능수행");
		mapper.boardInsert(board);
	}
	
	//글 상세보기
	@GetMapping("/{idx}") //board/3 → 3번 글 보기
	public Board boardContent(@PathVariable("idx") int idx) { //writer, title, content 3개 데이터를 묶는 타입 Board
		System.out.println("게시글 상세보기 기능수행");
		Board vo = mapper.boardContent(idx);
		return vo;
	}
	
	//삭제하기
	@DeleteMapping("/{idx}")
	public void boardDelete(@PathVariable("idx") int idx) { //요청에서 넘어온 idx 값을 변수에 넣어줘 라는 뜻
		System.out.println("게시글 삭제 기능수행");
		mapper.boardDelete(idx);
	}
	
	//글수정
	@PutMapping("/update") //put방식
	public void boardUpdate(@RequestBody Board vo) { 
		//@RequestBody: HTTP 요청 body에 담아 보낸 JSON 같은 데이터를 → 자바 객체(vo)로 변환해주는 거야.
		System.out.println("게시글 업데이트 기능수행");
		mapper.boardUpdate(vo);
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
}

