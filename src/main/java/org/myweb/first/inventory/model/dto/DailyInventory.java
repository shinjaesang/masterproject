package org.myweb.first.inventory.model.dto;

import java.util.List;

public class DailyInventory {
    private String date;             // 날짜
    private String supplier;         // 거래처
    private String productCode;      // 상품코드
    private String productName;      // 상품명
    private String productType;      // 상품유형
    private String category;         // 카테고리
    private int periodInbound;       // 기간총입고
    private int periodOutbound;      // 기간총출고
    private int periodStock;         // 기간총재고
    private String dailyQuantities;  // 일별 수량 (콤마로 구분된 문자열)

    // Getters and Setters
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getPeriodInbound() {
        return periodInbound;
    }

    public void setPeriodInbound(int periodInbound) {
        this.periodInbound = periodInbound;
    }

    public int getPeriodOutbound() {
        return periodOutbound;
    }

    public void setPeriodOutbound(int periodOutbound) {
        this.periodOutbound = periodOutbound;
    }

    public int getPeriodStock() {
        return periodStock;
    }

    public void setPeriodStock(int periodStock) {
        this.periodStock = periodStock;
    }

    public String getDailyQuantities() {
        return dailyQuantities;
    }

    public void setDailyQuantities(String dailyQuantities) {
        this.dailyQuantities = dailyQuantities;
    }

    // List<Integer>를 받아서 문자열로 변환하는 오버로드된 setter
    public void setDailyQuantities(List<Integer> dailyQuantities) {
        if (dailyQuantities == null || dailyQuantities.isEmpty()) {
            this.dailyQuantities = "";
            return;
        }
        
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < dailyQuantities.size(); i++) {
            sb.append(dailyQuantities.get(i));
            if (i < dailyQuantities.size() - 1) {
                sb.append(",");
            }
        }
        this.dailyQuantities = sb.toString();
    }

    @Override
    public String toString() {
        return "DailyInventory [date=" + date + ", supplier=" + supplier + ", productCode=" + productCode
                + ", productName=" + productName + ", productType=" + productType + ", category=" + category
                + ", periodInbound=" + periodInbound + ", periodOutbound=" + periodOutbound 
                + ", periodStock=" + periodStock + ", dailyQuantities=" + dailyQuantities + "]";
    }
} 