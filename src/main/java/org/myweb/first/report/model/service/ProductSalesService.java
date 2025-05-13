package org.myweb.first.report.model.service;

import org.myweb.first.report.model.dto.ProductSalesDTO;
import org.myweb.first.report.model.dto.ProductSalesSummaryDTO;
import java.util.List;
import java.util.Map;

public interface ProductSalesService {
    List<ProductSalesDTO> getProductSalesList(Map<String, String> params);
    ProductSalesSummaryDTO getProductSalesSummary(Map<String, String> params);
    // 합계, 요약 등 필요한 메서드 추가 가능
} 