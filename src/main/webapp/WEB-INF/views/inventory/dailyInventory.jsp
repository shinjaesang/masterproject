<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 일자별 재고관리</title>
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

            <!-- Daily Inventory Management Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">일자별 재고조회</h6>
                            <!-- Search Filters -->
                            <form class="row g-3 mb-4 align-items-end" action="${pageContext.request.contextPath}/inventory/daily/search.do" method="post">
                                <div class="col-md-3">
                                    <label for="period" class="form-label">기간</label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" name="startDate" value="${param.startDate}">
                                        <span class="input-group-text">~</span>
                                        <input type="date" class="form-control" name="endDate" value="${param.endDate}">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                     <label for="vendorSearch" class="form-label">판매처</label>
                                     <div class="input-group">
                                        <select id="vendorGroup" name="vendorGroup" class="form-select">
                                            <option value="">판매처그룹</option>
                                            <c:if test="${not empty vendorGroups}">
                                                <c:forEach items="${vendorGroups}" var="group">
                                                    <option value="${group.code}" ${param.vendorGroup eq group.code ? 'selected' : ''}>${group.name}</option>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                        <select id="vendor" name="vendor" class="form-select">
                                            <option value="">전체</option>
                                            <c:if test="${not empty vendors}">
                                                <c:forEach items="${vendors}" var="vendor">
                                                    <option value="${vendor.code}" ${param.vendor eq vendor.code ? 'selected' : ''}>${vendor.name}</option>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                        <button class="btn btn-outline-secondary" type="button" onclick="searchVendor()"><i class="fa fa-search"></i></button>
                                     </div>
                                </div>
                                <div class="col-md-3">
                                     <label for="supplierSearch" class="form-label">공급처</label>
                                     <div class="input-group">
                                        <select id="supplier" name="supplier" class="form-select">
                                            <option value="">전체</option>
                                            <c:if test="${not empty suppliers}">
                                                <c:forEach items="${suppliers}" var="supplier">
                                                    <option value="${supplier.code}" ${param.supplier eq supplier.code ? 'selected' : ''}>${supplier.name}</option>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                        <button class="btn btn-outline-secondary" type="button" onclick="searchSupplier()"><i class="fa fa-search"></i></button>
                                     </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="inventoryInfo" class="form-label">재고정보</label>
                                     <div class="input-group">
                                        <select id="inventoryType" name="inventoryType" class="form-select">
                                            <option value="">재고타입</option>
                                            <option value="NORMAL" ${param.inventoryType eq 'NORMAL' ? 'selected' : ''}>정상</option>
                                            <option value="DEFECTIVE" ${param.inventoryType eq 'DEFECTIVE' ? 'selected' : ''}>불량</option>
                                            <option value="TRANSIT" ${param.inventoryType eq 'TRANSIT' ? 'selected' : ''}>경유창고</option>
                                        </select>
                                        <select id="quality" name="quality" class="form-select">
                                            <option value="">품질</option>
                                            <option value="A" ${param.quality eq 'A' ? 'selected' : ''}>A급</option>
                                            <option value="B" ${param.quality eq 'B' ? 'selected' : ''}>B급</option>
                                            <option value="C" ${param.quality eq 'C' ? 'selected' : ''}>C급</option>
                                        </select>
                                        <select id="workType" name="workType" class="form-select">
                                            <option value="">작업</option>
                                            <option value="INBOUND" ${param.workType eq 'INBOUND' ? 'selected' : ''}>입고</option>
                                            <option value="OUTBOUND" ${param.workType eq 'OUTBOUND' ? 'selected' : ''}>출고</option>
                                        </select>
                                     </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="productPeriod" class="form-label">상품기간</label>
                                    <div class="input-group">
                                        <select id="productPeriodType" name="productPeriodType" class="form-select" style="max-width: 100px;">
                                            <option value="">선택</option>
                                            <option value="REGISTER" ${param.productPeriodType eq 'REGISTER' ? 'selected' : ''}>등록일</option>
                                            <option value="INBOUND" ${param.productPeriodType eq 'INBOUND' ? 'selected' : ''}>입고일</option>
                                        </select>
                                        <input type="date" class="form-control" name="productStartDate" value="${param.productStartDate}">
                                        <span class="input-group-text">~</span>
                                        <input type="date" class="form-control" name="productEndDate" value="${param.productEndDate}">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label for="category" class="form-label">카테고리</label>
                                    <select id="category" name="category" class="form-select">
                                        <option value="">전체</option>
                                        <c:if test="${not empty categories}">
                                            <c:forEach items="${categories}" var="category">
                                                <option value="${category.code}" ${param.category eq category.code ? 'selected' : ''}>${category.name}</option>
                                            </c:forEach>
                                        </c:if>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label for="productName" class="form-label">상품명</label>
                                    <input type="text" class="form-control" id="productName" name="productName" value="${param.productName}">
                                </div>

                                <div class="col-12 text-end">
                                    <button type="submit" class="btn btn-primary">검색</button>
                                    <button type="button" class="btn btn-secondary" onclick="exportToExcel()">다운로드</button>
                                </div>
                            </form>
                            
                            <!-- Daily Inventory List -->
                            <div class="table-responsive">
                                <table class="table text-center align-middle table-bordered table-hover mb-0">
                                    <thead>
                                        <tr class="text-dark">
                                            <th scope="col">공급처</th>
                                            <th scope="col">상품코드</th>
                                            <th scope="col">공급처상품명</th>
                                            <th scope="col">기간배송</th>
                                            <th scope="col">기간평균<br>발주</th>
                                            <th scope="col">기간평균<br>입고</th>
                                            <th scope="col">기간평균<br>배송</th>
                                            <th scope="col">분기X<br>총수량</th>
                                            <c:forEach items="${dateHeaders}" var="date">
                                                <th scope="col">${date}</th>
                                            </c:forEach>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${not empty dailyInventoryList}">
                                            <c:forEach items="${dailyInventoryList}" var="item">
                                                <tr>
                                                    <td>${item.supplier}</td>
                                                    <td>${item.productCode}</td>
                                                    <td>${item.supplierProductName}</td>
                                                    <td>${item.periodDelivery}</td>
                                                    <td>${item.avgOrder}</td>
                                                    <td>${item.avgInbound}</td>
                                                    <td>${item.avgDelivery}</td>
                                                    <td>${item.totalQuantity}</td>
                                                    <c:forEach items="${item.dailyQuantities}" var="quantity">
                                                        <td>${quantity}</td>
                                                    </c:forEach>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty dailyInventoryList}">
                                            <tr>
                                                <td colspan="${8 + fn:length(dateHeaders)}" class="text-center">데이터가 없습니다.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${not empty pageInfo}">
                                <nav aria-label="Page navigation" class="mt-4 d-flex justify-content-center">
                                    <ul class="pagination">
                                        <li class="page-item ${pageInfo.currentPage eq 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/inventory/daily.do?page=${pageInfo.currentPage - 1}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <c:forEach begin="1" end="${pageInfo.totalPages}" var="pageNum">
                                            <li class="page-item ${pageInfo.currentPage eq pageNum ? 'active' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/inventory/daily.do?page=${pageNum}">${pageNum}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${pageInfo.currentPage eq pageInfo.totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/inventory/daily.do?page=${pageInfo.currentPage + 1}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                    <span class="ms-3 align-self-center text-muted">/ ${pageInfo.totalPages}</span>
                                </nav>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Daily Inventory Management End -->
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
        // 판매처 검색
        function searchVendor() {
            const vendorGroup = document.getElementById('vendorGroup').value;
            // TODO: 판매처 검색 API 호출
            console.log('Search vendor group:', vendorGroup);
        }

        // 공급처 검색
        function searchSupplier() {
            const supplier = document.getElementById('supplier').value;
            // TODO: 공급처 검색 API 호출
            console.log('Search supplier:', supplier);
        }

        // 엑셀 다운로드
        function exportToExcel() {
            // TODO: 엑셀 다운로드 API 호출
            console.log('Export to Excel');
        }
    </script>
</body>
</html> 