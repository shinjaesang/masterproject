<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error.jsp" %>
<%-- page 지시자 태그 안에 errorPage 속성 추가할 수 있음
	errorPage 속성은 이 jsp 페이지에서 에러가 발생하면, 지정한 jsp 페이지로 에러를 넘기면서 페이지 바꾸기함
 --%>    
<%-- jsp 페이지에서 사용하는 jsp element 중 지시자 태그 (directive tag) 에서 page 지시자는 jsp 페이지에 한번만 사용할 수 있음
	page 지시자 태그에서 주로 이 페이지의 설정 정보를 속성으로 처리함
	import 속성만 분리할 수 있음
 --%>
 <%-- jsp 페이지에서 EL (Expression Language : 표현언어)을 사용한다면, import 필요없음 --%>
 <%-- <%@ page import="org.myweb.first.member.model.dto.Member" %> --%>
<%-- <%@ taglib uri="https://jakarta.ee/jsp/jstl/core" prefix="c" %> --%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
  <%-- jstl의 core 라이브러리 사용을 선언함 --%>
<%--  <%
	//로그인 상태를 확인하기 위해서 세션 객체에 저장된 로그인한 회원 정보를 추출함
	//request 에 자동 등록된 session id 를 가지고, 세션 id가 일치하는 세션 객체를 찾아옴
	Member loginUser = (Member)session.getAttribute("loginUser");
%>  --%>  <%-- EL 사용시 필요없음 --%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Stockmaster</title>
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
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->

        <!-- Sidebar Start -->
        <jsp:include page="sidebar.jsp" />
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <jsp:include page="navbar.jsp" />
            <!-- Navbar End -->

            <!-- Inventory Metrics Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-boxes fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">총 재고 수량</p>
                                <h6 class="mb-0">12,345 개</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-exclamation-triangle fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">재고 부족 품목</p>
                                <h6 class="mb-0">23 개</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-truck fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">오늘 입고</p>
                                <h6 class="mb-0">1,234 개</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-dolly fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">오늘 출고</p>
                                <h6 class="mb-0">1,234 개</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Inventory Metrics End -->

            <!-- Inventory Charts Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">재고 회전율</h6>
                                <a href="">자세히 보기</a>
                            </div>
                            <canvas id="inventory-turnover"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-12 col-xl-6">
                        <div class="bg-light text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">카테고리별 재고</h6>
                                <a href="">자세히 보기</a>
                            </div>
                            <canvas id="category-inventory"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Inventory Charts End -->

            <!-- Recent Transactions Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">최근 재고 거래</h6>
                        <a href="">모두 보기</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col"><input class="form-check-input" type="checkbox"></th>
                                    <th scope="col">날짜</th>
                                    <th scope="col">거래 ID</th>
                                    <th scope="col">제품명</th>
                                    <th scope="col">수량</th>
                                    <th scope="col">유형</th>
                                    <th scope="col">작업</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                    <td>2025-04-21</td>
                                    <td>TRN-001</td>
                                    <td>전자제품 A</td>
                                    <td>100</td>
                                    <td>입고</td>
                                    <td><a class="btn btn-sm btn-primary" href="">상세</a></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                    <td>2025-04-21</td>
                                    <td>TRN-002</td>
                                    <td>의류 B</td>
                                    <td>50</td>
                                    <td>출고</td>
                                    <td><a class="btn btn-sm btn-primary" href="">상세</a></td>
                                </tr>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox"></td>
                                    <td>2025-04-21</td>
                                    <td>TRN-003</td>
                                    <td>식품 C</td>
                                    <td>200</td>
                                    <td>입고</td>
                                    <td><a class="btn btn-sm btn-primary" href="">상세</a></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Recent Transactions End -->

            <!-- Widgets Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-12 col-md-6 col-xl-4">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <h6 class="mb-0">비상연락망</h6>
                                <a href="">모두 보기</a>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-3">
                                <i class="fa fa-phone-alt text-primary me-3"></i>
                                <div class="w-100">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h6 class="mb-0">김관리</h6>
                                        <small>창고 관리자</small>
                                    </div>
                                    <span>010-1234-5678</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-3">
                                <i class="fa fa-phone-alt text-primary me-3"></i>
                                <div class="w-100">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h6 class="mb-0">이책임</h6>
                                        <small>재고 담당자</small>
                                    </div>
                                    <span>010-9876-5432</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-6 col-xl-4">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">공지사항</h6>
                                <a href="notices.html">모두 보기</a>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-3">
                                <i class="fa fa-bullhorn text-primary me-3"></i>
                                <div class="w-100">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h6 class="mb-0">시스템 점검 안내</h6>
                                        <small>2025-04-22</small>
                                    </div>
                                    <span>04월 25일 00:00~02:00 시스템 점검</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center border-bottom py-3">
                                <i class="fa fa-bullhorn text-primary me-3"></i>
                                <div class="w-100">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h6 class="mb-0">재고 조사 안내</h6>
                                        <small>2025-04-20</small>
                                    </div>
                                    <span>04월 30일 재고 조사 예정</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-6 col-xl-4">
                        <div class="h-100 bg-light rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">창고 현황</h6>
                                <a href="">모두 보기</a>
                            </div>
                            <div id="warehouse-status"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Widgets End -->

            <!-- Footer Start -->
            <jsp:include page="footer.jsp" />
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>

    <!-- JavaScript Libraries -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/lib/chart/chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/lib/tempusdominus/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script>
        // Spinner
        var spinner = function () {
            setTimeout(function () {
                if ($('#spinner').length > 0) {
                    $('#spinner').removeClass('show');
                }
            }, 1);
        };
        spinner();

        // Back to top button
        $(window).scroll(function () {
            if ($(this).scrollTop() > 300) {
                $('.back-to-top').fadeIn('slow');
            } else {
                $('.back-to-top').fadeOut('slow');
            }
        });
        $('.back-to-top').click(function () {
            $('html, body').animate({scrollTop: 0}, 1500, 'easeInOutExpo');
            return false;
        });

        // Sidebar Toggler
        $('.sidebar-toggler').click(function () {
            $('.sidebar, .content').toggleClass("open");
            return false;
        });
    </script>

    <!-- Chart Initialization -->
    <script>
        // 재고 회전율 차트
        var ctx1 = document.getElementById('inventory-turnover').getContext('2d');
        var inventoryTurnoverChart = new Chart(ctx1, {
            type: 'line',
            data: {
                labels: ['1월', '2월', '3월', '4월', '5월', '6월'],
                datasets: [{
                    label: '재고 회전율',
                    data: [12, 19, 3, 5, 2, 3],
                    backgroundColor: 'rgba(0, 123, 255, 0.2)',
                    borderColor: 'rgba(0, 123, 255, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // 카테고리별 재고 차트
        var ctx2 = document.getElementById('category-inventory').getContext('2d');
        var categoryInventoryChart = new Chart(ctx2, {
            type: 'doughnut',
            data: {
                labels: ['전자제품', '의류', '식품', '가구', '문구'],
                datasets: [{
                    data: [300, 200, 150, 100, 50],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true
            }
        });
    </script>
</body>
</html>














