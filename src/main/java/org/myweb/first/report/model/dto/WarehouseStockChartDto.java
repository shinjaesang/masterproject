package org.myweb.first.report.model.dto;

import java.io.Serializable;

public class WarehouseStockChartDto implements Serializable {
    private static final long serialVersionUID = 1L;

    private String warehouseName;
    private int stockAmount;

    public WarehouseStockChartDto() {}

    public WarehouseStockChartDto(String warehouseName, int stockAmount) {
        this.warehouseName = warehouseName;
        this.stockAmount = stockAmount;
    }

    public String getWarehouseName() { return warehouseName; }
    public void setWarehouseName(String warehouseName) { this.warehouseName = warehouseName; }

    public int getStockAmount() { return stockAmount; }
    public void setStockAmount(int stockAmount) { this.stockAmount = stockAmount; }
} 