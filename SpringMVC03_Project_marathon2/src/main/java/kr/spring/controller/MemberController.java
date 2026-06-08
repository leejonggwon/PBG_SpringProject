package kr.spring.controller;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.spring.entity.Member;
import kr.spring.mapper.BoardMapper;
import kr.spring.mapper.MemberMapper;

@Controller
public class MemberController {
	
	//MemberMapper → 인터페이스 
	@Autowired
	private MemberMapper mapper; //SqlSessionFactoryBean → DB와 MyBatis 환경을 연결하는 설정 담당
									
	
	@RequestMapping("/joinForm.do")
	public String joinForm() {
		System.out.println("회원가입 페이지로 이동");
		return "member/joinForm"; //뷰네임을 돌려준다
	}
	
	//RestController가 아니고 비동기방식 메소드를 사용하기 위해서는 @ResponseBody 사용한다
	//@ResponseBody: 리턴값을 JSP 같은 뷰 이름으로 해석하지 않고, 클라이언트에게 바로 값(데이터)으로 보낸다.
	@RequestMapping("/registerCheck.do")
	public @ResponseBody int registerCheck(@RequestParam("memID") String memID){ //변수명이 다르면 @RequestParam("memID")로 매핑해야 한다
		System.out.println("아이디 중복체크");
		Member m = mapper.registerCheck(memID);
		//m == null → 아이디 중복가능
		//m != null → 아이디 사용 불가능
		if(m != null || memID.equals("")) {
			return 0;
		}else {
			return 1;
		}
	}
	
