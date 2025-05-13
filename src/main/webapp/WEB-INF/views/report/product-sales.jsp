<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 상품매출매입통계</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="재고관리 ERP 시스템" name="keywords">
    <meta content="효율적인 재고 관리를 위한 Stockmaster ERP 시스템" name="description">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    
    <style>
        .filter-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        .sales-table th {
            background-color: #e9ecef;
            font-weight: 600;
        }
        .table-summary td {
             background-color: #f8f9fa;
             font-weight: bold;
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

            <!-- Product Sales Statistics Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="mb-0">상품매출매입통계 <!-- <i class="fa fa-question-circle text-muted ms-1"></i> --></h4> 
                            </div>

                            <!-- Search Filters -->
                            <div class="filter-section">
                                <form class="row g-3" action="${pageContext.request.contextPath}/statistics/product-sales.do" method="get">
                                    <div class="col-md-4">
                                        <label class="form-label">검색기간</label>
                                        <div class="input-group">
                                            <input type="date" class="form-control" name="startDate" value="${param.startDate}">
                                            <span class="input-group-text">~</span>
                                            <input type="date" class="form-control" name="endDate" value="${param.endDate}">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">상품 정보</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" name="productCode" placeholder="상품코드" value="${param.productCode}">
                                            <input type="text" class="form-control" name="productName" placeholder="상품명" value="${param.productName}">
                                            <input type="text" class="form-control" name="optionName" placeholder="옵션" value="${param.optionName}">
                                            <input type="text" class="form-control" name="productCategory" placeholder="카테고리" value="${param.productCategory}">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">파트너 정보</label>
                                        <div class="input-group">
                                            <select class="form-select" name="partnerType">
                                                <option value="SUPPLIER" <c:if test="${param.partnerType == 'SUPPLIER'}">selected</c:if>>공급처</option>
                                                <option value="CUSTOMER" <c:if test="${param.partnerType == 'CUSTOMER'}">selected</c:if>>판매처</option>
                                            </select>
                                            <input type="text" class="form-control" name="partnerName" placeholder="파트너명" value="${param.partnerName}">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">거래구분</label>
                                        <select class="form-select" name="orderType">
                                            <option value="" <c:if test="${empty param.orderType}">selected</c:if>>전체</option>
                                            <option value="수주" <c:if test="${param.orderType == '수주'}">selected</c:if>>매출(수주)</option>
                                            <option value="발주" <c:if test="${param.orderType == '발주'}">selected</c:if>>매입(발주)</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">정렬</label>
                                        <select class="form-select" name="sort">
                                            <option value="" <c:if test="${empty param.sort}">selected</c:if>>정렬기준 선택</option>
                                            <option value="salesAmount_desc" <c:if test="${param.sort == 'salesAmount_desc'}">selected</c:if>>판매금액 내림차순</option>
                                            <option value="salesAmount_asc" <c:if test="${param.sort == 'salesAmount_asc'}">selected</c:if>>판매금액 오름차순</option>
                                            <option value="orderCount_desc" <c:if test="${param.sort == 'orderCount_desc'}">selected</c:if>>주문수량 내림차순</option>
                                            <option value="orderCount_asc" <c:if test="${param.sort == 'orderCount_asc'}">selected</c:if>>주문수량 오름차순</option>
                                            <option value="marginRate_desc" <c:if test="${param.sort == 'marginRate_desc'}">selected</c:if>>마진율 내림차순</option>
                                            <option value="marginRate_asc" <c:if test="${param.sort == 'marginRate_asc'}">selected</c:if>>마진율 오름차순</option>
                                            <option value="productName_asc" <c:if test="${param.sort == 'productName_asc'}">selected</c:if>>상품명 오름차순</option>
                                            <option value="productName_desc" <c:if test="${param.sort == 'productName_desc'}">selected</c:if>>상품명 내림차순</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 text-end align-self-end">
                                        <button type="submit" class="btn btn-primary">검색</button>
                                    </div>
                                </form>
                            </div>

                            <!-- Summary Cards -->
                            <div class="row mb-4">
                                <div class="col-12 d-flex justify-content-center">
                                    <table style="border:none; background:none; text-align:center;">
                                        <tr>
                                            <td style="color:#23272b; font-weight:bold; padding: 0 32px 4px 32px; font-size:1.05rem;">총 판매금액</td>
                                            <td style="color:#23272b; font-weight:bold; padding: 0 32px 4px 32px; font-size:1.05rem;">총 구매금액</td>
                                            <td style="color:#23272b; font-weight:bold; padding: 0 32px 4px 32px; font-size:1.05rem;">총 판매수량</td>
                                            <td style="color:#23272b; font-weight:bold; padding: 0 32px 4px 32px; font-size:1.05rem;">총 구매수량</td>
                                            <td style="color:#23272b; font-weight:bold; padding: 0 32px 4px 32px; font-size:1.05rem;">평균 마진율</td>
                                        </tr>
                                        <tr style="font-size:1.35rem;">
                                            <td style="font-weight:bold; padding: 0 32px;">
                                                <span style="color:#1976f6; font-weight:bold;"><fmt:formatNumber value="${totalSalesAmount}" pattern=",##0"/></span>
                                                <span style="font-size:0.95rem; color:#23272b; font-weight:bold;"> 원</span>
                                            </td>
                                            <td style="font-weight:bold; padding: 0 32px;">
                                                <span style="color:#1976f6; font-weight:bold;"><fmt:formatNumber value="${totalPurchaseAmount}" pattern=",##0"/></span>
                                                <span style="font-size:0.95rem; color:#23272b; font-weight:bold;"> 원</span>
                                            </td>
                                            <td style="font-weight:bold; padding: 0 32px;">
                                                <span style="color:#1976f6; font-weight:bold;">${totalSalesCount}</span>
                                                <span style="font-size:0.95rem; color:#23272b; font-weight:bold;"> 건</span>
                                            </td>
                                            <td style="font-weight:bold; padding: 0 32px;">
                                                <span style="color:#1976f6; font-weight:bold;">${totalPurchaseCount}</span>
                                                <span style="font-size:0.95rem; color:#23272b; font-weight:bold;"> 건</span>
                                            </td>
                                            <td style="font-weight:bold; padding: 0 32px;">
                                                <span style="color:#1976f6; font-weight:bold;">${averageMarginRate}</span>
                                                <span style="font-size:0.95rem; color:#23272b; font-weight:bold;"> %</span>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>

                            <!-- Stock History Summary -->
                            <!-- Stock History Summary -->

                            <!-- Sales Table -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-sm text-center sales-table">
                                    <thead>
                                        <tr>
                                            <th>거래구분</th>
                                            <th>상품코드</th>
                                            <th>상품명</th>
                                            <th>옵션</th>
                                            <th>카테고리</th>
                                            <th>주문수량</th>
                                            <th>판매금액</th>
                                            <th>상품원가</th>
                                            <th>마진금</th>
                                            <th>마진율</th>
                                            <th>판매처</th>
                                            <th>공급처</th>
                                            <th>가용재고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${salesList}" var="item">
                                            <tr>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${item.orderType eq '수주'}">매출</c:when>
                                                        <c:when test="${item.orderType eq '발주'}">매입</c:when>
                                                        <c:otherwise>${item.orderType}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${item.productCode}</td>
                                                <td>${item.productName}</td>
                                                <td>${item.optionName}</td>
                                                <td>${item.categoryName}</td>
                                                <td>${item.orderCount}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${item.orderType eq '수주'}">
                                                            <fmt:formatNumber value="${item.salesAmount}" pattern="#,#00"/>
                                                        </c:when>
                                                        <c:otherwise>-</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td><fmt:formatNumber value="${item.productCost}" pattern="#,#00"/></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${item.orderType eq '수주'}">
                                                            <fmt:formatNumber value="${item.marginAmount}" pattern="#,#00"/>
                                                        </c:when>
                                                        <c:otherwise>-</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${item.orderType eq '수주'}">${item.marginRate}%</c:when>
                                                        <c:otherwise>-</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="empty item.customerName">-</c:when>
                                                        <c:otherwise>${item.customerName}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${item.supplierName}</td>
                                                <td>${item.availableStock}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot class="table-summary">
                                        <tr>
                                            <td colspan="5">합계</td>
                                            <td>${totalOrderCount}</td>
                                            <td><fmt:formatNumber value="${totalSalesAmount}" pattern="#,#00"/></td>
                                            <td><fmt:formatNumber value="${totalProductCost}" pattern="#,#00"/></td>
                                            <td><fmt:formatNumber value="${totalMarginAmount}" pattern="#,#00"/></td>
                                            <td>${averageMarginRate}%</td>
                                            <td></td>
                                            <td></td>
                                            <td>${totalCurrentStock}</td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>

                            <!-- Stock History Modal -->
                            <div class="modal fade" id="stockHistoryModal" tabindex="-1">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">재고 이력 상세</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="table-responsive">
                                                <table class="table table-bordered table-sm">
                                                    <thead>
                                                        <tr>
                                                            <th>변경일시</th>
                                                            <th>변경유형</th>
                                                            <th>입고창고</th>
                                                            <th>출고창고</th>
                                                            <th>변경수량</th>
                                                            <th>입고창고재고</th>
                                                            <th>출고창고재고</th>
                                                            <th>변경자</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="stockHistoryBody">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <script>
                                function showStockHistory(productId) {
                                    // AJAX 호출로 재고 이력 데이터 가져오기
                                    $.ajax({
                                        url: '${pageContext.request.contextPath}/statistics/stock-history.do',
                                        method: 'GET',
                                        data: { productId: productId },
                                        success: function(response) {
                                            const tbody = $('#stockHistoryBody');
                                            tbody.empty();
                                            
                                            response.forEach(function(history) {
                                                tbody.append(`
                                                    <tr>
                                                        <td>${history.changeDate}</td>
                                                        <td>${history.changeType}</td>
                                                        <td>${history.inWarehouseName || '-'}</td>
                                                        <td>${history.outWarehouseName || '-'}</td>
                                                        <td>${history.changeQuantity}</td>
                                                        <td>${history.inStockQuantity || '-'}</td>
                                                        <td>${history.outStockQuantity || '-'}</td>
                                                        <td>${history.createdByName}</td>
                                                    </tr>
                                                `);
                                            });
                                            
                                            $('#stockHistoryModal').modal('show');
                                        },
                                        error: function(xhr, status, error) {
                                            alert('재고 이력 조회 중 오류가 발생했습니다.');
                                        }
                                    });
                                }
                            </script>
                            
                            <!-- Pagination -->
                            <div class="d-flex justify-content-between align-items-center mt-4">
                                <span class="text-muted">보기 1 - 43 / 43</span>
                                <nav aria-label="Page navigation">
                                    <ul class="pagination pagination-sm mb-0">
                                        <li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
                                    </ul>
                                </nav>
                                <div class="input-group input-group-sm" style="width: 100px;">
                                    <select class="form-select form-select-sm">
                                        <option selected>50</option>
                                        <option>100</option>
                                        <option>200</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Product Sales Statistics End -->
        </div>
        <!-- Content End -->
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/chart/chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    
    <script>
        // 사이드바 메뉴 활성화
        document.addEventListener('DOMContentLoaded', function() {
            // 다른 메뉴의 active 클래스를 제거
            document.querySelectorAll('.nav-link.dropdown-toggle').forEach(el => {
                el.classList.remove('active');
            });
            
            // 통계분석 메뉴에 active 클래스 추가
            const statisticsMenu = document.querySelector('.nav-link.dropdown-toggle:nth-of-type(9)'); 
            if (statisticsMenu) {
                statisticsMenu.classList.add('active');
            }
        });
    </script>
</body>
</html> 