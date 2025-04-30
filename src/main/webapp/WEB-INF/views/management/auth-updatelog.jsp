<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 권한 변경 로그</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

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
        .log-table th {
            background-color: #f8f9fa;
            font-weight: 500;
        }
        .log-table td {
            vertical-align: middle;
        }
        .change-type {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.85em;
            font-weight: 500;
        }
        .change-type.add {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        .change-type.modify {
            background-color: #fff3e0;
            color: #ef6c00;
        }
        .change-type.remove {
            background-color: #ffebee;
            color: #c62828;
        }
    </style>
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
        <jsp:include page="../common/sidebar.jsp" />
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <jsp:include page="../common/navbar.jsp" />
            <!-- Navbar End -->

            <!-- Auth Update Log Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="mb-4">
                    <h4 class="mb-0">계정 권한 관리</h4>
                    <small class="text-muted">사용자 계정 권한의 변경 로그를 관리할 수 있습니다.</small>
                </div>

                <!-- Tab Menu -->
                <div class="bg-light rounded p-3 mb-4">
                    <div class="nav nav-pills d-inline-flex text-center">
                        <button class="nav-link flex-fill me-1" 
                                onclick="location.href='${pageContext.request.contextPath}/authority/list.do'">
                            사용자 관리
                        </button>
                        <button class="nav-link flex-fill" 
                                onclick="location.href='${pageContext.request.contextPath}/authority/role.do'">
                            역할 관리
                        </button>
                        <button class="nav-link active flex-fill me-1" 
                                onclick="location.href='${pageContext.request.contextPath}/authority/log.do'">
                            권한 변경 로그
                        </button>
                    </div>
                </div>

                <!-- Log Table -->
                <div class="bg-light rounded p-4">
                    <div class="table-responsive">
                        <table class="table table-hover log-table">
                            <thead>
                                <tr>
                                    <th>변경 일시</th>
                                    <th>대상 사용자</th>
                                    <th>변경 유형</th>
                                    <th>이전 권한</th>
                                    <th>변경 권한</th>
                                    <th>변경자</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>2024-03-19 15:30:25</td>
                                    <td>홍길동</td>
                                    <td><span class="change-type add">추가</span></td>
                                    <td>일반 사용자</td>
                                    <td>관리자</td>
                                    <td>시스템 관리자</td>
                                </tr>
                                <tr>
                                    <td>2024-03-19 14:20:15</td>
                                    <td>김영희</td>
                                    <td><span class="change-type modify">수정</span></td>
                                    <td>읽기 전용</td>
                                    <td>일반 사용자</td>
                                    <td>시스템 관리자</td>
                                </tr>
                                <tr>
                                    <td>2024-03-19 11:45:30</td>
                                    <td>이철수</td>
                                    <td><span class="change-type remove">삭제</span></td>
                                    <td>부관리자</td>
                                    <td>일반 사용자</td>
                                    <td>시스템 관리자</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Auth Update Log End -->

            <!-- Footer Start -->
            <jsp:include page="../common/footer.jsp" />
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top">
            <i class="bi bi-arrow-up"></i>
        </a>
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
        $(document).ready(function() {
            // 스피너 숨기기
            $('#spinner').removeClass('show');
            
            // 컨텐츠 표시
            $('.content').addClass('show');
        });
    </script>
</body>
</html> 