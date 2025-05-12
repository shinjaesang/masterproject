<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                                    <label for="productType" class="form-label">상품 유형</label>
                                    <select id="productType" name="productType" class="form-select">
                                        <option value="">전체</option>
                                        <option value="부품" ${param.productType eq '부품' ? 'selected' : ''}>부품</option>
                                        <option value="완제품" ${param.productType eq '완제품' ? 'selected' : ''}>완제품</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="supplier" class="form-label">공급처</label>
                                    <select id="supplier" name="partnerId" class="form-select">
                                        <option value="">전체</option>
                                        <c:if test="${not empty suppliers}">
                                            <c:forEach items="${suppliers}" var="supplier">
                                                <option value="${supplier.partnerId}" ${param.partnerId eq supplier.partnerId ? 'selected' : ''}>${supplier.partnerName}</option>
                                            </c:forEach>
                                        </c:if>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="searchCondition" class="form-label">검색조건</label>
                                    <select id="searchCondition" name="searchCondition" class="form-select">
                                        <option value="productName" ${param.searchCondition eq 'productName' ? 'selected' : ''}>상품명</option>
                                        <option value="productCode" ${param.searchCondition eq 'productCode' ? 'selected' : ''}>상품코드</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="searchKeyword" class="form-label">검색어</label>
                                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${param.searchKeyword}">
                                </div>
                                <div class="col-md-4">
                                    <label for="inventoryStatus" class="form-label">재고상태</label>
                                    <select id="inventoryStatus" name="inventoryStatus" class="form-select">
                                        <option value="">전체</option>
                                        <option value="NORMAL" ${param.inventoryStatus eq 'NORMAL' ? 'selected' : ''}>정상</option>
                                        <option value="LOW" ${param.inventoryStatus eq 'LOW' ? 'selected' : ''}>부족</option>
                                        <option value="ZERO" ${param.inventoryStatus eq 'ZERO' ? 'selected' : ''}>품절</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="dateRange" class="form-label">기간</label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" name="startDate" value="${param.startDate}">
                                        <span class="input-group-text">~</span>
                                        <input type="date" class="form-control" name="endDate" value="${param.endDate}">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="sortOrder" class="form-label">정렬</label>
                                    <select id="sortOrder" name="sortOrder" class="form-select">
                                        <option value="productId" ${param.sortOrder eq 'productId' ? 'selected' : ''}>상품코드</option>
                                        <option value="productName" ${param.sortOrder eq 'productName' ? 'selected' : ''}>상품명</option>
                                        <option value="partnerName" ${param.sortOrder eq 'partnerName' ? 'selected' : ''}>공급처</option>
                                        <option value="productType" ${param.sortOrder eq 'productType' ? 'selected' : ''}>상품유형</option>
                                        <option value="totalStock" ${param.sortOrder eq 'totalStock' ? 'selected' : ''}>전체재고</option>
                                        <option value="availableStock" ${param.sortOrder eq 'availableStock' ? 'selected' : ''}>가용재고</option>
                                        <option value="headOfficeStock" ${param.sortOrder eq 'headOfficeStock' ? 'selected' : ''}>본사창고</option>
                                        <option value="busanStock" ${param.sortOrder eq 'busanStock' ? 'selected' : ''}>부산창고</option>
                                        <option value="incheonStock" ${param.sortOrder eq 'incheonStock' ? 'selected' : ''}>인천창고</option>
                                        <option value="daeguStock" ${param.sortOrder eq 'daeguStock' ? 'selected' : ''}>대구창고</option>
                                        <option value="gwangjuStock" ${param.sortOrder eq 'gwangjuStock' ? 'selected' : ''}>광주창고</option>
                                        <option value="transitStock" ${param.sortOrder eq 'transitStock' ? 'selected' : ''}>경유창고</option>
                                        <option value="defectiveStock" ${param.sortOrder eq 'defectiveStock' ? 'selected' : ''}>불량창고</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="pageSize" class="form-label">페이지당 개수</label>
                                    <select id="pageSize" name="pageSize" class="form-select" onchange="this.form.submit()">
                                        <option value="20" ${param.pageSize eq '20' ? 'selected' : ''}>20개씩 보기</option>
                                        <option value="50" ${param.pageSize eq '50' ? 'selected' : ''}>50개씩 보기</option>
                                        <option value="100" ${param.pageSize eq '100' ? 'selected' : ''}>100개씩 보기</option>
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
                                            <th rowspan="2" style="vertical-align: middle;">구분</th>
                                            <th colspan="7">창고별 재고</th>
                                            <th rowspan="2" style="vertical-align: middle;">가용재고</th>
                                            <th rowspan="2" style="vertical-align: middle;">전체재고</th>
                                        </tr>
                                        <tr class="table-secondary">
                                            <th>본사창고</th>
                                            <th>부산창고</th>
                                            <th>인천창고</th>
                                            <th>대구창고</th>
                                            <th>광주창고</th>
                                            <th>경유창고</th>
                                            <th>불량창고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="table-light"><strong>수량 (개)</strong></td>
                                            <td><fmt:formatNumber value="${headOfficeSum}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${busanSum}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${incheonSum}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${daeguSum}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${gwangjuSum}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${transitSum}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${defectiveSum}" pattern="#,#00" /></td>
                                            <td><strong><fmt:formatNumber value="${availableSum}" pattern="#,#00" /></strong></td>
                                            <td><strong><fmt:formatNumber value="${totalSum}" pattern="#,#00" /></strong></td>
                                        </tr>
                                        <tr>
                                            <td class="table-light"><strong>원가 (원)</strong></td>
                                            <td><fmt:formatNumber value="${headOfficeCost}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${busanCost}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${incheonCost}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${daeguCost}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${gwangjuCost}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${transitCost}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${defectiveCost}" pattern="#,#00" /></td>
                                            <td><strong><fmt:formatNumber value="${availableCost}" pattern="#,#00" /></strong></td>
                                            <td><strong><fmt:formatNumber value="${totalCost}" pattern="#,#00" /></strong></td>
                                        </tr>
                                        <tr>
                                            <td class="table-light"><strong>판매가 (원)</strong></td>
                                            <td><fmt:formatNumber value="${headOfficeSell}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${busanSell}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${incheonSell}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${daeguSell}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${gwangjuSell}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${transitSell}" pattern="#,#00" /></td>
                                            <td><fmt:formatNumber value="${defectiveSell}" pattern="#,#00" /></td>
                                            <td><strong><fmt:formatNumber value="${availableSell}" pattern="#,#00" /></strong></td>
                                            <td><strong><fmt:formatNumber value="${totalSell}" pattern="#,#00" /></strong></td>
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
                                            <th scope="col">상품유형</th>
                                            <th scope="col">이미지</th>
                                            <th scope="col">상품명</th>
                                            <th scope="col">옵션</th>
                                            <th scope="col">본사창고</th>
                                            <th scope="col">부산창고</th>
                                            <th scope="col">인천창고</th>
                                            <th scope="col">대구창고</th>
                                            <th scope="col">광주창고</th>
                                            <th scope="col">경유창고</th>
                                            <th scope="col">불량창고</th>
                                            <th scope="col">가용재고</th>
                                            <th scope="col">전체재고</th>
                                            <th scope="col">안전재고</th>
                                            <th scope="col">재고상태</th>
                                            <th scope="col">원가</th>
                                            <th scope="col">판매가</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${not empty inventoryList}">
                                            <c:forEach items="${inventoryList}" var="item" varStatus="status">
                                                <tr>
                                                    <td><input class="form-check-input" type="checkbox" name="selectedItems" value="${item.productId}"></td>
                                                    <td>${status.count}</td>
                                                    <td>${item.partnerName}</td>
                                                    <td>${item.productId}</td>
                                                    <td>${item.productType}</td>
                                                    <td><img src="${pageContext.request.contextPath}/product/image/${item.productId}" alt="img" style="width: 30px; height: 30px;"></td>
                                                    <td>${item.productName}</td>
                                                    <td>${item.optionValue}</td>
                                                    <td>${item.headOfficeStock}</td>
                                                    <td>${item.busanStock}</td>
                                                    <td>${item.incheonStock}</td>
                                                    <td>${item.daeguStock}</td>
                                                    <td>${item.gwangjuStock}</td>
                                                    <td>${item.transitStock}</td>
                                                    <td>${item.defectiveStock}</td>
                                                    <td>${item.availableStock}</td>
                                                    <td>${item.totalStock}</td>
                                                    <td>${item.safeStock}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${item.availableStock == 0}">
                                                                <span class="badge bg-secondary">품절</span>
                                                            </c:when>
                                                            <c:when test="${item.availableStock lt item.safeStock}">
                                                                <span class="badge bg-danger">부족</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">정상</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td><fmt:formatNumber value="${item.costPrice}" pattern="#,###" /></td>
                                                    <td><fmt:formatNumber value="${item.sellingPrice}" pattern="#,###" /></td>
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
                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Page navigation" class="mt-3">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
                                            <form method="post" action="${pageContext.request.contextPath}/inventory/search.do" style="display:inline;">
                                                <input type="hidden" name="page" value="${currentPage - 1}" />
                                                <button class="page-link" type="submit" tabindex="-1">이전</button>
                                            </form>
                                        </li>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item <c:if test='${i == currentPage}'>active</c:if>'">
                                                <form method="post" action="${pageContext.request.contextPath}/inventory/search.do" style="display:inline;">
                                                    <input type="hidden" name="page" value="${i}" />
                                                    <button class="page-link" type="submit">${i}</button>
                                                </form>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>'">
                                            <form method="post" action="${pageContext.request.contextPath}/inventory/search.do" style="display:inline;">
                                                <input type="hidden" name="page" value="${currentPage + 1}" />
                                                <button class="page-link" type="submit">다음</button>
                                            </form>
                                        </li>
                                    </ul>
                                </nav>
                            </c:if>
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