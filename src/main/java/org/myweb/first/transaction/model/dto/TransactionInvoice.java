package org.myweb.first.transaction.model.dto;

public class TransactionInvoice {

	private String tdocId;
    private String docName;
    private String docType;
    private String relatedPartyId;
    private String uploaderName;
    private String status;
    private String uploadedAt;
	public TransactionInvoice() {
		super();
	}
	public TransactionInvoice(String tdocId, String docName, String docType, String relatedPartyId, String uploaderName,
			String status, String uploadedAt) {
		super();
		this.tdocId = tdocId;
		this.docName = docName;
		this.docType = docType;
		this.relatedPartyId = relatedPartyId;
		this.uploaderName = uploaderName;
		this.status = status;
		this.uploadedAt = uploadedAt;
	}
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
	public String getRelatedPartyId() {
		return relatedPartyId;
	}
	public void setRelatedPartyId(String relatedPartyId) {
		this.relatedPartyId = relatedPartyId;
	}
	public String getUploaderName() {
		return uploaderName;
	}
	public void setUploaderName(String uploaderName) {
		this.uploaderName = uploaderName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUploadedAt() {
		return uploadedAt;
	}
	public void setUploadedAt(String uploadedAt) {
		this.uploadedAt = uploadedAt;
	}
	@Override
	public String toString() {
		return "TaxInvoice [tdocId=" + tdocId + ", docName=" + docName + ", docType=" + docType + ", relatedPartyId="
				+ relatedPartyId + ", uploaderName=" + uploaderName + ", status=" + status + ", uploadedAt="
				+ uploadedAt + "]";
	}
    
    
}
