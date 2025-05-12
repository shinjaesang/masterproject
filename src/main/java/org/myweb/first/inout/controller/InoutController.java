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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

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
    public String inoutList(@RequestParam(name = "page", required = false, defaultValue = "1") int page, Model model) {
        int limit = 10; // 한 페이지에 10개
        int listCount = inOutVoiceService.selectInOutVoiceTotalCount(new HashMap<>()); // 전체 데이터 개수
        org.myweb.first.common.Paging paging = new org.myweb.first.common.Paging(listCount, limit, page, "list.do");
        paging.calculate();

        Map<String, Object> params = new HashMap<>();
        params.put("startRow", paging.getStartRow());
        params.put("endRow", paging.getEndRow());

        List<InOutVoice> inOutVoiceList = inOutVoiceService.selectInOutVoiceList(params);
        // 창고명 세팅
        for (InOutVoice v : inOutVoiceList) {
            if (v.getInWarehouseId() != null && !v.getInWarehouseId().isEmpty()) {
                Warehouse inWh = warehouseService.selectWarehouseById(v.getInWarehouseId());
                if (inWh != null) v.setInWarehouseName(inWh.getWarehouseName());
            }
            if (v.getOutWarehouseId() != null && !v.getOutWarehouseId().isEmpty()) {
                Warehouse outWh = warehouseService.selectWarehouseById(v.getOutWarehouseId());
                if (outWh != null) v.setOutWarehouseName(outWh.getWarehouseName());
            }
        }
        model.addAttribute("inOutVoiceList", inOutVoiceList);
        model.addAttribute("paging", paging);
        return "inoutvoice/list";
    }
    
    /**
     * 입고 전표 등록 페이지
     * @return 입고 전표 등록 뷰
     */
    @GetMapping("/inregister.do")
    public String inregisterForm(Model model) {
        // 창고 목록 조회
        List<Warehouse> warehouseList = warehouseService.selectAllWarehouses();
        model.addAttribute("warehouseList", warehouseList);
        return "inoutvoice/inregister";
    }
    
    /**
     * 출고 전표 등록 페이지
     * @return 출고 전표 등록 뷰
     */
    @GetMapping("/outregister.do")
    public String outregisterForm(Model model) {
        // 창고 목록 조회
        List<Warehouse> warehouseList = warehouseService.selectAllWarehouses();
        model.addAttribute("warehouseList", warehouseList);
        return "inoutvoice/outregister";
    }
    
    /**
     * 입출고 전표 등록 처리
     * @param inOutVoice 입출고 전표 정보
     * @param redirectAttributes 리다이렉트 시 전달할 속성
     * @return 리다이렉트 경로
     */
    @PostMapping("/inregister.do")
    public String inregister(InOutVoice inOutVoice, RedirectAttributes redirectAttributes) {
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
     * 입출고 전표 등록 처리
     * @param inOutVoice 입출고 전표 정보
     * @param redirectAttributes 리다이렉트 시 전달할 속성
     * @return 리다이렉트 경로
     */
    @PostMapping("/outregister.do")
    public String outregister(InOutVoice inOutVoice, RedirectAttributes redirectAttributes) {
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
     * @param page 페이지
     * @param model 모델
     * @return 검색 결과 뷰
     */
    @PostMapping("/search.do")
    public String searchInOutVoice(
            @RequestParam("startDate") String startDate,
            @RequestParam("endDate") String endDate,
            @RequestParam("documentTitle") String documentTitle,
            @RequestParam("documentType") String documentType,
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            Model model) {
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("documentTitle", documentTitle);
        params.put("documentType", documentType);

        int limit = 10;
        int listCount = inOutVoiceService.selectInOutVoiceTotalCount(params);
        org.myweb.first.common.Paging paging = new org.myweb.first.common.Paging(listCount, limit, page, "search.do");
        paging.calculate();
        params.put("startRow", paging.getStartRow());
        params.put("endRow", paging.getEndRow());

        List<InOutVoice> inOutVoiceList = inOutVoiceService.selectInOutVoiceList(params);
        // 창고명 세팅
        for (InOutVoice v : inOutVoiceList) {
            if (v.getInWarehouseId() != null && !v.getInWarehouseId().isEmpty()) {
                Warehouse inWh = warehouseService.selectWarehouseById(v.getInWarehouseId());
                if (inWh != null) v.setInWarehouseName(inWh.getWarehouseName());
            }
            if (v.getOutWarehouseId() != null && !v.getOutWarehouseId().isEmpty()) {
                Warehouse outWh = warehouseService.selectWarehouseById(v.getOutWarehouseId());
                if (outWh != null) v.setOutWarehouseName(outWh.getWarehouseName());
            }
        }
        model.addAttribute("inOutVoiceList", inOutVoiceList);
        model.addAttribute("paging", paging);
        // 검색 조건도 페이징 뷰에 넘기고 싶으면 model에 추가
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("documentTitle", documentTitle);
        model.addAttribute("documentType", documentType);
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
        // 상품목록 추가
        List<org.myweb.first.inout.model.dto.InOutVoiceProductDetail> productList = inOutVoiceService.selectInOutVoiceProductList(inoutvoiceId);
        // 창고명 조회
        String inWarehouseName = null;
        String outWarehouseName = null;
        if (inOutVoice.getInWarehouseId() != null && !inOutVoice.getInWarehouseId().isEmpty()) {
            org.myweb.first.warehouse.model.dto.Warehouse inWarehouse = warehouseService.selectWarehouseById(inOutVoice.getInWarehouseId());
            if (inWarehouse != null) inWarehouseName = inWarehouse.getWarehouseName();
        }
        if (inOutVoice.getOutWarehouseId() != null && !inOutVoice.getOutWarehouseId().isEmpty()) {
            org.myweb.first.warehouse.model.dto.Warehouse outWarehouse = warehouseService.selectWarehouseById(inOutVoice.getOutWarehouseId());
            if (outWarehouse != null) outWarehouseName = outWarehouse.getWarehouseName();
        }
        model.addAttribute("inOutVoice", inOutVoice);
        model.addAttribute("productList", productList);
        model.addAttribute("inWarehouseName", inWarehouseName);
        model.addAttribute("outWarehouseName", outWarehouseName);
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
    
    @PostMapping("/addProduct.do")
    @ResponseBody
    public Map<String, Object> addProductToInOutVoice(
        @RequestParam("inoutvoiceId") String inoutvoiceId,
        @RequestParam("productId") String productId,
        @RequestParam("quantity") int quantity,
        HttpSession session
    ) {
        Map<String, Object> result = new HashMap<>();
        try {
            String workerId = null;
            Object loginUser = session.getAttribute("loginUser");
            if (loginUser != null) {
                // loginUser가 Employee 객체라고 가정
                try {
                    java.lang.reflect.Method getEmpId = loginUser.getClass().getMethod("getEmpId");
                    workerId = (String) getEmpId.invoke(loginUser);
                } catch (Exception e) {
                    workerId = null;
                }
            }
            if (workerId == null) {
                result.put("success", false);
                result.put("error", "로그인 정보가 없습니다. 다시 로그인 해주세요.");
                return result;
            }
            int insertResult = inOutVoiceService.insertInOutVoiceProduct(inoutvoiceId, productId, quantity, workerId);
            result.put("success", insertResult > 0);
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        return result;
    }
    
    @GetMapping("/getProductList.do")
    @ResponseBody
    public List<org.myweb.first.inout.model.dto.InOutVoiceProductDetail> getProductList(@RequestParam("inoutvoiceId") String inoutvoiceId) {
        return inOutVoiceService.selectInOutVoiceProductList(inoutvoiceId);
    }
    
    @PostMapping("/processProduct.do")
    @ResponseBody
    public Map<String, Object> processProduct(@RequestParam(value = "ids", required = false) List<String> ids, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (ids == null || ids.isEmpty()) {
            result.put("success", false);
            result.put("error", "선택된 상품이 없습니다.");
            return result;
        }
        try {
            String workerId = null;
            Object loginUser = session.getAttribute("loginUser");
            if (loginUser != null) {
                try {
                    java.lang.reflect.Method getEmpId = loginUser.getClass().getMethod("getEmpId");
                    workerId = (String) getEmpId.invoke(loginUser);
                } catch (Exception e) {
                    workerId = null;
                }
            }
            if (workerId == null) {
                result.put("success", false);
                result.put("error", "로그인 정보가 없습니다. 다시 로그인 해주세요.");
                return result;
            }
            int updated = inOutVoiceService.processInOutVoiceProducts(ids, workerId);
            result.put("success", true);
            result.put("updated", updated);
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        return result;
    }

    @PostMapping("/deleteProduct.do")
    @ResponseBody
    public Map<String, Object> deleteProduct(@RequestParam(value = "ids", required = false) List<String> ids) {
        Map<String, Object> result = new HashMap<>();
        if (ids == null || ids.isEmpty()) {
            result.put("success", false);
            result.put("error", "선택된 상품이 없습니다.");
            return result;
        }
        try {
            int deleted = inOutVoiceService.deleteInOutVoiceProducts(ids);
            result.put("success", true);
            result.put("deleted", deleted);
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        return result;
    }
} 