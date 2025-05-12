package org.myweb.first.document.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.myweb.first.document.model.dao.DocumentDao;
import org.myweb.first.document.model.dto.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class DocumentServiceImpl implements DocumentService {
    private static final Logger logger = LoggerFactory.getLogger(DocumentServiceImpl.class);

    @Autowired
    private DocumentDao documentDao;

    @Override
    public List<Document> selectDocumentList(Map<String, Object> searchParams) {
        return documentDao.selectDocumentList(searchParams);
    }

    @Override
    public int selectTotalDocumentCount(Map<String, Object> searchParams) {
        return documentDao.selectTotalDocumentCount(searchParams);
    }

    @Override
    public Document selectDocumentDetail(String docId) {
        return documentDao.selectDocumentDetail(docId);
    }

    @Override
    public int updateDocumentStatus(String docId, String status) {
        Map<String, String> params = Map.of("docId", docId, "status", status);
        return documentDao.updateDocumentStatus(params);
    }

    @Override
    public List<Document> selectDocumentReferences(String docId) {
        return documentDao.selectDocumentReferences(docId);
    }

    @Override
    public int insertDocumentReference(String docId, String empId) {
        Map<String, String> params = Map.of("docId", docId, "empId", empId);
        return documentDao.insertDocumentReference(params);
    }

    @Override
    public int deleteDocumentReference(String docId, String empId) {
        Map<String, String> params = Map.of("docId", docId, "empId", empId);
        return documentDao.deleteDocumentReference(params);
    }

    @Override
    public List<Document> selectDocumentReviewers(String docId) {
        return documentDao.selectDocumentReviewers(docId);
    }

    @Override
    public List<Document> selectDocumentApprovers(String docId) {
        return documentDao.selectDocumentApprovers(docId);
    }

    @Override
    public List<Document> selectApprovalLineEmployees() {
        return documentDao.selectApprovalLineEmployees();
    }

    @Override
    public List<Document> selectReviewerLineEmployees() {
        return documentDao.selectReviewerLineEmployees();
    }

    @Override
    public List<Document> selectAllEmployees() {
        return documentDao.selectAllEmployees();
    }

    @Override
    @Transactional
    public int insertDocument(Document document, 
                             List<Map<String, Object>> approvers,
                             List<Map<String, Object>> reviewers,
                             List<Map<String, Object>> referrers,
                             List<MultipartFile> attachments) {
        int result = 0;
        
        try {
            // 1. 문서 기본 정보 등록
            result = documentDao.insertDocument(document);
            if (result <= 0) {
                throw new RuntimeException("문서 등록에 실패했습니다.");
            }
            
            logger.info("문서 등록 성공 - docId: {}", document.getDocId());
            
            // 2. 결재선 등록
            // 결재자 등록
            if (approvers != null && !approvers.isEmpty()) {
                for (Map<String, Object> approver : approvers) {
                    Map<String, String> params = new HashMap<>();
                    params.put("docId", document.getDocId());
                    params.put("empId", (String) approver.get("empId"));
                    params.put("role", "결재자");
                    logger.info("결재자 등록 시도: {}", params);
                    int insertResult = documentDao.insertApprovalLine(params);
                    logger.info("결재자 등록 결과: {}", insertResult);
                }
            }
            
            // 검토자 등록
            if (reviewers != null && !reviewers.isEmpty()) {
                for (Map<String, Object> reviewer : reviewers) {
                    Map<String, String> params = new HashMap<>();
                    params.put("docId", document.getDocId());
                    params.put("empId", (String) reviewer.get("empId"));
                    params.put("role", "검토자");
                    logger.info("검토자 등록 시도: {}", params);
                    int insertResult = documentDao.insertApprovalLine(params);
                    logger.info("검토자 등록 결과: {}", insertResult);
                }
            }
            
            // 참조자 등록
            if (referrers != null && !referrers.isEmpty()) {
                for (Map<String, Object> referrer : referrers) {
                    Map<String, String> params = new HashMap<>();
                    params.put("docId", document.getDocId());
                    params.put("empId", (String) referrer.get("empId"));
                    params.put("role", "참조자");
                    logger.info("참조자 등록 시도: {}", params);
                    int insertResult = documentDao.insertApprovalLine(params);
                    logger.info("참조자 등록 결과: {}", insertResult);
                }
            }
            
            // 3. 첨부파일 등록 (임시 비활성화)
            /*
            if (attachments != null && !attachments.isEmpty()) {
                String uploadPath = "D:/upload/";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                
                for (MultipartFile file : attachments) {
                    if (!file.isEmpty()) {
                        String originalFilename = file.getOriginalFilename();
                        String savedFilename = System.currentTimeMillis() + "_" + originalFilename;
                        File destFile = new File(uploadPath + savedFilename);
                        file.transferTo(destFile);
                        
                        Map<String, Object> fileParams = new HashMap<>();
                        fileParams.put("docId", document.getDocId());
                        fileParams.put("originalFilename", originalFilename);
                        fileParams.put("filePath", uploadPath);
                        fileParams.put("fileSize", file.getSize());
                        
                        logger.info("첨부파일 등록 시도: {}", fileParams);
                        int fileResult = documentDao.insertAttachment(fileParams);
                        logger.info("첨부파일 등록 결과: {}", fileResult);
                    }
                }
            }
            */
            
            return result;
        } catch (Exception e) {
            logger.error("문서 등록 중 오류 발생", e);
            throw new RuntimeException("문서 등록 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
}
