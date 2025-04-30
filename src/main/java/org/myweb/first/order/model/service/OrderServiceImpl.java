package org.myweb.first.order.model.service;

import java.util.List;
import java.util.Map;
import org.myweb.first.order.model.dao.OrderDao;
import org.myweb.first.order.model.dto.Order;
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
    public Order getOrderById(Long orderId) {
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
    public int removeOrder(Long orderId) {
        return orderDao.deleteOrder(orderId);
    }
    
    @Override
    @Transactional
    public int changeOrderStatus(Long orderId, String stockStatus) {
        return orderDao.updateOrderStatus(orderId, stockStatus);
    }
    
    @Override
    public int getOrderCount(Map<String, Object> params) {
        return orderDao.selectOrderCount(params);
    }
}
