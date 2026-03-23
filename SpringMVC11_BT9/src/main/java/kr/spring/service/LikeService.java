package kr.spring.service;

import kr.spring.entity.Like;

public interface LikeService {

	//좋아요+1 기능
	void likePlus(Long idx);

	//Like 객체생성하는 기능
	void insertLike(Like like);

	//like_availavle 값 불러오기
	int selectLike(Like like);

	

}
