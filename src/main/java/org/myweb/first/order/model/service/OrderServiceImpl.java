package org.myweb.first.order.model.service;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import org.myweb.first.order.model.dao.OrderDao;
import org.myweb.first.order.model.dto.Order;
import org.myweb.first.order.model.dto.OrderItem;
import org.myweb.first.product.model.dto.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderServiceImpl implements OrderService {
    
    @Autowired
    private OrderDao orderDao;
    
    @Override
    public List<Order> getOrderList(Map<String, Object> params) {
        return orderDao.selectOrderList(params);
    }
    
    @Override
    public List<Order> getAllOrders() {
        return orderDao.selectAllOrders();
    }
    
    @Override
    public Order getOrderById(String orderId) {
        return orderDao.selectOrderById(orderId);
    }
    
    @Override
    @Transactional
    public int registerOrder(Order order) {
        try {
            // 주문 기본 정보 등록
            int result = orderDao.insertOrder(order);
            
            if (result > 0 && order.getItems() != null && !order.getItems().isEmpty()) {
                for (OrderItem item : order.getItems()) {
                    // 상품 정보 조회
                    Product product = orderDao.selectProductInfo(item.getProductId());
                    if (product == null) {
                        throw new IllegalArgumentException("상품 정보를 찾을 수 없습니다: " + item.getProductId());
                    }

                    // 주문 항목 정보 세팅
                    item.setOrderId(order.getOrderId());
                    item.setProductName(product.getProductName());
                    item.setOptionValue(product.getOptionValue());
                    item.setCostPrice(product.getCostPrice() != null ? product.getCostPrice().intValue() : null);
                    item.setSellingPrice(product.getSellingPrice() != null ? product.getSellingPrice().intValue() : null);
                    
                    // 주문 항목 등록
                    result = orderDao.insertOrderItem(item);
                    if (result <= 0) {
                        throw new RuntimeException("주문 항목 등록 실패");
                    }
                }
            }
            return result;
        } catch (Exception e) {
            throw new RuntimeException("주문 등록 중 오류 발생: " + e.getMessage(), e);
        }
    }
    
    @Override
    @Transactional
    public int modifyOrder(Order order) {
        // 1. 주문 정보 수정
        int result = orderDao.updateOrder(order);

        // 2. 기존 주문 항목 전체 삭제
        orderDao.deleteOrderItemsByOrderId(order.getOrderId());

        // 3. 새 주문 항목 등록
        if (order.getItems() != null) {
            for (OrderItem item : order.getItems()) {
                item.setOrderId(order.getOrderId());
                orderDao.insertOrderItem(item);
            }
        }
        return result;
    }
    
    @Override
    @Transactional
    public int removeOrder(String orderId) {
        return orderDao.deleteOrder(orderId);
    }
    
    @Override
    @Transactional
    public int changeOrderStatus(String orderId, String orderStatus) {
        return orderDao.updateOrderStatus(orderId, orderStatus);
    }
    
    @Override
    public int getOrderCount(Map<String, Object> params) {
        return orderDao.selectOrderCount(params);
    }
    
    @Override
    public Product getProductInfo(String productId) {
        return orderDao.selectProductInfo(productId);
    }
    
    @Override
    public List<Map<String, Object>> getPartnerList() {
        return orderDao.selectPartnerList();
    }
    
    @Override
    @Transactional
    public int deleteSelectedOrders(List<String> orderIds) {
        return orderDao.deleteSelectedOrders(orderIds);
    }
}
