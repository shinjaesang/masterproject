package org.myweb.first.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.myweb.first.order.model.dto.Order;
import org.myweb.first.order.model.dto.OrderItem;
import org.myweb.first.order.model.service.OrderService;
import org.myweb.first.product.model.dto.Product;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/order")
public class OrderController {
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    
    @Autowired
    private OrderService orderService;
    
    // 주문 목록 페이지
    @GetMapping("/list.do")
    public String orderList(@RequestParam Map<String, Object> params, Model model) {
        try {
            List<Order> orders = orderService.getOrderList(params);
            
            // 주문 건수 계산
            int orderCount = orders.size();
            
            // 총 판매금액 계산
            int totalPrice = 0;
            for (Order order : orders) {
                if (order.getItems() != null) {
                    for (OrderItem item : order.getItems()) {
                        if (item.getSellingPrice() != null && item.getQuantity() != null) {
                            totalPrice += item.getSellingPrice() * item.getQuantity();
                        }
                    }
                }
            }
            
            model.addAttribute("orderList", orders);
            model.addAttribute("orderCount", orderCount);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("params", params); // 검색 조건 유지를 위해 파라미터 추가
            
            return "order/orders";
        } catch (Exception e) {
            logger.error("주문 목록 조회 중 오류 발생", e);
            model.addAttribute("error", "주문 목록을 불러오는 중 오류가 발생했습니다.");
            return "common/error";
        }
    }
    
