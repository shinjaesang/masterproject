package org.myweb.first.document.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import org.myweb.first.document.model.dto.Document;
import org.myweb.first.document.model.service.DocumentService;
import org.myweb.first.member.model.dto.Member;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/document")
public class DocumentController {
	private static final Logger logger = LoggerFactory.getLogger(DocumentController.class);

	@Autowired
	private DocumentService documentService;

	// 결재문서 목록 조회 페이지
	@GetMapping("/list.do")
	public String documentList(@RequestParam(value = "docId", required = false) String docId,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "documentFormat", required = false) String documentFormat,
			@RequestParam(value = "empId", required = false) String empId,
			@RequestParam(value = "empName", required = false) String empName,
			@RequestParam(value = "department", required = false) String department,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate,
			@RequestParam(value = "approvalStatus", required = false) String approvalStatus, Model model) {
		try {
			logger.info("결재문서 목록 조회 페이지 접근");

			Map<String, Object> searchParams = new HashMap<>();
			searchParams.put("docId", docId);
			searchParams.put("title", title);
			searchParams.put("documentFormat", documentFormat);
			searchParams.put("empId", empId);
			searchParams.put("empName", empName);
			searchParams.put("department", department);
			searchParams.put("startDate", startDate);
			searchParams.put("endDate", endDate);
			searchParams.put("approvalStatus", approvalStatus);

			List<Document> documents = documentService.selectDocumentList(searchParams);
			int totalCount = documentService.selectTotalDocumentCount(searchParams);

			model.addAttribute("documents", documents);
			model.addAttribute("totalCount", totalCount);
			model.addAttribute("pageTitle", "결재문서 목록");
			return "document/approval-documents";
		} catch (Exception e) {
			logger.error("결재문서 목록 조회 중 오류 발생: " + e.getMessage());
			model.addAttribute("error", "결재문서 목록을 불러오는 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	// 문서 작성 페이지
	@GetMapping("/register.do")
	public String documentWrite(Model model) {
		try {
			logger.info("문서 작성 페이지 접근");
			model.addAttribute("pageTitle", "문서 작성");
			return "document/approval-documentsregister";
		} catch (Exception e) {
			logger.error("문서 작성 페이지 접근 중 오류 발생: " + e.getMessage());
			model.addAttribute("error", "문서 작성 페이지를 불러오는 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	// 문서 등록 처리
	@PostMapping("/register.do")
	@ResponseBody
	public Map<String, Object> registerDocument(
			@RequestParam("title") String title,
			@RequestParam("content") String content,
			@RequestParam("documentType") String documentType,
			@RequestParam(value = "approverList", required = false) List<String> approverList,
			@RequestParam(value = "reviewerList", required = false) List<String> reviewerList,
			@RequestParam(value = "referrerList", required = false) List<String> referrerList,
			@RequestParam(value = "attachments", required = false) List<MultipartFile> attachments,
			HttpSession session) {
		
		Map<String, Object> response = new HashMap<>();
		
		try {
			// 세션에서 사용자 정보 가져오기
			Member loginUser = (Member) session.getAttribute("loginUser");
			if (loginUser == null) {
				response.put("success", false);
				response.put("message", "로그인이 필요합니다.");
				return response;
			}
			
			// Document 객체 생성 및 설정
			Document document = new Document();
			document.setTitle(title);
			document.setContent(content);
			document.setEmpId(loginUser.getEmpId());
			document.setDraftDate(new java.sql.Date(System.currentTimeMillis()));
			document.setApprovalStatus("발송");
			document.setDocumentFormat(documentType);
			
			// 결재선 데이터 파싱
			List<Map<String, Object>> approvers = approverList != null ? 
				approverList.stream()
					.map(json -> parseUserJson(json))
					.collect(Collectors.toList()) : 
				new ArrayList<>();
				
			List<Map<String, Object>> reviewers = reviewerList != null ? 
				reviewerList.stream()
					.map(json -> parseUserJson(json))
					.collect(Collectors.toList()) : 
				new ArrayList<>();
				
			List<Map<String, Object>> referrers = referrerList != null ? 
				referrerList.stream()
					.map(json -> parseUserJson(json))
					.collect(Collectors.toList()) : 
				new ArrayList<>();
			
			// 문서 등록
			int result = documentService.insertDocument(document, approvers, reviewers, referrers, attachments);
			
			if (result > 0) {
				response.put("success", true);
				response.put("message", "문서가 성공적으로 등록되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "문서 등록에 실패했습니다.");
			}
			
		} catch (Exception e) {
			logger.error("문서 등록 중 오류 발생", e);
			response.put("success", false);
			response.put("message", "문서 등록 중 오류가 발생했습니다: " + e.getMessage());
		}
		
		return response;
	}

	private Map<String, Object> parseUserJson(String json) {
		try {
			ObjectMapper mapper = new ObjectMapper();
			return mapper.readValue(json, Map.class);
		} catch (Exception e) {
			logger.error("JSON 파싱 오류", e);
			throw new RuntimeException("결재선 데이터 파싱 중 오류가 발생했습니다.");
		}
	}

	// 결재선 지정 페이지
	@GetMapping("/approval-line.do")
	public String approvalLine(Model model) {
		try {
			logger.info("결재선 지정 페이지 접근");
			List<Document> employees = documentService.selectApprovalLineEmployees();
			model.addAttribute("employees", employees);
			model.addAttribute("pageTitle", "결재선 지정");
			return "document/select-approval-line";
		} catch (Exception e) {
			logger.error("결재선 지정 페이지 접근 중 오류 발생: " + e.getMessage());
			model.addAttribute("error", "결재선 지정 페이지를 불러오는 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	// 검토자 지정 페이지 (과장, 부장만)
	@GetMapping("/reviewer-line.do")
	public String selectReviewerLine(Model model) {
		try {
			logger.info("검토자 지정 페이지 접근");
			List<Document> employees = documentService.selectReviewerLineEmployees();
			model.addAttribute("employees", employees);
			model.addAttribute("pageTitle", "검토자 지정");
			return "document/select-reviewer-line";
		} catch (Exception e) {
			logger.error("검토자 지정 페이지 접근 중 오류 발생: " + e.getMessage());
			model.addAttribute("error", "검토자 지정 페이지를 불러오는 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	// 참조자 지정 페이지 (모든 직급)
	@GetMapping("/reference-line.do")
	public String selectReferrerLine(Model model) {
		try {
			logger.info("참조자 지정 페이지 접근");
			List<Document> employees = documentService.selectAllEmployees();
			model.addAttribute("employees", employees);
			model.addAttribute("pageTitle", "참조자 지정");
			return "document/select-referrer-line";
		} catch (Exception e) {
			logger.error("참조자 지정 페이지 접근 중 오류 발생: " + e.getMessage());
			model.addAttribute("error", "참조자 지정 페이지를 불러오는 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	/*
	 * @GetMapping("/approval-documents") public String showApprovalDocuments(Model
	 * model) { List<Document> documents = documentService.selectAllDocuments();
	 * model.addAttribute("documents", documents); return
	 * "document/approval-documents"; }
	 */

	@GetMapping("/view/{docId}")
	public String showDocumentDetail(@PathVariable("docId") String docId, Model model) {
		try {
			logger.info("문서 상세 조회 시작 - 문서ID: {}", docId);

			// 문서 상세 정보 조회
			Document document = documentService.selectDocumentDetail(docId);
			if (document == null) {
				logger.error("문서를 찾을 수 없음 - 문서ID: {}", docId);
				model.addAttribute("error", "해당 문서를 찾을 수 없습니다.");
				return "common/error";
			}
			logger.info("문서 상세 정보 조회 성공 - 문서ID: {}", docId);

			// 참조자 정보 조회
			List<Document> references = documentService.selectDocumentReferences(docId);
			document.setReferences(references);
			logger.info("참조자 정보 조회 성공 - 문서ID: {}, 참조자 수: {}", docId, references.size());

			// 검토자 정보 조회
			List<Document> reviewers = documentService.selectDocumentReviewers(docId);
			document.setReviewers(reviewers);
			logger.info("검토자 정보 조회 성공 - 문서ID: {}, 검토자 수: {}", docId, reviewers.size());

			// 결재자 정보 조회
			List<Document> approvers = documentService.selectDocumentApprovers(docId);
			document.setApprovers(approvers);
			logger.info("결재자 정보 조회 성공 - 문서ID: {}, 결재자 수: {}", docId, approvers.size());
			
			System.out.println("docId: " + docId);
			System.out.println("reviewers: " + reviewers);
			System.out.println("approvers: " + approvers);
			System.out.println("references: " + references);

			// 모델에 데이터 추가
			model.addAttribute("document", document);
			model.addAttribute("pageTitle", "문서 상세");

			logger.info("문서 상세 페이지 렌더링 시작 - 문서ID: {}", docId);
			return "document/approval-documentdetail";

		} catch (Exception e) {
			logger.error("문서 상세 조회 중 오류 발생 - 문서ID: {}, 오류: {}", docId, e.getMessage(), e);
			model.addAttribute("error", "문서 상세 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
			return "common/error";
		}
	}

	@PostMapping("/recall/{docId}")
	@ResponseBody
	public Map<String, Object> recallDocument(@PathVariable("docId") String docId) {
		Map<String, Object> response = new HashMap<>();
		try {
			int result = documentService.updateDocumentStatus(docId, "회수");
			if (result > 0) {
				response.put("success", true);
				response.put("message", "문서가 성공적으로 회수되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "문서 회수에 실패했습니다.");
			}
		} catch (Exception e) {
			logger.error("문서 회수 중 오류 발생: " + e.getMessage());
			response.put("success", false);
			response.put("message", "문서 회수 중 오류가 발생했습니다.");
		}
		return response;
	}

	@PostMapping("/reference/add")
	@ResponseBody
	public Map<String, Object> addReference(@RequestParam("docId") String docId, @RequestParam("empId") String empId) {
		Map<String, Object> response = new HashMap<>();
		try {
			int result = documentService.insertDocumentReference(docId, empId);
			if (result > 0) {
				response.put("success", true);
				response.put("message", "참조자가 추가되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "참조자 추가에 실패했습니다.");
			}
		} catch (Exception e) {
			logger.error("참조자 추가 중 오류 발생: " + e.getMessage());
			response.put("success", false);
			response.put("message", "참조자 추가 중 오류가 발생했습니다.");
		}
		return response;
	}

	@PostMapping("/reference/remove")
	@ResponseBody
	public Map<String, Object> removeReference(@RequestParam("docId") String docId,
			@RequestParam("empId") String empId) {
		Map<String, Object> response = new HashMap<>();
		try {
			int result = documentService.deleteDocumentReference(docId, empId);
			if (result > 0) {
				response.put("success", true);
				response.put("message", "참조자가 제거되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "참조자 제거에 실패했습니다.");
			}
		} catch (Exception e) {
			logger.error("참조자 제거 중 오류 발생: " + e.getMessage());
			response.put("success", false);
			response.put("message", "참조자 제거 중 오류가 발생했습니다.");
		}
		return response;
	}

	@GetMapping("/download/{fileId}")
	public void downloadFile(@PathVariable String fileId, HttpServletResponse response) {
		try {
			// 파일 정보 조회
			Map<String, String> fileInfo = documentService.selectFileInfo(fileId);
			if (fileInfo == null) {
				throw new RuntimeException("파일을 찾을 수 없습니다.");
			}
			
			String filePath = fileInfo.get("filePath");
			String savedFileName = fileInfo.get("savedFileName");
			String originalFileName = fileInfo.get("originalFileName");
			
			// 파일 객체 생성
			File file = new File(filePath + savedFileName);
			if (!file.exists()) {
				throw new RuntimeException("파일이 존재하지 않습니다.");
			}
			
			// 응답 헤더 설정
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + 
				new String(originalFileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			response.setContentLength((int) file.length());
			
			// 파일 스트림으로 전송
			try (FileInputStream fis = new FileInputStream(file);
				 OutputStream out = response.getOutputStream()) {
				byte[] buffer = new byte[1024];
				int count;
				while ((count = fis.read(buffer)) != -1) {
					out.write(buffer, 0, count);
				}
			}
		} catch (Exception e) {
			logger.error("파일 다운로드 중 오류 발생", e);
			throw new RuntimeException("파일 다운로드 중 오류가 발생했습니다: " + e.getMessage());
		}
	}
}