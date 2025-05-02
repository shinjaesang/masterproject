package org.myweb.first.authority.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.myweb.first.authority.model.service.AuthorityService;
import org.myweb.first.member.model.dto.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/authority")
public class AuthorityController {

	@Autowired
	private AuthorityService authorityService;

	// 권한 관리 페이지로 이동
	@GetMapping("/list.do")
	public String authorityManagementPage(
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "department", required = false) String department,
			@RequestParam(value = "position", required = false) String position,
			@RequestParam(value = "role", required = false) String role,
			Model model) {
		
		// 검색 조건 설정
		Map<String, String> params = new HashMap<>();
		if (name != null && !name.isEmpty()) params.put("name", name);
		if (department != null && !department.isEmpty()) params.put("department", department);
		if (position != null && !position.isEmpty()) params.put("position", position);
		if (role != null && !role.isEmpty()) params.put("role", role);
		
		// 전체 사용자 수 조회
		int totalUsers = authorityService.getTotalUsers(params);
		
		// 페이징 계산
		int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
		int startPage = ((page - 1) / 10) * 10 + 1;
		int endPage = Math.min(startPage + 9, totalPages);
		
		// 페이징 정보 설정
		Map<String, Object> pagination = new HashMap<>();
		pagination.put("currentPage", page);
		pagination.put("startPage", startPage);
		pagination.put("endPage", endPage);
		pagination.put("totalPages", totalPages);
		pagination.put("pageSize", pageSize);
		
		// 페이지네이션 파라미터 계산
		int startRow = (page - 1) * pageSize + 1;
		int endRow = page * pageSize;
		params.put("startRow", String.valueOf(startRow));
		params.put("endRow", String.valueOf(endRow));
		
		// 현재 페이지의 사용자 목록 조회
		List<Member> userList = authorityService.getUsersByPage(page, pageSize, params);
		
		model.addAttribute("userList", userList);
		model.addAttribute("pagination", pagination);
		model.addAttribute("searchParams", params);
		
		return "management/auth-management";
	}

	// 사용자 검색
	@GetMapping("/search.do")
	@ResponseBody
	public List<Member> searchUsers(@RequestParam Map<String, String> params) {
		return authorityService.searchUsers(params);
	}

	// 사용자 상태 변경
	@PostMapping("/status/{empId}")
	@ResponseBody
	public ResponseEntity<String> updateUserStatus(
			@PathVariable("empId") String empId,
			@RequestParam("status") String status) {
		int result = authorityService.updateUserStatus(empId, status);
		return ResponseEntity.ok(result > 0 ? "success" : "fail");
	}

	// 사용자 권한 변경
	@PostMapping("/role/{empId}")
	@ResponseBody
	public ResponseEntity<String> updateUserRole(
			@PathVariable("empId") String empId,
			@RequestParam("role") String role) {
		int result = authorityService.updateUserRole(empId, role);
		return ResponseEntity.ok(result > 0 ? "success" : "fail");
	}

	// 사용자 삭제
	@PostMapping("/deleteUser.do")
	@ResponseBody
	public Map<String, Object> deleteUser(@RequestParam("empId") String empId) {
		Map<String, Object> response = new HashMap<>();
		try {
			int result = authorityService.deleteUser(empId);
			response.put("success", result > 0);
			response.put("message", result > 0 ? "사용자가 성공적으로 삭제되었습니다." : "사용자 삭제에 실패했습니다.");
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "사용자 삭제 중 오류가 발생했습니다: " + e.getMessage());
		}
		return response;
	}

	// 역할 관리 목록 페이지
	@GetMapping("/role.do")
	public String roleList(Model model) {
		return "management/role-management";
	}

	// 역할 추가 페이지
	@GetMapping("/roleadd.do")
	public String roleAdd(Model model) {
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
		return "management/role-edit";
	}

	// 사용자 추가 및 변경 페이지
	@GetMapping("/roleuseredit.do")
	public String roleUserEdit(Model model) {
		return "management/role-useredit";
	}

	// 권한 변경 로그 목록 페이지
	@GetMapping("/log.do")
	public String logList(Model model) {
		return "management/auth-updatelog";
	}
}