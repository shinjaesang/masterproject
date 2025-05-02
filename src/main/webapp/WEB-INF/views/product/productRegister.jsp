<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 상품등록</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .product-title { font-size: 2rem; font-weight: bold; margin-bottom: 1.5rem; }
        .form-section { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .btn-black { background: #111; color: #fff; border: none; }
        .btn-black:hover { background: #222; color: #fff; }
        .btn-gray { background: #f8f9fa; color: #111; border: 1px solid #bbb; }
        .btn-gray:hover { background: #e9ecef; color: #111; }
    </style>
</head>
<body>
<div class="container-fluid position-relative bg-white d-flex p-0">
    <!-- Sidebar Start -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
    <!-- Sidebar End -->
    <!-- Content Start -->
    <div class="content">
        <!-- Navbar Start -->
        <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
        <!-- Navbar End -->
        <div class="container-fluid pt-4 px-4">
            <div class="row g-4">
                <div class="col-12">
                    <div class="bg-light rounded h-100 p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">상품등록</h4>
                            <button class="btn btn-secondary" type="button" onclick="history.back()">목록으로</button>
                        </div>
                        <form id="productForm" method="post" action="${pageContext.request.contextPath}/product/add" enctype="multipart/form-data" accept-charset="UTF-8">
                            <div class="form-section">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">상품코드</label>
                                        <input type="text" class="form-control" name="productId" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">상품명</label>
                                        <input type="text" class="form-control" name="productName" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">옵션</label>
                                        <input type="text" class="form-control" name="optionValue">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">상품유형</label>
                                        <select class="form-select" name="productType" required>
                                            <option value="">선택하세요</option>
                                            <option value="부품">부품</option>
                                            <option value="완제품">완제품</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">공급처</label>
                                        <select class="form-select" name="partnerId" required>
                                            <option value="">선택하세요</option>
                                            <!-- 공급처 목록은 AJAX로 동적 로딩 -->
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">카테고리</label>
                                        <select class="form-select" name="category" required>
                                            <option value="">선택하세요</option>
                                            <option value="전자부품">전자부품</option>
                                            <option value="전자제품">전자제품</option>
                                            <option value="가전제품">가전제품</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">원가</label>
                                        <input type="number" class="form-control" name="costPrice" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">판매가</label>
                                        <input type="number" class="form-control" name="sellingPrice" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">제조사</label>
                                        <input type="text" class="form-control" name="manufacturer">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">원산지</label>
                                        <input type="text" class="form-control" name="countryOfOrigin">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">안전재고</label>
                                        <input type="number" class="form-control" name="safeStock" value="0">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">상품이미지</label>
                                        <input type="file" class="form-control" name="productImage" accept="image/*">
                                    </div>
                                </div>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">등록</button>
                                <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Content End -->
</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script>
$(function() {
    // 공급처 목록 로딩
    $.ajax({
        url: "${pageContext.request.contextPath}/partner/list",
        method: "GET",
        dataType: "json",
        success: function(data) {
            var html = '<option value="">선택하세요</option>';
            $.each(data, function(i, partner) {
                html += '<option value="' + partner.partnerId + '">' + 
                       partner.partnerId + ' - ' + partner.partnerName + '</option>';
            });
            $('select[name=partnerId]').html(html);
        }
    });

    // 폼 제출 전 유효성 검사
    $('#productForm').on('submit', function(e) {
        e.preventDefault();
        
        // 필수 입력값 검사
        var requiredFields = ['productId', 'productName', 'productType', 'partnerId', 'category', 'costPrice', 'sellingPrice'];
        var isValid = true;
        
        requiredFields.forEach(function(field) {
            if (!$('input[name=' + field + '], select[name=' + field + ']').val()) {
                alert(field + '은(는) 필수 입력값입니다.');
                isValid = false;
                return false;
            }
        });
        
        if (!isValid) return;
        
        // 가격 검증
        var costPrice = parseInt($('input[name=costPrice]').val());
        var sellingPrice = parseInt($('input[name=sellingPrice]').val());
        
        if (costPrice > sellingPrice) {
            alert('판매가는 원가보다 커야 합니다.');
            return;
        }
        
        // 폼 제출
        this.submit();
    });
});
</script>
</body>
</html> 