package org.myweb.first.inout.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.inout.model.dto.InOutVoice;
import org.myweb.first.inout.model.dto.InOutVoiceProductDetail;
import org.springframework.stereotype.Repository;

@Repository
public class InOutVoiceDao {

    private final SqlSession sqlSession;

    public InOutVoiceDao(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    /**
     * 입출고 전표 목록 조회
     * @param params 검색 조건
     * @return 입출고 전표 목록
     */
    public List<InOutVoice> selectInOutVoiceList(Map<String, Object> params) {
        return sqlSession.selectList("inOutVoiceMapper.selectInOutVoiceList", params);
    }

    /**
     * 입출고 전표 상세 조회
     * @param inoutvoiceId 전표 ID
     * @return 입출고 전표 정보
     */
    public InOutVoice selectInOutVoiceById(String inoutvoiceId) {
        return sqlSession.selectOne("inOutVoiceMapper.selectInOutVoiceById", inoutvoiceId);
    }

    /**
     * 입출고 전표 등록
     * @param inOutVoice 입출고 전표 정보
     * @return 등록된 행 수
     */
    public int insertInOutVoice(InOutVoice inOutVoice) {
        return sqlSession.insert("inOutVoiceMapper.insertInOutVoice", inOutVoice);
    }

    /**
     * 입출고 전표 수정
     * @param inOutVoice 입출고 전표 정보
     * @return 수정된 행 수
     */
    public int updateInOutVoice(InOutVoice inOutVoice) {
        return sqlSession.update("inOutVoiceMapper.updateInOutVoice", inOutVoice);
    }

    /**
     * 입출고 전표 삭제
     * @param inoutvoiceId 전표 ID
     * @return 삭제된 행 수
     */
    public int deleteInOutVoice(String inoutvoiceId) {
        return sqlSession.delete("inOutVoiceMapper.deleteInOutVoice", inoutvoiceId);
    }

    /**
     * 입출고 전표 총 개수 조회
     * @param params 검색 조건
     * @return 총 개수
     */
    public int selectInOutVoiceTotalCount(Map<String, Object> params) {
        return sqlSession.selectOne("inOutVoiceMapper.selectInOutVoiceTotalCount", params);
    }
    
    /**
     * 전표별 상품목록 조회
     * @param inoutvoiceId 전표 ID
     * @return 상품 상세 목록
     */
    public List<InOutVoiceProductDetail> selectInOutVoiceProductList(String inoutvoiceId) {
        return sqlSession.selectList("inOutVoiceMapper.selectInOutVoiceProductList", inoutvoiceId);
    }

    /**
     * 전표별 상품 추가 (처리)
     */
    public int insertInOutVoiceProduct(String inoutvoiceId, String productId, int quantity, String workerId) {
        java.util.Map<String, Object> param = new java.util.HashMap<>();
        param.put("inoutvoiceId", inoutvoiceId);
        param.put("productId", productId);
        param.put("quantity", quantity);
        param.put("workerId", workerId);
        return sqlSession.insert("inOutVoiceMapper.insertInOutVoiceProduct", param);
    }

    public int processInOutVoiceProducts(java.util.List<String> ids) {
        return sqlSession.update("inOutVoiceMapper.processInOutVoiceProducts", ids);
    }

    public int deleteInOutVoiceProducts(java.util.List<String> ids) {
        return sqlSession.delete("inOutVoiceMapper.deleteInOutVoiceProducts", ids);
    }

    public List<InOutVoiceProductDetail> selectProductsByIds(List<String> ids) {
        return sqlSession.selectList("inOutVoiceMapper.selectProductsByIds", ids);
    }

    public int updateProductAsProcessed(List<String> ids, String workerId) {
        java.util.Map<String, Object> param = new java.util.HashMap<>();
        param.put("ids", ids);
        param.put("workerId", workerId);
        return sqlSession.update("inOutVoiceMapper.updateProductAsProcessed", param);
    }
} 