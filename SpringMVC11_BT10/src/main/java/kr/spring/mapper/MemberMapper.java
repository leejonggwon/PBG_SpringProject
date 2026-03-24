package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.entity.Board;
import kr.spring.entity.Member;
import kr.spring.entity.Role;

@Mapper
public interface MemberMapper {

	List<Member> memberRoleList(); //회원권한전체조회

	void roleUpdate(Member member);//회원권한수정

	Member getMember(String username);

	void profileUpdate(Member mvo);


}



