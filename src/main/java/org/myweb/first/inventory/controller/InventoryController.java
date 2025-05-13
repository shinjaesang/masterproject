package org.myweb.first.inventory.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;

import org.myweb.first.inventory.model.dto.DailyInventory;
import org.myweb.first.inventory.model.dto.DailyInventorySearchCondition;
import org.myweb.first.inventory.model.dto.Inventory;
import org.myweb.first.inventory.model.dto.InventorySearchCondition;
import org.myweb.first.inventory.model.service.InventoryService;
import org.myweb.first.partner.model.service.PartnerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
            @ModelAttribute DailyInventorySearchCondition searchCondition,
            Model model,
            jakarta.servlet.http.HttpSession session) {
        
        // 페이지 정보 설정
        if (searchCondition == null) {
            searchCondition = new DailyInventorySearchCondition();
        }
        searchCondition.setPage(page);
        searchCondition.setStartRow((page - 1) * searchCondition.getPageSize());
        searchCondition.setEndRow(page * searchCondition.getPageSize());
        
        List<DailyInventory> dailyInventoryList = new ArrayList<>();
        List<String> dateHeaders = new ArrayList<>();
        int totalCount = 0;
        int totalPages = 1;
        
        // 카테고리 목록 로드 - 세션에 저장하여 항상 사용 가능하게 함
        if (session.getAttribute("categories") == null) {
            log.info("카테고리 목록을 새로 로드합니다.");
            try {
                List<Map<String, String>> categories = inventoryService.getCategories();
                session.setAttribute("categories", categories);
                model.addAttribute("categories", categories);
                log.info("카테고리 개수: {}", categories.size());
                for (Map<String, String> category : categories) {
                    log.info("카테고리: {} - {}", category.get("code"), category.get("name"));
                }
            } catch (Exception e) {
                log.error("카테고리 로드 중 오류 발생", e);
                // 카테고리 데이터가 없는 경우 하드코딩된 데이터 사용
                List<Map<String, String>> fallbackCategories = createFallbackCategories();
                session.setAttribute("categories", fallbackCategories);
                model.addAttribute("categories", fallbackCategories);
            }
        } else {
            log.info("세션에서 카테고리 목록을 가져옵니다.");
            model.addAttribute("categories", session.getAttribute("categories"));
        }
        
        // 상품 유형 목록 로드
        if (session.getAttribute("productTypes") == null) {
            List<Map<String, String>> productTypes = createProductTypes();
            session.setAttribute("productTypes", productTypes);
            model.addAttribute("productTypes", productTypes);
        } else {
            model.addAttribute("productTypes", session.getAttribute("productTypes"));
        }
        
        // 날짜 조건이 있는 경우에만 데이터 조회
        if (searchCondition.getStartDate() != null && !searchCondition.getStartDate().isEmpty() &&
            searchCondition.getEndDate() != null && !searchCondition.getEndDate().isEmpty()) {
            
            // 검색 타입과 키워드 처리
            if (searchCondition.getSearchType() != null && searchCondition.getSearchKeyword() != null && !searchCondition.getSearchKeyword().isEmpty()) {
                log.info("검색 조건: 타입={}, 키워드={}", searchCondition.getSearchType(), searchCondition.getSearchKeyword());
                
                // 상품명 또는 상품코드로 검색
                if ("name".equals(searchCondition.getSearchType())) {
                    searchCondition.setProductName(searchCondition.getSearchKeyword());
                    searchCondition.setProductCode(null);
                } else if ("code".equals(searchCondition.getSearchType())) {
                    searchCondition.setProductCode(searchCondition.getSearchKeyword());
                    searchCondition.setProductName(null);
                }
            }
            
            // 데이터 조회
            dailyInventoryList = inventoryService.searchDailyInventory(searchCondition);
            dateHeaders = inventoryService.selectDateHeaders(searchCondition);
            totalCount = inventoryService.countDailyInventory(searchCondition);
            totalPages = (int) Math.ceil((double) totalCount / searchCondition.getPageSize());
            
            // 데이터가 없는 경우 메시지 추가
            if (dailyInventoryList.isEmpty()) {
                model.addAttribute("noDataMessage", "검색 조건에 해당하는 데이터가 없습니다.");
            }
        } else {
            // 기본 날짜 값 설정 (UI에 표시는 되지만 자동 검색 실행하지 않음)
            java.time.LocalDate today = java.time.LocalDate.now();
            java.time.LocalDate sevenDaysAgo = today.minusDays(7);
            searchCondition.setStartDate(sevenDaysAgo.toString());
            searchCondition.setEndDate(today.toString());
            
            // 날짜 헤더만 생성
            dateHeaders = inventoryService.selectDateHeaders(searchCondition);
            
            // 날짜를 선택하라는 메시지 추가
            model.addAttribute("noDataMessage", "조회할 날짜 범위를 선택한 후 검색 버튼을 클릭하세요.");
        }
        
        // 모델에 데이터 추가
        model.addAttribute("dailyInventoryList", dailyInventoryList);
        model.addAttribute("dateHeaders", dateHeaders);
        
        // 페이지 정보
        Map<String, Object> pageInfo = new HashMap<>();
        pageInfo.put("currentPage", page);
        pageInfo.put("totalPages", totalPages);
        pageInfo.put("totalCount", totalCount);
        model.addAttribute("pageInfo", pageInfo);
        
        // 창고 목록과 거래처 목록 가져오기
        try {
            // 파트너 목록 (거래처 목록)
            List<?> partners = partnerService.selectAllPartners();
            
            // 거래처 디버깅 로그
            log.info("거래처 목록 로딩: {} 개", partners.size());
            int supplierCount = 0;
            int vendorCount = 0;
            int unknownCount = 0;
            
            for (Object obj : partners) {
                // 리플렉션으로 파트너 타입과 이름 가져오기
                try {
                    String partnerType = "";
                    String partnerName = "";
                    
                    if (obj instanceof Map) {
                        Map<?, ?> partner = (Map<?, ?>) obj;
                        partnerType = String.valueOf(partner.get("partnerType"));
                        partnerName = String.valueOf(partner.get("partnerName"));
                    } else {
                        // 동적 객체 속성 접근 시도
                        try {
                            java.lang.reflect.Method getTypeMethod = obj.getClass().getMethod("getPartnerType");
                            java.lang.reflect.Method getNameMethod = obj.getClass().getMethod("getPartnerName");
                            partnerType = String.valueOf(getTypeMethod.invoke(obj));
                            partnerName = String.valueOf(getNameMethod.invoke(obj));
                        } catch (Exception e) {
                            log.warn("거래처 객체 속성 접근 실패", e);
                        }
                    }
                    
                    if ("공급처".equals(partnerType)) {
                        supplierCount++;
                    } else if ("판매처".equals(partnerType)) {
                        vendorCount++;
                    } else {
                        unknownCount++;
                        log.warn("알 수 없는 거래처 유형: {}({})", partnerName, partnerType);
                    }
                } catch (Exception e) {
                    log.error("거래처 데이터 처리 중 오류", e);
                }
            }
            
            log.info("거래처 유형 집계: 공급처={}, 판매처={}, 알 수 없음={}", supplierCount, vendorCount, unknownCount);
            model.addAttribute("partners", partners);
            
            // 임시로 창고 목록 데이터 생성 (실제로는 WarehouseService를 주입하여 사용할 것)
            List<Map<String, String>> warehouses = new ArrayList<>();
            Map<String, String> wh1 = new HashMap<>();
            wh1.put("warehouseId", "WH001");
            wh1.put("warehouseName", "본사창고");
            warehouses.add(wh1);
            
            Map<String, String> wh2 = new HashMap<>();
            wh2.put("warehouseId", "WH002");
            wh2.put("warehouseName", "경유창고");
            warehouses.add(wh2);
            
            Map<String, String> wh3 = new HashMap<>();
            wh3.put("warehouseId", "WH003");
            wh3.put("warehouseName", "불량창고");
            warehouses.add(wh3);
            
            Map<String, String> wh4 = new HashMap<>();
            wh4.put("warehouseId", "WH004");
            wh4.put("warehouseName", "부산창고");
            warehouses.add(wh4);
            
            Map<String, String> wh5 = new HashMap<>();
            wh5.put("warehouseId", "WH005");
            wh5.put("warehouseName", "인천창고");
            warehouses.add(wh5);
            
            Map<String, String> wh6 = new HashMap<>();
            wh6.put("warehouseId", "WH006");
            wh6.put("warehouseName", "대구창고");
            warehouses.add(wh6);
            
            Map<String, String> wh7 = new HashMap<>();
            wh7.put("warehouseId", "WH007");
            wh7.put("warehouseName", "광주창고");
            warehouses.add(wh7);
            
            model.addAttribute("warehouses", warehouses);
        } catch (Exception e) {
            log.error("창고 또는 거래처 목록 가져오기 실패", e);
        }
        
        return "inventory/dailyInventory";
    }

    // 임시 샘플 데이터 생성 메소드들 - 실제 구현에서는 제거
    private List<DailyInventory> createSampleDailyInventoryData() {
        List<DailyInventory> list = new ArrayList<>();
        
        for (int i = 1; i <= 5; i++) {
            DailyInventory item = new DailyInventory();
            item.setDate("2024-05-" + (i < 10 ? "0" + i : i));
            item.setSupplier("공급처" + i);
            item.setProductCode("PROD" + (i < 10 ? "00" + i : "0" + i));
            item.setPeriodInbound(i * 100);
            item.setPeriodOutbound(i * 80);
            item.setPeriodStock(i * 20);
            
            // 일별 수량 데이터
            List<Integer> dailyQuantities = new ArrayList<>();
            for (int j = 1; j <= 7; j++) {
                dailyQuantities.add(i * j * 10);
            }
            item.setDailyQuantities(dailyQuantities);
            
            list.add(item);
        }
        
        return list;
    }
    
    private List<String> createSampleDateHeaders() {
        List<String> headers = new ArrayList<>();
        for (int i = 1; i <= 7; i++) {
            headers.add("2024-05-" + (i < 10 ? "0" + i : i));
        }
        return headers;
    }
    
    private List<Map<String, String>> createSampleVendorGroups() {
        List<Map<String, String>> groups = new ArrayList<>();
        
        for (int i = 1; i <= 3; i++) {
            Map<String, String> group = new HashMap<>();
            group.put("code", "VG" + i);
            group.put("name", "판매처그룹" + i);
            groups.add(group);
        }
        
        return groups;
    }
    
    private List<Map<String, String>> createSampleVendors() {
        List<Map<String, String>> vendors = new ArrayList<>();
        
        for (int i = 1; i <= 5; i++) {
            Map<String, String> vendor = new HashMap<>();
            vendor.put("code", "V" + i);
            vendor.put("name", "판매처" + i);
            vendors.add(vendor);
        }
        
        return vendors;
    }
    
    private List<Map<String, String>> createSampleSuppliers() {
        List<Map<String, String>> suppliers = new ArrayList<>();
        
        for (int i = 1; i <= 5; i++) {
            Map<String, String> supplier = new HashMap<>();
            supplier.put("code", "S" + i);
            supplier.put("name", "공급처" + i);
            suppliers.add(supplier);
        }
        
        return suppliers;
    }

    @PostMapping("/dailyInventory/search.do")
    public String searchDailyInventory(
            @ModelAttribute DailyInventorySearchCondition searchCondition,
            Model model) {
        // 검색 조건으로 일자별 재고조회 페이지로 리다이렉트
        return "redirect:/inventory/dailyInventory.do?startDate=" + searchCondition.getStartDate() 
              + "&endDate=" + searchCondition.getEndDate()
              + (searchCondition.getSupplier() != null && !searchCondition.getSupplier().isEmpty() ? "&supplier=" + searchCondition.getSupplier() : "")
              + (searchCondition.getVendor() != null && !searchCondition.getVendor().isEmpty() ? "&vendor=" + searchCondition.getVendor() : "")
              + (searchCondition.getInventoryType() != null && !searchCondition.getInventoryType().isEmpty() ? "&inventoryType=" + searchCondition.getInventoryType() : "");
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

    @GetMapping("/dailyInventory/export.do")
    public String exportDailyInventory(
            @ModelAttribute DailyInventorySearchCondition searchCondition,
            Model model) {
        // 데이터 조회
        List<DailyInventory> dailyInventoryList = inventoryService.searchDailyInventory(searchCondition);
        List<String> dateHeaders = inventoryService.selectDateHeaders(searchCondition);
        
        // 모델에 데이터 추가
        model.addAttribute("dailyInventoryList", dailyInventoryList);
        model.addAttribute("dateHeaders", dateHeaders);
        model.addAttribute("filename", "일자별재고데이터_" + java.time.LocalDate.now().toString());
        
        // 엑셀 뷰 리턴 - 실제 구현에서는 Excel 뷰 클래스를 만들어 사용
        return "excelDailyInventoryView";
    }

    // 하드코딩된 카테고리 목록 생성
    private List<Map<String, String>> createFallbackCategories() {
        List<Map<String, String>> categories = new ArrayList<>();
        
        Map<String, String> category1 = new HashMap<>();
        category1.put("code", "전자제품");
        category1.put("name", "전자제품");
        categories.add(category1);
        
        Map<String, String> category2 = new HashMap<>();
        category2.put("code", "전자부품");
        category2.put("name", "전자부품");
        categories.add(category2);
        
        Map<String, String> category3 = new HashMap<>();
        category3.put("code", "가전제품");
        category3.put("name", "가전제품");
        categories.add(category3);
        
        return categories;
    }
    
    // 상품 유형 목록 생성
    private List<Map<String, String>> createProductTypes() {
        List<Map<String, String>> productTypes = new ArrayList<>();
        
        Map<String, String> type1 = new HashMap<>();
        type1.put("code", "부품");
        type1.put("name", "부품");
        productTypes.add(type1);
        
        Map<String, String> type2 = new HashMap<>();
        type2.put("code", "완제품");
        type2.put("name", "완제품");
        productTypes.add(type2);
        
        return productTypes;
    }
} 