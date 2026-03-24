package kr.spring.service;

import java.util.List;

import kr.spring.entity.Member;
import kr.spring.entity.Role;

public interface MemberService {

	void join(Member m); //회원가입기능

	List<Member> memberRoleList(); //회원권한전체조회

	void roleUpdate(Member member);//회원권한수정
	
	Member getMember(String username); //회원정보조회

	void profileUpdate(Member mvo); //프로필업데이트

	Member registerCheck(String username); //아이디중복체크

}

