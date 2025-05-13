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
    
    <style>
        .bg-highlight {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .text-positive {
            color: #198754;
        }
        .text-negative {
            color: #dc3545;
        }
        
        /* 검색 버튼 애니메이션 */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .btn-pulse {
            animation: pulse 1.5s infinite;
            box-shadow: 0 0 0 0 rgba(0, 123, 255, 0.7);
        }
        
        /* 상품명 컬럼 스타일 */
        .product-name-col {
            min-width: 250px;
            width: 30%;
        }
        
        .product-name-cell {
            text-align: left;
            white-space: normal;
            word-break: break-word;
        }
        
        /* 테이블 셀 정렬 */
        .table th {
            vertical-align: middle;
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

            <!-- Daily Inventory Management Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">일자별 재고조회</h6>
                            <!-- Search Filters -->
                            <form id="searchForm" class="row g-3 mb-4 align-items-end" action="${pageContext.request.contextPath}/inventory/dailyInventory.do" method="get">
                                <input type="hidden" name="page" value="1" id="currentPage">
                                <div class="col-md-4">
                                    <label for="period" class="form-label">조회기간 (총 일자)</label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" name="startDate" value="${param.startDate}" placeholder="시작일">
                                        <span class="input-group-text">~</span>
                                        <input type="date" class="form-control" name="endDate" value="${param.endDate}" placeholder="종료일">
                                    </div>
                                   <!--  <div id="dateRangeDisplay" class="small text-muted mt-1"></div> -->
                                </div>
                                <div class="col-md-3">
                                    <label for="partnerType" class="form-label">거래처 유형</label>
                                    <select class="form-select" id="partnerType" name="partnerType">
                                        <option value="">전체</option>
                                        <option value="공급처" ${param.partnerType eq '공급처' ? 'selected' : ''}>공급처</option>
                                        <option value="판매처" ${param.partnerType eq '판매처' ? 'selected' : ''}>판매처</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label for="partnerId" class="form-label">거래처</label>
                                    <select class="form-select" id="partnerId" name="supplier">
                                        <option value="">전체</option>
                                        <c:choose>
                                            <c:when test="${empty partners}">
                                                <!-- 거래처 데이터가 없을 때 디버깅 메시지 -->
                                                <option value="" disabled>거래처 데이터를 불러올 수 없습니다</option>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${partners}" var="partner">
                                                    <option 
                                                        value="${partner.partnerId}" 
                                                        data-type="${partner.partnerType}" 
                                                        ${param.supplier eq partner.partnerId ? 'selected' : ''}>
                                                        ${partner.partnerName} (${partner.partnerType})
                                                    </option>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="productInfo" class="form-label">상품정보</label>
                                    <div class="input-group">
                                        <select id="productType" name="productType" class="form-select">
                                            <option value="">상품유형</option>
                                            <!-- 상품유형 목록 디버깅 -->
                                            <c:choose>
                                                <c:when test="${empty productTypes}">
                                                    <!-- 상품유형 데이터가 없을 경우 기본 옵션 표시 -->
                                                    <option value="부품">부품</option>
                                                    <option value="완제품">완제품</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${productTypes}" var="type">
                                                        <option value="${type.code}" ${param.productType eq type.code ? 'selected' : ''}>${type.name}</option>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </select>
                                        <select id="category" name="category" class="form-select">
                                            <option value="">카테고리</option>
                                            <!-- 카테고리 목록 디버깅 -->
                                            <c:choose>
                                                <c:when test="${empty categories}">
                                                    <!-- 카테고리 데이터가 없을 경우 기본 옵션 표시 -->
                                                    <option value="전자제품">전자제품</option>
                                                    <option value="전자부품">전자부품</option>
                                                    <option value="가전제품">가전제품</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${categories}" var="category">
                                                        <option value="${category.code}" ${param.category eq category.code ? 'selected' : ''}>${category.name}</option>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="productSearch" class="form-label">제품검색</label>
                                    <div class="input-group">
                                        <select id="searchType" name="searchType" class="form-select" style="max-width: 120px;">
                                            <option value="name" ${param.searchType eq 'name' ? 'selected' : ''}>상품명</option>
                                            <option value="code" ${param.searchType eq 'code' ? 'selected' : ''}>상품코드</option>
                                        </select>
                                        <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" value="${param.searchKeyword}" placeholder="검색어 입력">
                                        <c:if test="${not empty param.searchKeyword}">
                                            <button type="button" class="btn btn-outline-secondary" id="clearSearch" title="검색어 지우기">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </c:if>
                                    </div>
                                    <c:if test="${not empty param.searchKeyword}">
                                        <div class="small text-info mt-1">
                                            <i class="fas fa-search"></i> 
                                            <c:choose>
                                                <c:when test="${param.searchType eq 'code'}">상품코드</c:when>
                                                <c:otherwise>상품명</c:otherwise>
                                            </c:choose>
                                            "${param.searchKeyword}" 검색 결과입니다.
                                        </div>
                                    </c:if>
                                </div>
                                <div class="col-md-6 d-flex align-items-end gap-2">
                                    <button type="submit" class="btn btn-primary search-btn" id="searchButton" style="min-width: 100px;">
                                        <i class="fa fa-search me-2"></i>검색
                                    </button>
                                    <button type="button" class="btn btn-success" onclick="exportToExcel()" style="min-width: 100px;">
                                        <i class="fas fa-file-excel me-1"></i> 엑셀
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary" onclick="resetForm()" style="min-width: 100px;">
                                        <i class="fas fa-sync-alt me-1"></i> 초기화
                                    </button>
                                </div>
                            </form>
                            
                            <!-- Daily Inventory List -->
                            <div class="table-responsive">
                                <table class="table text-center align-middle table-bordered table-hover mb-0">
                                    <thead>
                                        <tr class="text-dark bg-light">
                                        	<th scope="col">거래처</th>
                                            <th scope="col">상품코드</th>
                                            <th scope="col" class="product-name-col" style="min-width: 200px;">상품명</th>
                                            <th scope="col">상품유형</th>
                                            <th scope="col">카테고리</th>
                                            <th scope="col">기간총입고</th>
                                            <th scope="col">기간총출고</th>
                                            <th scope="col">기간총재고</th>
                                            <c:if test="${not empty param.startDate and not empty param.endDate}">
                                                <c:forEach items="${dateHeaders}" var="date">
                                                    <th scope="col">${date}</th>
                                                </c:forEach>
                                            </c:if>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${not empty dailyInventoryList}">
                                            <c:forEach items="${dailyInventoryList}" var="item">
                                                <tr>
                                                    <td>${item.supplier}</td>
                                                    <td>${item.productCode}</td>
                                                    <td class="text-start product-name-cell">${item.productName}</td>
                                                    <td>${item.productType}</td>
                                                    <td>${item.category}</td>
                                                    <td class="text-positive">${item.periodInbound}</td>
                                                    <td class="text-negative">${item.periodOutbound}</td>
                                                    <td class="<c:choose><c:when test="${fn:contains(item.periodStock, '-')}">text-negative</c:when><c:otherwise>text-positive</c:otherwise></c:choose>">${item.periodStock}</td>
                                                    <c:if test="${not empty param.startDate and not empty param.endDate}">
                                                        <c:if test="${not empty item.dailyQuantities}">
                                                            <c:set var="dailyQtyArray" value="${fn:split(item.dailyQuantities, ',')}" />
                                                            <c:forEach items="${dailyQtyArray}" var="quantity" varStatus="status">
                                                                <td class="<c:choose><c:when test="${fn:contains(quantity, '-')}">text-negative</c:when><c:otherwise>text-positive</c:otherwise></c:choose>">${quantity}</td>
                                                            </c:forEach>
                                                        </c:if>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty dailyInventoryList}">
                                            <tr>
                                                <td colspan="${9 + (not empty param.startDate and not empty param.endDate ? fn:length(dateHeaders) : 0)}" class="text-center">
                                                    <c:choose>
                                                        <c:when test="${not empty noDataMessage}">
                                                            ${noDataMessage}
                                                        </c:when>
                                                        <c:otherwise>
                                                            데이터가 없습니다.
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
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
                                            <a class="page-link" href="${pageContext.request.contextPath}/inventory/dailyInventory.do?page=${pageInfo.currentPage - 1}&startDate=${param.startDate}&endDate=${param.endDate}&partnerType=${param.partnerType}&supplier=${param.supplier}&productType=${param.productType}&category=${param.category}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <c:forEach begin="1" end="${pageInfo.totalPages}" var="pageNum">
                                            <li class="page-item ${pageInfo.currentPage eq pageNum ? 'active' : ''}">
                                                <a class="page-link" href="${pageContext.request.contextPath}/inventory/dailyInventory.do?page=${pageNum}&startDate=${param.startDate}&endDate=${param.endDate}&partnerType=${param.partnerType}&supplier=${param.supplier}&productType=${param.productType}&category=${param.category}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${pageNum}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${pageInfo.currentPage eq pageInfo.totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/inventory/dailyInventory.do?page=${pageInfo.currentPage + 1}&startDate=${param.startDate}&endDate=${param.endDate}&partnerType=${param.partnerType}&supplier=${param.supplier}&productType=${param.productType}&category=${param.category}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                    <span class="ms-3 align-self-center text-muted">${pageInfo.currentPage} / ${pageInfo.totalPages} 페이지</span>
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
    
    <!-- 디버깅 정보: 현재 페이지 에서만 확인 용도 (배포 시 삭제) -->
    <div style="display:none" id="debugInfo">
        <h4>카테고리 변수 디버깅</h4>
        <p>categories 변수가 비었나요? ${empty categories}</p>
        <p>카테고리 목록:</p>
        <ul>
            <c:forEach items="${categories}" var="category">
                <li>코드: ${category.code}, 이름: ${category.name}</li>
            </c:forEach>
        </ul>
        
        <h4>상품유형 변수 디버깅</h4>
        <p>productTypes 변수가 비었나요? ${empty productTypes}</p>
        <p>상품유형 목록:</p>
        <ul>
            <c:forEach items="${productTypes}" var="type">
                <li>코드: ${type.code}, 이름: ${type.name}</li>
            </c:forEach>
        </ul>
        
        <h4>거래처 디버깅</h4>
        <p>partners 변수가 비었나요? ${empty partners}</p>
        <p>거래처 목록:</p>
        <ul>
            <c:forEach items="${partners}" var="partner">
                <li>ID: ${partner.partnerId}, 이름: ${partner.partnerName}, 유형: ${partner.partnerType}</li>
            </c:forEach>
        </ul>
    </div>
    <script>
        $(document).ready(function() {
            // 오늘 날짜와 7일 전 날짜를 기본으로 설정
            if (!$('input[name="startDate"]').val()) {
                const today = new Date();
                const sevenDaysAgo = new Date(today);
                sevenDaysAgo.setDate(today.getDate() - 7);
                
                $('input[name="startDate"]').val(formatDate(sevenDaysAgo));
                $('input[name="endDate"]').val(formatDate(today));
            }
            
            // 거래처 유형 변경 이벤트 리스너
            $('#partnerType').change(function() {
                console.log("거래처 유형 변경됨:", $(this).val());
                updatePartnerList();
                highlightSearchButton();
            });
            
            // 상품유형과 카테고리 변경 이벤트 리스너
            $('#productType, #category').change(function() {
                console.log($(this).attr('id') + " 변경됨:", $(this).val());
                highlightSearchButton();
            });
            
            // 검색어 입력 및 검색 유형 변경 이벤트 리스너
            $('#searchKeyword').on('input', function() {
                console.log("검색어 입력됨:", $(this).val());
                if ($(this).val().trim().length > 0) {
                    highlightSearchButton();
                }
            });

            $('#searchType').change(function() {
                console.log("검색 유형 변경됨:", $(this).val());
                if ($('#searchKeyword').val().trim().length > 0) {
                    highlightSearchButton();
                }
            });

            // 엔터 키로 검색 제출
            $('#searchKeyword').keypress(function(e) {
                if (e.which === 13) {
                    e.preventDefault();
                    $('#searchForm').submit();
                }
            });
            
            // 검색어 지우기 버튼 이벤트
            $('#clearSearch').click(function() {
                $('#searchKeyword').val('');
                $('#searchForm').submit();
            });
            
            // 초기 데이터 저장 및 거래처 목록 업데이트
            window.allPartners = [];
            
            // DOM에서 데이터 속성 확인 및 디버깅
            console.log("== 거래처 데이터 속성 확인 ==");
            $('#partnerId option').each(function(idx) {
                const $option = $(this);
                
                if ($option.val()) {
                    const rawType = $option.data('type');
                    console.log("옵션 " + idx + ": 값=" + $option.val() + ", 텍스트=" + $option.text() + ", 타입=" + rawType);
                    
                    // data- 속성이 제대로 설정되지 않았을 수 있으므로 텍스트에서 추출 시도
                    let type = rawType || "";
                    if (!type) {
                        const match = $option.text().match(/\(([^)]+)\)$/);
                        if (match && match[1]) {
                            type = match[1];
                            console.log("  텍스트에서 타입 추출: " + type);
                        }
                    }
                    
                    window.allPartners.push({
                        id: $option.val(),
                        name: $option.text().replace(/ \([^)]+\)$/, ''), // 괄호 내용 제거
                        type: type
                    });
                }
            });
            
            console.log("초기 거래처 목록:", window.allPartners);
            
            // 초기 거래처 목록 필터링 적용
            updatePartnerList();
            
            // 디버그 정보: 카테고리와 상품유형 데이터 콘솔에 출력
            console.log("카테고리 데이터 확인:");
            var categories = [];
            $('#category option').each(function() {
                if ($(this).val()) {
                    categories.push({
                        code: $(this).val(),
                        name: $(this).text()
                    });
                }
            });
            console.log(categories);
            
            console.log("상품유형 데이터 확인:");
            var productTypes = [];
            $('#productType option').each(function() {
                if ($(this).val()) {
                    productTypes.push({
                        code: $(this).val(),
                        name: $(this).text()
                    });
                }
            });
            console.log(productTypes);
            
            // 초기 상태에서 검색 버튼 강조 효과 추가
            const hasStartDate = $('input[name="startDate"]').val();
            const hasEndDate = $('input[name="endDate"]').val();
            const hasParamStartDate = "${not empty param.startDate}" === "true";
            const hasParamEndDate = "${not empty param.endDate}" === "true";
            
            if (!hasStartDate || !hasEndDate || (!hasParamStartDate || !hasParamEndDate)) {
                $('#searchButton').addClass('btn-pulse');
            } else {
                $('#searchButton').removeClass('btn-pulse');
            }
            
            // 날짜 필드 변경 시 검색 버튼 상태 업데이트
            $('input[name="startDate"], input[name="endDate"]').on('change', function() {
                updateSearchButtonState();
            });
            
            // 거래처 유형 변경 시 거래처 목록 업데이트
            $('#partnerType').change(function() {
                updatePartnerList();
            });
            
            // 초기 로드 시 거래처 유형에 따른 거래처 목록 필터링
            updatePartnerList();
            
            // 폼 제출 시 날짜 검증
            $('#searchForm').on('submit', function(e) {
                const startDate = $('input[name="startDate"]').val();
                const endDate = $('input[name="endDate"]').val();
                
                if (!startDate || !endDate) {
                    e.preventDefault();
                    alert('조회 시작일과 종료일을 모두 선택해주세요.');
                    return false;
                }
                
                const start = new Date(startDate);
                const end = new Date(endDate);
                
                if (start > end) {
                    e.preventDefault();
                    alert('시작일은 종료일보다 이전이어야 합니다.');
                    return false;
                }
                
                // 30일 이상의 기간을 선택한 경우 경고
                const daysDiff = Math.floor((end - start) / (1000 * 60 * 60 * 24));
                if (daysDiff > 30) {
                    if (!confirm('30일 이상의 기간을 조회하면 데이터 로딩이 오래 걸릴 수 있습니다. 계속하시겠습니까?')) {
                        e.preventDefault();
                        return false;
                    }
                }
                
                // 검색 버튼 애니메이션 제거
                $('#searchButton').removeClass('btn-pulse');
                return true;
            });
            
            // 검색 필터 변경 시 이벤트 처리
            $('.form-select, input[type="date"], input[type="text"]').on('change', function() {
                // 검색 필터가 변경되면 페이지를 1로 초기화
                $('#currentPage').val(1);
            });
            
            // 검색 버튼 애니메이션 효과
            $("#searchButton").on("click", function() {
                $(this).addClass("btn-pulse");
                setTimeout(function() {
                    $("#searchButton").removeClass("btn-pulse");
                }, 500);
            });

            // 날짜 선택 시 날짜 범위 표시 업데이트
            $('input[name="startDate"], input[name="endDate"]').on('change', function() {
                updateDateRangeDisplay();
            });

            // 초기 페이지 로드 시 날짜 범위 표시 업데이트
            updateDateRangeDisplay();
        });
        
        // 검색 버튼 상태 업데이트 함수
        function updateSearchButtonState() {
            const startDate = $('input[name="startDate"]').val();
            const endDate = $('input[name="endDate"]').val();
            
            if (startDate && endDate) {
                $('#searchButton').removeClass('btn-pulse');
            } else {
                $('#searchButton').addClass('btn-pulse');
            }
        }
        
        // 날짜 범위 표시 함수
        function updateDateRangeDisplay() {
            const startDate = $('input[name="startDate"]').val();
            const endDate = $('input[name="endDate"]').val();
            
            if (startDate && endDate) {
                const startDateObj = new Date(startDate);
                const endDateObj = new Date(endDate);
                const diffTime = Math.abs(endDateObj - startDateObj);
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
                
                $('#dateRangeDisplay').text(`${startDate} ~ ${endDate} (총 ${diffDays}일)`);
                $('#searchButton').removeClass('btn-pulse');
            } else {
                $('#dateRangeDisplay').text('');
                $('#searchButton').addClass('btn-pulse');
            }
        }
        
        // 거래처 목록 필터링 함수
        function updatePartnerList() {
            const partnerType = $('#partnerType').val();
            const selectedPartnerId = '${param.supplier}';
            
            console.log("거래처 필터링 - 선택된 유형: " + partnerType);
            console.log("현재 선택된 거래처 ID: " + selectedPartnerId);
            
            // 전체 거래처 목록 수집
            if (!window.allPartners || window.allPartners.length === 0) {
                console.log("거래처 목록 초기화 중...");
                window.allPartners = [];
                $('#partnerId option').each(function() {
                    if ($(this).val()) {
                        const type = $(this).data('type') || "";
                        window.allPartners.push({
                            id: $(this).val(),
                            name: $(this).text().replace(` (${type})`, ''), // 유형 표시 제거
                            type: type
                        });
                    }
                });
                
                console.log("수집된 전체 거래처 목록:", window.allPartners);
                
                // 타입별 거래처 수 확인
                const supplierCount = window.allPartners.filter(p => p.type === '공급처').length;
                const vendorCount = window.allPartners.filter(p => p.type === '판매처').length;
                const unknownCount = window.allPartners.filter(p => !p.type || p.type === '').length;
                
                console.log("거래처 타입 통계: 공급처=" + supplierCount + ", 판매처=" + vendorCount + ", 알 수 없음=" + unknownCount);
            }
            
            // 거래처 select 초기화
            $('#partnerId').empty().append('<option value="">전체</option>');
            
            // 유형에 따라 필터링
            let filteredPartners = [];
            if (partnerType) {
                // 선택된 유형과 일치하는 거래처만 필터링
                filteredPartners = window.allPartners.filter(p => {
                    const match = (p.type === partnerType);
                    if (!match && p.type) {
                        console.log("타입 불일치: 파트너=" + p.name + ", 타입=" + p.type + ", 요청된 타입=" + partnerType);
                    }
                    return match;
                });
                console.log("'" + partnerType + "' 유형의 거래처 " + filteredPartners.length + "개 필터링됨");
            } else {
                // 전체 선택 시 모든 거래처 표시
                filteredPartners = window.allPartners;
                console.log("전체 거래처 " + filteredPartners.length + "개 표시");
            }
            
            // 필터링된 거래처 목록 추가
            filteredPartners.forEach(p => {
                const selected = p.id === selectedPartnerId ? 'selected' : '';
                $('#partnerId').append('<option value="' + p.id + '" data-type="' + p.type + '" ' + selected + '>' + p.name + (p.type ? ' (' + p.type + ')' : '') + '</option>');
            });
            
            // 드롭다운 상태 확인
            console.log("필터링 후 거래처 드롭다운 옵션 수: " + $('#partnerId option').length);
        }
        
        // 날짜 포맷 함수 (YYYY-MM-DD)
        function formatDate(date) {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        }
        
        // 폼 초기화
        function resetForm() {
            // select 요소 초기화
            $('form select').val('');
            
            // 텍스트 입력 필드 초기화
            $('form input[type="text"]').val('');
            
            // 날짜 필드는 기본값으로 설정
            const today = new Date();
            const sevenDaysAgo = new Date(today);
            sevenDaysAgo.setDate(today.getDate() - 7);
            
            $('input[name="startDate"]').val(formatDate(sevenDaysAgo));
            $('input[name="endDate"]').val(formatDate(today));
            $('input[name="productStartDate"]').val('');
            $('input[name="productEndDate"]').val('');
            
            // 날짜 범위 표시 업데이트
            updateDateRangeDisplay();
            
            // 현재 URL에서 파라미터를 제거한 URL로 이동
            //window.location.href = window.location.pathname;
        }

        // 엑셀 다운로드
        function exportToExcel() {
            // 조회 조건 검증
            const startDate = $('input[name="startDate"]').val();
            const endDate = $('input[name="endDate"]').val();
            
            if (!startDate || !endDate) {
                alert('조회 시작일과 종료일을 모두 선택한 후 검색해야 엑셀 다운로드가 가능합니다.');
                return;
            }
            
            // 검색 결과가 없는 경우 확인
            if ($('tbody tr td[colspan]').length > 0) {
                if (!confirm('검색 결과가 없습니다. 그래도 엑셀 다운로드를 진행하시겠습니까?')) {
                    return;
                }
            }
            
            // 폼 데이터를 복제
            const formData = $('#searchForm').serialize();
            // 엑셀 다운로드 URL로 이동
            window.location.href = '${pageContext.request.contextPath}/inventory/dailyInventory/export.do?' + formData;
        }

        // 디버깅 모드 활성화 (F12 누르면 디버그 정보 표시)
        $(document).keydown(function(e) {
            if (e.keyCode === 123) { // F12 키
                $('#debugInfo').toggle();
                return false;
            }
        });

        // 검색 버튼 강조 표시 함수
        function highlightSearchButton() {
            $('#searchButton').addClass('btn-pulse');
            setTimeout(function() {
                $('#searchButton').removeClass('btn-pulse');
            }, 1500);
        }
    </script>
</body>
</html> 