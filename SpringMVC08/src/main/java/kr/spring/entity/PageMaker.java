package kr.spring.entity;

import lombok.Data;

@Data //Getter Setter
public class PageMaker { //페이징처리 클래스
	//게시글을 페이징 하는 기법들이 들어간다 

	private Criteria cri; //현재 몇 페이지인지 정보와 게시글을 몇 개씩 볼 것인지 그리고 
	                      // 현재 페이지에서 몇 번 글부터 시작해야하는 정보를 가지고 있는 객체가 있어야 
						  // 페이징 처리가 가능하다 
	
	private int totalCount; //전체 게시글 수 
	                        // 총게시글의 수를 알아야 몇 페이지가 나오는지 알 수 있다 
	
	private int startPage; //시작페이지 번호 
	                       // 한 번에 보여줄 페이지 목록 중 “첫 번째 페이지 번호”
						   // 처음구간: 1, 다음구간: 11
	
	private int endPage; //한 번에 보여줄 페이지 목록 중 “마지막 페이지 번호”
	
	private boolean prev; //이전 페이지 목록으로 이동할 수 있는 버튼 표시 여부
						  // 현재 1~10페이지를 보고 있으면 이전 구간이 없으므로 prev = false
	                      // 11~20페이지라면 이전 구간이 있으니까 prev = true
	
	private boolean next; //다음 페이지 목록으로 이동할 수 있는 버튼 표시 여부
	
	private int displayPageNum = 10; //하단에 몇 개의 페이지를 보여줄 것인지
	                                 // 10이면 10개의 페이지 번호가 표시되는것을 의미한다 
	
	//총 게시글의 수를 구하는 메소드
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		makePagein(); //총 게시글 수로 해서 페이지번호를 만든다 
	}
	
	//실제 페이징기법
	public void makePagein() {
		
		//1.화면에 보여질 마지막 페이지 번호
		// 현재 하단에 보여줄 페이지 개수는? 1 2 3 4 5 6 7 8 9 10 이렇게 10개다(displayPageNum) 
		// 현재 7페이지일 경우, 마지막 페이지 번호는 10이다.
		// 1)현재 페이지(page)에서 10.0 을 나눈다: 7 / 10.0 = 0.7
		// 2)소수발생 시 올림(ceil)한다: 0.7 → 1
		// 3)10을 곱하면 마지막 페이지값 나온다: 1 x 10 = 10 
		// 현재 13페이지일 경우, 마지막 페이지 번호는 20이다.
		endPage = (int)(Math.ceil((cri.getPage() / (double)displayPageNum)) * displayPageNum);
		//Math.ceil() : 소수점발생하면 올림 한다
		
		//2. 화면에 보여질 시작페이지 번호
		//현재 7페이지 → (10(endPage) - 10) + 1 = 1
		//현재 15페이지 → (20(endPage) - 10) + 1 = 11
		startPage = endPage - displayPageNum + 1;
		
		// startPage가 0보다 작거나 같다면 1부터 시작할 수 있게한다 
		if (startPage <= 0) {
			startPage = 1; 
		}
		
		//3.최종페이지가 맞는지 유효성검사하기
		// 예) 101개의 게시글을 10개씩 보여주면 총 11페이지가 필요하다
		//  1)101(총게시글수) / 10.0(한페이지당 게시글수) = 10.1 
		//  2)소수발생 시 올림(ceil)한다: 10.1 → 11 페이지로 계산
		//getPerPageNum : 한페이지당의 게시글 개수
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
		//tempEndPage : 전체 게시글 수 기준으로 필요한 총 페이지 수(마지막 페이지 번호)를 계산하는 변수
		
		//4.화면에 보여질 마지막 페이지 유효성 체크 
		// 계산된 마지막 페이지 번호(endPage)가 실제 존재하는 마지막 페이지(tempEndPage)보다 크면 조정해라
        if (tempEndPage < endPage) { 
            endPage = tempEndPage; 
        }

		//5. 이전, 다음페이지 버튼 존재여부 
        //startPage가 1이면 첫번째 페이지 구간이므로 이전 버튼은 표시하지 않는다.
		prev = (startPage == 1)? false : true;
		
		//예) 전체 게시글 수가 160개일 때 tempEndPage는 16이다.
		// 현재 3페이지 구간(endPage=10)에서는 endPage < tempEndPage 이므로 다음 버튼이 필요하다.
		// 반면, 13페이지 구간(endPage=20)에서는 endPage > tempEndPage 이므로 다음 버튼이 필요하지 않다
		next = (endPage < tempEndPage) ? true : false; 
		
	}
}













