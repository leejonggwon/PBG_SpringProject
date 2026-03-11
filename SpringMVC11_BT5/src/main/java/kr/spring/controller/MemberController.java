package kr.spring.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
	public String imageUpdate(@AuthenticationPrincipal CustomUser customUser, // 스프링 시큐리티가 관리하는 사용자 정보를 customUser라는 이름으로 바로 꺼내준다
	                          @RequestParam("profile") MultipartFile file,
	                          RedirectAttributes rttr) {

	    String uploadDir = "C:/boot_upload/profile_upload/"; 

	    // 1. 로그인 체크 (customUser가 null이면 인증 정보가 없는 것)
	    if (customUser == null) {
	        rttr.addFlashAttribute("msg", "로그인 세션이 만료되었습니다.");
	        return "redirect:/loginForm";
	    }

	    // 2. CustomUser 안에 있는 Member 객체 꺼내기
	    // (보통 CustomUser 안에 Member 필드가 있고 getMember() 메서드가 있을 거야)
	    Member mvo = customUser.getMember(); //CustomUser 안에 Member를 꺼낸다
	    String username = mvo.getUsername(); 

	    if (!file.isEmpty()) { //파일이 비어있지 않으면
	        try {
	            // 3. 기존 파일 삭제
	            String oldImg = mvo.getProfile(); //현재 존재하는 profile값
	            if (oldImg != null && !oldImg.isEmpty()) { //profile값이 있는 경우 
	            	//new File(경로 + 파일명) : 주소에 있는 실제 파일 덩어리를 다룰 수 있게 '파일 객체'로 변환하는 역할
	                File oldFile = new File(uploadDir + oldImg); //new File(경로 + 파일명) → 실제파일의 위치정보를 oldFle 객체를 만든다  
	                if (oldFile.exists()) oldFile.delete(); //자리에 파일이 있으면 삭제한다
	            }

	            // 4. 새 파일 저장 (UUID 사용) //UUID:  파일명 안겹치게 하는역할
	            String originalName = file.getOriginalFilename(); //파일을 선택했을 때의 진짜 이름
	            String newFileName = UUID.randomUUID().toString() + "_" + originalName; //a1b2c3d4..._profile.jpg
	            
	            file.transferTo(new File(uploadDir + newFileName)); //new File(경로 + 파일명)를 file에 저장한다

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
	    } //if (!file.isEmpty())

	    return "redirect:/board/list";
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

	
	
	
}


