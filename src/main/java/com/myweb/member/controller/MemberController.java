package com.myweb.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.member.service.MemberService;
import com.myweb.member.vo.LoginVO;
import com.myweb.member.vo.MemberVO;
import com.webjjang.util.PageObject;
import com.webjjang.util.file.FileUtil;

import lombok.extern.log4j.Log4j;

// 자동생성
// @Controller, @Service, @Repository, @Component, @RestController
@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	
	private final String MODULE = "member";
	// 자동 DI
	@Autowired
	@Qualifier("ms")
	private MemberService service;
	
	// 회원 리스트 - 관리자
	@GetMapping("/list.do")
	// @ModelAttribute 변수 - model에 담긴 벼수로 처리해 준다. -> JSP 까지 전달된다.
	public String list(@ModelAttribute PageObject pageObject, Model model) throws Exception {
		
		model.addAttribute("list", service.list(pageObject));
		
		return MODULE + "/list";
	}
	
	// 회원 정보보기 / 내 정보보기
	@GetMapping("/view")
	public String view(String id, Model model, HttpSession session) throws Exception {
		
		if(id == null) {
			model.addAttribute("title", "내 정보 보기");
			id = ((LoginVO)session.getAttribute("login")).getId();
		}
		else {
			
			model.addAttribute("title", "회원 정보 보기");
		}
		
		model.addAttribute("vo", service.view(id));
		
		return MODULE + "/view";
	}
	
	
	// * 회원가입 폼
	// * 회원가입 처리
	@PostMapping("/write.do")
	public String write(MemberVO vo, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		
		log.info("write().vo : " + vo);
		
		String path = "/upload/" + MODULE ;
		
		// 파일 서버에 올리기
		vo.setPhoto(FileUtil.upload(path , vo.getImageFile(), request));
		
		// DB에 데이터 쓰기
		service.write(vo);
		rttr.addFlashAttribute("msg", "회원가입 완료!!");
		
		return "/";
	}
	// * 아이디 중복 체크 -> Ajax 처리를 해서 /ajax URL 밑으로 만드는 것이 좋다. -> AjaxController
	@GetMapping("/idCheck")
	public String idCheck(String id, Model model) throws Exception{
		
		model.addAttribute("id", service.idCheck(id));
		
		return "member/idCheck";
	}
	
	// 회원수정 폼
	@GetMapping("/write.do")
	public String writeForm() {
		
		return MODULE + "/write";
	}
	
	// 회원수정 처리
	// 회원 탈퇴
	
	// 회원 상태 변경 처리 - 관리자 (회원 등급 폼 - 회원 리스트)
	@PostMapping("/changeStatus.do")
	public String changeStatus(PageObject pageObject, MemberVO vo) throws Exception {
		
		// DB에서 상태변경
		service.changeStatus(vo);
		
		return "redirect:view.do?id=" + vo.getId()
			+ "&page=" + pageObject.getPage() 
			+ "&perPageNum=" + pageObject.getPerPageNum();
	}
	
	// 회원 등급 수정 처리- 관리자 (회원 등급 폼 - 회원 리스트)
	@PostMapping("/changeGradeNo.do")
	public String changeGradeNo(PageObject pageObject, MemberVO vo) throws Exception {
		
		// DB에서 등급변경
		service.changeGradeNo(vo);
		
		return "redirect:view.do?id=" + vo.getId()
		+ "&page=" + pageObject.getPage() 
		+ "&perPageNum=" + pageObject.getPerPageNum();
	}
	
	// * 로그인 폼 - 아이디, 비밀번호
	@GetMapping("/login.do")
	public String loginForm() {
		return MODULE + "/login";
	}
	
	// * 로그인 처리 - session을 이용한다.
	@PostMapping("/login.do")
	public String login(LoginVO vo, HttpSession session) throws Exception {
		log.info("login().vo : " + vo);
		
		// DB에서 입력한 정보에 맞는 데이터를 가져온다.
		LoginVO loginVO = service.login(vo);
		
		log.info("login().vo : " + loginVO);
		
		// loginVO 가 null : 아이디와 비밀번호가 틀려서 데이터를 가져오지 못한경우
		if(loginVO == null) throw new Exception("아이디 와 비밀번호를 확인해주세요");
		
		// 실제적인 로그인 처리
		session.setAttribute("login", loginVO);
		
		return "redirect:/";
	}

	// * 로그아웃
	@GetMapping("/logout.do")
	public String loout(HttpSession session, RedirectAttributes rttr) {
		
		// 로그아웃 처리
		session.removeAttribute("login");
		
		rttr.addFlashAttribute("msg", "로그아웃 되었습니다.");
		
		return "redirect:/";
	}
	// 아이디 찾기
	// 비밀번호 찾기
}
