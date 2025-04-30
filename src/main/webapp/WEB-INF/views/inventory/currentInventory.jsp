<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 현 재고 조회</title>
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

            <!-- Inventory Management Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">현 재고 조회</h6>
                            <!-- Search Filters -->
                            <form class="row g-3 mb-4" action="${pageContext.request.contextPath}/inventory/search.do" method="post">
                                <div class="col-md-4">
                                    <label for="supplier" class="form-label">공급처</label>
                                    <input type="text" class="form-control" id="supplier" name="supplier" placeholder="전체그룹" value="${param.supplier}">
                                </div>
                                <div class="col-md-4">
                                    <label for="productTag" class="form-label">상품태그</label>
                                    <select id="productTag" name="productTag" class="form-select">
                                        <option value="">상품태그</option>
                                        <c:if test="${not empty productTags}">
                                            <c:forEach items="${productTags}" var="tag">
                                                <option value="${tag.code}" ${param.productTag eq tag.code ? 'selected' : ''}>${tag.name}</option>
                                            </c:forEach>
                                        </c:if>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="searchCondition" class="form-label">검색조건</label>
                                    <select id="searchCondition" name="searchCondition" class="form-select">
                                        <option value="productName" ${param.searchCondition eq 'productName' ? 'selected' : ''}>상품명</option>
                                        <option value="productCode" ${param.searchCondition eq 'productCode' ? 'selected' : ''}>상품코드</option>
                                        <option value="barcode" ${param.searchCondition eq 'barcode' ? 'selected' : ''}>바코드</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="inventoryQuantity" class="form-label">재고수량</label>
                                    <select id="inventoryQuantity" name="inventoryQuantity" class="form-select">
                                        <option value="">전체</option>
                                        <option value="0" ${param.inventoryQuantity eq '0' ? 'selected' : ''}>0개</option>
                                        <option value="1-10" ${param.inventoryQuantity eq '1-10' ? 'selected' : ''}>1-10개</option>
                                        <option value="11-50" ${param.inventoryQuantity eq '11-50' ? 'selected' : ''}>11-50개</option>
                                        <option value="51-100" ${param.inventoryQuantity eq '51-100' ? 'selected' : ''}>51-100개</option>
                                        <option value="101" ${param.inventoryQuantity eq '101' ? 'selected' : ''}>101개 이상</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
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
                                <div class="col-md-4">
                                    <label for="inventoryStatus" class="form-label">재고상태</label>
                                    <select id="inventoryStatus" name="inventoryStatus" class="form-select">
                                        <option value="">전체</option>
                                        <option value="NORMAL" ${param.inventoryStatus eq 'NORMAL' ? 'selected' : ''}>정상</option>
                                        <option value="DEFECTIVE" ${param.inventoryStatus eq 'DEFECTIVE' ? 'selected' : ''}>불량</option>
                                        <option value="TRANSIT" ${param.inventoryStatus eq 'TRANSIT' ? 'selected' : ''}>경유창고</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="workPeriod" class="form-label">작업기간</label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" name="workStartDate" value="${param.workStartDate}">
                                        <span class="input-group-text">~</span>
                                        <input type="date" class="form-control" name="workEndDate" value="${param.workEndDate}">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="productPeriod" class="form-label">상품기간</label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" name="productStartDate" value="${param.productStartDate}">
                                        <span class="input-group-text">~</span>
                                        <input type="date" class="form-control" name="productEndDate" value="${param.productEndDate}">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="quality" class="form-label">품질</label>
                                    <select id="quality" name="quality" class="form-select">
                                        <option value="">전체</option>
                                        <option value="A" ${param.quality eq 'A' ? 'selected' : ''}>A급</option>
                                        <option value="B" ${param.quality eq 'B' ? 'selected' : ''}>B급</option>
                                        <option value="C" ${param.quality eq 'C' ? 'selected' : ''}>C급</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="sortOrder" class="form-label">정렬</label>
                                    <select id="sortOrder" name="sortOrder" class="form-select">
                                        <option value="productName" ${param.sortOrder eq 'productName' ? 'selected' : ''}>상품명</option>
                                        <option value="inventoryQuantity" ${param.sortOrder eq 'inventoryQuantity' ? 'selected' : ''}>재고수량</option>
                                        <option value="costPrice" ${param.sortOrder eq 'costPrice' ? 'selected' : ''}>원가</option>
                                        <option value="sellingPrice" ${param.sortOrder eq 'sellingPrice' ? 'selected' : ''}>판매가</option>
                                    </select>
                                </div>
                                <div class="col-12 text-end">
                                    <button type="submit" class="btn btn-primary">검색</button>
                                </div>
                            </form>
                            
                            <!-- Summary Table -->
                            <div class="table-responsive mb-4">
                                <table class="table table-bordered text-center">
                                    <thead>
                                        <tr class="table-secondary">
                                            <th></th>
                                            <th>정상</th>
                                            <th>불량</th>
                                            <th>경유창고</th>
                                            <th>애플 물류</th>
                                            <th>삼성 물류</th>
                                            <th>SK 물류</th>
                                            <th>LG 물류</th>
                                            <th>ICT 물류</th>
                                            <th>정상+창고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">수량 (개)</th>
                                            <td>${inventorySummary.normalQuantity != null ? inventorySummary.normalQuantity : 0}</td>
                                            <td>${inventorySummary.defectiveQuantity != null ? inventorySummary.defectiveQuantity : 0}</td>
                                            <td>${inventorySummary.transitQuantity != null ? inventorySummary.transitQuantity : 0}</td>
                                            <td>${inventorySummary.appleQuantity != null ? inventorySummary.appleQuantity : 0}</td>
                                            <td>${inventorySummary.samsungQuantity != null ? inventorySummary.samsungQuantity : 0}</td>
                                            <td>${inventorySummary.skQuantity != null ? inventorySummary.skQuantity : 0}</td>
                                            <td>${inventorySummary.lgQuantity != null ? inventorySummary.lgQuantity : 0}</td>
                                            <td>${inventorySummary.ictQuantity != null ? inventorySummary.ictQuantity : 0}</td>
                                            <td>${inventorySummary.totalQuantity != null ? inventorySummary.totalQuantity : 0}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">원가 (원)</th>
                                            <td>${inventorySummary.normalCostPrice != null ? inventorySummary.normalCostPrice : 0}</td>
                                            <td>${inventorySummary.defectiveCostPrice != null ? inventorySummary.defectiveCostPrice : 0}</td>
                                            <td>${inventorySummary.transitCostPrice != null ? inventorySummary.transitCostPrice : 0}</td>
                                            <td>${inventorySummary.appleCostPrice != null ? inventorySummary.appleCostPrice : 0}</td>
                                            <td>${inventorySummary.samsungCostPrice != null ? inventorySummary.samsungCostPrice : 0}</td>
                                            <td>${inventorySummary.skCostPrice != null ? inventorySummary.skCostPrice : 0}</td>
                                            <td>${inventorySummary.lgCostPrice != null ? inventorySummary.lgCostPrice : 0}</td>
                                            <td>${inventorySummary.ictCostPrice != null ? inventorySummary.ictCostPrice : 0}</td>
                                            <td>${inventorySummary.totalCostPrice != null ? inventorySummary.totalCostPrice : 0}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">판매가 (원)</th>
                                            <td>${inventorySummary.normalSellingPrice != null ? inventorySummary.normalSellingPrice : 0}</td>
                                            <td>${inventorySummary.defectiveSellingPrice != null ? inventorySummary.defectiveSellingPrice : 0}</td>
                                            <td>${inventorySummary.transitSellingPrice != null ? inventorySummary.transitSellingPrice : 0}</td>
                                            <td>${inventorySummary.appleSellingPrice != null ? inventorySummary.appleSellingPrice : 0}</td>
                                            <td>${inventorySummary.samsungSellingPrice != null ? inventorySummary.samsungSellingPrice : 0}</td>
                                            <td>${inventorySummary.skSellingPrice != null ? inventorySummary.skSellingPrice : 0}</td>
                                            <td>${inventorySummary.lgSellingPrice != null ? inventorySummary.lgSellingPrice : 0}</td>
                                            <td>${inventorySummary.ictSellingPrice != null ? inventorySummary.ictSellingPrice : 0}</td>
                                            <td>${inventorySummary.totalSellingPrice != null ? inventorySummary.totalSellingPrice : 0}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-end mb-3">
                                <button class="btn btn-secondary" onclick="exportToExcel()">다운로드</button>
                            </div>

                            <!-- Detailed Inventory List -->
                            <div class="table-responsive">
                                <table class="table text-center align-middle table-bordered table-hover mb-0">
                                    <thead>
                                        <tr class="text-dark">
                                            <th scope="col"><input class="form-check-input" type="checkbox" id="selectAll"></th>
                                            <th scope="col">No</th>
                                            <th scope="col">공급처</th>
                                            <th scope="col">상품코드</th>
                                            <th scope="col">이미지</th>
                                            <th scope="col">바코드</th>
                                            <th scope="col">상품명</th>
                                            <th scope="col">옵션</th>
                                            <th scope="col">정상재고</th>
                                            <th scope="col">불량재고</th>
                                            <th scope="col">경유창고</th>
                                            <th scope="col">애플 물류</th>
                                            <th scope="col">삼성 물류</th>
                                            <th scope="col">SK 물류</th>
                                            <th scope="col">LG 물류</th>
                                            <th scope="col">ICT 물류</th>
                                            <th scope="col">가용재고</th>
                                            <th scope="col">점유수</th>
                                            <th scope="col">출고</th>
                                            <th scope="col">원가</th>
                                            <th scope="col">판매가</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${not empty inventoryList}">
                                            <c:forEach items="${inventoryList}" var="item" varStatus="status">
                                                <tr>
                                                    <td><input class="form-check-input" type="checkbox" name="selectedItems" value="${item.productCode}"></td>
                                                    <td>${status.count}</td>
                                                    <td>${item.supplier}</td>
                                                    <td>${item.productCode}</td>
                                                    <td><img src="${pageContext.request.contextPath}/resources/img/product/${item.imagePath}" alt="img" style="width: 30px; height: 30px;"></td>
                                                    <td>${item.barcode}</td>
                                                    <td>${item.productName}</td>
                                                    <td>${item.option}</td>
                                                    <td>${item.normalQuantity}</td>
                                                    <td>${item.defectiveQuantity}</td>
                                                    <td>${item.transitQuantity}</td>
                                                    <td>${item.appleQuantity}</td>
                                                    <td>${item.samsungQuantity}</td>
                                                    <td>${item.skQuantity}</td>
                                                    <td>${item.lgQuantity}</td>
                                                    <td>${item.ictQuantity}</td>
                                                    <td>${item.availableQuantity}</td>
                                                    <td>${item.occupiedQuantity}</td>
                                                    <td>${item.outboundQuantity}</td>
                                                    <td>${item.costPrice}</td>
                                                    <td>${item.sellingPrice}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty inventoryList}">
                                            <tr>
                                                <td colspan="21" class="text-center">데이터가 없습니다.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Inventory Management End -->
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
        // 전체 선택 체크박스
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.getElementsByName('selectedItems');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });

        // 엑셀 다운로드
        function exportToExcel() {
            const selectedItems = Array.from(document.getElementsByName('selectedItems'))
                .filter(checkbox => checkbox.checked)
                .map(checkbox => checkbox.value);
            
            if (selectedItems.length === 0) {
                alert('다운로드할 항목을 선택해주세요.');
                return;
            }

            // TODO: 엑셀 다운로드 API 호출
            console.log('Selected items:', selectedItems);
        }

        document.addEventListener('DOMContentLoaded', function() {
            // 상품관리 메뉴의 active 클래스를 제거
            const productMenu = document.querySelector('.nav-link.dropdown-toggle[data-bs-toggle="dropdown"]');
            if (productMenu) {
                productMenu.classList.remove('active');
            }
            
            // 재고관리 메뉴에 active 클래스 추가
            const inventoryMenu = document.querySelector('.nav-link.dropdown-toggle[data-bs-toggle="dropdown"]:nth-child(6)');
            if (inventoryMenu) {
                inventoryMenu.classList.add('active');
            }
        });
    </script>
</body>
</html> 