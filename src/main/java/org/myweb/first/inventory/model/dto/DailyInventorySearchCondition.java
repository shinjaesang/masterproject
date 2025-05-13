package org.myweb.first.inventory.model.dto;

import java.io.Serializable;

public class DailyInventorySearchCondition implements Serializable {
    private String startDate;         // 시작일자
    private String endDate;           // 종료일자
    private String vendorGroup;       // 판매처그룹
    private String vendor;            // 판매처
    private String supplier;          // 공급처
    private String inventoryType;     // 재고타입 (NORMAL, DEFECTIVE, TRANSIT)
    private String quality;           // 품질 (A, B, C)
    private String workType;          // 작업 (INBOUND, OUTBOUND)
    private String productPeriodType; // 상품기간 타입 (REGISTER, INBOUND)
    private String productStartDate;  // 상품 시작일자
    private String productEndDate;    // 상품 종료일자
    private String category;          // 카테고리
    private String productName;       // 상품명
    private String productCode;       // 상품코드
    private String productType;       // 상품유형
    private String searchType;        // 검색 유형 (name, code)
    private String searchKeyword;     // 검색어
    private int page = 1;             // 페이지 번호
    private int pageSize = 20;        // 페이지 크기
    private int startRow;             // 시작 행
    private int endRow;               // 종료 행

    // Getters and Setters
    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getVendorGroup() {
        return vendorGroup;
    }

    public void setVendorGroup(String vendorGroup) {
        this.vendorGroup = vendorGroup;
    }

    public String getVendor() {
        return vendor;
    }

    public void setVendor(String vendor) {
        this.vendor = vendor;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public String getInventoryType() {
        return inventoryType;
    }

    public void setInventoryType(String inventoryType) {
        this.inventoryType = inventoryType;
    }

    public String getQuality() {
        return quality;
    }

    public void setQuality(String quality) {
        this.quality = quality;
    }

    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    public String getProductPeriodType() {
        return productPeriodType;
    }

    public void setProductPeriodType(String productPeriodType) {
        this.productPeriodType = productPeriodType;
    }

    public String getProductStartDate() {
        return productStartDate;
    }

    public void setProductStartDate(String productStartDate) {
        this.productStartDate = productStartDate;
    }

    public String getProductEndDate() {
        return productEndDate;
    }

    public void setProductEndDate(String productEndDate) {
        this.productEndDate = productEndDate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getStartRow() {
        return startRow;
    }

    public void setStartRow(int startRow) {
        this.startRow = startRow;
    }

    public int getEndRow() {
        return endRow;
    }

    public void setEndRow(int endRow) {
        this.endRow = endRow;
    }
} 