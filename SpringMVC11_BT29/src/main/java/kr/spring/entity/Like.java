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
public class Like {
	
	private Long idx;
	private String username;
	private int like_available; //현재좋아하는상태, 처음누를때 생성되면서 1이된다 
	
}