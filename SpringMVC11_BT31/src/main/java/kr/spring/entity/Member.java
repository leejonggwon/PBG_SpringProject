package kr.spring.entity;

import java.sql.Date;

import javax.persistence.Entity;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity //(javax.persistence) //JPA 표준 어노테이션으로 이 클래스는 DB용 클래스 라고 알려주는 역할
@Table(name = "BT_MEMBER") //javax.persistence
@Data   //getter setter
@ToString
@AllArgsConstructor //클래스의 모든 필드를 매개변수로 받는 생성자
@NoArgsConstructor //반드시필수: MyBatis가 객체형태로 만들수 있기때문에 (매개변수가 없는 생성자)
public class Member {
	
	@Id //(javax.persistence) //PK의 의미
	private String username; 
	//Spring Security에서는 id가 아닌 username으로 지정해야한다 
	
	private String password; 
	//Spring Security에서는 pw가 아닌 password로 지정해야한다
	
	//Spring Security에는 권한도 반드시 있어야한다 
	@Enumerated(EnumType.STRING) //@Enumerated → 열거형(권한이 여러개이기 떄문에)
	private Role role;
	
	private String course; 
	
	private String name; //이름
	private String nick_name; //닉네임
	private int age; //나이 
	private String gender; //성별
	private String email; //이메일
	private String profile; //프로필사진
	
	private boolean enabled; //계정 활성화/비활성화 부분(enabled)
	
	private String user_code; //회원번호
	
}



