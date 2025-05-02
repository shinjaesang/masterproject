package org.myweb.first.inout.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.myweb.first.inout.model.dto.InOutVoice;
import org.myweb.first.inout.model.service.InOutVoiceService;
import org.myweb.first.warehouse.model.dto.Warehouse;
import org.myweb.first.warehouse.model.service.WarehouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 입출고 관리 컨트롤러
 */
@Controller
@RequestMapping("/inout")
public class InoutController {
    
    private final InOutVoiceService inOutVoiceService;
    private final WarehouseService warehouseService;
    
    @Autowired
    public InoutController(InOutVoiceService inOutVoiceService, WarehouseService warehouseService) {
        this.inOutVoiceService = inOutVoiceService;
        this.warehouseService = warehouseService;
    }
    
    /**
     * 입출고 조회 페이지
     * @return 입출고 목록 조회 뷰
     */
    @GetMapping("/list.do")
    public String inoutList(Model model) {
        Map<String, Object> params = new HashMap<>();
        List<InOutVoice> inOutVoiceList = inOutVoiceService.selectInOutVoiceList(params);
        model.addAttribute("inOutVoiceList", inOutVoiceList);
        return "inoutvoice/list";
    }
    
    /**
     * 입출고 전표 등록 페이지
     * @return 입출고 전표 등록 뷰
     */
    @GetMapping("/register.do")
    public String registerForm(Model model) {
        // 창고 목록 조회
        List<Warehouse> warehouseList = warehouseService.selectAllWarehouses();
        model.addAttribute("warehouseList", warehouseList);
        return "inoutvoice/register";
    }
    
    /**
     * 입출고 전표 등록 처리
     * @param inOutVoice 입출고 전표 정보
     * @param redirectAttributes 리다이렉트 시 전달할 속성
     * @return 리다이렉트 경로
     */
    @PostMapping("/register.do")
    public String register(InOutVoice inOutVoice, RedirectAttributes redirectAttributes) {
        // 생성일자 설정
        inOutVoice.setCreatedAt(new java.sql.Date(System.currentTimeMillis()));
        
        int result = inOutVoiceService.insertInOutVoice(inOutVoice);
        
        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "전표가 성공적으로 등록되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "전표 등록에 실패했습니다.");
        }
        
        return "redirect:/inout/list.do";
    }
    
    /**
     * 입출고 검색
     * @param startDate 시작일
     * @param endDate 종료일
     * @param documentTitle 전표제목
     * @param documentType 전표유형
     * @param model 모델
     * @return 검색 결과 뷰
     */
    @PostMapping("/search.do")
    public String searchInOutVoice(
            @RequestParam("startDate") String startDate,
            @RequestParam("endDate") String endDate,
            @RequestParam("documentTitle") String documentTitle,
            @RequestParam("documentType") String documentType,
            Model model) {
        
        System.out.println("=== 검색 파라미터 ===");
        System.out.println("startDate: " + startDate);
        System.out.println("endDate: " + endDate);
        System.out.println("documentTitle: " + documentTitle);
        System.out.println("documentType: " + documentType);
        
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("documentTitle", documentTitle);
        params.put("documentType", documentType);
        
        List<InOutVoice> inOutVoiceList = inOutVoiceService.selectInOutVoiceList(params);
        
        System.out.println("=== 검색 결과 ===");
        System.out.println("결과 개수: " + (inOutVoiceList != null ? inOutVoiceList.size() : 0));
        if (inOutVoiceList != null && !inOutVoiceList.isEmpty()) {
            for (InOutVoice item : inOutVoiceList) {
                System.out.println("전표ID: " + item.getInoutvoiceId() + 
                                 ", 전표명: " + item.getInoutvoiceName() + 
                                 ", 전표유형: " + item.getInoutvoiceType());
            }
        }
        
        model.addAttribute("inOutVoiceList", inOutVoiceList);
        
        return "inoutvoice/list";
    }
    
    /**
     * 입출고 상세 정보
     * @param inoutvoiceId 전표 ID
     * @param model 모델
     * @return 상세 정보 뷰
     */
    @GetMapping("/detail.do")
    public String detail(@RequestParam("inoutvoiceId") String inoutvoiceId, Model model) {
        InOutVoice inOutVoice = inOutVoiceService.selectInOutVoiceById(inoutvoiceId);
        model.addAttribute("inOutVoice", inOutVoice);
        return "inoutvoice/detail";
    }
    
    @GetMapping("/update.do")
    public String updateForm(@RequestParam("inoutvoiceId") String inoutvoiceId, Model model) {
        InOutVoice inOutVoice = inOutVoiceService.selectInOutVoiceById(inoutvoiceId);
        model.addAttribute("inOutVoice", inOutVoice);
        return "inoutvoice/update";
    }
    
    @PostMapping("/update.do")
    public String update(InOutVoice inOutVoice, RedirectAttributes redirectAttributes) {
        int result = inOutVoiceService.updateInOutVoice(inOutVoice);
        
        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "전표가 성공적으로 수정되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "전표 수정에 실패했습니다.");
        }
        
        return "redirect:/inout/detail.do?inoutvoiceId=" + inOutVoice.getInoutvoiceId();
    }
    
    @GetMapping("/delete.do")
    public String delete(@RequestParam("inoutvoiceId") String inoutvoiceId, RedirectAttributes redirectAttributes) {
        int result = inOutVoiceService.deleteInOutVoice(inoutvoiceId);
        
        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "전표가 성공적으로 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "전표 삭제에 실패했습니다.");
        }
        
        return "redirect:/inout/list.do";
    }
} 