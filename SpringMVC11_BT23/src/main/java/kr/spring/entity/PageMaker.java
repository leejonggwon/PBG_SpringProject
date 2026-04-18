package kr.spring.entity;

import lombok.Data;

//PageMaker : 페이징처리를 해주는 클래스
@Data
public class PageMaker { 
	
	private Criteria cri; //현재 페이지, 페이지당 게시글 갯수, 현재 페이지에 몇번 게시글이 시작하는지 정보가 있다 
	
	private int totalCount; //전체 게시글 수 
	
	private int displayPageNum = 10; //페이지 목록에 보여줄 페이지 개수
	
	private int startPage; //페이지 목록 중 첫페이지번호
	                       //첫구간: 1, 다음구간; 11
	
	private int endPage; //페이지 목록 중 마지막 페이지번호 
						 //첫구간: 10, 다음구간; 20
	
	private boolean prev; //이전 버튼
	                      //11-20 페이지구간 : prev = true
	
	private boolean next; //다음 버튼
						  //1-10 페이지구간 : next = true	

	//총 게시글 수를 구한다 
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount; //총 게시글수
		makePagein(); //첫페이지번호, 마지막페이지 번호, 총 페이지수, 이전/다음버튼 존재여부  
	}

	
	private void makePagein() {
		//1.페이지 목록기준 마지막페이지 번호 (현재페이지 8인경우) 
		// 8/10.0 = 0.8
		// 0.8 올림 → 1 
		// 1*10 = 10   
		endPage = (int)(Math.ceil((cri.getPage() / (double)displayPageNum)) * displayPageNum);
		
		//2.페이지 목록기준 시작페이지 번호 (마지막페이지 10인 경우)
		// 10 - 10 + 1 = 1
		startPage =  endPage - displayPageNum + 1 ;
		
		
		if (startPage <= 0) {
			startPage = 1; 
		}
		
		//3.총 게시글수 기준 마지막페이지번호 (총게시글 101개 경우)
		// 101/10.0 = 10.1
		// 10.1 올림 → 11 
		// 총페이지 수 11개 
		int tempEndPage = (int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
		
		//4.화면에 보여질 마지막 페이지 유효성 체크 
		// 페이지 목록 기준 마지막 페이지 번호가 실제 마지막 페이지번호 보다 크면 실제 마지막 페이지번호로 조정한다
		if(tempEndPage < endPage) {
			endPage = tempEndPage; 
		}
		
		//5. 이전, 다음페이지 버튼 존재여부 
        //startPage가 1이면 이전버튼은 표시하지 않는다 
		prev = (startPage == 1)? false : true;
		
		//(실제 페이지번호)가 (페이지목록 기준 페이지번호)보다 크면 다음버튼이 필요하다 
		//전체 게시글 수가 160개일 때 tempEndPage는 16이다.
		// 13페이지 구간(endPage=20)에서는 endPage > tempEndPage 이므로 다음 버튼이 필요하지 않다
		next = (endPage < tempEndPage) ? true : false; 
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
