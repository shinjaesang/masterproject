package org.myweb.first.partner.model.dto;

import java.io.Serializable;

public class Partner implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private String partnerId;           // 거래처 ID
    private String partnerType;         // 거래처 유형
    private String partnerName;         // 거래처명
    private String empid;               // 담당자 ID
    private String managerName;         // 담당자명
    private String contactInfo;         // 연락처
    private String email;               // 이메일
    private String partnerAddress;      // 주소
    private String businessRegNo;       // 사업자등록번호
    private String representativeName;  // 대표자명
    private String corporateType;       // 법인형태
    private String transactionStatus;   // 거래상태

    public Partner() {}

    // Getters and Setters
    public String getPartnerId() {
        return partnerId;
    }

    public void setPartnerId(String partnerId) {
        this.partnerId = partnerId;
    }

    public String getPartnerType() {
        return partnerType;
    }

    public void setPartnerType(String partnerType) {
        this.partnerType = partnerType;
    }

    public String getPartnerName() {
        return partnerName;
    }

    public void setPartnerName(String partnerName) {
        this.partnerName = partnerName;
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

    public String getPartnerAddress() {
        return partnerAddress;
    }

    public void setPartnerAddress(String partnerAddress) {
        this.partnerAddress = partnerAddress;
    }

    public String getBusinessRegNo() {
        return businessRegNo;
    }

    public void setBusinessRegNo(String businessRegNo) {
        this.businessRegNo = businessRegNo;
    }

    public String getRepresentativeName() {
        return representativeName;
    }

    public void setRepresentativeName(String representativeName) {
        this.representativeName = representativeName;
    }

    public String getCorporateType() {
        return corporateType;
    }

    public void setCorporateType(String corporateType) {
        this.corporateType = corporateType;
    }

    public String getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(String transactionStatus) {
        this.transactionStatus = transactionStatus;
    }

    @Override
    public String toString() {
        return "Partner{" +
                "partnerId='" + partnerId + '\'' +
                ", partnerType='" + partnerType + '\'' +
                ", partnerName='" + partnerName + '\'' +
                ", empid='" + empid + '\'' +
                ", managerName='" + managerName + '\'' +
                ", contactInfo='" + contactInfo + '\'' +
                ", email='" + email + '\'' +
                ", partnerAddress='" + partnerAddress + '\'' +
                ", businessRegNo='" + businessRegNo + '\'' +
                ", representativeName='" + representativeName + '\'' +
                ", corporateType='" + corporateType + '\'' +
                ", transactionStatus='" + transactionStatus + '\'' +
                '}';
    }
} 