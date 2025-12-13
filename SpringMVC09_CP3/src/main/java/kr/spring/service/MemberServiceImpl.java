package kr.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Board;
import kr.spring.entity.Member;
import kr.spring.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	//로그인
		@Override
		public Member login(Member vo) {
			Member mvo = mapper.login(vo);
			return mvo; //서비스는 뷰네임이 아닌 데이터를 돌려준다
			            //컨트롤러는 받아온 데이터로 뷰를 만들어서 돌려준다
		}

		@Override
		public void profileUpdate(Member vo) {
			mapper.profileUpdate(vo);
			
		}

		@Override
		public int update(Member m) {
			return  mapper.update(m);
			
			
		}
	
}
