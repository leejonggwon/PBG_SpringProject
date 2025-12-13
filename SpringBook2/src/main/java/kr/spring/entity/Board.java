package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data               //lombok으로 Getter/Setter 자동으로 만들어줬음 
@AllArgsConstructor //전체생성자 
@NoArgsConstructor  //기본생성자
@ToString           //ToString
public class Board {
	
	private int idx; //번호
	private String title; //제목	
	private String content; //내용
	private String writer; //작성자
	private String indate; //작성일
	private int count; //조회수
	
	
}


