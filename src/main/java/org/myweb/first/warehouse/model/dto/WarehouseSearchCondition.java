package org.myweb.first.warehouse.model.dto;

import java.io.Serializable;

public class WarehouseSearchCondition implements Serializable {
    private String warehouseName;
    private String warehouseAddress;
    private String managerName;
    private String contactInfo;
    private String warehouseType;

    public String getWarehouseName() { return warehouseName; }
    public void setWarehouseName(String warehouseName) { this.warehouseName = warehouseName; }
    public String getWarehouseAddress() { return warehouseAddress; }
    public void setWarehouseAddress(String warehouseAddress) { this.warehouseAddress = warehouseAddress; }
    public String getManagerName() { return managerName; }
    public void setManagerName(String managerName) { this.managerName = managerName; }
    public String getContactInfo() { return contactInfo; }
    public void setContactInfo(String contactInfo) { this.contactInfo = contactInfo; }
    public String getWarehouseType() { return warehouseType; }
    public void setWarehouseType(String warehouseType) { this.warehouseType = warehouseType; }
} 