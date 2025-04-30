package org.myweb.first.member.controller;

import java.io.File;
import java.sql.Date;
import java.util.ArrayList;

import org.myweb.first.common.Paging;
import org.myweb.first.common.Search;
import org.myweb.first.member.model.dto.Member;
import org.myweb.first.member.model.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@RequestMapping("/loginPage.do")
	public String moveLoginPage() {
		return "member/loginPage";
	}

	@RequestMapping("enrollPage.do")
	public String moveEnrollPage() {
		return "member/enrollPage";
	}

	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String loginMethod(Member member, HttpSession session, SessionStatus status, Model model) {
		logger.info("login.do : " + member);

		Member loginUser = memberService.selectMember(member.getEmpId());

		// 임시 비밀번호 처리: 'hashed_pwd1'인 경우 BCrypt로 암호화하여 업데이트
		if (loginUser != null && "hashed_pwd1".equals(loginUser.getEmpPwd())) {
			String encryptedPwd = bcryptPasswordEncoder.encode("hashed_pwd1");
			loginUser.setEmpPwd(encryptedPwd);
			memberService.updateMemberPassword(loginUser);
			logger.info("Password updated to BCrypt format for user: " + loginUser.getEmpId());
		}

		if (loginUser != null && 
			((member.getEmpPwd().equals(loginUser.getEmpPwd())) || // 평문 비밀번호 비교
			 bcryptPasswordEncoder.matches(member.getEmpPwd(), loginUser.getEmpPwd())) && // BCrypt 비밀번호 비교
			"Y".equals(loginUser.getIsActive())) {
			
			session.setAttribute("loginUser", loginUser);
			status.setComplete();
			// 로그인 성공시 마지막 로그인 시간 업데이트
			memberService.updateLastLoginDate(member.getEmpId());
			return "common/main";
		} else {
			model.addAttribute("message", "로그인 실패! 사원번호나 비밀번호를 다시 확인하세요. 또는 비활성화된 계정입니다. 관리자에게 문의하세요.");
			return "common/error";
		}
	}

	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
			return "common/main";
		} else {
			/* model.addAttribute("message", "로그인 세션이 존재하지 않습니다."); */
			return "common/main";
		}
	}

	@RequestMapping(value = "idchk.do", method = RequestMethod.POST)
	@ResponseBody
	public String dupCheckEmpIdMethod(@RequestParam("empId") String empId) {
		int result = memberService.selectCheckId(empId);
		return (result == 0) ? "ok" : "dup";
	}

	// 비밀번호 찾기 페이지로 이동
	@RequestMapping("findPassword.do")
	public String moveFindPasswordPage() {
		return "member/findPassword";
	}

	// 비밀번호 찾기 처리
	@RequestMapping(value = "findPassword.do", method = RequestMethod.POST)
	public String findPasswordMethod(@RequestParam("empId") String empId, 
								   @RequestParam("email") String email,
								   Model model) {
		logger.info("findPassword.do : empId=" + empId + ", email=" + email);

		Member member = memberService.findMemberByEmployeeNoAndEmail(empId, email);

		if (member != null) {
			// 임시 비밀번호 생성
			String tempPassword = generateTempPassword();
			
			// 비밀번호 암호화
			String encryptedPassword = bcryptPasswordEncoder.encode(tempPassword);
			
			// 임시 비밀번호로 업데이트
			member.setEmpPwd(encryptedPassword);
			memberService.updateMemberPassword(member);
			
			// 이메일로 임시 비밀번호 전송
			memberService.sendTempPasswordEmail(email, tempPassword);
			
			model.addAttribute("message", "임시 비밀번호가 이메일로 전송되었습니다.");
			return "member/loginPage";
		} else {
			model.addAttribute("message", "입력하신 정보와 일치하는 계정을 찾을 수 없습니다.");
			return "common/error";
		}
	}

	private String generateTempPassword() {
		String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < 8; i++) {
			int index = (int) (Math.random() * chars.length());
			sb.append(chars.charAt(index));
		}
		return sb.toString();
	}

	// 사원 목록 조회 페이지로 이동
	@RequestMapping("memberListView.do")
	public String moveToMemberListView(Model model) {
		ArrayList<Member> list = memberService.selectList(null);  // 페이징 처리는 나중에 추가
		model.addAttribute("memberList", list);
		return "member/memberListView";
	}

	@RequestMapping("mypage.do")
	public String mypage(@RequestParam("empId") String empId, Model model) {
		// empId를 사용하여 사용자 정보를 조회
		Member member = memberService.selectMember(empId);
		model.addAttribute("member", member);
		return "member/mypage";
	}

}
