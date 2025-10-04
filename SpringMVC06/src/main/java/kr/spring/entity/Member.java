package kr.spring.entity;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data  //lombok으로 Getter/Setter 자동으로 만들어줬음 
@AllArgsConstructor //전체생성자: 모든 필드를 매개변수로 갖는 생성자를 자동 생성 //Member m = new Member("hong123", "홍길동");
@NoArgsConstructor  //기본생성자: 매개변수가 없는 기본 생성자를 자동 생성 //MemberVO m = new MemberVO(); → m.setMemId("hong123");
@ToString           //데이터확인 
public class Member {
	//VO = Value Object 
	// 값만 담는 객체라는 의미, DB에서 가져온 데이터나, 폼에서 입력받은 데이터를 하나의 객체로 묶어서 다룰 때 사용
	//DB의 컬럼명과 VO의 필드명은 같아야한다 → MyBatis에서 자동으로 VO를 만들어준다
	private int memIdx;
	private String memID;
	private String memPassword;
	private String memName;
	private int memAge;
	private String memGender;
	private String memEmail;
	private String memProfile;
	
	//**회원이 가진 권한들을 저장하는 변수로
	//여러 권한을 여러개 담을 수 있도록 List 형태로 만든다. ROLE_MANAGER경우 회원권한(관리자, 매니저, 유저)이다 
	private List<Auth> authList;
	
	
}
