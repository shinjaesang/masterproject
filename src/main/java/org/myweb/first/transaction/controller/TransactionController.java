package org.myweb.first.transaction.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import jakarta.servlet.http.HttpSession;
import org.myweb.first.member.model.dto.Member;

@Controller
@RequestMapping("/transaction")
public class TransactionController {
	private static final Logger logger = LoggerFactory.getLogger(TransactionController.class);

	@Autowired
	private TransactionService transactionService;

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
	public Map<String, Object> registerTransaction(@ModelAttribute Transaction transaction, 
												 @RequestParam(value = "attachedFile", required = false) MultipartFile file,
												 HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		
		try {
			if (file != null && !file.isEmpty()) {
				transaction.setAttachedFile(file.getBytes());
			}
			
			// 거래처와 작성자 정보 설정
			transaction.setRelatedPartyType("PARTNER");
			transaction.setStatus("유효");
			
			// 세션에서 사용자 정보 가져오기
			Member loginUser = (Member) session.getAttribute("loginUser");
			if (loginUser != null) {
				transaction.setUploadedBy(loginUser.getEmpId());
			}
			
			int result = transactionService.insertTransaction(transaction);
			
			if (result > 0) {
				response.put("success", true);
				response.put("message", "문서가 성공적으로 등록되었습니다.");
			} else {
				response.put("success", false);
				response.put("message", "문서 등록에 실패했습니다.");
			}
		} catch (Exception e) {
			logger.error("문서 등록 중 오류 발생: ", e);
			response.put("success", false);
			response.put("message", "문서 등록 중 오류가 발생했습니다.");
		}
		
		return response;
	}
}
