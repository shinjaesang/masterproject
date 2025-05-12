package org.myweb.first.inout.model.service;

import java.util.List;
import java.util.Map;

import org.myweb.first.inout.model.dto.InOutVoice;
import org.myweb.first.inout.model.dto.InOutVoiceProductDetail;

public interface InOutVoiceService {

    /**
     * 입출고 전표 목록 조회
     * @param params 검색 조건
     * @return 입출고 전표 목록
     */
    List<InOutVoice> selectInOutVoiceList(Map<String, Object> params);

    /**
     * 입출고 전표 상세 조회
     * @param inoutvoiceId 전표 ID
     * @return 입출고 전표 정보
     */
    InOutVoice selectInOutVoiceById(String inoutvoiceId);

    /**
     * 입출고 전표 등록
     * @param inOutVoice 입출고 전표 정보
     * @return 등록된 행 수
     */
    int insertInOutVoice(InOutVoice inOutVoice);

    /**
     * 입출고 전표 수정
     * @param inOutVoice 입출고 전표 정보
     * @return 수정된 행 수
     */
    int updateInOutVoice(InOutVoice inOutVoice);

    /**
     * 입출고 전표 삭제
     * @param inoutvoiceId 전표 ID
     * @return 삭제된 행 수
     */
    int deleteInOutVoice(String inoutvoiceId);

    /**
     * 입출고 전표 총 개수 조회
     * @param params 검색 조건
     * @return 총 개수
     */
    int selectInOutVoiceTotalCount(Map<String, Object> params);
    
    /**
     * 전표별 상품목록 조회
     * @param inoutvoiceId 전표 ID
     * @return 상품 상세 목록
     */
    List<InOutVoiceProductDetail> selectInOutVoiceProductList(String inoutvoiceId);

    /**
     * 전표별 상품 추가 (처리)
     */
    int insertInOutVoiceProduct(String inoutvoiceId, String productId, int quantity, String workerId);

    // 상품 처리/삭제 추가
    int processInOutVoiceProducts(java.util.List<String> ids, String workerId);
    int deleteInOutVoiceProducts(java.util.List<String> ids);
} 