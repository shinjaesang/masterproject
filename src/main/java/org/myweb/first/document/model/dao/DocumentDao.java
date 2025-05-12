package org.myweb.first.document.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.document.model.dto.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DocumentDao {
    @Autowired
    private SqlSession sqlSession;

    public List<Document> selectDocumentList(Map<String, Object> searchParams) {
        return sqlSession.selectList("documentMapper.selectDocumentList", searchParams);
    }

    public int selectTotalDocumentCount(Map<String, Object> searchParams) {
        return sqlSession.selectOne("documentMapper.selectTotalDocumentCount", searchParams);
    }

    public Document selectDocumentDetail(String docId) {
        return sqlSession.selectOne("documentMapper.selectDocumentDetail", docId);
    }

    public int updateDocumentStatus(Map<String, String> params) {
        return sqlSession.update("documentMapper.updateDocumentStatus", params);
    }

    public List<Document> selectDocumentReferences(String docId) {
        return sqlSession.selectList("documentMapper.selectDocumentReferences", docId);
    }

    public int insertDocumentReference(Map<String, String> params) {
        return sqlSession.insert("documentMapper.insertDocumentReference", params);
    }

    public int deleteDocumentReference(Map<String, String> params) {
        return sqlSession.delete("documentMapper.deleteDocumentReference", params);
    }

    public List<Document> selectDocumentReviewers(String docId) {
        return sqlSession.selectList("documentMapper.selectDocumentReviewers", docId);
    }

    public List<Document> selectDocumentApprovers(String docId) {
        return sqlSession.selectList("documentMapper.selectDocumentApprovers", docId);
    }

    public List<Document> selectApprovalLineEmployees() {
        return sqlSession.selectList("documentMapper.selectApprovalLineEmployees");
    }

    public List<Document> selectReviewerLineEmployees() {
        return sqlSession.selectList("documentMapper.selectReviewerLineEmployees");
    }

    // 모든 직원 조회 (참조자용)
    public List<Document> selectAllEmployees() {
        return sqlSession.selectList("documentMapper.selectAllEmployees");
    }

    // 문서 등록
    public int insertDocument(Document document) {
        return sqlSession.insert("documentMapper.insertDocument", document);
    }

    // 결재선 등록
    public int insertApprovalLine(Map<String, String> params) {
        return sqlSession.insert("documentMapper.insertApprovalLine", params);
    }

    // 첨부파일 등록
    public int insertAttachment(Map<String, Object> params) {
        return sqlSession.insert("documentMapper.insertAttachment", params);
    }

    // public Map<String, String> selectFileInfo(String fileId) {
    //     return sqlSession.selectOne("documentMapper.selectFileInfo", fileId);
    // }
}
