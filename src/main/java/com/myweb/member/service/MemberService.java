package com.myweb.member.service;

import java.util.List;

import com.myweb.member.vo.LoginVO;
import com.myweb.member.vo.MemberVO;
import com.webjjang.util.PageObject;

public interface MemberService {
	
	// 회원 리스트 - 관리자
	public List<MemberVO> list(PageObject pageObject) throws Exception;
	// 회원 정보보기
	public MemberVO view(String id)	throws Exception;
	// * 회원가입 처리
	// * 아이디 중복 체크
	public String idCheck(String id) throws Exception;
	// 회원수정 처리
	public int write(MemberVO vo) throws Exception;
	// 회원 탈퇴
	// 회원 상태 변경 처리 - 관리자 (회원 등급 폼 - 회원 리스트)
	public int changeStatus(MemberVO vo) throws Exception;
	// 회원 등급 수정 처리- 관리자 (회원 등급 폼 - 회원 리스트)
	public int changeGradeNo(MemberVO vo) throws Exception;
	// * 로그인 처리 - session을 이용한다.
	public LoginVO login(LoginVO vo) throws Exception; 
	// 아이디 찾기
	// 비밀번호 찾기

	
}
