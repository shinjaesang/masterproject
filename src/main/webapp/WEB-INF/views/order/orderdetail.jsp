<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .modal-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        .modal-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
        }
        .total-amount {
            font-size: 1.2em;
            font-weight: bold;
            color: #0d6efd;
        }
        .card {
            margin-bottom: 1rem;
        }
        .card-header {
            background-color: #f8f9fa;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">주문 상세 정보</h5>
                        <button type="button" class="btn-close" onclick="history.back()"></button>
                    </div>
                    <div class="card-body">
                        <!-- 주문 기본 정보 -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <h6 class="mb-0">주문 정보</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><strong>주문번호:</strong> ${order.orderId}</p>
                                        <p><strong>주문유형:</strong> ${order.orderType}</p>
                                        <p><strong>거래처명:</strong> ${order.partnerName}</p>
                                        <p><strong>거래처주소:</strong> ${order.partnerAddress}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>주문일자:</strong> <fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd"/></p>
                                        <p><strong>주문상태:</strong> ${order.orderStatus}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 주문 상품 목록 -->
                        <div class="card">
                            <div class="card-header">
                                <h6 class="mb-0">주문 상품</h6>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>상품코드</th>
                                                <th>상품명</th>
                                                <th>옵션</th>
                                                <th>수량</th>
                                                <th>원가</th>
                                                <th>판매가</th>
                                                <th>총원가</th>
                                                <th>총 판매가</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${order.items}" var="item">
                                                <tr>
                                                    <td>${item.productCode}</td>
                                                    <td>${item.productName}</td>
                                                    <td>${item.optionValue}</td>
                                                    <td>${item.quantity}</td>
                                                    <td><fmt:formatNumber value="${item.costPrice}" pattern="#,###"/>원</td>
                                                    <td><fmt:formatNumber value="${item.sellingPrice}" pattern="#,###"/>원</td>
                                                    <td><fmt:formatNumber value="${item.costPrice * item.quantity}" pattern="#,###"/>원</td>
                                                    <td><fmt:formatNumber value="${item.sellingPrice * item.quantity}" pattern="#,###"/>원</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="6" class="text-end"><strong>총 원가:</strong></td>
                                                <td colspan="2" class="text-end">
                                                    <c:set var="totalCost" value="0"/>
                                                    <c:forEach items="${order.items}" var="item">
                                                        <c:set var="totalCost" value="${totalCost + (item.costPrice * item.quantity)}"/>
                                                    </c:forEach>
                                                    <fmt:formatNumber value="${totalCost}" pattern="#,###"/>원
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6" class="text-end"><strong>총 판매가:</strong></td>
                                                <td colspan="2" class="text-end">
                                                    <c:set var="totalAmount" value="0"/>
                                                    <c:forEach items="${order.items}" var="item">
                                                        <c:set var="totalAmount" value="${totalAmount + (item.sellingPrice * item.quantity)}"/>
                                                    </c:forEach>
                                                    <fmt:formatNumber value="${totalAmount}" pattern="#,###"/>원
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-end">
                            <button type="button" class="btn btn-warning me-2" onclick="location.href='update.do?orderId=${order.orderId}'">수정</button>
                            <button type="button" class="btn btn-danger" onclick="deleteOrder('${order.orderId}')">삭제</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteOrder(orderId) {
            if (confirm('정말로 이 주문을 삭제하시겠습니까?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/order/deleteOrder.do',
                    type: 'POST',
                    data: { orderId: orderId },
                    success: function(response) {
                        if (response.success) {
                            alert('주문이 삭제되었습니다.');
                            location.href = '${pageContext.request.contextPath}/order/list.do';
                        } else {
                            alert(response.message || '주문 삭제에 실패했습니다.');
                        }
                    },
                    error: function() {
                        alert('주문 삭제 중 오류가 발생했습니다.');
                    }
                });
            }
        }
    </script>
</body>
</html> 