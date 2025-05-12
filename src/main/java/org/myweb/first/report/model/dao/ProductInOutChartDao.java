package org.myweb.first.report.model.dao;

import org.myweb.first.report.model.dto.ProductInOutChartDto;
import java.util.List;
import java.util.Map;

public interface ProductInOutChartDao {
    List<ProductInOutChartDto> selectProductInOutChart(Map<String, Object> params);
} 