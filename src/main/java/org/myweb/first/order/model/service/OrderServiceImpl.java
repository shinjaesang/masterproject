package org.myweb.first.order.model.service;

import java.util.List;
import java.util.Map;
import org.myweb.first.order.model.dao.OrderDao;
import org.myweb.first.order.model.dto.Order;
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
    public Order getOrderById(String orderId) {
        return orderDao.selectOrderById(orderId);
    }
    
    @Override
    @Transactional
    public int registerOrder(Order order) {
        return orderDao.insertOrder(order);
    }
    
    @Override
    @Transactional
    public int modifyOrder(Order order) {
        return orderDao.updateOrder(order);
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
