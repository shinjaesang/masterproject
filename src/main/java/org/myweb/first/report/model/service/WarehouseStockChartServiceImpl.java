package org.myweb.first.report.model.service;

import org.myweb.first.report.model.dao.WarehouseStockChartDao;
import org.myweb.first.report.model.dto.WarehouseStockChartDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class WarehouseStockChartServiceImpl implements WarehouseStockChartService {
    private final WarehouseStockChartDao warehouseStockChartDao;

    @Autowired
    public WarehouseStockChartServiceImpl(WarehouseStockChartDao warehouseStockChartDao) {
        this.warehouseStockChartDao = warehouseStockChartDao;
    }

    @Override
    public List<WarehouseStockChartDto> getWarehouseStockChart(Map<String, Object> params) {
        return warehouseStockChartDao.selectWarehouseStockChart(params);
    }
} 