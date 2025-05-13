package org.myweb.first.report.inoutstat.model.dto;

import java.util.List;

public class InoutStatChartDTO {
    private List<String> labels;         // 날짜 라벨
    private List<Integer> inData;        // 입고량 데이터
    private List<Integer> outData;       // 출고량 데이터
    private List<Integer> stockData;     // 재고량 데이터

    // Getters and Setters
    public List<String> getLabels() {
        return labels;
    }

    public void setLabels(List<String> labels) {
        this.labels = labels;
    }

    public List<Integer> getInData() {
        return inData;
    }

    public void setInData(List<Integer> inData) {
        this.inData = inData;
    }

    public List<Integer> getOutData() {
        return outData;
    }

    public void setOutData(List<Integer> outData) {
        this.outData = outData;
    }

    public List<Integer> getStockData() {
        return stockData;
    }

    public void setStockData(List<Integer> stockData) {
        this.stockData = stockData;
    }
} 