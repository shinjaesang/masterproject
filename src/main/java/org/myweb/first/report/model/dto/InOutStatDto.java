package org.myweb.first.report.model.dto;

import java.io.Serializable;

public class InOutStatDto implements Serializable {
    private static final long serialVersionUID = 1L;

    private String date;        // 날짜 (yyyy-MM-dd)
    private int inAmount;       // 입고량
    private int outAmount;      // 출고량
    private int stockAmount;    // 재고량
    private String rate;        // 증감률(%)

    public InOutStatDto() {}

    public InOutStatDto(String date, int inAmount, int outAmount, int stockAmount, String rate) {
        this.date = date;
        this.inAmount = inAmount;
        this.outAmount = outAmount;
        this.stockAmount = stockAmount;
        this.rate = rate;
    }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public int getInAmount() { return inAmount; }
    public void setInAmount(int inAmount) { this.inAmount = inAmount; }

    public int getOutAmount() { return outAmount; }
    public void setOutAmount(int outAmount) { this.outAmount = outAmount; }

    public int getStockAmount() { return stockAmount; }
    public void setStockAmount(int stockAmount) { this.stockAmount = stockAmount; }

    public String getRate() { return rate; }
    public void setRate(String rate) { this.rate = rate; }
} 