package kr.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Like;
import kr.spring.mapper.LearnLikeMapper;
import kr.spring.mapper.LikeMapper;

@Service
public class LearnLikeServiceImpl implements LearnLikeService{
	
	
	@Autowired
	private LearnLikeMapper mapper;

	//likeCount +1
	@Override
	public void likePlus(Long idx) {
		mapper.likePlus(idx);
	}

	//Like객체 존재여부확인
	@Override
	public int likeHave(Like like) {
		return mapper.likeHave(like);	
	}
	
	//Like객체생성하기
	@Override
	public void insertLike(Like like) {
		mapper.insertLike(like);	
	}
	
	//like_available=1 로 수정하기
	@Override
	public void updateLike(Like like) {
		mapper.updateLike(like);
	}

	//like_availavle값 불러오기
	@Override
	public int selectLike(Like like) {
		return mapper.selectLike(like); 
	}

	//like_count -1
	@Override
	public void unLike(Long idx) {
		mapper.unLike(idx);
		
	}

	//Like객체삭제
	@Override
	public void deleteLike(Like like) {
		mapper.deleteLike(like);	
	}


	//like_available=1 로 수정하기
	@Override
	public void updateLike_0(Like like) {
		mapper.updateLike_0(like);
		
	}

	

	

	
	
	
}
