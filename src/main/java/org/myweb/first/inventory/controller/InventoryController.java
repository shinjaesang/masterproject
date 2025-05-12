package org.myweb.first.inventory.controller;

import java.util.List;

import org.myweb.first.inventory.model.dto.InventorySearchCondition;
import org.myweb.first.inventory.model.service.InventoryService;
import org.myweb.first.partner.model.service.PartnerService;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/inventory")
public class InventoryController {
	
	private static final Logger log = LoggerFactory.getLogger(InventoryController.class);
	
    @Autowired
    private InventoryService inventoryService;

    @Autowired
    private PartnerService partnerService;

    @GetMapping("/currentInventory.do")
    public String showCurrentInventory(@RequestParam(value = "page", required = false, defaultValue = "1") int page, Model model) {
        org.myweb.first.inventory.model.dto.InventorySearchCondition cond = new org.myweb.first.inventory.model.dto.InventorySearchCondition();
        cond.setPage(page);
        cond.setStartRow((page - 1) * cond.getPageSize());
        cond.setEndRow(page * cond.getPageSize());
        List<org.myweb.first.inventory.model.dto.Inventory> inventoryList = inventoryService.searchInventory(cond);
        int totalCount = inventoryService.countInventory(cond);
        int totalPages = (int) Math.ceil((double) totalCount / cond.getPageSize());
        model.addAttribute("inventoryList", inventoryList);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("suppliers", partnerService.selectSuppliersOnly());

        // 합계 변수 선언
        long headOfficeSum = 0, busanSum = 0, incheonSum = 0, daeguSum = 0, gwangjuSum = 0, transitSum = 0, defectiveSum = 0;
        long availableSum = 0, totalSum = 0;
        long headOfficeCost = 0, busanCost = 0, incheonCost = 0, daeguCost = 0, gwangjuCost = 0, transitCost = 0, defectiveCost = 0;
        long availableCost = 0, totalCost = 0;
        long headOfficeSell = 0, busanSell = 0, incheonSell = 0, daeguSell = 0, gwangjuSell = 0, transitSell = 0, defectiveSell = 0;
        long availableSell = 0, totalSell = 0;

        for (org.myweb.first.inventory.model.dto.Inventory inv : inventoryList) {
            // 재고 수량은 절대값으로 처리
            headOfficeSum += Math.abs(inv.getHeadOfficeStock());
            busanSum += Math.abs(inv.getBusanStock());
            incheonSum += Math.abs(inv.getIncheonStock());
            daeguSum += Math.abs(inv.getDaeguStock());
            gwangjuSum += Math.abs(inv.getGwangjuStock());
            transitSum += Math.abs(inv.getTransitStock());
            defectiveSum += Math.abs(inv.getDefectiveStock());
            availableSum += Math.abs(inv.getAvailableStock());
            totalSum += Math.abs(inv.getTotalStock());

            // 원가 계산
            headOfficeCost += Math.abs(inv.getHeadOfficeStock() * inv.getCostPrice());
            busanCost += Math.abs(inv.getBusanStock() * inv.getCostPrice());
            incheonCost += Math.abs(inv.getIncheonStock() * inv.getCostPrice());
            daeguCost += Math.abs(inv.getDaeguStock() * inv.getCostPrice());
            gwangjuCost += Math.abs(inv.getGwangjuStock() * inv.getCostPrice());
            transitCost += Math.abs(inv.getTransitStock() * inv.getCostPrice());
            defectiveCost += Math.abs(inv.getDefectiveStock() * inv.getCostPrice());
            availableCost += Math.abs(inv.getAvailableStock() * inv.getCostPrice());
            totalCost += Math.abs(inv.getTotalStock() * inv.getCostPrice());

            // 판매가 계산
            headOfficeSell += Math.abs(inv.getHeadOfficeStock() * inv.getSellingPrice());
            busanSell += Math.abs(inv.getBusanStock() * inv.getSellingPrice());
            incheonSell += Math.abs(inv.getIncheonStock() * inv.getSellingPrice());
            daeguSell += Math.abs(inv.getDaeguStock() * inv.getSellingPrice());
            gwangjuSell += Math.abs(inv.getGwangjuStock() * inv.getSellingPrice());
            transitSell += Math.abs(inv.getTransitStock() * inv.getSellingPrice());
            defectiveSell += Math.abs(inv.getDefectiveStock() * inv.getSellingPrice());
            availableSell += Math.abs(inv.getAvailableStock() * inv.getSellingPrice());
            totalSell += Math.abs(inv.getTotalStock() * inv.getSellingPrice());
        }

        model.addAttribute("headOfficeSum", headOfficeSum);
        model.addAttribute("busanSum", busanSum);
        model.addAttribute("incheonSum", incheonSum);
        model.addAttribute("daeguSum", daeguSum);
        model.addAttribute("gwangjuSum", gwangjuSum);
        model.addAttribute("transitSum", transitSum);
        model.addAttribute("defectiveSum", defectiveSum);
        model.addAttribute("availableSum", availableSum);
        model.addAttribute("totalSum", totalSum);

        model.addAttribute("headOfficeCost", headOfficeCost);
        model.addAttribute("busanCost", busanCost);
        model.addAttribute("incheonCost", incheonCost);
        model.addAttribute("daeguCost", daeguCost);
        model.addAttribute("gwangjuCost", gwangjuCost);
        model.addAttribute("transitCost", transitCost);
        model.addAttribute("defectiveCost", defectiveCost);
        model.addAttribute("availableCost", availableCost);
        model.addAttribute("totalCost", totalCost);

        model.addAttribute("headOfficeSell", headOfficeSell);
        model.addAttribute("busanSell", busanSell);
        model.addAttribute("incheonSell", incheonSell);
        model.addAttribute("daeguSell", daeguSell);
        model.addAttribute("gwangjuSell", gwangjuSell);
        model.addAttribute("transitSell", transitSell);
        model.addAttribute("defectiveSell", defectiveSell);
        model.addAttribute("availableSell", availableSell);
        model.addAttribute("totalSell", totalSell);

        return "inventory/currentInventory";
    }

