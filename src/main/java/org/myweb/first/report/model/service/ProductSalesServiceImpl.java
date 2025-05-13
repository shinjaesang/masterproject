package org.myweb.first.report.model.service;

import org.myweb.first.report.model.dao.ProductSalesDAO;
import org.myweb.first.report.model.dto.ProductSalesDTO;
import org.myweb.first.report.model.dto.ProductSalesSummaryDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ProductSalesServiceImpl implements ProductSalesService {

    @Autowired
    private ProductSalesDAO productSalesDAO;

    @Override
    public List<ProductSalesDTO> getProductSalesList(Map<String, String> params) {
        return productSalesDAO.selectProductSalesList(params);
    }

    public ProductSalesSummaryDTO getProductSalesSummary(Map<String, String> params) {
        return productSalesDAO.selectProductSalesSummary(params);
    }
} 