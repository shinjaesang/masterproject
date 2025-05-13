package org.myweb.first.report.model.service;

import org.myweb.first.report.model.dto.StockHistoryDTO;
import java.util.List;

public interface StockHistoryService {
    List<StockHistoryDTO> getStockHistoryByProductId(String productId);
} 