	@RequestMapping("/join.do")
	public String join(Member m, RedirectAttributes rttr, HttpSession session) { // 넘어오는 name 값과 Member 필드명이 같으면, 하나로 묶은 Member로 받을 수 있다
		                                                                         // HttpSession 사용자별 데이터를 서버에 잠깐 저장하고 관리하는 공간
		System.out.println("회원가입 기능요청");
		
		// 유효성검사: 백엔드 개발자는 필수적으로 유효성 검사를 해야 한다
		// → 값이 null 이거나 빈 문자열("")인 경우, 또는 숫자가 0인 경우를 체크한다
		if(m.getMemID() == null || m.getMemID().equals("") || //m.getMemID() == null는 jsp name값이 틀렸다는 의미
		   m.getMemPassword() == null || m.getMemPassword().equals("") ||
		   m.getMemName() == null || m.getMemName().equals("") ||
		   m.getMemAge() == 0 ||
		   m.getMemEmail() == null || m.getMemEmail().equals("") 
		   ) {
			//회원가입을 할 수 없는 부분, 하나라도 누락되어 있기 때문에 
			
			//실패시 joinForm.do로 msgType과 msg 내용을 보내함
			//msgType: "실패메세지", msg: "모든 내용을 입력하세요" 보낼것임 
			
			//리다이렉트 방식은 model을 사용할 수 없다(포워딩방식만 가능하다) → 그러므로 RedirectAAttributtes 사용한다
			// RedirectAAttributtes - 리다이렉트 방식으로 이동할때 보낼 데이를 저장하는 객체
			// RedirectAAttributtes 저장데이터는 해당 jsp에 page context에 저장된다
			// addFlashAttribute는 리다이렉트할 때 1회성으로 데이터를 전달하는 메서드
			rttr.addFlashAttribute("msgType", "실패메세지"); 
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요");
			
			return "redirect:/joinForm.do"; //다시 회원가입 입력하는 폼으로 다시 요청하도록 시킨다 	
			
		}else {
			//누락된것이 없으므로 회원가입을 시도할 수 있는 부분	
			m.setMemProfile(""); //null을 넣고 싶지 않을 때 빈 문자열로 초기화
			int cnt = mapper.join(m); //cnt가 1이면 회원가입성공, 0이면 실패  
			
			if(cnt == 1) {
				System.out.println("회원가입 성공");
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "회원가입에 성공했습니다");
				//회원가입 성공 시 로그인 처리까지 시키기
				//로그인 정보 저장 (m에 Member 정보가 저장되어 있다)
				session.setAttribute("mvo", m); 
				//세션 유지 → session.setMaxInactiveInterval(60*60); // 1시간(초 단위)
				//로그아웃 처리 → session.invalidate(); 
				return "redirect:/";
			}else {
				System.out.println("회원가입 실패");
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "회원가입에 실패했습니다");
				return "redirect:/joinForm.do";
			}
		}
	}
	
	//로그아웃
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) { //매개변수에 HttpSession 쓰면 쓸수 있다
		session.invalidate();
		return "redirect:/";
	}
	
	//로그인폼이동
	@RequestMapping("/loginForm.do")
	public String loginForm() { 
		return "member/loginForm";
	}
	
	
	//로그인
	@RequestMapping("/login.do")
	public String login(Member m, RedirectAttributes rttr, HttpSession session) { 
		 Member userInfo = mapper.login(m); //로그인을 하고 회원정보를 돌려받아야한다
		 
		 if(userInfo != null) {
			 System.out.println("로그인 성공");
			 	session.setAttribute("mvo", userInfo); //header.jsp에서 "mvo"로 판단하므로 "mvo"로 이름을 준다
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "로그인에 성공했습니다");
				return "redirect:/";
		 }else{
			 System.out.println("로그인 실패");
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "로그인에 실패했습니다");
				return "redirect:/loginForm.do";
		 }
	}
	
	//업데이트폼
	@RequestMapping("/updateForm.do")
	public String updateForm() {
		System.out.println("회원정보수정 페이지로 이동");
		return "member/updateForm"; 
	}
	
	//업데이트
	@RequestMapping("/update.do")
	public String update(Member m, RedirectAttributes rttr, HttpSession session) {
		//유효성검사 
		if(m.getMemPassword() == null || m.getMemPassword().equals("") ||
		   m.getMemName() == null || m.getMemName().equals("") ||
		   m.getMemAge() == 0 ||
		   m.getMemEmail() == null || m.getMemEmail().equals("") 
		  ) {
			rttr.addFlashAttribute("msgType", "실패메세지"); 
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요");
			
			return "redirect:/updateForm.do"; //다시 회원가입 입력하는 폼으로 다시 요청하도록 시킨다
			
		}else{
			//회원정보 수정할때 이미지가 날아가는것 방지하는 첫번째 방법
			Member mvo = (Member)session.getAttribute("mvo"); 
			m.setMemProfile(mvo.getMemProfile()); //로그인한 Member의 MemProfile 값울 담는다
			
			int cnt = mapper.update(m); 
			
			if(cnt == 1) {
				System.out.println("회원정보수정 성공");
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "회원정보수정에 성공했습니다");
				session.setAttribute("mvo", m); //회원정보 session도 업데이트해야한다
				return "redirect:/";		
			}else {
				System.out.println("회원정보수정 실패");
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "회원정보수정에 실패했습니다");
				return "redirect:/updateForm.do";
			}
		}
	}
	
	//회원사진등록 페이지 이동
	@RequestMapping("/imageForm.do")
	public String imageForm() {
		System.out.println("회원사진등록 페이지 이동");
		return "member/imageForm"; 
	}
	
	
	//회원사진등록 기능
	@RequestMapping("/imageUpdate.do")
	public String imageUpdate(HttpServletRequest request, RedirectAttributes rttr, HttpSession session) { 
		                      //클라이언트(브라우저)에서 서버(서블릿)로 들어온 요청 전체를 담고 있는 객체
							  //요청 URL, 파라미터, 세션, 헤더 같은 정보를 꺼낼 수 있음
							  //request.getRealPath()처럼 웹 애플리케이션의 실제 물리적 경로를 가져오는 기능도 제공 
		                      //파일종류, 파일이 들어있다 
		
		// 파일업로드를 할 수 있게 도와주는 객체 (cos.jar)
		// 파일업로드를 할 수 있게 도와주는 MultipartRequest 객체를 생성하기 위해서는
		// 5개의 정보가 필요하다
		// 요청데이터, 저장경로, 최대크기, 인코딩, 파일명 중복제거
		MultipartRequest multi = null;  // 파일 업로드 처리를 위한 MultipartRequest 객체를 선언하는 코드
		                                // cos.jar에서 제공하는 클래스
										// HTML <form enctype="multipart/form-data">로 전송된 파일 업로드 요청을 처리할 수 있게 해줌.
		
		//파일의 저장경로(request요청 객체가 필요하다) 
		String savePath = request.getRealPath("resources/upload");
		
		
		int fileMaxSize = 10 * 1024 * 1000; // 10mb까지 가능한 파일의 최대크기 
		
		System.out.println(savePath); //이미지가 저장된 경로 
		
		
		//로그인한 회원의 프로필 정보를 업데이트 //세션에 저장된 데이터를 키(key)로 꺼낸다
		Member mvo = (Member)session.getAttribute("mvo");
		
		//이미지 업로드 할 떄 기존 회원의 이미지를 삭제를 해주는 기능
		String oldImg = mvo.getMemProfile(); //MemProfile 값 반환
		
		File oldFile = new File(savePath + "/" + oldImg);
		if(oldFile.exists()) {
			oldFile.delete();
		}
		
	
		try {
			//파일업로드 기능수행 객체 생성 (폼 데이터 + 파일 데이터, 저장경로, 최대크기, 한글 인코딩, cos 라이브러리에서 제공하는 파일로 동일한 이름으로 파일업로드 시 숫자를 붙여주는 객체)
			//multi: 내가 업로드한 파일은 객체안에 모두 있다 
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
			
		} catch (Exception e) {
			System.out.println("파일업로드 실패");
			rttr.addFlashAttribute("msgType", "실패메세지"); 
			rttr.addFlashAttribute("msg", "파일의 크기가 너무 큽니다");
			return "redirect:/imageForm.do";
		}
		
		//이미지 유효성 검사(jpg, png 같은 이미지 파일만 저장하겠다)
		File file = multi.getFile("memProfile"); //사용자가 업로드한 파일을 서버에서 다룰 수 있도록 File 객체로 꺼내주는 역할
		
		if(file != null) {
			//여기로 오는 순간 이미 내가 폴더안에 파일 업로드한 상황 
			
			//업로드한 파일의 확장자를 가져오기 //.getName() → abc.jpg
			//substring: 문자열(String)에서 원하는 부분만 잘라내는 메서드
			//lastIndexOf("."): 점(.) 다음 글자부터 확장자를 잘라낼 때 기준이 되는 위치를 구하는 코드			
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1); //.기준 뒤로 잘라준다 
			
			//소문자인 경우 대문자로 통일
			ext = ext.toUpperCase();
			if(!(ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG"))) {
				//이미지 파일이 아니라면 파일을 삭제한다 
				if(file.exists()) {
					//해당 파일이 존재하는지 유무
					file.delete();
					rttr.addFlashAttribute("msgType", "실패메세지"); 
					rttr.addFlashAttribute("msg", "이미지 파일만 가능합니다(PNG, JPG, GIF)");
					return "redirect:/imageForm.do";
				}
			}
		}
		
		//업로드한 이미지의 이름 
		//업로드된 파일 "memProfile"의 서버에 저장된 실제 파일 이름을 문자열로 반환해 줌.
		String newProfile = multi.getFilesystemName("memProfile");
		
		//로그인 정보에 업로드한 이미지 넣기 
		mvo.setMemProfile(newProfile);
		
		
		//해당회원 DB에 파일 이름 넣기 
		mapper.profileUpdate(mvo);
		
		//세션에 새로운 정보 넣어주기 
		session.setAttribute("mvo", mvo);
		rttr.addFlashAttribute("msgType", "성공메세지"); 
		rttr.addFlashAttribute("msg", "이미지 변경이 성공했습니다");
		
		return "redirect:/"; 
	}
	
}




















