package com.myweb.member.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.myweb.member.mapper.MemberMapper;
import com.myweb.member.vo.LoginVO;
import com.myweb.member.vo.MemberVO;
import com.webjjang.util.PageObject;

@Service
@Qualifier("ms")
public class MemberServiceImpl implements MemberService{
	
	// 자동 DI
	@Inject
	private MemberMapper mapper;
	
	// 회원 리스트
	@Override
	public List<MemberVO> list(PageObject pageObject) throws Exception {
		// TODO Auto-generated method stub
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}
	
	// 로그인 처리
	@Override
	public LoginVO login(LoginVO vo) throws Exception{
		// TODO Auto-generated method stub
		return mapper.login(vo);
	}
	
	// 회원가입 처리
	@Override
	public int write(MemberVO vo) throws Exception{
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}
	// 아이디 중복체크
	@Override
	public String idCheck(String id) throws Exception {
		// TODO Auto-generated method stub
		return mapper.idCheck(id);
	}
	// 회원정보 보기/ 내정보 보기
	@Override
	public MemberVO view(String id) throws Exception {
		// TODO Auto-generated method stub
		return mapper.view(id);
	}
	// 회원상태 변경
	@Override
	public int changeStatus(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.changeStatus(vo);
	}
	// 회원등급 변경
	@Override
	public int changeGradeNo(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.changeGradeNo(vo);
	}



}
