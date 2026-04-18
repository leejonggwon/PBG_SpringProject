package kr.spring.service;

import java.util.List;

import kr.spring.entity.Criteria;
import kr.spring.entity.Member;
import kr.spring.entity.Role;

public interface MemberService {

	int join(Member m); //회원가입기능

	List<Member> memberList(Criteria cri); //회원권한전체조회

	void roleCourceUpdate(Member member);//회원권한/교육과정수정
	
	Member getMember(String username); //회원정보조회

	void profileUpdate(Member mvo); //프로필업데이트

	int registerCheck(String username); //아이디중복체크

	int nick_nameCheck(String nick_name); //닉네임중복체크

	int update_nick_name(Member m); //닉네임수정

	int update_password(Member m); //비밀번호수정

	int member_update(Member m); //회원정보수정

	int close_account(String username); //탈퇴하기

	int imageDelete(String username); //프로필이미지삭제

	int totalCount(Criteria cri); //전체게시글수

	

}

