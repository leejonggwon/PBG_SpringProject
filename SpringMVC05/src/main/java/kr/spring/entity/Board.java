package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
//데이터 객체
//DTO를 하나의 객체라고 해서 영어로 entity라고 한다 
//entity 패키지를 따로 만든다, entity에 Board DTO를 넣는다, 실제에서는 Board라고 쓴다 

//어노테이션으로 필요한거 추가하면 된다
@Data               //lombok으로 Getter/Setter 자동으로 만들어줬음 
@AllArgsConstructor //전체생성자 
@NoArgsConstructor  //기본생성자
@ToString           //ToString
public class Board {
	
	private int idx; //번호
	private String memID; //작성했을 당시 로그인 한 사람의 아이디
	private String title; //제목	
	private String content; //내용
	private String writer; //작성자
	private String indate; //작성일
	private int count; //조회수
	
	//**요즘에는 Getter/Setter/생성자를 안쓴다 → 롬복API로 사용한다(알아서 만들어준다)
	
}


