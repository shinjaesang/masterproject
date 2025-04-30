package org.myweb.first.warehouse.model.dto;

import java.io.Serializable;

public class Warehouse implements Serializable {
	private static final long serialVersionUID = 2379056518857620438L;
	private String warehouseId;         // 창고 ID
    private String warehouseType;       // 창고 유형
    private String warehouseName;       // 창고 이름
    private String warehouseAddress;    // 창고 주소
    private Integer warehouseArea;      // 창고 면적
    private String empid;               // 담당자 ID
    private String managerName;         // 담당자 이름
    private String contactInfo;         // 연락처
    private String email;               // 이메일

    public Warehouse() {}

    public String getWarehouseId() {
        return warehouseId;
    }
    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }
    public String getWarehouseType() {
        return warehouseType;
    }
    public void setWarehouseType(String warehouseType) {
        this.warehouseType = warehouseType;
    }
    public String getWarehouseName() {
        return warehouseName;
    }
    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }
    public String getWarehouseAddress() {
        return warehouseAddress;
    }
    public void setWarehouseAddress(String warehouseAddress) {
        this.warehouseAddress = warehouseAddress;
    }
    public Integer getWarehouseArea() {
        return warehouseArea;
    }
    public void setWarehouseArea(Integer warehouseArea) {
        this.warehouseArea = warehouseArea;
    }
    public String getEmpid() {
        return empid;
    }
    public void setEmpid(String empid) {
        this.empid = empid;
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
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Warehouse{" +
                "warehouseId='" + warehouseId + '\'' +
                ", warehouseType='" + warehouseType + '\'' +
                ", warehouseName='" + warehouseName + '\'' +
                ", warehouseAddress='" + warehouseAddress + '\'' +
                ", warehouseArea=" + warehouseArea +
                ", empid='" + empid + '\'' +
                ", managerName='" + managerName + '\'' +
                ", contactInfo='" + contactInfo + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
} 