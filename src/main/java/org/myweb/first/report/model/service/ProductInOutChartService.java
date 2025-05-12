package org.myweb.first.report.model.service;

import org.myweb.first.report.model.dto.ProductInOutChartDto;
import java.util.List;
import java.util.Map;

public interface ProductInOutChartService {
    List<ProductInOutChartDto> getProductInOutChart(Map<String, Object> params);
} 