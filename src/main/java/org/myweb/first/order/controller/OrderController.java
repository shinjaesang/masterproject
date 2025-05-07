package org.myweb.first.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.myweb.first.order.model.dto.Order;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.databind.ObjectMapper;

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
            @RequestParam(value = "partnerId", required = false) String partnerId,
            @RequestParam(value = "partnerName", required = false) String partnerName,
            @RequestParam(value = "orderType", required = false) String orderType,
            @RequestParam(value = "orderStatus", required = false) String orderStatus,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "productName", required = false) String productName,
            @RequestParam(value = "minPrice", required = false) Integer minPrice,
            @RequestParam(value = "maxPrice", required = false) Integer maxPrice,
            Model model) {
        
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("orderId", orderId);
            params.put("partnerId", partnerId);
            params.put("partnerName", partnerName);
            params.put("orderType", orderType);
            params.put("orderStatus", orderStatus);
            params.put("startDate", startDate);
            params.put("endDate", endDate);
            params.put("productName", productName);
            params.put("minPrice", minPrice);
            params.put("maxPrice", maxPrice);
            
            List<Order> orderList = orderService.getOrderList(params);
            int orderCount = orderService.getOrderCount(params);
            
            // 총 판매금액 계산
            double totalPrice = orderList.stream()
                .mapToDouble(order -> order.getSellingPrice() * order.getQuantity())
                .sum();
            
            model.addAttribute("orderList", orderList);
            model.addAttribute("orderCount", orderCount);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("params", params);
            
            // 사용자 권한 정보 추가
            model.addAttribute("user", new HashMap<String, Object>() {{
                put("hasPriceViewPermission", true); // 실제로는 세션에서 권한 정보를 가져와야 함
            }});
            
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
            
            // 디버깅을 위한 로그 출력
            logger.info("거래처 목록: {}", partnerList);
            
            return "order/orderregister";
        } catch (Exception e) {
            logger.error("주문 등록 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "페이지 로드 중 오류가 발생했습니다.");
            return "common/error";
        }
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
            
            // 디버깅을 위한 로그 출력
            logger.info("주문 정보: {}", order);
            logger.info("거래처 목록: {}", partnerList);
            
            // JSON 변환을 위한 데이터 추가
            ObjectMapper mapper = new ObjectMapper();
            String orderJson = mapper.writeValueAsString(order);
            String partnerListJson = mapper.writeValueAsString(partnerList);
            
            model.addAttribute("order", order);
            model.addAttribute("partnerList", partnerList);
            model.addAttribute("orderJson", orderJson);
            model.addAttribute("partnerListJson", partnerListJson);
            
            return "order/orderupdate";
        } catch (Exception e) {
            logger.error("주문 수정 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "페이지 로드 중 오류가 발생했습니다.");
            return "common/error";
        }
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
            System.out.println("전달받은 productId: " + productId); // 로그 추가
            // 상품 정보 조회
            Product productInfo = orderService.getProductInfo(productId);
            // 디버깅을 위한 로그 출력
            logger.info("상품 정보: {}", productInfo);
            if (productInfo != null) {
                result.put("success", true);
                result.put("productId", productInfo.getProductId());
                result.put("productName", productInfo.getProductName());
                result.put("optionValue", productInfo.getOptionValue());
                result.put("sellingPrice", productInfo.getSellingPrice());
            } else {
                result.put("success", false);
                result.put("message", "상품을 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
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
} 