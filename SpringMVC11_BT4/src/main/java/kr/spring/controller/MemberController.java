package kr.spring.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.entity.Board;
import kr.spring.entity.CustomUser;
import kr.spring.entity.Member;
import kr.spring.entity.Role;
import kr.spring.service.MemberService;

@Controller
@RequestMapping("/member/*") //member로 들어오는것 처리한다 
public class MemberController { 
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	//회원가입폼 이동
	@GetMapping("/joinForm")
	public String joinForm() {
		return "member/joinForm";
	}
	
	//회원정보수정페이지 이동
	@GetMapping("/updateForm")
	public String updateForm() {
		return "member/updateForm";
	}
	
	//회원가입 기능
	@PostMapping("/join")
	public String join(Member m) {
		m.setPassword(passwordEncoder.encode(m.getPassword()));
		service.join(m);
		return "index";
	}
	
	//회원가입폼 이동
	@GetMapping("/adminPage")
	public String adminPage() {
		return "member/adminPage";
	}
	
	//회원권한전체조회
	@GetMapping("/roleAll")  
	public @ResponseBody List<Member> memberRoleList() {                                    
		List<Member> list = service.memberRoleList();//게시글 목록 전체보는 기능
		return list; //비동기 방식의 서버는 JSON데이터를 반환한다 
	}
	
	//회원권한수정
	@PostMapping("/roleUpdate")  
	public @ResponseBody Member roleUpdate(Member member) {                                    
		service.roleUpdate(member);
		return member;
	}
	
	
	@PostMapping("/imageUpdate")
	public String imageUpdate(@AuthenticationPrincipal CustomUser customUser, // CustomUser로 바로 받기
	                          @RequestParam("profile") MultipartFile file,
	                          RedirectAttributes rttr) {

	    String uploadDir = "C:/upload/"; 

	    // 1. 로그인 체크 (customUser가 null이면 인증 정보가 없는 것)
	    if (customUser == null) {
	        rttr.addFlashAttribute("msg", "로그인 세션이 만료되었습니다.");
	        return "redirect:/loginForm";
	    }

	    // 2. CustomUser 안에 있는 Member 객체 꺼내기
	    // (보통 CustomUser 안에 Member 필드가 있고 getMember() 메서드가 있을 거야)
	    Member mvo = customUser.getMember(); 
	    String username = mvo.getUsername();

	    if (!file.isEmpty()) {
	        try {
	            // 3. 기존 파일 삭제
	            String oldImg = mvo.getProfile();
	            if (oldImg != null && !oldImg.isEmpty()) {
	                File oldFile = new File(uploadDir + oldImg);
	                if (oldFile.exists()) oldFile.delete();
	            }

	            // 4. 새 파일 저장 (UUID 사용)
	            String originalName = file.getOriginalFilename();
	            String newFileName = UUID.randomUUID().toString() + "_" + originalName;
	            
	            file.transferTo(new File(uploadDir + newFileName));

	            // 5. DB 업데이트
	            mvo.setProfile(newFileName); 
	            service.profileUpdate(mvo); // JPA save()

	            // 6. 중요: 현재 세션의 인증 정보(Principal)도 업데이트
	            // 이렇게 해야 common.jsp 같은 곳에서 <sec:authentication>으로 바로 바뀐 사진이 보여!
	            customUser.getMember().setProfile(newFileName);

	            rttr.addFlashAttribute("msgType", "성공메세지");
	            rttr.addFlashAttribute("msg", "프로필 사진이 변경되었습니다.");

	        } catch (Exception e) {
	            e.printStackTrace();
	            rttr.addFlashAttribute("msg", "파일 처리 중 에러가 발생했습니다.");
	        }
	    }

	    return "redirect:/board/list";
	}

	
	
	
}


