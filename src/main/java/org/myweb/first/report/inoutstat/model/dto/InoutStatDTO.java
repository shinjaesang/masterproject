package org.myweb.first.report.inoutstat.model.dto;

public class InoutStatDTO {
    private String stat_date;        // 날짜
    private int inAmount;            // 입고량
    private int outAmount;           // 출고량
    private int stockAmount;         // 재고량
    private double rate;             // 증감률

    // Getters and Setters
    public String getStat_date() {
        return stat_date;
    }

    public void setStat_date(String stat_date) {
        this.stat_date = stat_date;
    }

    public int getInAmount() {
        return inAmount;
    }

    public void setInAmount(int inAmount) {
        this.inAmount = inAmount;
    }

    public int getOutAmount() {
        return outAmount;
    }

    public void setOutAmount(int outAmount) {
        this.outAmount = outAmount;
    }

    public int getStockAmount() {
        return stockAmount;
    }

    public void setStockAmount(int stockAmount) {
        this.stockAmount = stockAmount;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }
} 