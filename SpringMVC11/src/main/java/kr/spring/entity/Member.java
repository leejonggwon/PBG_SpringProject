package kr.spring.entity;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;

import lombok.Data;
import lombok.ToString;

@Entity //(javax.persistence) //JPA 표준 어노테이션으로 이 클래스는 DB용 클래스 라고 알려주는 역할
@Data   //getter setter
@ToString
public class Member {
	
	@Id //(javax.persistence) //PK의 의미
	private String username; 
	//Spring Security에서는 id가 아닌 username으로 지정해야한다 
	
	private String password; 
	//Spring Security에서는 pw가 아닌 password로 지정해야한다
	
	//Spring Security에는 권한도 반드시 있어야한다 
	@Enumerated(EnumType.STRING) //@Enumerated → 열거형(권한이 여러개이기 떄문에)
	private Role role;
	
	private String name; //이름
	
	private boolean ebled; //계정 활성화/비활성화 부분(enabled)
	
	
}



