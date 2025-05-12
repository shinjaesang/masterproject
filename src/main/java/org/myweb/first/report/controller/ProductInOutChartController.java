package org.myweb.first.report.controller;

import org.myweb.first.report.model.dto.ProductInOutChartDto;
import org.myweb.first.report.model.service.ProductInOutChartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/report/inout")
public class ProductInOutChartController {
    private final ProductInOutChartService productInOutChartService;

    @Autowired
    public ProductInOutChartController(ProductInOutChartService productInOutChartService) {
        this.productInOutChartService = productInOutChartService;
    }

    @GetMapping("/product-chart")
    public List<ProductInOutChartDto> getProductInOutChart(
            @RequestParam(name = "startDate", required = false) String startDate,
            @RequestParam(name = "endDate", required = false) String endDate,
            @RequestParam(name = "warehouse", required = false) String warehouse,
            @RequestParam(name = "category", required = false) String category
    ) {
        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("warehouse", warehouse);
        params.put("category", category);
        return productInOutChartService.getProductInOutChart(params);
    }
} 