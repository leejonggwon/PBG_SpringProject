package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.entity.Board;
import kr.spring.entity.Member;

@Mapper //MyBatis가 InterFace를 찾기위해 달아주는 부분
public interface MemberMapper {

	//아이디 체크
	public Member registerCheck(String memID);

	//회원가입
	//cnt로 인해서 리턴타입이 int이다 
	public int join(Member m);

	//로그인
	public Member login(Member m);

	//업데이트
	public int update(Member m);

	//회원 이미지 등록기능 
	public void profileUpdate(Member mvo);

	
        
}















