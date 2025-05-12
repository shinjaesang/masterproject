package org.myweb.first.inventory.model.dto;

public class Inventory {
    private String productId;
    private String productName;
    private String productType;
    private String partnerName;
    private String partnerId;
    private String optionValue;
    private String imagePath;
    private int headOfficeStock;
    private int busanStock;
    private int incheonStock;
    private int daeguStock;
    private int gwangjuStock;
    private int transitStock;
    private int defectiveStock;
    private int totalStock;
    private int availableStock;
    private int safeStock;
    private int costPrice;
    private int sellingPrice;

    // Getters
    public String getProductId() { return productId; }
    public String getProductName() { return productName; }
    public String getProductType() { return productType; }
    public String getPartnerName() { return partnerName; }
    public String getPartnerId() { return partnerId; }
    public String getOptionValue() { return optionValue; }
    public String getImagePath() { return imagePath; }
    public int getHeadOfficeStock() { return headOfficeStock; }
    public int getBusanStock() { return busanStock; }
    public int getIncheonStock() { return incheonStock; }
    public int getDaeguStock() { return daeguStock; }
    public int getGwangjuStock() { return gwangjuStock; }
    public int getTransitStock() { return transitStock; }
    public int getDefectiveStock() { return defectiveStock; }
    public int getTotalStock() { return totalStock; }
    public int getAvailableStock() { return availableStock; }
    public int getSafeStock() { return safeStock; }
    public int getCostPrice() { return costPrice; }
    public int getSellingPrice() { return sellingPrice; }

    // Setters
    public void setProductId(String productId) { this.productId = productId; }
    public void setProductName(String productName) { this.productName = productName; }
    public void setProductType(String productType) { this.productType = productType; }
    public void setPartnerName(String partnerName) { this.partnerName = partnerName; }
    public void setPartnerId(String partnerId) { this.partnerId = partnerId; }
    public void setOptionValue(String optionValue) { this.optionValue = optionValue; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    public void setHeadOfficeStock(int headOfficeStock) { this.headOfficeStock = headOfficeStock; }
    public void setBusanStock(int busanStock) { this.busanStock = busanStock; }
    public void setIncheonStock(int incheonStock) { this.incheonStock = incheonStock; }
    public void setDaeguStock(int daeguStock) { this.daeguStock = daeguStock; }
    public void setGwangjuStock(int gwangjuStock) { this.gwangjuStock = gwangjuStock; }
    public void setTransitStock(int transitStock) { this.transitStock = transitStock; }
    public void setDefectiveStock(int defectiveStock) { this.defectiveStock = defectiveStock; }
    public void setTotalStock(int totalStock) { this.totalStock = totalStock; }
    public void setAvailableStock(int availableStock) { this.availableStock = availableStock; }
    public void setSafeStock(int safeStock) { this.safeStock = safeStock; }
    public void setCostPrice(int costPrice) { this.costPrice = costPrice; }
    public void setSellingPrice(int sellingPrice) { this.sellingPrice = sellingPrice; }
} 