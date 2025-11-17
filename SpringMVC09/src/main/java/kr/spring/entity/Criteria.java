package kr.spring.entity;

import lombok.Data;

@Data //Getter Setter
public class Criteria { //기준이라는 뜻
	
	//검색기능에 필요한 변수 
	private String type;    //writer, title, content에 대한 값을 담기는 변수
	private String keyword; //검색내용
	
	private int page;       //현재 페이지 번호를 저장할 변수
	
	private int perPageNum; //한 페이지당 보여줄 게시글 개수, 보통10개
	
	//Criteria 기본 셋팅 생성자를 통해서 하기
	public Criteria() {
		this.page = 1;        
		this.perPageNum = 10;
	}
	
	
	//** 현재 페이지의 게시글의 시작번호를 구하는 메소드 
	// 1page 당 → 1 ~ 10 게시글을 보여주고, 2page → 11 ~ 20, 3page → 21 ~ 30 이다
	// 예외: mysql에서는 시작값을 0으로 인식하는 특징이 있으므로 
	// 1page → 0 ~ 9, 2page → 10 ~ 19, 3page → 20 ~ 29로 바꾼다 
	public int getPageStart() {
		return (page - 1) * perPageNum;
	}
	//현재 페이지 번호가 3이고, 한 페이지당 보여줄 게시글 수가 10개면 
	// → 게시글의 시작번호는 20이다 (mysql기준), 실제로는 21번째 글부터 시작한다
	
	
	
	
	
	
	
	
	
}
