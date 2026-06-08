package kr.spring.entity;

import java.sql.Time;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

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
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date mrBirth;
	private String mrGender;
	private String mrCourse;
	private Time mrRecord;
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date mrDate;

}
