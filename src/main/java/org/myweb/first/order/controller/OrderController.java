package org.myweb.first.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.myweb.first.order.model.dto.Order;
import org.myweb.first.order.model.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/order")
public class OrderController {
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    
    @Autowired
    private OrderService orderService;
    
    // 주문 목록 페이지
    @GetMapping("/list.do")
    public String orderList(
            @RequestParam(value = "orderId", required = false) String orderId,
            @RequestParam(value = "partnerName", required = false) String partnerName,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "productName", required = false) String productName,
            @RequestParam(value = "minPrice", required = false) Integer minPrice,
            @RequestParam(value = "maxPrice", required = false) Integer maxPrice,
            Model model) {
        
        Map<String, Object> params = new HashMap<>();
        params.put("orderId", orderId);
        params.put("partnerName", partnerName);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("productName", productName);
        params.put("minPrice", minPrice);
        params.put("maxPrice", maxPrice);
        
        List<Order> orderList = orderService.getOrderList(params);
        int orderCount = orderService.getOrderCount(params);
        
        model.addAttribute("orderList", orderList);
        model.addAttribute("orderCount", orderCount);
        model.addAttribute("params", params);
        
        return "order/orders";
    }
    
    // 주문 등록 페이지
    @GetMapping("/register.do")
    public String orderRegisterForm(Model model) {
        return "order/orderregister";
    }
    
    // 주문 등록 처리
    @PostMapping("/registerOrder.do")
    public String orderRegister(@ModelAttribute Order order) {
        int result = orderService.registerOrder(order);
        if (result > 0) {
            return "redirect:/order/list.do";
        } else {
            return "redirect:/order/register.do";
        }
    }
    
    // 주문 수정 페이지
    @GetMapping("/update.do")
    public String orderUpdateForm(@RequestParam("orderId") Long orderId, Model model) {
        Order order = orderService.getOrderById(orderId);
        model.addAttribute("order", order);
        return "order/orderupdate";
    }
    
    // 주문 수정 처리
    @PostMapping("/updateOrder.do")
    public String orderUpdate(@ModelAttribute Order order) {
        int result = orderService.modifyOrder(order);
        if (result > 0) {
            return "redirect:/order/list.do";
        } else {
            return "redirect:/order/update.do?orderId=" + order.getOrderId();
        }
    }
    
    // 주문 삭제 처리
    @PostMapping("/deleteOrder.do")
    @ResponseBody
    public Map<String, Object> deleteOrder(@RequestParam("orderId") Long orderId) {
        Map<String, Object> result = new HashMap<>();
        try {
            int deleteResult = orderService.removeOrder(orderId);
            result.put("success", deleteResult > 0);
            result.put("message", deleteResult > 0 ? "주문이 삭제되었습니다." : "주문 삭제에 실패했습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "주문 삭제 중 오류가 발생했습니다.");
            logger.error("주문 삭제 오류", e);
        }
        return result;
    }
    
    // 주문 상태 변경 처리
    @PostMapping("/changeStatus.do")
    @ResponseBody
    public Map<String, Object> changeOrderStatus(
            @RequestParam("orderId") Long orderId,
            @RequestParam("stockStatus") String stockStatus) {
        Map<String, Object> result = new HashMap<>();
        try {
            int updateResult = orderService.changeOrderStatus(orderId, stockStatus);
            result.put("success", updateResult > 0);
            result.put("message", updateResult > 0 ? "주문 상태가 변경되었습니다." : "주문 상태 변경에 실패했습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "주문 상태 변경 중 오류가 발생했습니다.");
            logger.error("주문 상태 변경 오류", e);
        }
        return result;
    }
} 