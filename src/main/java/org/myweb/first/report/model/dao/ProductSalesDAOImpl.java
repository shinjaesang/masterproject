package org.myweb.first.report.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.report.model.dto.ProductSalesDTO;
import org.myweb.first.report.model.dto.ProductSalesSummaryDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductSalesDAOImpl implements ProductSalesDAO {
    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<ProductSalesDTO> selectProductSalesList(Map<String, String> params) {
        return sqlSession.selectList("org.myweb.first.report.model.dao.ProductSalesDAO.selectProductSalesList", params);
    }

    @Override
    public ProductSalesSummaryDTO selectProductSalesSummary(Map<String, String> params) {
        return sqlSession.selectOne("org.myweb.first.report.model.dao.ProductSalesDAO.selectProductSalesSummary", params);
    }
} 