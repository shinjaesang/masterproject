package org.myweb.first.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.myweb.first.common.Paging;
import org.myweb.first.common.Search;
import org.myweb.first.member.model.dto.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("memberDao")  // servlet-context.xml 에 dao 클래스로 자동 등록하는 어노테이션임. (id 속성의 아이디지정할 수도 있음)
public class MemberDao {
	//마이바티스 매퍼 파일에 실행시킬 쿼리문(sql 문) 별도로 작성함
	//root-context.xml 에 설정된 마이바티스 세션 객체를 연결해서 사용함
	
	@Autowired  // root-context.xml 에서 생성한 객체를 자동 연결하는 어노테이션임
	private SqlSessionTemplate sqlSessionTemplate;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDao.class);
	
	public Member selectLogin(Member member) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectLogin", member);
	}
	
	public int selectCheckId(String userId) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectCheckId", userId);
	}
	
	public Member selectMember(String userId) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectMember", userId);
	}
	
	//dml -----------------------------------------
	public int insertMember(Member member) {
		logger.info("MemberDao.insertMember 시작 - member: {}", member);
		try {
			int result = sqlSessionTemplate.insert("org.myweb.first.member.model.dao.MemberDao.insertMember", member);
			logger.info("MemberDao.insertMember 결과 - result: {}", result);
			return result;
		} catch (Exception e) {
			logger.error("MemberDao.insertMember 오류 발생: {}", e.getMessage(), e);
			throw e;
		}
	}
	
	public int updateMember(Member member) {
		return sqlSessionTemplate.update("org.myweb.first.member.model.dao.MemberDao.updateMember", member);
	}
	
	public int deleteMember(String userId) {
		return sqlSessionTemplate.delete("org.myweb.first.member.model.dao.MemberDao.deleteMember", userId);
	}
	
	// 관리자용 **************************************
	
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectListCount");
	}
	
	public ArrayList<Member> selectList(Paging paging){
		List<Member> list = sqlSessionTemplate.selectList("org.myweb.first.member.model.dao.MemberDao.selectList", paging);
		return (ArrayList<Member>)list;
	}
	
	public int updateLoginOk(Member member) {
		return sqlSessionTemplate.update("org.myweb.first.member.model.dao.MemberDao.updateLoginOk", member);
	}
	
	//관리자용 회원 검색용 ************************************************
	public int selectSearchUserIdCount(String keyword) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectSearchUserIdCount", keyword);
	}
	
	public int selectSearchGenderCount(String keyword) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectSearchGenderCount", keyword);
	}
	
	public int selectSearchAgeCount(int age) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectSearchAgeCount", age);
	}
	
	public int selectSearchEnrollDateCount(Search search) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectSearchEnrollDateCount", search);
	}
	
	public int selectSearchLoginOKCount(String keyword) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectSearchLoginOKCount", keyword);
	}
	
	public ArrayList<Member> selectSearchUserId(Search search){
		List<Member> list = sqlSessionTemplate.selectList("org.myweb.first.member.model.dao.MemberDao.selectSearchUserId", search);
		return (ArrayList<Member>)list;
	}
	
	public ArrayList<Member> selectSearchGender(Search search){
		List<Member> list = sqlSessionTemplate.selectList("org.myweb.first.member.model.dao.MemberDao.selectSearchGender", search);
		return (ArrayList<Member>)list;
	}
	
	public ArrayList<Member> selectSearchAge(Search search){
		List<Member> list = sqlSessionTemplate.selectList("org.myweb.first.member.model.dao.MemberDao.selectSearchAge", search);
		return (ArrayList<Member>)list;
	}
	
	public ArrayList<Member> selectSearchEnrollDate(Search search){
		List<Member> list = sqlSessionTemplate.selectList("org.myweb.first.member.model.dao.MemberDao.selectSearchEnrollDate", search);
		return (ArrayList<Member>)list;
	}
	
	public ArrayList<Member> selectSearchLoginOK(Search search){
		List<Member> list = sqlSessionTemplate.selectList("org.myweb.first.member.model.dao.MemberDao.selectSearchLoginOK", search);
		return (ArrayList<Member>)list;
	}
	
	// 비밀번호 찾기 관련 메소드 ------------------
	public Member findMemberByEmployeeNoAndEmail(String empId, String email) {
		Member member = new Member();
		member.setEmpId(empId);
		member.setEmail(email);
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.findMemberByEmployeeNoAndEmail", member);
	}
	
	public int updateMemberPassword(Member member) {
		return sqlSessionTemplate.update("org.myweb.first.member.model.dao.MemberDao.updateMemberPassword", member);
	}
	
	// 로그인 관련 메소드 ------------------
	public int updateLastLoginDate(String empId) {
		return sqlSessionTemplate.update("org.myweb.first.member.model.dao.MemberDao.updateLastLoginDate", empId);
	}
	
	public int selectCheckEmail(String email) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectCheckEmail", email);
	}
	
	public int selectCheckPhone(String phone) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectCheckPhone", phone);
	}
	
	public int selectCheckEmpNo(String empNo) {
		return sqlSessionTemplate.selectOne("org.myweb.first.member.model.dao.MemberDao.selectCheckEmpNo", empNo);
	}
}










