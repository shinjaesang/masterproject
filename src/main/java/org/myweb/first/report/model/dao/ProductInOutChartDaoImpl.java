package org.myweb.first.report.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.report.model.dto.ProductInOutChartDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ProductInOutChartDaoImpl implements ProductInOutChartDao {
    private final SqlSession sqlSession;

    @Autowired
    public ProductInOutChartDaoImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public List<ProductInOutChartDto> selectProductInOutChart(Map<String, Object> params) {
        return sqlSession.selectList("productInOutChartMapper.selectProductInOutChart", params);
    }
} 