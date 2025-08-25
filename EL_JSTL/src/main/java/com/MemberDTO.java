package com;

public class MemberDTO {
	//DTO 역할: 데이터를 전달하는 용도(로그인 정보, 게시글 등록 정보)
	
	private String id;
	private String pw;
	private String nick;
	private String addr;
	
	//생성자
	public MemberDTO(String id, String pw, String nick, String addr) {
		super();
		this.id = id;
		this.pw = pw;
		this.nick = nick;
		this.addr = addr;
	}
	
	//Getter/Setter
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPw() {
		return pw;
	}
	
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	public String getNick() {
		return nick;
	}
	
	public void setNick(String nick) {
		this.nick = nick;
	}
	
	public String getAddr() {
		return addr;
	}
	
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
	
	
}
