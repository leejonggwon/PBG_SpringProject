package kr.spring.entity;

import lombok.Data;

@Data 
public class Criteria {
	
	private String type;   
	private String keyword; 
	
	private int page;       
	private int perPageNum; 
	
	public Criteria() {
		this.page = 1;        
		this.perPageNum = 10;
	}
	
	public int getPageStart() {
		return (page - 1) * perPageNum;
	}		
		
}
