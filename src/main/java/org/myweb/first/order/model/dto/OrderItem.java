package org.myweb.first.order.model.dto;

public class OrderItem {
    private String orderItemId;    // 주문 항목 ID
    private String orderId;        // 주문 ID
    private String productId;      // 상품 ID
    private String productCode;    // 상품 코드
    private String productName;    // 상품명
    private String optionValue;    // 상품 옵션
    private Integer costPrice;     // 원가
    private Integer sellingPrice;  // 판매가
    private Integer quantity;      // 주문 수량
//    private Integer totalAmount;      // 총액

    public OrderItem() {}

    public OrderItem(String orderItemId, String orderId, String productId, Integer quantity, String productName, String optionValue, Integer sellingPrice) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.productName = productName;
        this.optionValue = optionValue;
        this.sellingPrice = sellingPrice;
    }

    public String getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(String orderItemId) {
        this.orderItemId = orderItemId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
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

    public String getOptionValue() {
        return optionValue;
    }

    public void setOptionValue(String optionValue) {
        this.optionValue = optionValue;
    }

    public Integer getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(Integer costPrice) {
        this.costPrice = costPrice;
    }

    public Integer getSellingPrice() {
        return sellingPrice;
    }

    public void setSellingPrice(Integer sellingPrice) {
        this.sellingPrice = sellingPrice;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
} 