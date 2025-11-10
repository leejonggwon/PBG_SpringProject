package kr.spring.entity;

import lombok.Data;

@Data //Getter Setter
public class Criteria { //기준이라는 뜻
	
	private int page; //현재 보고 있는 페이지 번호를 저장하는 변수
	private int perPageNum; //한페이지 보여줄 게시글의 개수 
	
	//현재 페이지의 게시글의 시작번호를 구하는 메소드 
	//1page → 1 ~ 10 2page → 11 ~ 20 3page → 21 ~ 30
	
}
