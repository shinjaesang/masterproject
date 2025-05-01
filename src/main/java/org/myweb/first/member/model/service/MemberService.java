package org.myweb.first.member.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.myweb.first.common.Paging;
import org.myweb.first.common.Search;
import org.myweb.first.member.model.dto.Member;

//spring framework 에서는 서비스 모델은 인터페이스로 만들도록 정해져 있음
//인터페이스에서 비즈니스 로직 처리용 메소드 규칙을 정의함
public interface MemberService {
	/*public abstract*/ Member selectLogin(Member member);
	int selectCheckId(String empId);
	Member selectMember(String empId);	
	//dml ----------------------------
	int insertMember(Member member);
	int updateMember(Member member);
	int deleteMember(String empId);
	//관리자용 ---------------------------
	int selectListCount();
	ArrayList<Member> selectList(Paging paging);
	int updateLoginOk(Member member);
	//관리자용 검색 카운트용 -----------------
	int selectSearchUserIdCount(String keyword);
	int selectSearchGenderCount(String keyword);
	int selectSearchAgeCount(int age);
	int selectSearchEnrollDateCount(Search search);
	int selectSearchLoginOKCount(String keyword);
	//관리자용 검색 목록 조회용 -------------------
	ArrayList<Member> selectSearchUserId(Search search);
	ArrayList<Member> selectSearchGender(Search search);
	ArrayList<Member> selectSearchAge(Search search);
	ArrayList<Member> selectSearchEnrollDate(Search search);
	ArrayList<Member> selectSearchLoginOK(Search search);
	
	//비밀번호 찾기 관련 메소드 ------------------
	Member findMemberByEmployeeNoAndEmail(String empId, String email);
	int updateMemberPassword(Member member);
	void sendTempPasswordEmail(String email, String tempPassword);
	
	//로그인 관련 메소드 ------------------
	int updateLastLoginDate(String empId);
	
	// New methods for checking duplicate email, phone, and empNo
	int selectCheckEmail(String email);
	int selectCheckPhone(String phone);
	int selectCheckEmpNo(String empNo);
	
	// 사용자 전체 목록 조회
	List<Member> selectAllMembers();
	
	// 검색 조건에 따른 사용자 목록 조회
	List<Member> searchMembers(Map<String, String> param);
	
	// 계정 상태 업데이트
	int updateMemberStatus(Member member);
	
	// 한 페이지에 출력할 목록 조회용 : 관리자가 아닌 회원만 조회함
}
