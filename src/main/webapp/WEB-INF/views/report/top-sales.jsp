<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 판매베스트</title>
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
        .best-table-section {
            margin-bottom: 30px;
        }
        .best-table th {
            background-color: #e9ecef;
            font-weight: 600;
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

            <!-- Top Sales Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h4 class="mb-4">판매베스트</h4>

                            <!-- Search Filters -->
                            <div class="filter-section">
                                <form class="row g-3 align-items-end" action="${pageContext.request.contextPath}/statistics/top-sales.do" method="get">
                                    <div class="col-md-4">
                                        <label for="searchPeriod" class="form-label">검색기간</label>
                                        <div class="input-group">
                                            <select class="form-select" style="max-width: 100px;">
                                                <option>발주일</option>
                                                <option>등록일</option>
                                            </select>
                                            <input type="date" class="form-control" name="startDate" value="2025-04-24">
                                            <span class="input-group-text">~</span>
                                            <input type="date" class="form-control" name="endDate" value="2025-04-24">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="seller" class="form-label">판매처</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="seller" name="seller" placeholder="전체">
                                            <button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>
                                            <button class="btn btn-outline-secondary" type="button">상세선택</button>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="supplier" class="form-label">공급처</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="supplier" name="supplier" placeholder="전체">
                                            <button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>
                                            <button class="btn btn-outline-secondary" type="button">상세선택</button>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                         <button type="submit" class="btn btn-primary w-100">선택</button>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="criteria" class="form-label">조회기준</label>
                                        <select id="criteria" name="criteria" class="form-select">
                                            <option value="quantity" selected>수량</option>
                                            <option value="amount">금액</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="productCriteria" class="form-label">상품기준</label>
                                        <select id="productCriteria" name="productCriteria" class="form-select">
                                            <option value="option" selected>옵션별보기</option>
                                            <option value="product">상품별보기</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 ms-auto text-end">
                                        <button type="submit" class="btn btn-info"><i class="fa fa-search me-2"></i>검색</button>
                                        <button type="button" class="btn btn-secondary"><i class="fa fa-download me-2"></i>다운로드</button>
                                    </div>
                                </form>
                            </div>
                            
                            <!-- Best 10 Tables -->
                            <div class="row">
                                <!-- Best 10 판매상품 -->
                                <div class="col-md-6 best-table-section">
                                    <h6>Best 10 판매상품</h6>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm text-center">
                                            <thead><tr><th>순위</th><th>상품이미지</th><th>상품명</th><th>옵션</th><th>공급처상품명</th><th>판매수량 <i class="fa fa-question-circle"></i></th><th>취소수량</th></tr></thead>
                                            <tbody><!-- 데이터 영역 --></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- Best 10 취소상품 -->
                                <div class="col-md-6 best-table-section">
                                    <h6>Best 10 취소상품</h6>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm text-center">
                                            <thead><tr><th>순위</th><th>상품이미지</th><th>상품명</th><th>옵션</th><th>공급처상품명</th><th>발주수량 <i class="fa fa-question-circle"></i></th><th>취소수량</th><th>취소율</th><th>배송전취소</th><th>배송후취소</th></tr></thead>
                                            <tbody><!-- 데이터 영역 --></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- Best 10 판매처 -->
                                <div class="col-md-6 best-table-section">
                                    <h6>Best 10 판매처</h6>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm text-center">
                                            <thead><tr><th>순위</th><th>판매처명</th><th>판매수량 <i class="fa fa-question-circle"></i></th><th>취소수량</th></tr></thead>
                                            <tbody><!-- 데이터 영역 --></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- Best 10 공급처 -->
                                <div class="col-md-6 best-table-section">
                                    <h6>Best 10 공급처</h6>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm text-center">
                                            <thead><tr><th>순위</th><th>공급처명</th><th>판매수량 <i class="fa fa-question-circle"></i></th><th>취소수량</th></tr></thead>
                                            <tbody><!-- 데이터 영역 --></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- Best 10 제조사 -->
                                <div class="col-md-6 best-table-section">
                                    <h6>Best 10 제조사</h6>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm text-center">
                                            <thead><tr><th>순위</th><th>제조사명</th><th>판매수량 <i class="fa fa-question-circle"></i></th><th>취소수량</th></tr></thead>
                                            <tbody><!-- 데이터 영역 --></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- Best 10 원산지 -->
                                <div class="col-md-6 best-table-section">
                                    <h6>Best 10 원산지</h6>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm text-center">
                                            <thead><tr><th>순위</th><th>원산지명</th><th>판매수량 <i class="fa fa-question-circle"></i></th><th>취소수량</th></tr></thead>
                                            <tbody><!-- 데이터 영역 --></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- Best 10 상품태그 -->
                                <div class="col-md-6 best-table-section">
                                    <h6>Best 10 상품태그</h6>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm text-center">
                                            <thead><tr><th>순위</th><th>상품태그명</th><th>판매수량 <i class="fa fa-question-circle"></i></th><th>취소수량</th></tr></thead>
                                            <tbody><!-- 데이터 영역 --></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- Best 10 카테고리 -->
                                <div class="col-md-6 best-table-section">
                                    <h6>Best 10 카테고리</h6>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm text-center">
                                            <thead><tr><th>순위</th><th>카테고리명</th><th>판매수량 <i class="fa fa-question-circle"></i></th><th>취소수량</th></tr></thead>
                                            <tbody><!-- 데이터 영역 --></tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Top Sales End -->
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
            // nth-of-type 인덱스는 실제 메뉴 구조에 맞게 조정해야 합니다.
            const statisticsMenu = document.querySelector('.nav-link.dropdown-toggle:nth-of-type(9)'); 
            if (statisticsMenu) {
                statisticsMenu.classList.add('active');
            }
        });
    </script>
</body>
</html> 