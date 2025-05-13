package org.myweb.first.report.model.dao;

import org.myweb.first.report.model.dto.StockHistoryDTO;
import java.util.List;

public interface StockHistoryDAO {
    List<StockHistoryDTO> selectStockHistoryByProductId(String productId);
} 