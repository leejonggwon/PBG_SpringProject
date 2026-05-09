package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.Member;
import kr.spring.entity.Role;

@Mapper
public interface MemberMapper {

	List<Member> memberList(Criteria cri); //회원권한전체조회

	void roleCourseUpdate(Member member);//회원권한/교육과정수정

	Member getMember(String username);

	void profileUpdate(Member mvo);
	
	int registerCheck(String username); //아이디중복체크

	int nick_nameCheck(String nick_name); //닉네임중복체크

	int join(Member m); //회원가입

	int update_nick_name(Member m); //닉네임수정

	int update_password(Member m); //비밀번호수정

	int member_update(Member m); //회원정보수정

	int close_account(String username); //탈퇴하기

	int imageDelete(String username); //프로필이미지삭제

	int totalCount(Criteria cri); //전체게시글수

	Member writerInfo(String username); //작성자정보조회


}



