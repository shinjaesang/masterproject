package org.myweb.first.inout.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 입출고 관리 컨트롤러
 */
@Controller
@RequestMapping("/inout")
public class InOutController {
    
    /**
     * 입출고 조회 페이지
     * @return 입출고 조회 뷰
     */
    @GetMapping("/list.do")
    public String inoutList() {
        // TODO: 입출고 목록 조회 로직
        return "inoutvoice/list";
    }
    
    /**
     * 입출고 전표 등록 페이지
     * @return 입출고 전표 등록 뷰
     */
    @GetMapping("/register.do")
    public String registerForm() {
        return "inoutvoice/register";
    }
    
    /**
     * 입출고 전표 등록 처리
     * @param redirectAttributes 리다이렉트 시 전달할 속성
     * @return 리다이렉트 경로
     */
    @PostMapping("/register.do")
    public String register(RedirectAttributes redirectAttributes) {
        // TODO: 전표 등록 로직 구현
        
        // 성공 메시지 설정
        redirectAttributes.addFlashAttribute("message", "전표가 성공적으로 등록되었습니다.");
        
        // 전표 조회 페이지로 리다이렉트
        return "redirect:/inout/list.do";
    }
    
    /**
     * 입출고 검색
     * @return 검색 결과 뷰
     */
    @PostMapping("/search.do")
    public String search() {
        // TODO: 검색 로직 구현
        return "inoutvoice/list";
    }
    
    /**
     * 입출고 상세 정보
     * @return 상세 정보 뷰
     */
    @GetMapping("/detail.do")
    public String detail() {
        // TODO: 상세 정보 조회 로직
        return "inoutvoice/detail";
    }
} 