package kr.spring.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Criteria;
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

	//회원가입
	@Override
	public int join(Member m) {
		//memberRepository.save(m);
		return mapper.join(m);
	}

	//회원권한전체조회
	@Override
	public List<Member> memberList(Criteria cri) {
		return mapper.memberList(cri);
	}

	
	//회원권한/교육과정수정
	@Override
	public void roleCourseUpdate(Member member) {
		mapper.roleCourseUpdate(member);
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

	//아이디중복체크
	@Override
	public int registerCheck(String username) {
		return mapper.registerCheck(username);
	}

	//닉네임중복체크
	@Override
	public int nick_nameCheck(String nick_name) {
		return mapper.nick_nameCheck(nick_name);
	}

	//닉네임수정
	@Override
	public int update_nick_name(Member m) {
		return mapper.update_nick_name(m);
	}

	//비밀번수정
	@Override
	public int update_password(Member m) {
		return mapper.update_password(m);
	}

	//회원정보수정
	@Override
	public int member_update(Member m) {
		return mapper.member_update(m);
	}

	//탈퇴하기
	@Override
	public int close_account(String username) {
		return mapper.close_account(username);
	}

	//프로필이미지삭제
	@Override
	public int imageDelete(String username) {
		return mapper.imageDelete(username);
	}

	@Override
	public int totalCount(Criteria cri) {
		return mapper.totalCount(cri);
	}

	
	
	
	
}
