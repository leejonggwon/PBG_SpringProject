package kr.spring.service;

import kr.spring.entity.Board;
import kr.spring.entity.Member;

public interface MemberService {
		//로그인 기능
		public Member login(Member vo);

		//프로필사진 업데이트
		public void profileUpdate(Member vo);

		//업데이트
		public int update(Member m);
}
