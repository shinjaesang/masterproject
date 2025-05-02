package org.myweb.first.product.model.dto;

import java.io.Serializable;
import java.util.Date;

public class Product implements Serializable {
    private String productId;
    private String partnerId;
    private String productName;
    private String optionValue;
    private String productType;
    private Double costPrice;
    private Double sellingPrice;
    private String manufacturer;
    private String countryOfOrigin;
    private String category;
    private Integer safeStock;
    private byte[] productImage;
    private Date createdAt;
    private Date updatedAt;
    private String partnerName;

    public Product() {}

    public String getProductId() { return productId; }
    public void setProductId(String productId) { this.productId = productId; }
    public String getPartnerId() { return partnerId; }
    public void setPartnerId(String partnerId) { this.partnerId = partnerId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getOptionValue() { return optionValue; }
    public void setOptionValue(String optionValue) { this.optionValue = optionValue; }
    public String getProductType() { return productType; }
    public void setProductType(String productType) { this.productType = productType; }
    public Double getCostPrice() { return costPrice; }
    public void setCostPrice(Double costPrice) { this.costPrice = costPrice; }
    public Double getSellingPrice() { return sellingPrice; }
    public void setSellingPrice(Double sellingPrice) { this.sellingPrice = sellingPrice; }
    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }
    public String getCountryOfOrigin() { return countryOfOrigin; }
    public void setCountryOfOrigin(String countryOfOrigin) { this.countryOfOrigin = countryOfOrigin; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public Integer getSafeStock() { return safeStock; }
    public void setSafeStock(Integer safeStock) { this.safeStock = safeStock; }
    public byte[] getProductImage() { return productImage; }
    public void setProductImage(byte[] productImage) { this.productImage = productImage; }
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
    public String getPartnerName() { return partnerName; }
    public void setPartnerName(String partnerName) { this.partnerName = partnerName; }
} 