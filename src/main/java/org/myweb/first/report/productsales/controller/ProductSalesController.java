package org.myweb.first.report.productsales.controller;

import org.myweb.first.report.productsales.model.dto.ProductSalesDTO;
import org.myweb.first.report.productsales.model.dto.ProductSalesSummaryDTO;
import org.myweb.first.report.productsales.model.service.ProductSalesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
public class ProductSalesController {

    @Autowired
    private ProductSalesService productSalesService;

    @GetMapping("/statistics/product-sales.do")
    public String getProductSalesStatistics(@RequestParam Map<String, String> params, Model model) {
        List<ProductSalesDTO> salesList = productSalesService.getProductSalesList(params);
        model.addAttribute("salesList", salesList);
        // 요약 정보 추가
        ProductSalesSummaryDTO summary = productSalesService.getProductSalesSummary(params);
        model.addAttribute("totalSalesAmount", summary.getTotalSalesAmount());
        model.addAttribute("totalPurchaseAmount", summary.getTotalPurchaseAmount());
        model.addAttribute("totalSalesCount", summary.getTotalSalesCount());
        model.addAttribute("totalPurchaseCount", summary.getTotalPurchaseCount());
        model.addAttribute("averageMarginRate", summary.getAverageMarginRate());
        model.addAttribute("averagePurchaseRate", summary.getAveragePurchaseRate());
        return "report/product-sales";
    }
} 