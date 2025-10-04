package kr.spring.entity;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

//직접만든 클래스 객체는 내부보안 규정상 바로 담을 수 없음 → *내가 원하는 VO를 담을 수 있게 변환해주는 User Class가 필요
//MemberUser: mvo를 담을수 있게 변환해주는 클래스
@Data //로그인성공하면 member가져가 써야하므로 getter/setter 메소드가 있어야한다
public class MemberUser extends User{
	// MemberUser는 Spring Security에 Member객체를 담을 수 있게 해주는 클래스
	
	private Member member;
	
	//생성자
	public MemberUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		//Collection → 여러 개를 담을 수 있는 리스트나 세트, 배열형태의 권한
		//? extends GrantedAuthority → GrantedAuthority를 구현한 모든 객체 가능
		//authorities: 사용자의 권한 정보를 담는 컬렉션(Collection)
		
		// MemberUser 객체 생성시 아이디, 비밀번호, 권한을 입력받게 정의되어 있다 
		// 실제로 우리는 생성자를 사용하지 않는다 
		// 하지만 왜 구현했냐? 추성메소드라서 어쩔 수 없이 구현해야해..  아래 3개만쓸거면 이거써도
		// 나쁘지 않아 
		super(username, password, authorities);
	}
	
	//실제로 우리가 사용할 생성자 
	public MemberUser(Member mvo) {
		//User 클래스의 생성자를 사용해서 구현한다
		//생성자(아이디, 비밀번호, 권한을 넣어준다)
		super(mvo.getMemID(), mvo.getMemPassword(), 
				/*User클래스의 생성자의 사용하는 권한정보는 Collection<SimpleGrantedAuthrity>형태로 변경해서 넣어야함
				 * 정리: 회원이 가진 권한 목록(List<Auth>)을 Spring Security가 사용하는 권한 객체(Collection<GrantedAuthority>)로 변환하는 과정”*/
				mvo.getAuthList().stream() /*스트림(Stream)으로 변환 - 데이터를 하나씩 처리할 수 있는 도구*/
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
				/*  map은 각 요소를 변환(transform)하는 작업
				 *  Auth 객체 → SimpleGrantedAuthority 객체로 변환
				 *  List<Auth> -> Collection 안에 들어갈 수 있게 변경 */
				.collect(Collectors.toList())
				/* 스트림 처리가 끝나면 다시 리스트(List)로 모으는 작업
				 * 최종 컬렉션 리스트로 변경*/
				);
		this.member = member;
	}
	
	
}
