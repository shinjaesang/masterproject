package org.myweb.first.inventory.model.dto;

import java.io.Serializable;

public class InventorySearchCondition implements Serializable {
    private String productCode;
    private String productName;
    private String productType;
    private String partnerId;
    private String warehouse;
    private String inventoryStatus;
    private int page = 1;
    private int pageSize = 20;
    private int startRow;
    private int endRow;
    private String sortOrder;
    public String getProductCode() { return productCode; }
    public void setProductCode(String productCode) { this.productCode = productCode; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getProductType() { return productType; }
    public void setProductType(String productType) { this.productType = productType; }
    public String getPartnerId() { return partnerId; }
    public void setPartnerId(String partnerId) { this.partnerId = partnerId; }
    public String getWarehouse() { return warehouse; }
    public void setWarehouse(String warehouse) { this.warehouse = warehouse; }
    public String getInventoryStatus() { return inventoryStatus; }
    public void setInventoryStatus(String inventoryStatus) { this.inventoryStatus = inventoryStatus; }
    public int getPage() { return page; }
    public void setPage(int page) { this.page = page; }
    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }
    public int getStartRow() { return startRow; }
    public void setStartRow(int startRow) { this.startRow = startRow; }
    public int getEndRow() { return endRow; }
    public void setEndRow(int endRow) { this.endRow = endRow; }
    public String getSortOrder() { return sortOrder; }
    public void setSortOrder(String sortOrder) { this.sortOrder = sortOrder; }
} 