package org.myweb.first.report.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.report.model.dto.WarehouseStockChartDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class WarehouseStockChartDaoImpl implements WarehouseStockChartDao {
    private final SqlSession sqlSession;

    @Autowired
    public WarehouseStockChartDaoImpl(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public List<WarehouseStockChartDto> selectWarehouseStockChart(Map<String, Object> params) {
        return sqlSession.selectList("warehouseStockChartMapper.selectWarehouseStockChart", params);
    }
} 