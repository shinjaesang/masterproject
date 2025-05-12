package org.myweb.first.transaction.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Arrays;
import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.myweb.first.transaction.model.dto.Transaction;
import org.myweb.first.transaction.model.service.TransactionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.myweb.first.member.model.dto.Member;
import org.springframework.format.annotation.DateTimeFormat;
import org.myweb.first.partner.model.dto.Partner;
import org.myweb.first.partner.model.service.PartnerService;
import java.util.ArrayList;
import org.myweb.first.partner.model.dto.PartnerSearchCondition;
import org.springframework.http.ResponseEntity;


@Controller
@RequestMapping("/transaction")
public class TransactionController {
	private static final Logger logger = LoggerFactory.getLogger(TransactionController.class);

	@Autowired
	private TransactionService transactionService;

	@Autowired
	private PartnerService partnerService;

	@GetMapping("/list.do")
	public String transactionList(@RequestParam(value = "tdocId", required = false) String tdocId,
			@RequestParam(value = "docName", required = false) String docName,
			@RequestParam(value = "docType", required = false) String docType,
			@RequestParam(value = "relatedPartyId", required = false) String relatedPartyId,
			@RequestParam(value = "uploadedBy", required = false) String uploadedBy,
			@RequestParam(value = "uploaderName", required = false) String uploaderName,
			@RequestParam(value = "status", required = false) String status,
			@RequestParam(value = "uploadedAt", required = false) String uploadedAt, Model model) {
		
		logger.info("거래문서 목록 조회 시작 - 파라미터: tdocId={}, docName={}, docType={}, relatedPartyId={}, uploadedBy={}, uploaderName={}, status={}, uploadedAt={}"
				, tdocId, docName, docType, relatedPartyId, uploadedBy, uploaderName, status, uploadedAt);
		
		try {
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("tdocId", tdocId);
			paramMap.put("docName", docName);
			paramMap.put("docType", docType);
			paramMap.put("relatedPartyId", relatedPartyId);
			paramMap.put("uploadedBy", uploadedBy);
			paramMap.put("uploaderName", uploaderName);
			paramMap.put("status", status);
			paramMap.put("uploadedAt", uploadedAt);

			List<Transaction> transactionList = transactionService.selectTransactionList(paramMap);
			model.addAttribute("transactionList", transactionList);

			logger.info("거래문서 목록 조회 완료 - 조회된 문서 수: {}", transactionList.size());
			return "transaction/documents";
		} catch (Exception e) {
			logger.error("거래문서 조회 중 오류 발생: ", e);
			model.addAttribute("message", "거래문서 조회 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	@GetMapping("/detail.do")
	public String transactionDetail(@RequestParam(value = "tdocId", required = true) String tdocId, Model model) {
		logger.info("거래문서 상세 조회 시작 - 파라미터: tdocId={}", tdocId);

		try {
			Transaction transaction = transactionService.selectTransactionDetail(tdocId);
			model.addAttribute("transaction", transaction);

			logger.info("거래문서 상세 조회 완료");
			return "transaction/documentdetail";
		} catch (Exception e) {
			logger.error("거래문서 상세 조회 중 오류 발생: ", e);
			model.addAttribute("message", "거래문서 상세 조회 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	@GetMapping("/taxdomesticlist.do")
	public String taxDomesticList(Model model) {
		try {
			logger.info("세금계산서 목록 페이지 접근");
			model.addAttribute("pageTitle", "세금계산서 목록");
			return "transaction/tax-domestic";
		} catch (Exception e) {
			logger.error("세금계산서 목록 페이지 접근 중 오류 발생: " + e.getMessage());
			model.addAttribute("error", "세금계산서 목록 페이지를 불러오는 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	@GetMapping("/taxdomesticdetail.do")
	public String taxDomesticDetail(Model model) {
		try {
			logger.info("세금계산서 상세보기 페이지 접근");
			model.addAttribute("pageTitle", "세금계산서 상세보기");
			return "transaction/tax-domestic-detail";
		} catch (Exception e) {
			logger.error("세금계산서 상세보기 페이지 접근 중 오류 발생: " + e.getMessage());
			model.addAttribute("error", "세금계산서 상세보기 페이지를 불러오는 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	@GetMapping("/taxforeignlist.do")
	public String taxForeignList(Model model) {
		try {
			logger.info("Invoice 목록 페이지 접근");
			model.addAttribute("pageTitle", "Invoice 목록");
			return "transaction/tax-foreign";
		} catch (Exception e) {
			logger.error("Invoice 목록 페이지 접근 중 오류 발생: " + e.getMessage());
			model.addAttribute("error", "Invoice 목록 페이지를 불러오는 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	@GetMapping("/taxforeigndetail.do")
	public String taxForeignDetail(Model model) {
		try {
			logger.info("Invoice 상세보기 페이지 접근");
			model.addAttribute("pageTitle", "Invoice 상세보기");
			return "transaction/tax-foreign-detail";
		} catch (Exception e) {
			logger.error("Invoice 상세보기 페이지 접근 중 오류 발생: " + e.getMessage());
			model.addAttribute("error", "Invoice 상세보기 페이지를 불러오는 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	@GetMapping("/register.do")
	public String showRegisterForm() {
		return "transaction/documentregister";
	}

	@PostMapping("/register.do")
	@ResponseBody
	public Map<String, Object> registerTransaction(
			@RequestParam("docName") String docName,
			@RequestParam("docType") String docType,
			@RequestParam("relatedPartyId") String relatedPartyId,
			@RequestParam("validUntil") @DateTimeFormat(pattern = "yyyy-MM-dd") java.util.Date validUntil,
			@RequestParam(value = "content", required = false) String content,
			@RequestParam(value = "attachedFile", required = false) MultipartFile file,
			HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		logger.info("거래문서 등록 시작 - 파라미터: docName={}, docType={}, relatedPartyId={}, validUntil={}", 
				docName, docType, relatedPartyId, validUntil);
		try {
			// Transaction 객체 생성 및 설정
			Transaction transaction = new Transaction();
			transaction.setDocName(docName);
			transaction.setDocType(docType);
			transaction.setRelatedPartyId(relatedPartyId);
			// java.util.Date를 java.sql.Date로 변환
			transaction.setValidUntil(new java.sql.Date(validUntil.getTime()));
			transaction.setContent(content);
			// 파일 처리
			if (file != null && !file.isEmpty()) {
				transaction.setAttachedFile(file.getBytes());
				transaction.setAttachedFileName(file.getOriginalFilename());
				logger.info("파일 업로드 정보 - 파일명: {}, 크기: {} bytes", file.getOriginalFilename(), file.getSize());
			}
			// 기본 정보 설정
			transaction.setRelatedPartyType("판매처");
			transaction.setStatus("유효");
			// 작성자 정보 설정
			Member loginUser = (Member) session.getAttribute("loginUser");
			if (loginUser != null) {
				transaction.setUploadedBy(loginUser.getEmpId());
			} else {
				logger.warn("로그인 사용자 정보가 없습니다.");
				response.put("success", false);
				response.put("message", "로그인이 필요합니다.");
				return response;
			}
			// 문서 등록 처리
			int result = transactionService.insertTransaction(transaction);
			if (result > 0) {
				logger.info("거래문서 등록 성공 - 문서번호: {}", transaction.getTdocId());
				response.put("success", true);
				response.put("message", "문서가 성공적으로 등록되었습니다.");
			} else {
				logger.warn("거래문서 등록 실패");
				response.put("success", false);
				response.put("message", "문서 등록에 실패했습니다.");
			}
		} catch (Exception e) {
			logger.error("거래문서 등록 중 오류 발생", e);
			response.put("success", false);
			response.put("message", "문서 등록 중 오류가 발생했습니다.");
		}
		return response;
	}

	// 거래문서 일괄 삭제 (추가)
	@PostMapping("/delete.do")
	@ResponseBody
	public Map<String, Object> deleteTransactions(@RequestParam("documentIds") String documentIds) {
		Map<String, Object> response = new HashMap<>();
		try {
			List<String> tdocIdList = Arrays.asList(documentIds.split(","));
			int result = transactionService.deleteTransactions(tdocIdList);
			if (result > 0) {
				response.put("success", true);
				response.put("message", "선택한 문서가 성공적으로 삭제되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "문서 삭제에 실패했습니다.");
			}
		} catch (Exception e) {
			logger.error("일괄 삭제 중 오류 발생", e);
			response.put("success", false);
			response.put("message", "문서 삭제 중 오류가 발생했습니다.");
		}
		return response;
	}

	@GetMapping("/download.do")
	public void downloadFile(@RequestParam("tdocId") String tdocId, HttpServletResponse response) {
		logger.info("파일 다운로드 시작: {}", tdocId);
		try {
			Transaction transaction = transactionService.selectTransactionDetail(tdocId);
			if (transaction == null || transaction.getAttachedFile() == null) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일을 찾을 수 없습니다.");
				return;
			}

			// 첨부파일명이 없는 경우 문서명을 사용
			String fileName = transaction.getAttachedFileName();
			if (fileName == null || fileName.trim().isEmpty()) {
				fileName = transaction.getDocName();
				logger.warn("첨부파일명이 없어 문서명을 사용합니다: {}", fileName);
			}
			
			// 파일 확장자 추출 (마지막 . 이후의 문자열)
			String fileExtension = "";
			int lastDotIndex = fileName.lastIndexOf(".");
			if (lastDotIndex > 0) {
				fileExtension = fileName.substring(lastDotIndex + 1).toLowerCase();
			}
			
			// Content-Type 설정
			String contentType;
			switch (fileExtension) {
				case "png":
					contentType = "image/png";
					break;
				case "jpg":
				case "jpeg":
					contentType = "image/jpeg";
					break;
				case "gif":
					contentType = "image/gif";
					break;
				case "pdf":
					contentType = "application/pdf";
					break;
				case "doc":
					contentType = "application/msword";
					break;
				case "docx":
					contentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
					break;
				case "xls":
					contentType = "application/vnd.ms-excel";
					break;
				case "xlsx":
					contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
					break;
				case "txt":
					contentType = "text/plain";
					break;
				default:
					contentType = "application/octet-stream";
			}
			
			// 한글 파일명 처리
			String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
			
			response.setContentType(contentType);
			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
			
			logger.info("파일 다운로드 정보 - 파일명: {}, Content-Type: {}, 크기: {} bytes", 
				fileName, contentType, transaction.getAttachedFile().length);
			
			try (ServletOutputStream out = response.getOutputStream()) {
				out.write(transaction.getAttachedFile());
				out.flush();
			}
			logger.info("파일 다운로드 완료: {}", fileName);
		} catch (Exception e) {
			logger.error("파일 다운로드 중 오류 발생: {}", e.getMessage(), e);
			try {
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "파일 다운로드 중 오류가 발생했습니다.");
			} catch (IOException ex) {
				logger.error("오류 응답 전송 중 추가 오류 발생", ex);
			}
		}
	}

	@GetMapping("/update.do")
	public String showUpdateForm(@RequestParam("tdocId") String tdocId, Model model) {
		logger.info("거래문서 수정 페이지 접근 시작 - 파라미터: tdocId={}", tdocId);
		try {
			Transaction transaction = transactionService.selectTransactionDetail(tdocId);
			logger.info("거래문서 조회 결과: {}", transaction != null ? "문서 존재" : "문서 없음");
			
			if (transaction == null) {
				logger.error("존재하지 않는 문서 요청: {}", tdocId);
				model.addAttribute("message", "존재하지 않는 문서입니다.");
				return "common/error";
			}
			// 거래처 목록 추가
			List<Partner> partnerList = partnerService.selectAllPartners();
			model.addAttribute("partnerList", partnerList);
			model.addAttribute("transaction", transaction);
			logger.info("거래문서 수정 페이지 로드 완료 - 문서번호: {}, 문서명: {}", tdocId, transaction.getDocName());
			return "transaction/documentupdate";
		} catch (Exception e) {
			logger.error("거래문서 수정 페이지 로드 중 오류 발생: {}", e.getMessage(), e);
			model.addAttribute("message", "문서 수정 페이지를 불러오는 중 오류가 발생했습니다.");
			return "common/error";
		}
	}

	@PostMapping("/update.do")
	@ResponseBody
	public Map<String, Object> updateTransaction(
			@RequestParam("tdocId") String tdocId,
			@RequestParam("docName") String docName,
			@RequestParam("docType") String docType,
			@RequestParam("relatedPartyId") String relatedPartyId,
			@RequestParam("validUntil") @DateTimeFormat(pattern = "yyyy-MM-dd") java.util.Date validUntil,
			@RequestParam(value = "content", required = false) String content,
			@RequestParam(value = "status", required = false) String status,
			@RequestParam(value = "attachedFile", required = false) MultipartFile file,
			HttpSession session) {
		
		Map<String, Object> response = new HashMap<>();
		logger.info("거래문서 수정 시작 - 파라미터: tdocId={}, docName={}, docType={}, validUntil={}", 
				tdocId, docName, docType, validUntil);
		
		try {
			// 기존 문서 조회
			Transaction existingTransaction = transactionService.selectTransactionDetail(tdocId);
			if (existingTransaction == null) {
				response.put("success", false);
				response.put("message", "존재하지 않는 문서입니다.");
				return response;
			}

			// Transaction 객체 업데이트
			existingTransaction.setDocName(docName);
			existingTransaction.setDocType(docType);
			existingTransaction.setRelatedPartyId(relatedPartyId);
			existingTransaction.setValidUntil(new java.sql.Date(validUntil.getTime()));
			existingTransaction.setContent(content);
			if (status != null) {
				existingTransaction.setStatus(status);
			}

			// 파일 처리
			if (file != null && !file.isEmpty()) {
				existingTransaction.setAttachedFile(file.getBytes());
				existingTransaction.setAttachedFileName(file.getOriginalFilename());
				logger.info("파일 업데이트 정보 - 파일명: {}, 크기: {} bytes", file.getOriginalFilename(), file.getSize());
			}

			// 작성자 정보 설정
			Member loginUser = (Member) session.getAttribute("loginUser");
			if (loginUser != null) {
				existingTransaction.setUploadedBy(loginUser.getEmpId());
			} else {
				logger.warn("로그인 사용자 정보가 없습니다.");
				response.put("success", false);
				response.put("message", "로그인이 필요합니다.");
				return response;
			}

			// 문서 수정 처리
			int result = transactionService.updateTransaction(existingTransaction);
			if (result > 0) {
				logger.info("수정 요청 docType 값: {}", docType);
				
				logger.info("거래문서 수정 성공 - 문서번호: {}", tdocId);
				response.put("success", true);
				response.put("message", "문서가 성공적으로 수정되었습니다.");
			} else {
				logger.warn("거래문서 수정 실패");
				response.put("success", false);
				response.put("message", "문서 수정에 실패했습니다.");
			}
		} catch (Exception e) {
			logger.error("거래문서 수정 중 오류 발생", e);
			response.put("success", false);
			response.put("message", "문서 수정 중 오류가 발생했습니다.");
		}
		return response;
	}
}

