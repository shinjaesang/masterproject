<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 상품등록</title>
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
        <div id="spinner" class="bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
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

            <!-- Product Registration Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">상품 등록</h6>
                            <form action="<c:url value='/products/register.do'/>" method="post" enctype="multipart/form-data">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="supplier" class="form-label">공급처</label>
                                        <select class="form-select" id="supplier" name="supplier" required>
                                            <option value="">공급처 선택</option>
                                            <c:forEach items="${suppliers}" var="supplier">
                                                <option value="${supplier}">${supplier}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="category" class="form-label">카테고리</label>
                                        <select class="form-select" id="category" name="category" required>
                                            <option value="">카테고리 선택</option>
                                            <c:forEach items="${categories}" var="category">
                                                <option value="${category}">${category}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="code" class="form-label">상품코드</label>
                                        <input type="text" class="form-control" id="code" name="code" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="name" class="form-label">상품명</label>
                                        <input type="text" class="form-control" id="name" name="name" required>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="manufacturer" class="form-label">제조사</label>
                                        <input type="text" class="form-control" id="manufacturer" name="manufacturer" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="origin" class="form-label">원산지</label>
                                        <input type="text" class="form-control" id="origin" name="origin" required>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="option" class="form-label">옵션</label>
                                        <input type="text" class="form-control" id="option" name="option">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="image" class="form-label">상품 이미지</label>
                                        <input type="file" class="form-control" id="image" name="image" accept="image/*">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="costPrice" class="form-label">원가</label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" id="costPrice" name="costPrice" required>
                                            <span class="input-group-text">원</span>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="sellingPrice" class="form-label">판매가</label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" id="sellingPrice" name="sellingPrice" required>
                                            <span class="input-group-text">원</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-12">
                                        <label for="description" class="form-label">상품 설명</label>
                                        <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary">등록</button>
                                        <a href="<c:url value='/products/list.do'/>" class="btn btn-secondary">취소</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Product Registration End -->

            <!-- Footer Start -->
            <jsp:include page="../common/footer.jsp" />
            <!-- Footer End -->
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

    <!-- Spinner Handler -->
    <script>
        $(document).ready(function() {
            // 페이지 로드 완료 시 스피너 숨기기
            $('#spinner').removeClass('show');
        });
    </script>
</body>
</html> 