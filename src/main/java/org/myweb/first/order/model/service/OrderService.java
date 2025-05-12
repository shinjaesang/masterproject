package org.myweb.first.order.model.service;

import java.util.List;
import java.util.Map;
import org.myweb.first.order.model.dto.Order;
import org.myweb.first.product.model.dto.Product;

public interface OrderService {
    // 주문 목록 조회 (필터링 포함)
    List<Order> getOrderList(Map<String, Object> params);
    
    // 전체 주문 목록 조회
    List<Order> getAllOrders();
    
    // 주문 상세 조회
    Order getOrderById(String orderId);
    
    // 주문 등록
    int registerOrder(Order order);
    
    // 주문 수정
    int modifyOrder(Order order);
    
    // 주문 삭제
    int removeOrder(String orderId);
    
    // 주문 상태 변경
    int changeOrderStatus(String orderId, String orderStatus);
    
    // 주문 수량 조회
    int getOrderCount(Map<String, Object> params);
    
    // 상품 정보 조회
    Product getProductInfo(String productId);
    
    // 거래처 목록 조회
    List<Map<String, Object>> getPartnerList();
    
    // 선택된 주문 일괄 삭제
    int deleteSelectedOrders(List<String> orderIds);
}
