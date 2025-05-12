package org.myweb.first.transaction.model.dto;

import java.sql.Date;

public class Transaction {
    private String tdocId;
    private String docName;
    private String docType;
    private String relatedPartyType;
    private String relatedPartyId;
    private String partnerName;
    private Date uploadedAt;
    private Date updatedAt;
    private String uploadedBy;
    private String uploaderName;
    private Date validUntil;
    private String status;
    private String content;
    private byte[] attachedFile;
    private String attachedFileName;
    
    public Transaction() {}

    public String getTdocId() {
        return tdocId;
    }

    public void setTdocId(String tdocId) {
        this.tdocId = tdocId;
    }

    public String getDocName() {
        return docName;
    }

    public void setDocName(String docName) {
        this.docName = docName;
    }

    public String getDocType() {
        return docType;
    }

    public void setDocType(String docType) {
        this.docType = docType;
    }

    public String getRelatedPartyType() {
        return relatedPartyType;
    }

    public void setRelatedPartyType(String relatedPartyType) {
        this.relatedPartyType = relatedPartyType;
    }

    public String getRelatedPartyId() {
        return relatedPartyId;
    }

    public void setRelatedPartyId(String relatedPartyId) {
        this.relatedPartyId = relatedPartyId;
    }

    public Date getUploadedAt() {
        return uploadedAt;
    }

    public void setUploadedAt(Date uploadedAt) {
        this.uploadedAt = uploadedAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getUploadedBy() {
        return uploadedBy;
    }

    public void setUploadedBy(String uploadedBy) {
        this.uploadedBy = uploadedBy;
    }

    public Date getValidUntil() {
        return validUntil;
    }

    public void setValidUntil(Date validUntil) {
        this.validUntil = validUntil;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public byte[] getAttachedFile() {
        return attachedFile;
    }

    public void setAttachedFile(byte[] attachedFile) {
        this.attachedFile = attachedFile;
    }

    public String getPartnerName() {
        return partnerName;
    }

    public void setPartnerName(String partnerName) {
        this.partnerName = partnerName;
    }

    public String getUploaderName() {
        return uploaderName;
    }

    public void setUploaderName(String uploaderName) {
        this.uploaderName = uploaderName;
    }

    public String getAttachedFileName() {
        return attachedFileName;
    }

    public void setAttachedFileName(String attachedFileName) {
        this.attachedFileName = attachedFileName;
    }

    @Override
    public String toString() {
        return "Transaction [tdocId=" + tdocId + ", docName=" + docName + ", docType=" + docType
                + ", relatedPartyType=" + relatedPartyType + ", relatedPartyId=" + relatedPartyId
                + ", uploadedAt=" + uploadedAt + ", uploadedBy=" + uploadedBy + ", validUntil="
                + validUntil + ", status=" + status + ", attachedFileName=" + attachedFileName + "]";
    }
}
