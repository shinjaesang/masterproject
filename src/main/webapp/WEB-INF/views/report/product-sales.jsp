<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 상품매출통계</title>
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
                                <h4 class="mb-0">상품매출통계 <!-- <i class="fa fa-question-circle text-muted ms-1"></i> --></h4> 
                            </div>

                            <!-- Search Filters -->
                            <div class="filter-section">
                                <form class="row g-3" action="${pageContext.request.contextPath}/statistics/product-sales.do" method="get">
                                    <div class="col-md-5">
                                        <label class="form-label">검색기간</label>
                                        <div class="input-group">
                                            <select class="form-select" style="max-width: 100px;">
                                                <option>발주일</option>
                                                <option>등록일</option>
                                            </select>
                                            <input type="date" class="form-control" name="startDate" value="2025-04-23">
                                            <input type="time" class="form-control" name="startTime" value="00:00:00">
                                            <span class="input-group-text">~</span>
                                            <input type="date" class="form-control" name="endDate" value="2025-04-23">
                                            <input type="time" class="form-control" name="endTime" value="23:59:59">
                                            <button class="btn btn-primary" type="submit">선택</button>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">판매처 정보</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="판매처 상품코드">
                                            <input type="text" class="form-control" placeholder="판매처 상품명">
                                            <input type="text" class="form-control" placeholder="판매처 옵션">
                                            <input type="text" class="form-control" placeholder="판매처 상품종류+옵션">
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">검색조건</label>
                                        <select class="form-select">
                                            <option>상품명</option>
                                        </select>
                                    </div>

                                    <div class="col-md-5">
                                        <label class="form-label">주문 정보</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="주문태그">
                                            <button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>
                                            <select class="form-select" style="max-width: 100px;">
                                                <option>관리</option>
                                            </select>
                                            <select class="form-select" style="max-width: 100px;">
                                                <option>전체포함</option>
                                            </select>
                                            <div class="input-group-text">
                                                <input class="form-check-input mt-0" type="checkbox"> 제외
                                            </div>
                                            <select class="form-select" style="max-width: 100px;">
                                                <option>상태 전체</option>
                                            </select>
                                            <select class="form-select" style="max-width: 100px;">
                                                <option>C/S 전체</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">판매처</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="전체">
                                            <button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>
                                            <button class="btn btn-outline-secondary" type="button">상세선택</button>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">공급처</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="전체">
                                            <button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>
                                            <button class="btn btn-outline-secondary" type="button">상세선택</button>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="includeTotalProduct" value="option1">
                                            <label class="form-check-label" for="includeTotalProduct">상품별합계 포함</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="viewTotalOption" value="option2">
                                            <label class="form-check-label" for="viewTotalOption">상품별합계만 조회</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="excludeGift" value="option3">
                                            <label class="form-check-label" for="excludeGift">사은품 제외</label>
                                        </div>
                                         <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="excludeShippingCancel" value="option4">
                                            <label class="form-check-label" for="excludeShippingCancel">배송후취소 제외</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="excludeGiftWrap" value="option5">
                                            <label class="form-check-label" for="excludeGiftWrap">선물포장비 제외</label>
                                        </div>
                                         <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="excludeDupeOrder" value="option6">
                                            <label class="form-check-label" for="excludeDupeOrder">주문복사 제외</label>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-2">
                                        <label class="form-label">카테고리</label>
                                        <select class="form-select">
                                            <option>전체</option>
                                        </select>
                                    </div>
                                     <div class="col-md-3">
                                        <label class="form-label">상품태그</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="상품태그">
                                            <button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>
                                            <button class="btn btn-outline-secondary" type="button">관리</button>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">정렬</label>
                                        <select class="form-select">
                                            <option>판매처>상품명>상품코드>옵션</option>
                                        </select>
                                    </div>
                                     <div class="col-md-3 text-end align-self-end">
                                        <button type="submit" class="btn btn-info"><i class="fa fa-search me-2"></i>검색</button>
                                        <button type="button" class="btn btn-secondary">검색관리</button>
                                    </div>
                                </form>
                            </div>

                            <!-- Action Buttons & Info -->
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <!-- <button class="btn btn-sm btn-outline-secondary">조회항목설정</button>
                                    <button class="btn btn-sm btn-outline-secondary">다운로드항목설정</button> -->
                                    <span class="ms-3 text-danger"><i class="fa fa-info-circle me-1"></i>배송 전 취소 주문 미포함, 배송 후 교환 주문 미포함</span>
                                </div>
                                <div>
                                    <button class="btn btn-sm btn-light border">다운로드</button>
                                </div>
                            </div>

                            <!-- Sales Table -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-sm text-center sales-table">
                                    <thead>
                                        <tr>
                                            <th>판매처</th><th>판매처 상품코드</th><th>판매처 상품명</th><th>주문수량</th><th>상품수</th>
                                            <th>판매금액</th><th>판매금액 합</th><th>상품원가</th><th>상품원가 합</th>
                                            <th>정산금액</th><th>마진금</th><th>마진율</th><th>매입율</th><th>메모</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                            
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