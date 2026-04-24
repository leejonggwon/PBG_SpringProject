package kr.spring.entity;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import lombok.Data;
//**시큐리티가 이해하는 형태안 CustomUser 형태로 묶어서 AuthenticationManagerBuilder에 반환된다
@Data
public class CustomUser extends User { //User는 UserDetail에 상속받는다
	//우리가 만든 회원정보 Member를 
	// Security Context Holder에 저장하기 위해서는 
	// User형태로 변환해서 넣어줘야한다 
	// 그걸 해주는 클래스가 바로 CustomUser 클래스이다 
	
	private Member member;
	
	public CustomUser(Member member) {
		super(member.getUsername(), member.getPassword(),
				AuthorityUtils.createAuthorityList("ROLE_" + member.getRole().toString()));
		
		//필드에 매개변수로 받아온 정보도 넣어준다(이름, 활성화여부 정보도 있으므로)
		this.member = member; 
	} 
	
}

