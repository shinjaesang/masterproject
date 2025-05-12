package org.myweb.first.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.myweb.first.product.model.dto.Product;
import org.myweb.first.product.model.dto.ProductSearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDao {
    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "productMapper.";

    // 상품 전체 목록 조회
    public List<Product> selectAllProducts() {
        return sqlSession.selectList(NAMESPACE + "selectAllProducts");
    }

    // 상품 상세 조회
    public Product selectProductById(String productId) {
        return sqlSession.selectOne(NAMESPACE + "selectProductById", productId);
    }

    // 상품 등록
    public int insertProduct(Product product) {
        return sqlSession.insert(NAMESPACE + "insertProduct", product);
    }

    // 상품 수정
    public int updateProduct(Product product) {
        return sqlSession.update(NAMESPACE + "updateProduct", product);
    }

    // 상품 삭제
    public int deleteProduct(String productId) {
        return sqlSession.delete(NAMESPACE + "deleteProduct", productId);
    }

    // 검색 조건에 따른 상품 목록 조회
    public List<Product> searchProducts(ProductSearchCondition cond) {
        return sqlSession.selectList(NAMESPACE + "searchProducts", cond);
    }

    public byte[] selectProductImage(String productId) {
        return sqlSession.selectOne(NAMESPACE + "selectProductImage", productId);
    }
} 