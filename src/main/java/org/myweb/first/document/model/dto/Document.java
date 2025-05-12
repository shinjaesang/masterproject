package org.myweb.first.document.model.dto;

import java.sql.Date;
import java.util.List;

public class Document {
	
	private String docId;
    private String title;
    private String content;
    private String empId;
    private String empName;
    private Date draftDate;
    private String approvalStatus;
    private String documentFormat;
    private Date approvalDate;
    private String department;
    private String job;
    private String referencerId;
    private String reviewerId;
    private String approverId;
    private String approverName;
    private String reviewerName;
    private String referencerName;
    private Date reviewDate;
    private byte[] attachFile;
    
    // 참조자, 검토자, 결재자 목록을 위한 필드 추가
    private List<Document> references;
    private List<Document> reviewers;
    private List<Document> approvers;
    
	public Document() {
		super();
	}
	
	public Document(String docId, String title, String content, String empId, String empName, Date draftDate, String approvalStatus,
			String documentFormat, String orderId, Date approvalDate, String department, String job) {
		super();
		this.docId = docId;
		this.title = title;
		this.content = content;
		this.empId = empId;
		this.empName = empName;
		this.draftDate = draftDate;
		this.approvalStatus = approvalStatus;
		this.documentFormat = documentFormat;
		this.approvalDate = approvalDate;
		this.department = department;
		this.job = job;
	}
	
	public String getDocId() {
		return docId;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public Date getDraftDate() {
		return draftDate;
	}
	public void setDraftDate(Date draftDate) {
		this.draftDate = draftDate;
	}
	public String getApprovalStatus() {
		return approvalStatus;
	}
	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
	public String getDocumentFormat() {
		return documentFormat;
	}
	public void setDocumentFormat(String documentFormat) {
		this.documentFormat = documentFormat;
	}
	public Date getApprovalDate() {
		return approvalDate;
	}
	public void setApprovalDate(Date approvalDate) {
		this.approvalDate = approvalDate;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getReferencerId() {
		return referencerId;
	}
	public void setReferencerId(String referencerId) {
		this.referencerId = referencerId;
	}
	public String getReviewerId() {
		return reviewerId;
	}
	public void setReviewerId(String reviewerId) {
		this.reviewerId = reviewerId;
	}
	public String getApproverId() {
		return approverId;
	}
	public void setApproverId(String approverId) {
		this.approverId = approverId;
	}
	public String getApproverName() {
		return approverName;
	}
	public void setApproverName(String approverName) {
		this.approverName = approverName;
	}
	public String getReviewerName() {
		return reviewerName;
	}
	public void setReviewerName(String reviewerName) {
		this.reviewerName = reviewerName;
	}
	public String getReferencerName() {
		return referencerName;
	}
	public void setReferencerName(String referencerName) {
		this.referencerName = referencerName;
	}
	public Date getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}
	
	public List<Document> getReferences() {
		return references;
	}
	
	public void setReferences(List<Document> references) {
		this.references = references;
	}
	
	public List<Document> getReviewers() {
		return reviewers;
	}
	
	public void setReviewers(List<Document> reviewers) {
		this.reviewers = reviewers;
	}
	
	public List<Document> getApprovers() {
		return approvers;
	}
	
	public void setApprovers(List<Document> approvers) {
		this.approvers = approvers;
	}
	
	public byte[] getAttachFile() {
		return attachFile;
	}
	
	public void setAttachFile(byte[] attachFile) {
		this.attachFile = attachFile;
	}
	
	@Override
	public String toString() {
		return "Document [docId=" + docId + ", title=" + title + ", content=" + content + ", empId=" + empId
				+ ", empName=" + empName + ", draftDate=" + draftDate + ", approvalStatus=" + approvalStatus + ", documentFormat="
				+ documentFormat + ", reviewDate=" + reviewDate + ", approvalDate=" + approvalDate + ", department=" + department 
				+ ", job=" + job + ", referencerId=" + referencerId + ", reviewerId=" + reviewerId + ", approverId=" + approverId
				+ ", approverName=" + approverName + ", reviewerName=" + reviewerName + ", referencerName=" + referencerName + "]";
	}
}
