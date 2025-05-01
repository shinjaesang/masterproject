package org.myweb.first.member.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.myweb.first.common.Paging;
import org.myweb.first.common.Search;
import org.myweb.first.member.model.dao.MemberDao;
import org.myweb.first.member.model.dto.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

//spring framework 에서는 서비스 interface 를 상속받는 후손클래스를 작성하도록 정해 놓았음
//후손 Impl 클래스를 서비스 클래스로 등록 처리함
@Service("memberService")  // servlet-context.xml 에 서비스 모델 클래스로 자동 등록되는 어노테이션임
public class MemberServiceImpl implements MemberService {
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

	//dao 와 연결 처리 (의존성 주입함 : DI)
	@Autowired
	private MemberDao memberDao;

	@Autowired
	private JavaMailSender mailSender;

	@Override
	public Member selectLogin(Member member) {
		return memberDao.selectLogin(member);
	}

	@Override
	public int selectCheckId(String empId) {
		return memberDao.selectCheckId(empId);
	}

	@Override
	@Transactional
	public int insertMember(Member member) {
		logger.info("MemberServiceImpl.insertMember 시작 - member: {}", member);
		try {
			int result = memberDao.insertMember(member);
			logger.info("MemberServiceImpl.insertMember 결과 - result: {}", result);
			return result;
		} catch (Exception e) {
			logger.error("MemberServiceImpl.insertMember 오류 발생: {}", e.getMessage(), e);
			throw e;
		}
	}

	@Override
	public Member selectMember(String empId) {
		return memberDao.selectMember(empId);
	}

	@Override
	@Transactional
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	@Transactional
	public int deleteMember(String empId) {
		return memberDao.deleteMember(empId);
	}

	// 관리자용 ------------------------------------------------------
	
	@Override
	public int selectListCount() {
		return memberDao.selectListCount();
	}

	@Override
	public List<Member> selectAllMembers() {
		return memberDao.selectAllMembers();
	}

	@Override
	public List<Member> searchMembers(Map<String, String> param) {
		return memberDao.searchMembers(param);
	}

	@Override
	public ArrayList<Member> selectList(Paging paging) {
		return memberDao.selectList(paging);
	}

	@Override
	public int updateLoginOk(Member member) {
		return memberDao.updateLoginOk(member);
	}

	@Override
	public int selectSearchUserIdCount(String keyword) {
		return memberDao.selectSearchUserIdCount(keyword);
	}

	@Override
	public int selectSearchGenderCount(String keyword) {
		return memberDao.selectSearchGenderCount(keyword);
	}

	@Override
	public int selectSearchAgeCount(int age) {
		return memberDao.selectSearchAgeCount(age);
	}

	@Override
	public int selectSearchEnrollDateCount(Search search) {
		return memberDao.selectSearchEnrollDateCount(search);
	}

	@Override
	public int selectSearchLoginOKCount(String keyword) {
		return memberDao.selectSearchLoginOKCount(keyword);
	}

	@Override
	public ArrayList<Member> selectSearchUserId(Search search) {
		return memberDao.selectSearchUserId(search);
	}

	@Override
	public ArrayList<Member> selectSearchGender(Search search) {
		return memberDao.selectSearchGender(search);
	}

	@Override
	public ArrayList<Member> selectSearchAge(Search search) {
		return memberDao.selectSearchAge(search);
	}

	@Override
	public ArrayList<Member> selectSearchEnrollDate(Search search) {
		return memberDao.selectSearchEnrollDate(search);
	}

	@Override
	public ArrayList<Member> selectSearchLoginOK(Search search) {
		return memberDao.selectSearchLoginOK(search);
	}

	@Override
	public Member findMemberByEmployeeNoAndEmail(String employeeNo, String email) {
		return memberDao.findMemberByEmployeeNoAndEmail(employeeNo, email);
	}

	@Override
	@Transactional
	public int updateMemberPassword(Member member) {
		return memberDao.updateMemberPassword(member);
	}

	@Override
	public void sendTempPasswordEmail(String email, String tempPassword) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("[StockMaster] 임시 비밀번호 발급");
		message.setText("임시 비밀번호: " + tempPassword + "\n\n보안을 위해 로그인 후 비밀번호를 변경해주세요.");
		
		mailSender.send(message);
	}

	@Override
	@Transactional
	public int updateLastLoginDate(String empId) {
		return memberDao.updateLastLoginDate(empId);
	}

	@Override
	public int selectCheckEmail(String email) {
		return memberDao.selectCheckEmail(email);
	}

	@Override
	public int selectCheckPhone(String phone) {
		return memberDao.selectCheckPhone(phone);
	}

	@Override
	public int selectCheckEmpNo(String empNo) {
		return memberDao.selectCheckEmpNo(empNo);
	}

	@Override
	@Transactional
	public int updateMemberStatus(Member member) {
		return memberDao.updateMemberStatus(member);
	}

}
