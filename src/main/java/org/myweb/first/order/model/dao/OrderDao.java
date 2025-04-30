package org.myweb.first.order.model.dao;

import java.util.List;
import java.util.Map;
import org.myweb.first.order.model.dto.Order;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.myweb.first.common.Paging;
import org.myweb.first.common.Search;

@Repository
public class OrderDao {
    
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    
    // 주문 목록 조회 (필터링 포함)
    public List<Order> selectOrderList(Map<String, Object> params) {
        return sqlSessionTemplate.selectList("orderMapper.selectOrderList", params);
    }
    
    // 주문 상세 조회
    public Order selectOrderById(Long orderId) {
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
    public int deleteOrder(Long orderId) {
        return sqlSessionTemplate.delete("orderMapper.deleteOrder", orderId);
    }
    
    // 주문 상태 변경
    public int updateOrderStatus(Long orderId, String stockStatus) {
        Map<String, Object> params = Map.of("orderId", orderId, "stockStatus", stockStatus);
        return sqlSessionTemplate.update("orderMapper.updateOrderStatus", params);
    }
    
    // 주문 수량 조회
    public int selectOrderCount(Map<String, Object> params) {
        return sqlSessionTemplate.selectOne("orderMapper.selectOrderCount", params);
    }
}
