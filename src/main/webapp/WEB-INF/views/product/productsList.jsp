<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 상품관리</title>
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

    <!-- Custom Styles for Edit Link -->
    <style>
        .edit-link {
            color: #0d6efd;
            text-decoration: none;
        }
        .edit-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }
    </style>
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

            <!-- Products Management Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">상품 관리</h6>
                        <a href="#" class="btn btn-primary">검색</a>
                    </div>

                    <!-- 검색창 및 필터링 섹션 -->
                    <div class="mb-4">
                        <form action="<c:url value='/products/list.do'/>" method="get">
                            <div class="row g-3">
                                <div class="col-md-2">
                                    <select class="form-select" name="supplier">
                                        <option value="">공급처</option>
                                        <c:forEach items="${suppliers}" var="supplier">
                                            <option value="${supplier}">${supplier}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <select class="form-select" name="searchType">
                                        <option value="">검색조건</option>
                                        <option value="name">상품명</option>
                                        <option value="option">옵션값</option>
                                        <option value="code">상품코드</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" name="searchKeyword" placeholder="상품명">
                                </div>
                                <div class="col-md-2">
                                    <input type="date" class="form-control" name="startDate" value="2025-01-31">
                                </div>
                                <div class="col-md-2">
                                    <input type="date" class="form-control" name="endDate" value="2025-03-31">
                                </div>
                                <div class="col-md-2">
                                    <select class="form-select" name="vendor">
                                        <option value="">판매처</option>
                                        <option value="A">판매처 A</option>
                                        <option value="B">판매처 B</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row g-3 mt-2">
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-secondary w-100">선택상품처리</button>
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-dark w-100">다운로드</button>
                                </div>
                                <div class="col-md-2">
                                    <a href="<c:url value='/products/register.do'/>" class="btn btn-primary w-100">상품등록</a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- 상품 테이블 -->
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col"><input class="form-check-input" type="checkbox"></th>
                                    <th scope="col">공급처</th>
                                    <th scope="col">작업</th>
                                    <th scope="col">이미지</th>
                                    <th scope="col">상품코드</th>
                                    <th scope="col">상품명</th>
                                    <th scope="col">제조사</th>
                                    <th scope="col">원산지</th>
                                    <th scope="col">옵션</th>
                                    <th scope="col">원가</th>
                                    <th scope="col">판매가</th>
                                    <th scope="col">카테고리</th>
                                    <th scope="col">등록일</th>
                                    <th scope="col">수정일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${products}" var="product">
                                    <tr>
                                        <td><input class="form-check-input" type="checkbox"></td>
                                        <td>${product.supplier}</td>
                                        <td>
                                            <a href="<c:url value='/products/edit.do?id=${product.id}'/>" class="edit-link">수정</a>
                                            <a href="<c:url value='/products/detail.do?id=${product.id}'/>" class="edit-link ms-2">상세</a>
                                        </td>
                                        <td><img src="<c:url value='/resources/img/${product.image}'/>" alt="이미지" style="width: 30px;"></td>
                                        <td>${product.code}</td>
                                        <td>${product.name}</td>
                                        <td>${product.manufacturer}</td>
                                        <td>${product.origin}</td>
                                        <td>${product.option}</td>
                                        <td>${product.costPrice} 원</td>
                                        <td>${product.sellingPrice} 원</td>
                                        <td>${product.category}</td>
                                        <td><fmt:formatDate value="${product.createdDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                        <td><fmt:formatDate value="${product.modifiedDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- 페이지네이션 -->
                    <div class="d-flex justify-content-center mt-4">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:if test="${pageInfo.hasPrevious}">
                                    <li class="page-item">
                                        <a class="page-link" href="<c:url value='/products/list.do?page=${pageInfo.currentPage - 1}'/>">«</a>
                                    </li>
                                </c:if>
                                <li class="page-item">
                                    <a class="page-link" href="<c:url value='/products/list.do?page=${pageInfo.currentPage}'/>">${pageInfo.currentPage}</a>
                                </li>
                                <c:if test="${pageInfo.hasNext}">
                                    <li class="page-item">
                                        <a class="page-link" href="<c:url value='/products/list.do?page=${pageInfo.currentPage + 1}'/>">»</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- Products Management End -->

            <!-- Footer Start -->
            <jsp:include page="../common/footer.jsp" />
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- Back to Top -->
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
            
            // 사이드바 토글 기능
            $('.sidebar-toggler').click(function() {
                $('.sidebar').toggleClass('open');
                $('.content').toggleClass('open');
                return false;
            });
        });
    </script>
</body>

</html>

