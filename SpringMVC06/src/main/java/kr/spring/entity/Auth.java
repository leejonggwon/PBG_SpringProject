package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data               //lombok으로 Getter/Setter 자동으로 생성
@AllArgsConstructor //전체생성자: 모든 필드를 매개변수로 받는 생성자
@NoArgsConstructor  //기본생성자: 매개변수가 없는 생성자
@ToString           //ToString 출력하는 매서드
public class Auth {
	//권한정보를 저장할 클래스 
	private int no;       // 일련번호
	private String memID; // 회원 아이디
	private String auth;  // 회원권한 (ROLE_USER, ROLE_MANAGER, ROLE_ADMIN)
}
