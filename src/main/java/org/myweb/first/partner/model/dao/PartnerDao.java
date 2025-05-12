package org.myweb.first.partner.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.partner.model.dto.Partner;
import org.myweb.first.partner.model.dto.PartnerSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Repository
public class PartnerDao {
    private static final Logger logger = LoggerFactory.getLogger(PartnerDao.class);

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "partnerMapper.";

    // 거래처 전체 목록 조회
    public List<Partner> selectAllPartners() {
        logger.info("=== 거래처 전체 목록 조회 시작 ===");
        List<Partner> result = sqlSession.selectList(NAMESPACE + "selectAllPartners");
        logger.info("조회 결과: {}", result);
        logger.info("=== 거래처 전체 목록 조회 종료 ===");
        return result;
    }

    // 거래처 상세 조회
    public Partner selectPartnerById(String partnerId) {
        logger.info("거래처 상세 조회: {}", partnerId);
        return sqlSession.selectOne(NAMESPACE + "selectPartnerById", partnerId);
    }

    // 거래처 등록
    public int insertPartner(Partner partner) {
        logger.info("거래처 등록: {}", partner);
        return sqlSession.insert(NAMESPACE + "insertPartner", partner);
    }

    // 거래처 수정
    public int updatePartner(Partner partner) {
        logger.info("거래처 수정: {}", partner);
        return sqlSession.update(NAMESPACE + "updatePartner", partner);
    }

    // 거래처 삭제
    public int deletePartner(String partnerId) {
        logger.info("거래처 삭제: {}", partnerId);
        return sqlSession.delete(NAMESPACE + "deletePartner", partnerId);
    }

    // 검색 조건에 따른 거래처 목록 조회
    public List<Partner> searchPartners(PartnerSearchCondition cond) {
        logger.info("=== 거래처 검색 시작 ===");
        logger.info("검색 조건: {}", cond);
        List<Partner> result = sqlSession.selectList(NAMESPACE + "searchPartners", cond);
        logger.info("검색 결과: {}", result);
        logger.info("=== 거래처 검색 종료 ===");
        return result;
    }

    public List<Partner> selectSuppliersOnly() {
        return sqlSession.selectList(NAMESPACE + "selectSuppliersOnly");
    }
} 