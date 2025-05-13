package org.myweb.first.report.productsales.model.dao;

import java.util.List;
import java.util.Map;

import org.myweb.first.report.productsales.model.dto.ProductSalesDTO;
import org.myweb.first.report.productsales.model.dto.ProductSalesSummaryDTO;

public interface ProductSalesDAO {
    List<ProductSalesDTO> selectProductSalesList(Map<String, String> params);
    ProductSalesSummaryDTO selectProductSalesSummary(Map<String, String> params);
    // 합계, 요약 등 필요한 메서드 추가 가능
} 