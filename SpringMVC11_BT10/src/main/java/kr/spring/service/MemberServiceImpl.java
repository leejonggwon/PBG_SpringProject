package kr.spring.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Member;
import kr.spring.entity.Role;
import kr.spring.mapper.BoardMapper;
import kr.spring.mapper.MemberMapper;
import kr.spring.repository.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private MemberMapper mapper;

	@Override
	public void join(Member m) {
		memberRepository.save(m);
	}

	//회원권한전체조회
	@Override
	public List<Member> memberRoleList() {
		return mapper.memberRoleList();
	}
	
	//회원권한수정
	@Override
	public void roleUpdate(Member member) {
		mapper.roleUpdate(member);
		
	}

	//회원정보가져오기
	@Override
	public Member getMember(String username) {
		return mapper.getMember(username);
	}

	//프로필이미지업데이트
	@Override
	public void profileUpdate(Member mvo) {	
	    mapper.profileUpdate(mvo);	
	}
	
	
	
}
