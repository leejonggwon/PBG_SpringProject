package kr.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Like;
import kr.spring.mapper.LikeMapper;

@Service
public class LikeServiceImpl implements LikeService{
	
	@Autowired
	private LikeMapper mapper;

	//likeCount +1
	@Override
	public void likePlus(Long idx) {
		mapper.likePlus(idx);
	}

	//Like객체생성하기
	@Override
	public void insertLike(Like like) {
		mapper.insertLike(like);	
	}

	//like_availavle값 불러오기
	@Override
	public int selectLike(Like like) {
		return mapper.selectLike(like); 
	}

	
	
	
}
