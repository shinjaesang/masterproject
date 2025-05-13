package org.myweb.first.report.model.dto;

public class ProductSalesSummaryDTO {
    private int totalOrderCount;
    private int totalSalesAmount;
    private int totalPurchaseAmount;
    private int totalSalesCount;
    private int totalPurchaseCount;
    private int totalProductCost;
    private int totalMarginAmount;
    private double averageMarginRate;
    private double averagePurchaseRate;
    private int totalProductCount;
    // getter/setter
    public int getTotalSalesAmount() { return totalSalesAmount; }
    public void setTotalSalesAmount(int totalSalesAmount) { this.totalSalesAmount = totalSalesAmount; }
    public int getTotalPurchaseAmount() { return totalPurchaseAmount; }
    public void setTotalPurchaseAmount(int totalPurchaseAmount) { this.totalPurchaseAmount = totalPurchaseAmount; }
    public int getTotalSalesCount() { return totalSalesCount; }
    public void setTotalSalesCount(int totalSalesCount) { this.totalSalesCount = totalSalesCount; }
    public int getTotalPurchaseCount() { return totalPurchaseCount; }
    public void setTotalPurchaseCount(int totalPurchaseCount) { this.totalPurchaseCount = totalPurchaseCount; }
    public double getAverageMarginRate() { return averageMarginRate; }
    public void setAverageMarginRate(double averageMarginRate) { this.averageMarginRate = averageMarginRate; }
    public double getAveragePurchaseRate() { return averagePurchaseRate; }
    public void setAveragePurchaseRate(double averagePurchaseRate) { this.averagePurchaseRate = averagePurchaseRate; }
} 