    @GetMapping("/dailyInventory.do")
    public String showDailyInventory(
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        // TODO: 실제 데이터를 가져오는 로직 구현
        // 임시 데이터 설정
        model.addAttribute("dailyInventoryList", null);
        model.addAttribute("dateHeaders", null);
        model.addAttribute("pageInfo", null);
        model.addAttribute("vendorGroups", null);
        model.addAttribute("vendors", null);
        model.addAttribute("suppliers", null);
        model.addAttribute("categories", null);
        
        return "inventory/dailyInventory";
    }

    @GetMapping("/monthlyInventory.do")
    public String showMonthlyInventory(
            @RequestParam(value = "page", defaultValue = "1") int page,
            Model model) {
        // TODO: 실제 데이터를 가져오는 로직 구현
        // 임시 데이터 설정
        model.addAttribute("monthlyInventoryList", null);
        model.addAttribute("monthHeaders", null);
        model.addAttribute("pageInfo", null);
        model.addAttribute("vendorGroups", null);
        model.addAttribute("vendors", null);
        model.addAttribute("suppliers", null);
        model.addAttribute("categories", null);
        
        return "inventory/monthlyInventory";
    }

    @PostMapping("/search.do")
    public String searchInventory(
        @ModelAttribute InventorySearchCondition cond,
        @RequestParam(value = "searchCondition", required = false) String searchCondition,
        @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
        @RequestParam(value = "page", required = false, defaultValue = "1") int page,
        @RequestParam(value = "sortOrder", required = false) String sortOrder,
        Model model) {
        // 상품유형(productType), 공급처(partnerId)는 @ModelAttribute로 자동 매핑
        // 상품명/상품코드는 searchCondition, searchKeyword로 수동 매핑
        if ("productName".equals(searchCondition)) {
            cond.setProductName(searchKeyword);
            cond.setProductCode(null);
        } else if ("productCode".equals(searchCondition)) {
            cond.setProductCode(searchKeyword);
            cond.setProductName(null);
        } else {
            cond.setProductName(null);
            cond.setProductCode(null);
        }
        cond.setPage(page);
        cond.setStartRow((page - 1) * cond.getPageSize());
        cond.setEndRow(page * cond.getPageSize());
        cond.setSortOrder(sortOrder);
        List<org.myweb.first.inventory.model.dto.Inventory> inventoryList = inventoryService.searchInventory(cond);
        int totalCount = inventoryService.countInventory(cond);
        int totalPages = (int) Math.ceil((double) totalCount / cond.getPageSize());
        model.addAttribute("inventoryList", inventoryList);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("suppliers", partnerService.selectSuppliersOnly());

        // 합계 변수 선언 (검색 결과에 대해서도 동일하게 집계)
        long headOfficeSum = 0, busanSum = 0, incheonSum = 0, daeguSum = 0, gwangjuSum = 0, transitSum = 0, defectiveSum = 0;
        long availableSum = 0, totalSum = 0;
        long headOfficeCost = 0, busanCost = 0, incheonCost = 0, daeguCost = 0, gwangjuCost = 0, transitCost = 0, defectiveCost = 0;
        long availableCost = 0, totalCost = 0;
        long headOfficeSell = 0, busanSell = 0, incheonSell = 0, daeguSell = 0, gwangjuSell = 0, transitSell = 0, defectiveSell = 0;
        long availableSell = 0, totalSell = 0;

        for (org.myweb.first.inventory.model.dto.Inventory inv : inventoryList) {
            // 재고 수량은 절대값으로 처리
            headOfficeSum += Math.abs(inv.getHeadOfficeStock());
            busanSum += Math.abs(inv.getBusanStock());
            incheonSum += Math.abs(inv.getIncheonStock());
            daeguSum += Math.abs(inv.getDaeguStock());
            gwangjuSum += Math.abs(inv.getGwangjuStock());
            transitSum += Math.abs(inv.getTransitStock());
            defectiveSum += Math.abs(inv.getDefectiveStock());
            availableSum += Math.abs(inv.getAvailableStock());
            totalSum += Math.abs(inv.getTotalStock());

            // 원가 계산
            headOfficeCost += Math.abs(inv.getHeadOfficeStock() * inv.getCostPrice());
            busanCost += Math.abs(inv.getBusanStock() * inv.getCostPrice());
            incheonCost += Math.abs(inv.getIncheonStock() * inv.getCostPrice());
            daeguCost += Math.abs(inv.getDaeguStock() * inv.getCostPrice());
            gwangjuCost += Math.abs(inv.getGwangjuStock() * inv.getCostPrice());
            transitCost += Math.abs(inv.getTransitStock() * inv.getCostPrice());
            defectiveCost += Math.abs(inv.getDefectiveStock() * inv.getCostPrice());
            availableCost += Math.abs(inv.getAvailableStock() * inv.getCostPrice());
            totalCost += Math.abs(inv.getTotalStock() * inv.getCostPrice());

            // 판매가 계산
            headOfficeSell += Math.abs(inv.getHeadOfficeStock() * inv.getSellingPrice());
            busanSell += Math.abs(inv.getBusanStock() * inv.getSellingPrice());
            incheonSell += Math.abs(inv.getIncheonStock() * inv.getSellingPrice());
            daeguSell += Math.abs(inv.getDaeguStock() * inv.getSellingPrice());
            gwangjuSell += Math.abs(inv.getGwangjuStock() * inv.getSellingPrice());
            transitSell += Math.abs(inv.getTransitStock() * inv.getSellingPrice());
            defectiveSell += Math.abs(inv.getDefectiveStock() * inv.getSellingPrice());
            availableSell += Math.abs(inv.getAvailableStock() * inv.getSellingPrice());
            totalSell += Math.abs(inv.getTotalStock() * inv.getSellingPrice());
        }

        model.addAttribute("headOfficeSum", headOfficeSum);
        model.addAttribute("busanSum", busanSum);
        model.addAttribute("incheonSum", incheonSum);
        model.addAttribute("daeguSum", daeguSum);
        model.addAttribute("gwangjuSum", gwangjuSum);
        model.addAttribute("transitSum", transitSum);
        model.addAttribute("defectiveSum", defectiveSum);
        model.addAttribute("availableSum", availableSum);
        model.addAttribute("totalSum", totalSum);

        model.addAttribute("headOfficeCost", headOfficeCost);
        model.addAttribute("busanCost", busanCost);
        model.addAttribute("incheonCost", incheonCost);
        model.addAttribute("daeguCost", daeguCost);
        model.addAttribute("gwangjuCost", gwangjuCost);
        model.addAttribute("transitCost", transitCost);
        model.addAttribute("defectiveCost", defectiveCost);
        model.addAttribute("availableCost", availableCost);
        model.addAttribute("totalCost", totalCost);

        model.addAttribute("headOfficeSell", headOfficeSell);
        model.addAttribute("busanSell", busanSell);
        model.addAttribute("incheonSell", incheonSell);
        model.addAttribute("daeguSell", daeguSell);
        model.addAttribute("gwangjuSell", gwangjuSell);
        model.addAttribute("transitSell", transitSell);
        model.addAttribute("defectiveSell", defectiveSell);
        model.addAttribute("availableSell", availableSell);
        model.addAttribute("totalSell", totalSell);

        return "inventory/currentInventory";
    }
} 