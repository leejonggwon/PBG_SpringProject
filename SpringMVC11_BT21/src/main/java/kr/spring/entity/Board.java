package kr.spring.entity;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

 
@Entity //(javax.persistence) //Board VO가 DataBase에 Table로 만들때 설정하는 부분 
@Table(name = "BT_BOARD") //이렇게 테이블이름 명시할 수 있다
@Data   //getter setter
@ToString
@AllArgsConstructor //모든 필드를 가진 생성자  
@NoArgsConstructor //매개변수 없는 생성자 
public class Board { //Board VO가 ORM기능을 통해서 알아서 TABLE로 형성이 될것이다
	
	@Id //(javax.persistence) //PK의 의미
	@GeneratedValue(strategy = GenerationType.IDENTITY) //DB가 PK 번호를 자동 증가해서 만들어주도록 맡기는 옵션: auto_increment와 같음
	private Long idx; //게시글 고유번호(호환을 위해서 long형으로 해준다)
	
	private String username;
	
	@Enumerated(EnumType.STRING) //@Enumerated → 열거형(권한이 여러개이기 떄문에)
	private Role role;
	
	private String title;
	
	@Column(length = 2200) //길이지정 → 길이지정 따로 안할떄는 길이 255
	private String content;
	
	@Column(updatable = false) //update 실행할때 writer 안바꿔 주겠다
	private String writer;
	
	//Date는 insert 안되고 update 안되게 하겠다 
	//Date 초기값으로 datetime 형태로 저장이 되고 현재시간이 들어가게 하겠다
	@Column(insertable = false, updatable = false, columnDefinition="datetime default now()")
	private java.util.Date indate;
	
	@Column(insertable = false, updatable = false, columnDefinition= "int default 0")
	private int count;
	
	@Column(insertable = false, updatable = false, columnDefinition= "int default 0")
	private int like_count ;
	
	private String attached_data; //첨부자료
	
	private String attached_data2; //첨부자료2
	
	private int board_group; //답글그룹

	private int board_level; //답글레벨

	private int board_sequence; //답글순서
	
	private String board_available; //삭제여부 
	
	
}








