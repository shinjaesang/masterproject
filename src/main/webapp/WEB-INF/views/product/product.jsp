<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 상품관리</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .product-title { font-size: 2rem; font-weight: bold; margin-bottom: 1.5rem; }
        .filter-section { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .table th, .table td { text-align: center; vertical-align: middle; }
        .table th { background: #f8f9fa; }
        .btn-black { background: #111; color: #fff; border: none; }
        .btn-black:hover { background: #222; color: #fff; }
        .btn-gray { background: #f8f9fa; color: #111; border: 1px solid #bbb; }
        .btn-gray:hover { background: #e9ecef; color: #111; }
        .pagination { justify-content: center; }
        /* 버튼 글자 가로 정렬 */
        .btn {
            writing-mode: horizontal-tb !important;
            text-orientation: mixed !important;
            white-space: nowrap !important;
        }
        @media (max-width: 576px) {
            .btn {
                min-width: 60px;
                font-size: 12px;
                padding: 6px 12px;
                white-space: nowrap;
            }
            .d-flex {
                flex-wrap: nowrap;
            }
        }
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
                            <h4 class="mb-0">상품관리</h4>
                            <button class="btn btn-success" type="button" id="btnRegisterProduct"><i class="fa fa-plus me-1"></i>신규상품등록</button>
                        </div>
                        <!-- 검색 필터 -->
                        <div class="filter-section mb-3">
                            <form class="row g-2 align-items-end" id="searchForm">
                                <div class="col-md-2">
                                    <label class="form-label">상품명</label>
                                    <input type="text" class="form-control" name="productName" placeholder="상품명 입력">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">상품코드</label>
                                    <input type="text" class="form-control" name="productId" placeholder="상품코드 입력">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">상품유형</label>
                                    <select class="form-select" name="productType">
                                        <option value="">전체</option>
                                        <option value="부품">부품</option>
                                        <option value="완제품">완제품</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">카테고리</label>
                                    <select class="form-select" name="category">
                                        <option value="">전체</option>
                                        <option value="전자부품">전자부품</option>
                                        <option value="전자제품">전자제품</option>
                                        <option value="가전제품">가전제품</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">공급처</label>
                                    <select class="form-select" name="partnerId">
                                        <option value="">전체</option>
                                        <!-- 공급처 목록은 AJAX로 동적 로딩 -->
                                    </select>
                                </div>
                                <div class="col-md-2 text-end">
                                    <button class="btn btn-primary w-100" type="button" id="btnSearch">검색</button>
                                </div>
                            </form>
                        </div>
                        <!-- 데이터 테이블 -->
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>상품코드</th>
                                    <th>이미지</th>
                                    <th>상품명</th>
                                    <th>옵션</th>
                                    <th>상품유형</th>
                                    <th>공급처코드</th>
                                    <th>공급처명</th>
                                    <th>원가</th>
                                    <th>판매가</th>
                                    <th>제조사</th>
                                    <th>원산지</th>
                                    <th>카테고리</th>
                                    <th>안전재고</th>
                                    <th>등록일</th>
                                    <th>수정일</th>
                                    <th>관리</th>
                                </tr>
                                </thead>
                                <tbody id="productTableBody">
                                <!-- JS로 동적 렌더링 -->
                                </tbody>
                            </table>
                        </div>
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
function loadPartnerList() {
    $.ajax({
        url: "${pageContext.request.contextPath}/partner/list",
        method: "GET",
        dataType: "json",
        success: function(data) {
            var html = '<option value="">전체</option>';
            $.each(data, function(i, partner) {
                html += '<option value="' + partner.partnerId + '">' + 
                       partner.partnerId + ' - ' + partner.partnerName + '</option>';
            });
            $('select[name=partnerId]').html(html);
        }
    });
}

function loadProductList() {
    var params = {
        productName: $('input[name=productName]').val(),
        productId: $('input[name=productId]').val(),
        productType: $('select[name=productType]').val(),
        category: $('select[name=category]').val(),
        partnerId: $('select[name=partnerId]').val()
    };
    $.ajax({
        url: "${pageContext.request.contextPath}/product/list",
        method: "GET",
        data: params,
        dataType: "json",
        success: function(data) {
            var html = "";
            if(data.length === 0) {
                html = "<tr><td colspan='16'>검색 결과가 없습니다.</td></tr>";
            } else {
                $.each(data, function(i, p) {
                    html += "<tr>";
                    html += "<td>" + (p.productId || '') + "</td>";
                    html += "<td>";
                    if (p.productImage) {
                        html += "<img src='data:image/jpeg;base64," + p.productImage + "' alt='상품이미지' style='max-width: 50px; cursor: pointer;' onclick='showImage(this.src)'>";
                    } else {
                        html += "<i class='fas fa-image' style='font-size: 24px; color: #ccc;'></i>";
                    }
                    html += "</td>";
                    html += "<td>" + (p.productName || '') + "</td>";
                    html += "<td>" + (p.optionValue || '') + "</td>";
                    html += "<td>" + (p.productType || '') + "</td>";
                    html += "<td>" + (p.partnerId || '') + "</td>";
                    html += "<td>" + (p.partnerName || '') + "</td>";
                    html += "<td>" + (p.costPrice ? p.costPrice.toLocaleString() + '원' : '-') + "</td>";
                    html += "<td>" + (p.sellingPrice ? p.sellingPrice.toLocaleString() + '원' : '-') + "</td>";
                    html += "<td>" + (p.manufacturer || '') + "</td>";
                    html += "<td>" + (p.countryOfOrigin || '') + "</td>";
                    html += "<td>" + (p.category || '') + "</td>";
                    html += "<td>" + (p.safeStock || '0') + "</td>";
                    html += "<td>" + (p.createdAt ? new Date(p.createdAt).toLocaleDateString() : '') + "</td>";
                    html += "<td>" + (p.updatedAt ? new Date(p.updatedAt).toLocaleDateString() : '') + "</td>";
                    html += "<td>";
                    html += "<button class='btn btn-outline-primary btn-sm btn-edit-product me-1' data-id='" + (p.productId || '') + "'>수정</button>";
                    html += "<button class='btn btn-outline-danger btn-sm btn-delete-product' data-id='" + (p.productId || '') + "'>삭제</button>";
                    html += "</td>";
                    html += "</tr>";
                });
            }
            $("#productTableBody").html(html);
        }
    });
}

$(function() {
    // 공급처 목록 로딩
    loadPartnerList();
    loadProductList();

    $('#btnRegisterProduct').on('click', function() {
        window.location.href = "${pageContext.request.contextPath}/product/register.do";
    });

    // 검색 버튼 클릭
    $('#btnSearch').on('click', function() {
        loadProductList();
    });

    // 수정 버튼 클릭
    $('#productTableBody').on('click', '.btn-edit-product', function() {
        var productId = $(this).data('id');
        if (!productId) {
            alert('상품코드가 없습니다!');
            return;
        }
        window.location.href = "${pageContext.request.contextPath}/product/edit.do?productId=" + encodeURIComponent(productId);
    });

    // 삭제 버튼 클릭
    $('#productTableBody').on('click', '.btn-delete-product', function() {
        if(confirm('정말 삭제하시겠습니까?')) {
            var pcode = $(this).data('id');
            $.ajax({
                url: "${pageContext.request.contextPath}/product/delete/" + pcode,
                method: "DELETE",
                success: function(res) {
                    if(res > 0) {
                        alert('삭제되었습니다.');
                        loadProductList();
                    } else {
                        alert('삭제에 실패했습니다.');
                    }
                }
            });
        }
    });
});

// 이미지 클릭 시 크게 보기
function showImage(src) {
    var modal = $('<div>').addClass('modal fade').attr('id', 'imageModal');
    var modalDialog = $('<div>').addClass('modal-dialog modal-lg');
    var modalContent = $('<div>').addClass('modal-content');
    var modalBody = $('<div>').addClass('modal-body text-center');
    var img = $('<img>').attr('src', src).css('max-width', '100%');
    
    modalBody.append(img);
    modalContent.append(modalBody);
    modalDialog.append(modalContent);
    modal.append(modalDialog);
    
    $('body').append(modal);
    modal.modal('show');
    
    modal.on('hidden.bs.modal', function() {
        modal.remove();
    });
}
</script>
</body>
</html> 