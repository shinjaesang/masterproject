package org.myweb.first.report.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.report.model.dto.StockHistoryDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class StockHistoryDAOImpl implements StockHistoryDAO {
    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<StockHistoryDTO> selectStockHistoryByProductId(String productId) {
        return sqlSession.selectList("org.myweb.first.report.model.dao.StockHistoryDAO.selectStockHistoryByProductId", productId);
    }
} 