package org.myweb.first.inout.model.dto;

public class InOutVoiceProductDetail implements java.io.Serializable {
    private static final long serialVersionUID = 1L;

    private String inoutvoiceProductId;
    private String inoutvoiceId;
    private String productId;
    private String productName;
    private String optionValue;
    private int quantity;
    private int costPrice;
    private int sellingPrice;
    private String status;
    private String inoutvoiceType;
    private String inWarehouseId;
    private String outWarehouseId;
    private String workerId;
    private java.util.Date createdAt;

    public String getInoutvoiceProductId() { return inoutvoiceProductId; }
    public void setInoutvoiceProductId(String inoutvoiceProductId) { this.inoutvoiceProductId = inoutvoiceProductId; }

    public String getInoutvoiceId() { return inoutvoiceId; }
    public void setInoutvoiceId(String inoutvoiceId) { this.inoutvoiceId = inoutvoiceId; }

    public String getProductId() { return productId; }
    public void setProductId(String productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getOptionValue() { return optionValue; }
    public void setOptionValue(String optionValue) { this.optionValue = optionValue; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getCostPrice() { return costPrice; }
    public void setCostPrice(int costPrice) { this.costPrice = costPrice; }

    public int getSellingPrice() { return sellingPrice; }
    public void setSellingPrice(int sellingPrice) { this.sellingPrice = sellingPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getInoutvoiceType() { return inoutvoiceType; }
    public void setInoutvoiceType(String inoutvoiceType) { this.inoutvoiceType = inoutvoiceType; }

    public String getInWarehouseId() { return inWarehouseId; }
    public void setInWarehouseId(String inWarehouseId) { this.inWarehouseId = inWarehouseId; }

    public String getOutWarehouseId() { return outWarehouseId; }
    public void setOutWarehouseId(String outWarehouseId) { this.outWarehouseId = outWarehouseId; }

    public String getWorkerId() { return workerId; }
    public void setWorkerId(String workerId) { this.workerId = workerId; }

    public java.util.Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(java.util.Date createdAt) { this.createdAt = createdAt; }
} 
