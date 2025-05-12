package org.myweb.first.report.model.service;

import org.myweb.first.report.model.dao.ProductInOutChartDao;
import org.myweb.first.report.model.dto.ProductInOutChartDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ProductInOutChartServiceImpl implements ProductInOutChartService {
    private final ProductInOutChartDao productInOutChartDao;

    @Autowired
    public ProductInOutChartServiceImpl(ProductInOutChartDao productInOutChartDao) {
        this.productInOutChartDao = productInOutChartDao;
    }

    @Override
    public List<ProductInOutChartDto> getProductInOutChart(Map<String, Object> params) {
        return productInOutChartDao.selectProductInOutChart(params);
    }
} 