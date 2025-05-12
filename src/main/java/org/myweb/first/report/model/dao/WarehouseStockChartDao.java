package org.myweb.first.report.model.dao;

import org.myweb.first.report.model.dto.WarehouseStockChartDto;
import java.util.List;
import java.util.Map;

public interface WarehouseStockChartDao {
    List<WarehouseStockChartDto> selectWarehouseStockChart(Map<String, Object> params);
} 