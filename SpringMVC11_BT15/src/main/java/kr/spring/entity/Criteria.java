package kr.spring.entity;

import lombok.Data;

@Data
public class Criteria {
	
	//검색기능에 필요한 변수 
	private String type;    //writer, title, content에 대한 값을 담기는 변수
	private String keyword; //검색내용
	
	private int page;       //현재 페이지
	private int perPageNum; //한 페이지당 보여줄 게시글수 (보통10개) 
	
	//Criteria 생성자를 통해서 기본 셋팅
	public Criteria() {
		this.page = 1;       
		this.perPageNum = 10;
	}
	
	//현재페이지의 게시글 시작번호
	 //1페이지 → 0 게시글부터 시작
	 //2페이지 → 10 (SQL은 시작값을 0으로 인식하는 특징이 있음)
	 //getPageStart() → 프로퍼티 pageStart로 인식한다 
	public int getPageStart() {
		return (page - 1) * perPageNum;
	}
	
	
}
