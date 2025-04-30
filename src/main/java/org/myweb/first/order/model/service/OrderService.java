package org.myweb.first.order.model.service;

import java.util.List;
import java.util.Map;
import org.myweb.first.order.model.dto.Order;

public interface OrderService {
    // 주문 목록 조회 (필터링 포함)
    List<Order> getOrderList(Map<String, Object> params);
    
    // 주문 상세 조회
    Order getOrderById(Long orderId);
    
    // 주문 등록
    int registerOrder(Order order);
    
    // 주문 수정
    int modifyOrder(Order order);
    
    // 주문 삭제
    int removeOrder(Long orderId);
    
    // 주문 상태 변경
    int changeOrderStatus(Long orderId, String stockStatus);
    
    // 주문 수량 조회
    int getOrderCount(Map<String, Object> params);
}
