package org.myweb.first.order.model.dto;

import java.util.Date;

public class Order {
    private Long orderId;           // 주문 ID
    private String partnerId;       // 거래처 ID
    private String partnerName;     // 거래처명
    private String partnerType;     // 거래처 유형
    private String managerName;     // 담당자명
    private String contactInfo;     // 연락처
    private String partnerAddress;  // 거래처 주소
    private String productId;       // 상품 ID
    private String productName;     // 상품명
    private String optionValue;     // 상품 옵션
    private Double sellingPrice;    // 판매가
    private Integer quantity;       // 주문 수량
    private String stockStatus;     // 재고 상태 (입고/출고)
    private Date createdAt;         // 주문 등록일
    
    // 기본 생성자
    public Order() {}
    
    // 전체 필드 생성자
    public Order(Long orderId, String partnerId, String partnerName, String partnerType, 
                String managerName, String contactInfo, String partnerAddress, String productId, 
                String productName, String optionValue, Double sellingPrice, Integer quantity, 
                String stockStatus, Date createdAt) {
        this.orderId = orderId;
        this.partnerId = partnerId;
        this.partnerName = partnerName;
        this.partnerType = partnerType;
        this.managerName = managerName;
        this.contactInfo = contactInfo;
        this.partnerAddress = partnerAddress;
        this.productId = productId;
        this.productName = productName;
        this.optionValue = optionValue;
        this.sellingPrice = sellingPrice;
        this.quantity = quantity;
        this.stockStatus = stockStatus;
        this.createdAt = createdAt;
    }
    
    // Getter와 Setter
    public Long getOrderId() {
        return orderId;
    }
    
    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }
    
    public String getPartnerId() {
        return partnerId;
    }
    
    public void setPartnerId(String partnerId) {
        this.partnerId = partnerId;
    }
    
    public String getPartnerName() {
        return partnerName;
    }
    
    public void setPartnerName(String partnerName) {
        this.partnerName = partnerName;
    }
    
    public String getPartnerType() {
        return partnerType;
    }
    
    public void setPartnerType(String partnerType) {
        this.partnerType = partnerType;
    }
    
    public String getManagerName() {
        return managerName;
    }
    
    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }
    
    public String getContactInfo() {
        return contactInfo;
    }
    
    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }
    
    public String getPartnerAddress() {
        return partnerAddress;
    }
    
    public void setPartnerAddress(String partnerAddress) {
        this.partnerAddress = partnerAddress;
    }
    
    public String getProductId() {
        return productId;
    }
    
    public void setProductId(String productId) {
        this.productId = productId;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public String getOptionValue() {
        return optionValue;
    }
    
    public void setOptionValue(String optionValue) {
        this.optionValue = optionValue;
    }
    
    public Double getSellingPrice() {
        return sellingPrice;
    }
    
    public void setSellingPrice(Double sellingPrice) {
        this.sellingPrice = sellingPrice;
    }
    
    public Integer getQuantity() {
        return quantity;
    }
    
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
    
    public String getStockStatus() {
        return stockStatus;
    }
    
    public void setStockStatus(String stockStatus) {
        this.stockStatus = stockStatus;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "Order [orderId=" + orderId + ", partnerId=" + partnerId + ", partnerName=" + partnerName 
                + ", partnerType=" + partnerType + ", managerName=" + managerName + ", contactInfo=" + contactInfo 
                + ", partnerAddress=" + partnerAddress + ", productId=" + productId + ", productName=" + productName 
                + ", optionValue=" + optionValue + ", sellingPrice=" + sellingPrice + ", quantity=" + quantity 
                + ", stockStatus=" + stockStatus + ", createdAt=" + createdAt + "]";
    }
}
