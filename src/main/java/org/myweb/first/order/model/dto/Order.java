package org.myweb.first.order.model.dto;

import java.util.Date;
import java.util.List;

public class Order {
    private String orderId;           // 주문 ID
    private String partnerId;         // 거래처 ID
    private String partnerName;       // 거래처명
    private String partnerType;       // 거래처 유형
    private String managerName;       // 담당자명
    private String contactInfo;       // 연락처
    private String partnerAddress;    // 거래처 주소
    private String orderType;         // 주문 유형
    private String orderStatus;       // 주문 상태 (접수, 처리중, 완료, 취소)
    private Date createdAt;           // 주문 등록일
    private List<OrderItem> items;    // 주문 상품 목록
    
    // 기본 생성자
    public Order() {}
    
    // 전체 필드 생성자
    public Order(String orderId, String partnerId, String partnerName, String partnerType, 
                String managerName, String contactInfo, String partnerAddress, String orderType, 
                String orderStatus, Date createdAt) {
        this.orderId = orderId;
        this.partnerId = partnerId;
        this.partnerName = partnerName;
        this.partnerType = partnerType;
        this.managerName = managerName;
        this.contactInfo = contactInfo;
        this.partnerAddress = partnerAddress;
        this.orderType = orderType;
        this.orderStatus = orderStatus;
        this.createdAt = createdAt;
    }
    
    // Getter와 Setter
    public String getOrderId() {
        return orderId;
    }
    
    public void setOrderId(String orderId) {
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
    
    public String getOrderType() {
        return orderType;
    }
    
    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }
    
    public String getOrderStatus() {
        return orderStatus;
    }
    
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    
    public Date getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public List<OrderItem> getItems() {
        return items;
    }
    
    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
    
    @Override
    public String toString() {
        return "Order [orderId=" + orderId + ", partnerId=" + partnerId + ", partnerName=" + partnerName 
                + ", partnerType=" + partnerType + ", managerName=" + managerName + ", contactInfo=" + contactInfo 
                + ", partnerAddress=" + partnerAddress + ", orderType=" + orderType + ", orderStatus=" + orderStatus 
                + ", createdAt=" + createdAt + "]";
    }
}
