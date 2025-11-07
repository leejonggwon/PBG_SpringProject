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

import kr.spring.entity.Book;
//**Controller 클래스들은 프로젝트 생성 시 설정한 kr.spring.controller 패키지 내에 위치해야 하며, 
            //그래야 HandlerMapping이 이를 올바르게 찾아서 정상적으로 작동할 수 있습니다.

import kr.spring.mapper.BookMapper;

@RequestMapping("/book") 

@RestController    
public class BookRestController { 
	
	@Autowired
	private BookMapper mapper; 
	
	//전체 글 목록 조회
	@GetMapping("/all") //서버에서 데이터를 조회할 때 사용
	public List<Book> bookList() {                                    
		System.out.println("게시글 전체보기 기능수행");
		List<Book> list = mapper.getLists();
		return list; //비동기 방식의 서버는 JSON데이터를 반환한다 
	}
	
	//새 글 작성
	@PostMapping("/new")  //서버에 새로운 데이터를 생성할 때 사용
	public void boardInsert(Book book) { 
		//title, author, company, isbn, count 데이터를 묶는 타입 Board
		System.out.println("게시글 작성 기능수행");
		mapper.bookInsert(book);
	}
	
	
	//삭제하기
	@DeleteMapping("/{num}") //서버의 데이터를 삭제할 때 사용
	public void bookDelete(@PathVariable("num") int num) { 
		//요청에서 넘어온 num 값을 변수에 넣어줘 라는 뜻
		System.out.println("게시글 삭제 기능수행");
		mapper.bookDelete(num);
	}
	
	
	//글 상세보기(업데이트폼)
	@GetMapping("/{num}") 
	public Book bookContent(@PathVariable("num") int num) { 
		System.out.println("게시글 상세보기 기능수행");
		Book vo = mapper.bookContent(num);
		return vo;
	}

	
	//글수정
	@PutMapping("/update") //기존 데이터를 전체 수정할 때 사용
	public void bookUpdate(@RequestBody Book vo) { 
		//@RequestBody: 클라이언트(Ajax)가 보낸 JSON 데이터를 자동으로 Book 객체로 변환
		System.out.println("게시글 업데이트 기능수행");
		mapper.bookUpdate(vo);
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
}

