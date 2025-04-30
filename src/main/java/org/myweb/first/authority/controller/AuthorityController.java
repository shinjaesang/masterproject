package org.myweb.first.authority.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/authority")
public class AuthorityController {
	private static final Logger logger = LoggerFactory.getLogger(AuthorityController.class);

	// 사용자 권한 목록 페이지
	@GetMapping("/list.do")
	public String authorityList(Model model) {
		logger.info("권한 관리 페이지 접근");
		return "management/auth-management";
	}

	// 역할 관리 목록 페이지
	@GetMapping("/role.do")
	public String roleList(Model model) {
		logger.info("역할 관리 페이지 접근");
		return "management/role-management";
	}

	// 역할 추가 페이지
	@GetMapping("/roleadd.do")
	public String roleAdd(Model model) {
		logger.info("역할 추가 페이지 접근");
		return "management/role-add";
	}

	/*
	 * // 주문 등록 처리
	 * 
	 * @PostMapping("/roleadd.do") public String roleAdd (@ModelAttribute
	 * AuthorityDTO authority) { // TODO: 권한 추가 처리 로직 return "redirect:/role.do"; }
	 */

	// 역할 편집 페이지
	@GetMapping("/roleedit.do")
	public String roleEdit(Model model) {
		logger.info("역할 편집 페이지 접근");
		return "management/role-edit";
	}

	// 사용자 추가 및 변경 페이지
	@GetMapping("/roleuseredit.do")
	public String roleUserEdit(Model model) {
		logger.info("사용자 추가 및 변경 페이지 접근");
		return "management/role-useredit";
	}

	// 권한 변경 로그 목록 페이지
	@GetMapping("/log.do")
	public String logList(Model model) {
		logger.info("권한 변경 로그 페이지 접근");
		return "management/auth-updatelog";

	}
}