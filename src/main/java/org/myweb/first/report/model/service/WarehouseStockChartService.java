package org.myweb.first.report.model.service;

import org.myweb.first.report.model.dto.WarehouseStockChartDto;
import java.util.List;
import java.util.Map;

public interface WarehouseStockChartService {
    List<WarehouseStockChartDto> getWarehouseStockChart(Map<String, Object> params);
} 