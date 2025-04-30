<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 - Stockmaster</title>
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
    <div class="container-xxl position-relative bg-white d-flex p-0">
        <!-- Sidebar Start -->
        <jsp:include page="../common/sidebar.jsp" />
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <jsp:include page="../common/navbar.jsp" />
            <!-- Navbar End -->

            <!-- Notice List Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h5 class="mb-0">공지사항</h5>
                        <button type="button" class="btn btn-primary" onclick="location.href='noticeswrite.do'">
                            <i class="fa fa-plus me-2"></i>새 공지사항
                        </button>
                    </div>
                    <div class="table-responsive">
                        <table class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col">번호</th>
                                    <th scope="col" style="width: 50%">제목</th>
                                    <th scope="col">작성자</th>
                                    <th scope="col">작성일</th>
                                    <th scope="col">조회수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${notices}" var="notice" varStatus="status">
                                    <tr>
                                        <td>${notice.noticeId}</td>
                                        <td class="text-start">
                                            <a href="noticesView.do?noticeId=${notice.noticeId}" class="text-dark">
                                                ${notice.title}
                                                <c:if test="${notice.isNew}">
                                                    <span class="badge bg-danger ms-2">NEW</span>
                                                </c:if>
                                            </a>
                                        </td>
                                        <td>${notice.writer}</td>
                                        <td><fmt:formatDate value="${notice.createdDate}" pattern="yyyy-MM-dd"/></td>
                                        <td>${notice.viewCount}</td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty notices}">
                                    <tr>
                                        <td colspan="5" class="text-center">등록된 공지사항이 없습니다.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Pagination Start -->
                    <div class="d-flex justify-content-center mt-4">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <c:if test="${pageMaker.prev}">
                                    <li class="page-item">
                                        <a class="page-link" href="notices.do?page=${pageMaker.startPage-1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                
                                <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
                                    <li class="page-item ${pageMaker.cri.page == pageNum ? 'active' : ''}">
                                        <a class="page-link" href="notices.do?page=${pageNum}">${pageNum}</a>
                                    </li>
                                </c:forEach>
                                
                                <c:if test="${pageMaker.next}">
                                    <li class="page-item">
                                        <a class="page-link" href="notices.do?page=${pageMaker.endPage+1}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                    <!-- Pagination End -->
                </div>
            </div>
            <!-- Notice List End -->

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
    
    <script>
        function goToWrite() {
            window.location.href = 'noticesWrite.do';
        }
        
        // 페이지 로드 완료 시 실행
        $(document).ready(function() {
            // spinner 요소가 있다면 제거
            if ($("#spinner").length > 0) {
                $("#spinner").removeClass("show");
            }
        });
    </script>
</body>
</html>
