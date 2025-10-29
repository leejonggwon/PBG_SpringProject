package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data               //lombok으로 Getter/Setter 자동으로 만들어줬음 
@AllArgsConstructor //전체생성자 
@NoArgsConstructor  //기본생성자
@ToString           //ToString
public class Book {
	
	private int num;
	private String title; 
	private String author;
	private String company;
	private String isbn; 
	private int count; 
}


