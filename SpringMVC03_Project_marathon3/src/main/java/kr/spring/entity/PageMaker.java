package kr.spring.entity;

import lombok.Data;

@Data
public class PageMaker {
	
	private Criteria cri;  

	private int totalCount; 
	
	private int startPage;  
	
	private int endPage; 	
	
	private boolean prev; 
	
	private boolean next; 
	
	private boolean prevPage; 
	private boolean nextPage; 
	
	private int displayPageNum = 10; 
	

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		makePagein(); 
	}
	

	public void makePagein() {
	
		endPage = (int)(Math.ceil((cri.getPage() / (double)displayPageNum)) * displayPageNum);
		
		startPage = endPage - displayPageNum + 1;
		
		if (startPage <= 0) {
			startPage = 1; 
		}
		
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
	
		if (tempEndPage < endPage) { 
			endPage = tempEndPage; 
		}
		
		prev = (startPage == 1)? false : true;	
		
		prevPage = (cri.getPage() == 1)? false : true;	
		
		next = (endPage < tempEndPage) ? true : false; 	
		
		nextPage = (cri.getPage() < tempEndPage) ? true : false; 
	
	}
}