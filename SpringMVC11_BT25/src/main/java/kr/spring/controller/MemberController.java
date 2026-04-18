package kr.spring.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriUtils;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.CustomUser;
import kr.spring.entity.Member;
import kr.spring.entity.PageMaker;
import kr.spring.entity.Role;
import kr.spring.service.MemberService;

@Controller
@RequestMapping("/member/*") //member로 들어오는것 처리한다 
public class MemberController { 
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	//로그인페이지로 이동
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
	@GetMapping("/memberUpdateForm")
	public String updateForm() {
		return "member/memberUpdateForm";
	}
	
	
	
	//회원가입 기능
	@PostMapping("/join")
	public String join(Member m, RedirectAttributes rttr) {
		
		if(service.registerCheck(m.getUsername()) == 1 || service.nick_nameCheck(m.getNick_name()) == 1
				) {
			rttr.addFlashAttribute("msgType", "실패메세지"); 
			rttr.addFlashAttribute("msg", "해당 아이디 또는 닉네임은 이미 사용 중입니다");
			return "redirect:/member/joinForm";
			
		}else {
			m.setProfile("");
			
			m.setPassword(passwordEncoder.encode(m.getPassword()));
			int cnt = service.join(m);
			System.out.println("cnt값 :"+cnt);
			
			if(cnt == 1) {
				System.out.println("회원가입 성공");
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "회원가입에 성공했습니다");					
				return "redirect:/member/login";
			}else {
				System.out.println("회원가입 실패");
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "회원가입에 실패했습니다");
				
				return "redirect:/member/joinForm";
			}			
		}
	}
	
	
	
	//회원가입폼 이동
	@GetMapping("/adminPage")
	public String adminPage() {
		return "member/adminPage";
	}
	
	//회원권한전체조회
	//현재페이지, 한 페이지당 몇개 게시글 보일지, 몇 페이지에 가져올 게시글범위를 위해 Criteria 객체가 필요하다 
	@RequestMapping("/memberList")  
	public @ResponseBody Map<String, Object> memberList(Criteria cri) {    
		List<Member> list = service.memberList(cri);//게시글 목록 전체보는 기능
		
		//페이징처리에 필요한 PageMaker객체생성 
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);	
		pageMaker.setTotalCount(service.totalCount(cri)); //총게시글
		
		// 데이터를 담을 Map 생성(String은 키 Object는 값)
	    Map<String, Object> result = new HashMap<>();
	    result.put("list", list);           // 회원 목록
	    result.put("pageMaker", pageMaker); // 페이징 정보
		
		return result; //비동기 방식의 서버는 JSON데이터를 반환한다 
	}
	
	

	//회원권한/교육과정수정
	@PostMapping("/roleCourceUpdate")  
	public @ResponseBody void roleCourceUpdate(Member member) {   		
		service.roleCourceUpdate(member);	
	}
	

	//계정관리전 현재비밀번호폼으로 이동
	@GetMapping("/memberUpdateForm_passwordCheckForm")
	public String memberUpdateForm_passwordCheckForm() {
		return "member/memberUpdateForm_passwordCheckForm";
	}
	

	
	//현재비밀번호
	@PostMapping("/passwordCheck")
	public String passwordCheck(String passwordCheck, Authentication authentication, RedirectAttributes rttr) {
		
	    CustomUser customUser = (CustomUser) authentication.getPrincipal();
	   
	    //dbPassword값: {bcrypt}$2a$10$TQAHIlZ5Xasxs9Y4j1/GVO5Nloodf58U/58DWiUz3JUNNldgsmw.m
	    String dbPassword = customUser.getMember().getPassword(); 
	    
	    //passwordEncoder.matches(평문, 암호문) 사용
	    if (passwordEncoder.matches(passwordCheck, dbPassword)) {
	        rttr.addFlashAttribute("msgType", "성공메세지"); 
	        rttr.addFlashAttribute("msg", "확인되었습니다.");
	        
	        // 성공 시 이동 (원하는 페이지로)
	        return "redirect:/member/memberUpdateForm"; 
	    } else {
	        rttr.addFlashAttribute("msgType", "실패메세지"); 
	        rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
	        
	        return "redirect:/member/memberUpdateForm_passwordCheckForm";
	    }
	}
	
	
	//프로필업로드
	@PostMapping("/imageUpdate")
	public String imageUpdate(@AuthenticationPrincipal CustomUser customUser, 
								// 시큐리티가 관리하는 사용자 정보를 customUser라는 이름으로 바로 꺼내준다
	                          @RequestParam("profile") MultipartFile file,  
	                          	//<input type="file" name="profile">이 변수로 연결된다
	                          RedirectAttributes rttr) {
	    String uploadDir = "C:/boot_upload/profile_upload/"; //외부경로
	    
	    // 1. 로그인 체크 (customUser가 null이면 인증 정보가 없는 것)
	    if (customUser == null) {
	        rttr.addFlashAttribute("msg", "로그인 세션이 만료되었습니다.");
	        return "redirect:/loginForm";
	    }

	    // 2. CustomUser 안에 있는 Member 객체 꺼내기
	    //CustomUser 안에 Member값을 꺼낸다
	     //username, password, role, name, nick_name, age, gender, email, profile, enabled 값
	    Member mvo = customUser.getMember(); 
	    //CustomUser 안에 Member값의 username 값
	    String username = mvo.getUsername(); 

	    if (!file.isEmpty()) { //파일값이 있을 때만 아래 로직실행
	    	
	        try {
	            // 3. 기존 파일 삭제
	        	//4c0b44b4-1132-4a89-9922-32470e20f495_logo.jpg
	            String oldImg = mvo.getProfile(); //DB에 저장되어 있는 profile값      
	            
	            if (oldImg != null && !oldImg.isEmpty()) { //profile값이 있는경우 
	            	//new File(경로 + 파일명) → 실제파일의 위치정보를 oldFle 객체를 만든다
	            	//C:\boot_upload\profile_upload\21b397aa-8b24-4ab1-9b01-cce6f540cd6b_Eye.png
	                File oldFile = new File(uploadDir + oldImg);                 
	                if (oldFile.exists()) oldFile.delete(); //자리에 파일이 있으면 삭제한다
	            }

	            // 4. 새 파일 저장 (UUID 사용) //UUID:  파일명 안겹치게 하는역할
	            //파일을 선택했을 때의 진짜 이름 //lee.png
	            String originalName = file.getOriginalFilename();       
	            //a1b2c3d4..._lee.jpg
	            String newFileName = UUID.randomUUID().toString() + "_" + originalName; 
	            
	            //네가 지정한 '하드디스크'로 파일을 실제로 저장하는 핵심 명령어
	            //new File(경로 + 파일명)를 file에 저장한다
	             //C:\boot_upload\profile_upload\21b397aa-8b24-4ab1-9b01-cce6f540cd6b_lee.png
	            file.transferTo(new File(uploadDir + newFileName)); 

	            // 5. DB 업데이트
	            mvo.setProfile(newFileName); 
	            service.profileUpdate(mvo); 

	            // 6. 중요: 현재 세션의 인증 정보(Principal)도 업데이트
	            // 이렇게 해야 common.jsp 같은 곳에서 <sec:authentication>으로 바로 바뀐 사진이 보인다
	            customUser.getMember().setProfile(newFileName);

	            rttr.addFlashAttribute("msgType", "성공메세지");
	            rttr.addFlashAttribute("msg", "프로필 사진이 변경되었습니다.");
	        } catch (Exception e) {
	            e.printStackTrace();
	            rttr.addFlashAttribute("msg", "파일 처리 중 에러가 발생했습니다.");
	        }
	    } //if (!file.isEmpty())
	    return "redirect:/member/memberUpdateForm";
	}
	
	
	//다운로드버튼
	@GetMapping("/download/{fileName:.+}") // :.+ : 파일 이름 뒤에 붙는 마침표(.)와 확장자까지 잘리지 않게 다 가져와라는 명령
	public ResponseEntity<Resource> downloadFile(@PathVariable String fileName) {
	    try {
	        // 실제 profile 이미지가 저장된 물리적 경로
	        String uploadDir = "C:/boot_upload/profile_upload/"; 
	        //path: 네비게이션 역할
	        Path path = Paths.get(uploadDir + fileName); //C:\boot_upload\profile_upload\ + a1b2c3d4...abc_test.jpg
	        //path에 찍힌 주소를 보고, 실제로 그 위치에 가서 파일이라는 '물건'을 집어 올리는 동작"
	        Resource resource = new UrlResource(path.toUri());

	        if (!resource.exists()) {
	            return ResponseEntity.notFound().build(); //없으면 404에러 뜬다
	        }

	        // 1. UUID가 붙은 파일명에서 실제 이름만 추출 (예: uuid_test.jpg -> test.jpg)
	        String downloadName = fileName;
	        if (fileName.contains("_")) { 									  //_가 들어가 있나?
	            downloadName = fileName.substring(fileName.indexOf("_") + 1); //_가 들어가 있는 +1번째 글자부터 끝까지 잘라라!
	        }

	        // 2. 한글 파일명 깨짐 방지 인코딩
	        String encodedFileName = UriUtils.encode(downloadName, StandardCharsets.UTF_8);
	        
	        // 3. 다운로드 헤더 설정 (다운로드방식과, 최종 파일 이름을 지정)
	        //  1. attachment: 첨부형태로 다운로드방식
	        //  2. filename=\"" + encodedFileName + "\" : UUID 떼고 한글인코딩 파일이름 지정
	        String contentDisposition = "attachment; filename=\"" + encodedFileName + "\"";
	        
	        //서버가 준비한 택배 상자(파일)를 브라우저에게 최종적으로 던져주는 동작
	        return ResponseEntity.ok() //파일찾기 성공했다는 상태확인 
	                .header(HttpHeaders.CONTENT_DISPOSITION, contentDisposition) //행동 지시 라벨 부착
	                .contentType(MediaType.APPLICATION_OCTET_STREAM) //내용물 종류 선언
	                .body(resource);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.internalServerError().build();
	    }
	}

	
	//닉네임수정 기능
	@PostMapping("/update_nick_name")
	public String update_nick_name(Member m, RedirectAttributes rttr, Authentication authentication) {
			
			//스프링 시큐리티를 쓰면 사용자가 로그인할 때 
		    // 인증 토큰(Authentication)이라는 신분증을 만들어서 세션 바구니(SecurityContext)에 넣어두는데
		    // 그런데 DB를 수정해도 이 신분증은 자동으로 갱신되지 않는다 그래서 수동으로 "신규 신분증 발급"을 해주는 과정이다
			// 1. DB 수정 (서비스 호출)
			int cnt = service.update_nick_name(m);
			
			if(cnt == 1) {
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "닉네임수정 되었습니다");									
			}else {
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "닉네임수정에 실패했습니다");				
			}		
			
			// 2. 현재 CustomUser 가져오기
			//getPrincipal()은 현재 접속자의 핵심 정보(ID, 권한 등)를 담고 있다
			CustomUser customUser = (CustomUser) authentication.getPrincipal();
		    
		    // 3. CustomUser 내부의 MemberVO 객체 정보 갱신
		    // 꺼내온 유저 객체 안에 들어있는 MemberVO의 닉네임을 새로운 값(m.getNick_name())으로 직접 바꿔준다
			// 세션역할하는 메모리가 바뀐다
		    customUser.getMember().setNick_name(m.getNick_name());

		    // 4. [중요] 새로운 인증 토큰 생성
		    // 정보가 수정된 customUser를 가지고 '새로운 신분증(Token)'을 만드는 과정이다
		    //UsernamePasswordAuthenticationToken는 Authentication(신분증) 설계도를 실제로 구현해서 만든 '실물 신분증'이라고 보면 된다
		    UsernamePasswordAuthenticationToken newToken = 
		        new UsernamePasswordAuthenticationToken(customUser, authentication.getCredentials(), authentication.getAuthorities());
		    
		    //세션강제 갱신하기
		    //새 신분증(newToken)을 신분증을 공식 신분증 보관함(SecurityContext)에 꽂아넣는 것과 같다
		    //getContext(): 현재 접속 중인 나'의 개인 보관함(Context)
		    //setAuthentication(newToken): 신분증 갈아 끼우기
		    SecurityContextHolder.getContext().setAuthentication(newToken);
			
			return "redirect:/member/memberUpdateForm";
		}
	
	
	    //비밀번호수정 기능
		@PostMapping("/update_password")
		public String update_password(Member m, RedirectAttributes rttr, Authentication authentication) {
				
				m.setPassword(passwordEncoder.encode(m.getPassword()));
				int cnt = service.update_password(m);
				
				if(cnt == 1) {			
					rttr.addFlashAttribute("msgType", "성공메세지"); 
					rttr.addFlashAttribute("msg", "비밀번호수정 성공했습니다");	
					
					return "redirect:/member/logout"; //action="${cpath}/member/logout"와 같은효과를 낸다
				}else {
					rttr.addFlashAttribute("msgType", "실패메세지"); 
					rttr.addFlashAttribute("msg", "비밀번호수정 실패했습니다");	
					
					return "redirect:/member/memberUpdateForm";
				}					

			}
		

		//회원정보수정기능
		@PostMapping("/member_update")
		public String member_update(Member m, RedirectAttributes rttr, Authentication authentication) {
				
				int cnt = service.member_update(m);
				
				if(cnt == 1) {
					rttr.addFlashAttribute("msgType", "성공메세지"); 
					rttr.addFlashAttribute("msg", "회원정보가 수정되었습니다");									
				}else {
					rttr.addFlashAttribute("msgType", "실패메세지"); 
					rttr.addFlashAttribute("msg", "회원정보 수정에 실패했습니다");				
				}		
		
				CustomUser customUser = (CustomUser) authentication.getPrincipal();
	
			    customUser.getMember().setName(m.getName());
			    customUser.getMember().setGender(m.getGender());
			    customUser.getMember().setEmail(m.getEmail());
			    
			    UsernamePasswordAuthenticationToken newToken = 
			        new UsernamePasswordAuthenticationToken(customUser, authentication.getCredentials(), authentication.getAuthorities());

			    SecurityContextHolder.getContext().setAuthentication(newToken);
				
				return "redirect:/member/memberUpdateForm";
			}
		
		//프로필이미지삭제
		@PostMapping("/imageDelete")  
		public String imageDelete(String username, RedirectAttributes rttr, Authentication authentication) { 


			int cnt = service.imageDelete(username);
			
			if(cnt == 1) {			
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "프로필이미지가 삭제되었습니다");			
			}else {
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "프로필이미지 삭제에 실패했습니다");								
			}	
			
			CustomUser customUser = (CustomUser) authentication.getPrincipal();
	
		    customUser.getMember().setProfile("");
		    
		    UsernamePasswordAuthenticationToken newToken = 
		        new UsernamePasswordAuthenticationToken(customUser, authentication.getCredentials(), authentication.getAuthorities());

		    SecurityContextHolder.getContext().setAuthentication(newToken);
			
			return "redirect:/member/memberUpdateForm";
		}
				
		
		//탈퇴하기
		@PostMapping("/close_account")  
		public String close_account(String username, RedirectAttributes rttr) { 

			int cnt = service.close_account(username);
			
			if(cnt == 1) {			
				rttr.addFlashAttribute("msgType", "성공메세지"); 
				rttr.addFlashAttribute("msg", "회원탈퇴 되었습니다");	
				
				return "redirect:/member/logout"; //action="${cpath}/member/logout"와 같은효과를 낸다
			}else {
				rttr.addFlashAttribute("msgType", "실패메세지"); 
				rttr.addFlashAttribute("msg", "회원탈퇴 실패했습니다");	
				
				return "redirect:/member/memberUpdateForm";
			}	
		}
		
		
		
		
	
}


