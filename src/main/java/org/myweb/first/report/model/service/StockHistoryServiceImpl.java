package org.myweb.first.report.model.service;

import org.myweb.first.report.model.dao.StockHistoryDAO;
import org.myweb.first.report.model.dto.StockHistoryDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StockHistoryServiceImpl implements StockHistoryService {
    @Autowired
    private StockHistoryDAO stockHistoryDAO;

    @Override
    public List<StockHistoryDTO> getStockHistoryByProductId(String productId) {
        return stockHistoryDAO.selectStockHistoryByProductId(productId);
    }
} 