    // 주문 등록 페이지
    @GetMapping("/register.do")
    public String orderRegisterForm(Model model) {
        try {
            // 거래처 목록 조회
            List<Map<String, Object>> partnerList = orderService.getPartnerList();
            model.addAttribute("partnerList", partnerList);
            
            return "order/orderregister";
        } catch (Exception e) {
            logger.error("주문 등록 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "페이지 로드 중 오류가 발생했습니다.");
            return "common/error";
        }
    }
    
    // 주문 등록 처리
    @PostMapping("/registerOrder.do")
    @ResponseBody
    public Map<String, Object> registerOrder(@RequestBody Order order) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 필수 입력값 검증
            if (order.getOrderType() == null || order.getOrderType().trim().isEmpty()) {
                result.put("status", "error");
                result.put("message", "주문 유형은 필수입니다.");
                return result;
            }
            if (order.getPartnerId() == null || order.getPartnerId().trim().isEmpty()) {
                result.put("status", "error");
                result.put("message", "거래처는 필수입니다.");
                return result;
            }
            if (order.getItems() == null || order.getItems().isEmpty()) {
                result.put("status", "error");
                result.put("message", "최소 하나 이상의 상품이 필요합니다.");
                return result;
            }

            // 주문 상태 초기값 설정
            order.setOrderStatus("접수");
            
            // 주문 등록 처리
            int registerResult = orderService.registerOrder(order);
            
            if (registerResult > 0) {
                result.put("status", "success");
                result.put("message", "주문이 성공적으로 등록되었습니다.");
            } else {
                result.put("status", "error");
                result.put("message", "주문 등록에 실패했습니다.");
            }
        } catch (Exception e) {
            logger.error("주문 등록 중 오류 발생", e);
            result.put("status", "error");
            result.put("message", "주문 등록 중 오류가 발생했습니다.");
        }
        return result;
    }
    
    // 주문 수정 페이지
    @GetMapping("/update.do")
    public String orderUpdateForm(@RequestParam("orderId") String orderId, Model model) {
        try {
            // 주문 정보 조회
            Order order = orderService.getOrderById(orderId);
            if (order == null) {
                model.addAttribute("error", "주문을 찾을 수 없습니다.");
                return "common/error";
            }
            
            // 거래처 목록 조회
            List<Map<String, Object>> partnerList = orderService.getPartnerList();
            
            model.addAttribute("order", order);
            model.addAttribute("partnerList", partnerList);
            
            return "order/orderupdate";
        } catch (Exception e) {
            logger.error("주문 수정 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "페이지 로드 중 오류가 발생했습니다.");
            return "common/error";
        }
    }
    
    
    
    @PostMapping("/updateOrder.do")
    @ResponseBody
    public Map<String, Object> updateOrder(@RequestBody Order order) {
        Map<String, Object> result = new HashMap<>();
        try {
            System.out.println("orderId: " + order.getOrderId());
            System.out.println("items: " + order.getItems());
            int updateResult = orderService.modifyOrder(order);
            if (updateResult > 0) {
                result.put("status", "success");
                result.put("message", "주문이 수정되었습니다.");
            } else {
                result.put("status", "error");
                result.put("message", "주문 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace(); // 또는 logger.error("주문 수정 오류", e);
            result.put("status", "error");
            result.put("message", "주문 수정 중 오류가 발생했습니다.");
        }
        return result;
    }
    
	
	/*
	 * @PostMapping("/updateOrder.do")
	 * 
	 * @ResponseBody public Map<String, Object> updateOrder(@RequestBody Order
	 * order) { Map<String, Object> result = new HashMap<>(); try { int updateResult
	 * = orderService.modifyOrder(order); if (updateResult > 0) {
	 * result.put("status", "success"); result.put("message", "주문이 수정되었습니다."); }
	 * else { result.put("status", "error"); result.put("message",
	 * "주문 수정에 실패했습니다."); } } catch (Exception e) { result.put("status", "error");
	 * result.put("message", "주문 수정 중 오류가 발생했습니다."); } return result; }
	 */
	 
    
	/*
	 * // 주문 수정 처리
	 * 
	 * @PostMapping("/updateOrder.do")
	 * 
	 * @ResponseBody public String orderUpdate(@ModelAttribute Order order) { try {
	 * int result = orderService.modifyOrder(order); if (result > 0) { return
	 * "redirect:/order/list.do"; } else { return
	 * "redirect:/order/update.do?orderId=" + order.getOrderId(); } } catch
	 * (Exception e) { logger.error("주문 수정 중 오류 발생", e); return
	 * "redirect:/order/update.do?orderId=" + order.getOrderId(); } }
	 */
    
    // 주문 삭제 처리
    @PostMapping("/deleteOrder.do")
    @ResponseBody
    public Map<String, Object> deleteOrder(@RequestParam("orderId") String orderId) {
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
            @RequestParam("orderId") String orderId,
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
    
    // 상품 정보 조회 API
    @GetMapping("/product-info.do")
    @ResponseBody
    public Map<String, Object> getProductInfo(@RequestParam("productId") String productId) {
        Map<String, Object> result = new HashMap<>();
        try {
            Product productInfo = orderService.getProductInfo(productId);
            if (productInfo != null) {
                result.put("status", "success");
                result.put("productId", productInfo.getProductId());
                result.put("productName", productInfo.getProductName());
                result.put("optionValue", productInfo.getOptionValue());
                result.put("costPrice", productInfo.getCostPrice());
                result.put("sellingPrice", productInfo.getSellingPrice());
            } else {
                result.put("status", "error");
                result.put("message", "상품을 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            result.put("status", "error");
            result.put("message", "상품 정보 조회 중 오류가 발생했습니다.");
            logger.error("상품 정보 조회 오류", e);
        }
        return result;
    }

    // 선택된 주문 일괄 삭제
    @PostMapping("/deleteSelectedOrders.do")
    @ResponseBody
    public Map<String, Object> deleteSelectedOrders(@RequestParam("orderIds") List<String> orderIds) {
        Map<String, Object> result = new HashMap<>();
        try {
            int deleteResult = orderService.deleteSelectedOrders(orderIds);
            result.put("success", deleteResult > 0);
            result.put("message", deleteResult > 0 ? "선택한 주문이 삭제되었습니다." : "주문 삭제에 실패했습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "주문 삭제 중 오류가 발생했습니다.");
            logger.error("주문 일괄 삭제 오류", e);
        }
        return result;
    }

    // 주문 상세 페이지
    @GetMapping("/detail.do")
    public String orderDetail(@RequestParam("orderId") String orderId, Model model) {
        try {
            Order order = orderService.getOrderById(orderId);
            if (order == null) {
                model.addAttribute("error", "주문을 찾을 수 없습니다.");
                return "common/error";
            }
            model.addAttribute("order", order);
            return "order/orderdetail";
        } catch (Exception e) {
            logger.error("주문 상세 조회 중 오류 발생", e);
            model.addAttribute("error", "주문 상세 정보를 불러오는 중 오류가 발생했습니다.");
            return "common/error";
        }
    }
} 