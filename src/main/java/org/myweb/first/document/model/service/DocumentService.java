package org.myweb.first.document.model.service;

import java.util.List;
import java.util.Map;

import org.myweb.first.document.model.dto.Document;
import org.springframework.web.multipart.MultipartFile;

public interface DocumentService {
    List<Document> selectDocumentList(Map<String, Object> searchParams);
    int selectTotalDocumentCount(Map<String, Object> searchParams);
    Document selectDocumentDetail(String docId);
    int updateDocumentStatus(String docId, String status);
    List<Document> selectDocumentReferences(String docId);
    int insertDocumentReference(String docId, String empId);
    int deleteDocumentReference(String docId, String empId);
    List<Document> selectDocumentReviewers(String docId);
    List<Document> selectDocumentApprovers(String docId);
    List<Document> selectApprovalLineEmployees();
    List<Document> selectReviewerLineEmployees();
    // 모든 직원 조회 (참조자용)
    List<Document> selectAllEmployees();
    
    // 문서 등록
    int insertDocument(Document document, 
                      List<Map<String, Object>> approvers,
                      List<Map<String, Object>> reviewers,
                      List<Map<String, Object>> referrers,
                      List<MultipartFile> attachments);
}
