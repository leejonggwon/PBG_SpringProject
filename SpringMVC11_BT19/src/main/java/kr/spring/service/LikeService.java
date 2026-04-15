package kr.spring.service;

import kr.spring.entity.Like;

public interface LikeService {
	


	//like_count +1
	void likePlus(Long idx);

	//Like객체 존재여부확인
	int likeHave(Like like);
	
	//Like 객체생성하는 기능
	void insertLike(Like like);
	
	//like_available=1 로 수정하기
	void updateLike(Like like);

	//like_availavle 값 불러오기
	int selectLike(Like like);

	//like_count -1
	void unLike(Long idx);

	//like_available=0 로 수정하기
	void updateLike_0(Like like);
		
	//like 객체삭제
	void deleteLike(Like like);

	


	

	

	

}
