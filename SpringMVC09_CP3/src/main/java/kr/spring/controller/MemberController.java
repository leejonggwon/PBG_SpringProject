package kr.spring.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.spring.entity.Board;
import kr.spring.entity.Member;
import kr.spring.service.BoardService;
import kr.spring.service.MemberService;

@Controller
@RequestMapping("/member/*") //login으로 해서 들어오는것들은 LoginController에서 받아드린다 
public class MemberController {
	
	//MemberService를 따로 만들어야하지만 로그인,로그아웃 기능만 사용하므로 BoardService 가져다 사용한다 
	@Autowired
	private MemberService service;
	
	
	//로그아웃
	@RequestMapping("/logoutProcess")
	public String logout(HttpSession session) {
		session.invalidate(); //세션만료(3tier가지 않는다)
		return "redirect:/board/list";
	}
		
	
	//로그인
	@RequestMapping("/loginProcess")
	public String login(Member vo, HttpSession session) { //id와 password Member vo에 담김
		
		Member mvo = service.login(vo); //일치하면 Member 형태로 로그인한 회원의 모든 정보들어있다
		
		if(mvo != null) {
			session.setAttribute("mvo", mvo); //세션저장
		}
		return "redirect:/board/list";
	}
	
	
	//회원사진등록 페이지 이동
	@GetMapping("/imageForm")
	public String imageForm() {
		System.out.println("회원사진등록 페이지 이동");
		return "member/imageForm"; 
	}
	
	
	
	
	//회원사진등록 기능
	@RequestMapping("/imageUpdate")
	public String imageUpdate(HttpServletRequest request, RedirectAttributes rttr, HttpSession session) {
		
		MultipartRequest multi = null;
		
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
			return "redirect:/member/imageForm";
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
					return "redirect:/member/imageForm";
				}
			}
		}
		
		//업로드한 이미지의 이름 
		//업로드된 파일 "memProfile"의 서버에 저장된 실제 파일 이름을 문자열로 반환해 줌.
		String newProfile = multi.getFilesystemName("memProfile");
		
		//로그인 정보에 업로드한 이미지 넣기 
		mvo.setMemProfile(newProfile);
		
		
		//해당회원 DB에 파일 이름 넣기 
		service.profileUpdate(mvo);
		
		//세션에 새로운 정보 넣어주기 
		session.setAttribute("mvo", mvo);
		rttr.addFlashAttribute("msgType", "성공메세지"); 
		rttr.addFlashAttribute("msg", "이미지 변경이 성공했습니다");
		
		return "redirect:/board/list"; 
	}

	
	
	
	
	
	

	//업데이트폼 이동 
	@RequestMapping("/updateForm")
	public String updateForm() {
		System.out.println("회원정보수정 페이지로 이동");
		return "member/updateForm"; 
	}
	
	
	
	
	@RequestMapping("/update")
	public String update(HttpServletRequest request, RedirectAttributes rttr, HttpSession session) {

	    MultipartRequest multi = null;       

	    // 1) 파일 저장 위치
	    String savePath = request.getRealPath("resources/upload");
	    int fileMaxSize = 10 * 1024 * 1000;

	    Member mvo = (Member)session.getAttribute("mvo");

	    try {
	        multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
	    } catch (Exception e) {
	        rttr.addFlashAttribute("msgType", "실패메세지");
	        rttr.addFlashAttribute("msg", "파일의 크기가 너무 큽니다");
	        return "redirect:/member/updateForm";
	    }

	    //**multipart/form-data로 들어오면 Spring MVC 기본 바인딩(Member m) 은 작동하지 않는다
	    // MultipartRequest multi = new MultipartRequest(request,) 이 실행되면 ulti.getParameter() 로 읽어야 한다
	    // Member m 에는 입력값이 안 들어가고 null, 0 값 발생 → 유효성 검사 실패한
	    // 2) multi에서 일반 파라미터 꺼내기
	    Member m = new Member();
	    m.setMemID(mvo.getMemID());
	    m.setMemPassword(multi.getParameter("memPassword"));
	    m.setMemName(multi.getParameter("memName"));
	    m.setMemAge(Integer.parseInt(multi.getParameter("memAge")));
	    m.setMemGender(multi.getParameter("memGender"));
	    m.setMemEmail(multi.getParameter("memEmail"));

	    // 3) 유효성 검사
	    if(m.getMemPassword() == null || m.getMemPassword().equals("") ||
	       m.getMemName() == null || m.getMemName().equals("") ||
	       m.getMemAge() == 0 ||
	       m.getMemEmail() == null || m.getMemEmail().equals("") ) {

	        rttr.addFlashAttribute("msgType", "실패메세지");
	        rttr.addFlashAttribute("msg", "모든 내용을 입력하세요");
	        return "redirect:/member/updateForm";
	    }

	    // 4) 이미지 처리
	    File file = multi.getFile("memProfile");
	    if(file != null) {
	        // 확장자 체크
	        String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1).toUpperCase();
	        if(!(ext.equals("PNG") || ext.equals("JPG") || ext.equals("GIF"))) {
	            file.delete();
	            rttr.addFlashAttribute("msgType", "실패메세지");
	            rttr.addFlashAttribute("msg", "이미지 파일만 가능합니다");
	            return "redirect:/member/updateForm";
	        }

	        // 기존 이미지 삭제
	        String oldImg = mvo.getMemProfile();
	        File oldFile = new File(savePath + "/" + oldImg);
	        if(oldFile.exists()) oldFile.delete();

	        // 새 이미지 이름 저장
	        m.setMemProfile(multi.getFilesystemName("memProfile"));
	    } else {
	        // 파일 업로드 안 했으면 기존 이미지 유지
	        m.setMemProfile(mvo.getMemProfile());
	    }

	    // 5) DB 업데이트
	    int cnt = service.update(m);

	    if(cnt == 1) {
	        session.setAttribute("mvo", m);
	        rttr.addFlashAttribute("msgType", "성공메세지");
	        rttr.addFlashAttribute("msg", "회원정보수정에 성공했습니다");
	        return "redirect:/board/list";
	    } else {
	        rttr.addFlashAttribute("msgType", "실패메세지");
	        rttr.addFlashAttribute("msg", "회원정보수정에 실패했습니다");
	        return "redirect:/member/updateForm";
	    }
	}






}




