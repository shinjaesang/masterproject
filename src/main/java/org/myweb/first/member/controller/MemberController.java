package org.myweb.first.member.controller;

import java.io.File;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
			return "common/main";
		}
	}

	@RequestMapping(value = "idchk.do", method = RequestMethod.POST)
	@ResponseBody
	public String dupCheckEmpIdMethod(@RequestParam("empId") String empId) {
		int result = memberService.selectCheckId(empId);
		return (result == 0) ? "ok" : "dup";
	}

	@RequestMapping(value = "emailchk.do", method = RequestMethod.POST)
	@ResponseBody
	public String dupCheckEmailMethod(@RequestParam("email") String email) {
		int result = memberService.selectCheckEmail(email);
		return (result == 0) ? "ok" : "dup";
	}

	@RequestMapping("findPassword.do")
	public String moveFindPasswordPage() {
		return "member/findPassword";
	}

	@RequestMapping(value = "findPassword.do", method = RequestMethod.POST)
	public String findPasswordMethod(@RequestParam("empId") String empId, 
								   @RequestParam("email") String email,
								   Model model) {
		logger.info("findPassword.do : empId=" + empId + ", email=" + email);

		Member member = memberService.findMemberByEmployeeNoAndEmail(empId, email);

		if (member != null) {
			String tempPassword = generateTempPassword();
			String encryptedPassword = bcryptPasswordEncoder.encode(tempPassword);
			member.setEmpPwd(encryptedPassword);
			memberService.updateMemberPassword(member);
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

	@RequestMapping("memberListView.do")
	public String moveToMemberListView(Model model) {
		ArrayList<Member> list = memberService.selectList(null);
		model.addAttribute("memberList", list);
		return "member/memberListView";
	}

	@RequestMapping("mypage.do")
	public String mypage(@RequestParam("empId") String empId, Model model) {
		Member member = memberService.selectMember(empId);
		model.addAttribute("member", member);
		return "member/mypage";
	}

	@RequestMapping(value = "enrollUser.do", method = RequestMethod.POST)
	public ModelAndView enrollUser(
		@RequestParam("empId") String empId,
		@RequestParam("empName") String empName,
		@RequestParam("department") String department,
		@RequestParam("job") String job,
		@RequestParam("email") String email,
		@RequestParam("phone") String phone,
		@RequestParam("empNo") String empNo,
		@RequestParam("hireDate") String hireDateStr,
		@RequestParam("address") String address,
		@RequestParam("empPwd") String empPwd) {
		
		logger.info("enrollUser.do 시작 - empId: {}, empName: {}", empId, empName);
		ModelAndView mv = new ModelAndView();
		
		try {
			// 사원번호 중복 체크
			int idCount = memberService.selectCheckId(empId);
			if (idCount > 0) {
				mv.addObject("message", "이미 사용 중인 사원번호입니다. 다른 사원번호를 사용해주세요.");
				mv.setViewName("common/error");
				return mv;
			}

			// 이메일 중복 체크
			int emailCount = memberService.selectCheckEmail(email);
			if (emailCount > 0) {
				mv.addObject("message", "이미 사용 중인 이메일입니다. 다른 이메일을 사용해주세요.");
				mv.setViewName("common/error");
				return mv;
			}

			// 전화번호 중복 체크
			int phoneCount = memberService.selectCheckPhone(phone);
			if (phoneCount > 0) {
				mv.addObject("message", "이미 사용 중인 전화번호입니다. 다른 전화번호를 사용해주세요.");
				mv.setViewName("common/error");
				return mv;
			}

			// 주민등록번호 중복 체크
			int empNoCount = memberService.selectCheckEmpNo(empNo);
			if (empNoCount > 0) {
				mv.addObject("message", "이미 사용 중인 주민등록번호입니다. 다른 주민등록번호를 사용해주세요.");
				mv.setViewName("common/error");
				return mv;
			}

			Member member = new Member();
			member.setEmpId(empId);
			member.setEmpName(empName);
			member.setDepartment(department);
			member.setJob(job);
			member.setEmail(email);
			member.setPhone(phone);
			member.setEmpNo(empNo);
			member.setAddress(address);
			member.setEmpPwd(empPwd);
			
			logger.info("입력된 회원 정보: {}", member);
			
			if (hireDateStr != null && !hireDateStr.isEmpty()) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date utilDate = sdf.parse(hireDateStr);
				member.setHireDate(new Date(utilDate.getTime()));
			}

			// 비밀번호 암호화
			String encryptedPwd = bcryptPasswordEncoder.encode(member.getEmpPwd());
			member.setEmpPwd(encryptedPwd);

			// 기본값 설정
			member.setAdminYN("N");
			member.setIsActive("Y");

			logger.info("DB에 저장할 회원 정보: {}", member);
			int result = memberService.insertMember(member);
			logger.info("회원 등록 결과: {}", result);

			if (result > 0) {
				mv.addObject("message", "사용자 등록이 성공적으로 완료되었습니다.");
				mv.setViewName("member/enrollSuccess");
			} else {
				mv.addObject("message", "사용자 등록에 실패했습니다.");
				mv.setViewName("common/error");
			}
		} catch (ParseException e) {
			logger.error("날짜 파싱 오류: {}", e.getMessage());
			mv.addObject("message", "날짜 형식이 잘못되었습니다.");
			mv.setViewName("common/error");
		} catch (Exception e) {
			logger.error("사용자 등록 중 오류 발생: {}", e.getMessage(), e);
			mv.addObject("message", "사용자 등록 처리 중 오류가 발생했습니다: " + e.getMessage());
			mv.setViewName("common/error");
		}

		return mv;
	}
}
