package org.myweb.first.inventory.model.dto;

public class WarehouseStock implements java.io.Serializable {
    private static final long serialVersionUID = 1L;

    private String warehouseId;
    private String productId;
    private int stockQuantity;
    private String lastUpdatedBy;
    private java.sql.Date lastUpdatedAt;

    public String getWarehouseId() { return warehouseId; }
    public void setWarehouseId(String warehouseId) { this.warehouseId = warehouseId; }

    public String getProductId() { return productId; }
    public void setProductId(String productId) { this.productId = productId; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public String getLastUpdatedBy() { return lastUpdatedBy; }
    public void setLastUpdatedBy(String lastUpdatedBy) { this.lastUpdatedBy = lastUpdatedBy; }

    public java.sql.Date getLastUpdatedAt() { return lastUpdatedAt; }
    public void setLastUpdatedAt(java.sql.Date lastUpdatedAt) { this.lastUpdatedAt = lastUpdatedAt; }
} 