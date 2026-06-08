package kr.spring.entity;

import java.sql.Time;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data               
@AllArgsConstructor 
@NoArgsConstructor  
@ToString 
public class Record {
	private String mrNumber;
	private String mrName;
	private String mrCourse;
	private Time mrRecord;

}
