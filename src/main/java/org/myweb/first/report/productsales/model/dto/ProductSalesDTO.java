package org.myweb.first.report.productsales.model.dto;

public class ProductSalesDTO {
    private String productId;
    private String productCode;
    private String productName;
    private String categoryName;
    private int orderCount;
    private int salesAmount;
    private int productCost;
    private int marginAmount;
    private double marginRate;
    private double purchaseRate;
    private String customerName;
    private String supplierName;
    private int availableStock;
    private String orderType;
    private String orderDate;
    private String optionName;

    // Getters
    public String getProductId() { return productId; }
    public String getProductCode() { return productCode; }
    public String getProductName() { return productName; }
    public String getCategoryName() { return categoryName; }
    public int getOrderCount() { return orderCount; }
    public int getSalesAmount() { return salesAmount; }
    public int getProductCost() { return productCost; }
    public int getMarginAmount() { return marginAmount; }
    public double getMarginRate() { return marginRate; }
    public double getPurchaseRate() { return purchaseRate; }
    public String getCustomerName() { return customerName; }
    public String getSupplierName() { return supplierName; }
    public int getAvailableStock() { return availableStock; }
    public String getOrderType() { return orderType; }
    public String getOrderDate() { return orderDate; }
    public String getOptionName() { return optionName; }

    // Setters
    public void setProductId(String productId) { this.productId = productId; }
    public void setProductCode(String productCode) { this.productCode = productCode; }
    public void setProductName(String productName) { this.productName = productName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public void setOrderCount(int orderCount) { this.orderCount = orderCount; }
    public void setSalesAmount(int salesAmount) { this.salesAmount = salesAmount; }
    public void setProductCost(int productCost) { this.productCost = productCost; }
    public void setMarginAmount(int marginAmount) { this.marginAmount = marginAmount; }
    public void setMarginRate(double marginRate) { this.marginRate = marginRate; }
    public void setPurchaseRate(double purchaseRate) { this.purchaseRate = purchaseRate; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
    public void setAvailableStock(int availableStock) { this.availableStock = availableStock; }
    public void setOrderType(String orderType) { this.orderType = orderType; }
    public void setOrderDate(String orderDate) { this.orderDate = orderDate; }
    public void setOptionName(String optionName) { this.optionName = optionName; }
} 