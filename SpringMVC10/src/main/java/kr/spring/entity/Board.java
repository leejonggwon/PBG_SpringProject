package kr.spring.entity;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;
import lombok.ToString;

@Entity //(javax.persistence) 
        //DB 테이블이랑 연결되는 객체다 라고 JPA한테 알려주는 역할
@Data   //getter setter 
@ToString
public class Board { //Board VO가 ORM기능을 통해서 알아서 TABLE로 형성이 될것이다
	
	@Id //(javax.persistence) //PK의 의미
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	//PK 번호는 DB가 알아서 1, 2, 3… 만든다 (auto_increment와 같음)
	private Long idx; //게시글 고유번호(호환을 위해서 Long형으로 해준다)
	
	private String title;
	
	@Column(length = 2000) //길이지정(기본 255)
	private String content;
	
	@Column(updatable = false) //update 실행할때 writer는 바뀌지 않는다
	private String writer;
	
	//(java.util)
	//Date는 insert/update 안되게 하겠다 
	//Date 초기값으로 datetime 형태로 저장이 되고 현재시간이 들어가게 하겠다
	@Column(insertable = false, updatable = false, columnDefinition="datetime default now()")
	private Date indate;
	
	@Column(insertable = false, updatable = false, columnDefinition= "int default 0")
	private Long count;
}








