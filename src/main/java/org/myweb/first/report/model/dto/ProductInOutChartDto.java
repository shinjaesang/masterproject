package org.myweb.first.report.model.dto;

import java.io.Serializable;

public class ProductInOutChartDto implements Serializable {
    private static final long serialVersionUID = 1L;

    private String productName;
    private int inAmount;
    private int outAmount;

    public ProductInOutChartDto() {}

    public ProductInOutChartDto(String productName, int inAmount, int outAmount) {
        this.productName = productName;
        this.inAmount = inAmount;
        this.outAmount = outAmount;
    }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public int getInAmount() { return inAmount; }
    public void setInAmount(int inAmount) { this.inAmount = inAmount; }

    public int getOutAmount() { return outAmount; }
    public void setOutAmount(int outAmount) { this.outAmount = outAmount; }
} 