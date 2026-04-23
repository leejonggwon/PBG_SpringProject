package kr.spring.entity;

import java.util.Date;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@AllArgsConstructor //클래스의 모든 필드를 매개변수로 받는 생성자
@NoArgsConstructor //반드시필수: MyBatis가 객체형태로 만들수 있기때문에 (매개변수가 없는 생성자)
@Data //Getter Setter
public class Comment {
	
	private int cmt_idx;        //댓글번호
	private Long idx;           //게시글번호 Board
	private String cmt_content; //댓글내용
	private String username; 
	private String name;        //이름 Member
	private String nick_name;   //닉네임 Member
	private Role role;          //역할 Member
	private String profile;     //프로필이미지 Member
	private Date cmt_indate;    //댓글작성된 시간
	
	private int cmt_cmt_count;  //댓글당 대댓글수
	
	private int cmt_group;      //댓글그룹	
	private int cmt_sequence;   //댓글순서
	private int cmt_level;      //댓글레벨
	private String cmt_available;  //댓글삭제여부(0:삭제상태)
	
}