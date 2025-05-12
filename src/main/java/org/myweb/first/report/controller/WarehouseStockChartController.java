package org.myweb.first.report.controller;

import org.myweb.first.report.model.dto.WarehouseStockChartDto;
import org.myweb.first.report.model.service.WarehouseStockChartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/report/inout")
public class WarehouseStockChartController {
    private final WarehouseStockChartService warehouseStockChartService;

    @Autowired
    public WarehouseStockChartController(WarehouseStockChartService warehouseStockChartService) {
        this.warehouseStockChartService = warehouseStockChartService;
    }

    @GetMapping("/warehouse-chart")
    public List<WarehouseStockChartDto> getWarehouseStockChart(
            @RequestParam(name = "date", required = false) String date
    ) {
        Map<String, Object> params = new HashMap<>();
        params.put("date", date);
        return warehouseStockChartService.getWarehouseStockChart(params);
    }
} 