package org.myweb.first.document.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/document")
public class DocumentController {
	private static final Logger logger = LoggerFactory.getLogger(DocumentController.class);
    
    // 결재문서 목록 조회 페이지
    @GetMapping("/list.do")
    public String documentList(Model model) {
        try {
            logger.info("결재문서 목록 조회 페이지 접근");
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
    public String registerDocument(Model model, RedirectAttributes rttr) {
        try {
            logger.info("문서 등록 처리");
            // TODO: 문서 등록 처리 로직
            rttr.addFlashAttribute("message", "문서가 성공적으로 등록되었습니다.");
            return "redirect:/document/list.do";
        } catch (Exception e) {
            logger.error("문서 등록 중 오류 발생: " + e.getMessage());
            model.addAttribute("error", "문서 등록 중 오류가 발생했습니다.");
            return "common/error";
        }
    }
    
    // 결재선 지정 페이지
    @GetMapping("/approval-line.do")
    public String approvalLine(Model model) {
        try {
            logger.info("결재선 지정 페이지 접근");
            model.addAttribute("pageTitle", "결재선 지정");
            return "document/select-approval-line";
        } catch (Exception e) {
            logger.error("결재선 지정 페이지 접근 중 오류 발생: " + e.getMessage());
            model.addAttribute("error", "결재선 지정 페이지를 불러오는 중 오류가 발생했습니다.");
            return "common/error";
        }
    }
    
    
    
}