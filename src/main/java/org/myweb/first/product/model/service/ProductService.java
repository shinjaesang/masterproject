package org.myweb.first.product.model.service;

import java.util.List;
import org.myweb.first.product.model.dto.Product;
import org.myweb.first.product.model.dto.ProductSearchCondition;

public interface ProductService {
    List<Product> selectAllProducts();
    Product selectProductById(String productId);
    int insertProduct(Product product);
    int updateProduct(Product product);
    int deleteProduct(String productId);
    List<Product> searchProducts(ProductSearchCondition cond);
    byte[] getProductImage(String productId);
} 