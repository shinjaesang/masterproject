package org.myweb.first.order.model.dao;

import java.util.List;
import java.util.Map;
import org.myweb.first.order.model.dto.Order;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.myweb.first.common.Paging;
import org.myweb.first.common.Search;
import org.myweb.first.product.model.dto.Product;

@Repository
public class OrderDao {
    
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    
    // 주문 목록 조회 (필터링 포함)
    public List<Order> selectOrderList(Map<String, Object> params) {
        return sqlSessionTemplate.selectList("orderMapper.selectOrderList", params);
    }
    
    // 주문 상세 조회
    public Order selectOrderById(String orderId) {
        return sqlSessionTemplate.selectOne("orderMapper.selectOrderById", orderId);
    }
    
    // 주문 등록
    public int insertOrder(Order order) {
        return sqlSessionTemplate.insert("orderMapper.insertOrder", order);
    }
    
    // 주문 수정
    public int updateOrder(Order order) {
        return sqlSessionTemplate.update("orderMapper.updateOrder", order);
    }
    
    // 주문 삭제
    public int deleteOrder(String orderId) {
        return sqlSessionTemplate.delete("orderMapper.deleteOrder", orderId);
    }
    
    // 주문 상태 변경
    public int updateOrderStatus(String orderId, String orderStatus) {
        Map<String, Object> params = Map.of("orderId", orderId, "orderStatus", orderStatus);
        return sqlSessionTemplate.update("orderMapper.updateOrderStatus", params);
    }
    
    // 주문 수량 조회
    public int selectOrderCount(Map<String, Object> params) {
        return sqlSessionTemplate.selectOne("orderMapper.selectOrderCount", params);
    }
    
    // 상품 정보 조회
    public Product selectProductInfo(String productId) {
        return sqlSessionTemplate.selectOne("orderMapper.selectProductInfo", productId);
    }
    
    // 거래처 목록 조회
    public List<Map<String, Object>> selectPartnerList() {
        return sqlSessionTemplate.selectList("orderMapper.selectPartnerList");
    }
    
    // 선택된 주문 일괄 삭제
    public int deleteSelectedOrders(List<String> orderIds) {
        return sqlSessionTemplate.delete("orderMapper.deleteSelectedOrders", orderIds);
    }
}
