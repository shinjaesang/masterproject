package org.myweb.first.product.model.service;

import java.util.List;

import org.myweb.first.product.model.dao.ProductDao;
import org.myweb.first.product.model.dto.Product;
import org.myweb.first.product.model.dto.ProductSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Override
    public List<Product> selectAllProducts() {
        return productDao.selectAllProducts();
    }

    @Override
    public Product selectProductById(String productId) {
        return productDao.selectProductById(productId);
    }

    @Override
    public int insertProduct(Product product) {
        return productDao.insertProduct(product);
    }

    @Override
    public int updateProduct(Product product) {
        return productDao.updateProduct(product);
    }

    @Override
    public int deleteProduct(String productId) {
        return productDao.deleteProduct(productId);
    }

    @Override
    public List<Product> searchProducts(ProductSearchCondition cond) {
        return productDao.searchProducts(cond);
    }
} 