<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 등록 - Stockmaster</title>
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
    
    <!-- CKEditor 5 -->
    <script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>
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

            <!-- Notice Write Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h5 class="mb-0">공지사항 등록</h5>
                    </div>
                    
                    <form action="noticesWrite.do" method="post">
                        <div class="mb-3">
                            <label for="title" class="form-label">제목</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="content" class="form-label">내용</label>
                            <textarea class="form-control" id="content" name="content" rows="10" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="writer" class="form-label">작성자</label>
                            <input type="text" class="form-control" id="writer" name="writer" 
                                   value="${sessionScope.loginUser.empName}" readonly>
                        </div>
                        
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>등록
                            </button>
                            <button type="button" class="btn btn-secondary" onclick="history.back()">
                                <i class="fas fa-arrow-left me-2"></i>취소
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- Notice Write End -->

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
        // CKEditor 초기화
        ClassicEditor
            .create(document.querySelector('#content'))
            .catch(error => {
                console.error(error);
            });
            
        // 폼 제출 전 유효성 검사
        document.querySelector('form').addEventListener('submit', function(e) {
            const title = document.querySelector('#title').value.trim();
            const content = document.querySelector('#content').value.trim();
            
            if (!title) {
                e.preventDefault();
                alert('제목을 입력해주세요.');
                return;
            }
            
            if (!content) {
                e.preventDefault();
                alert('내용을 입력해주세요.');
                return;
            }
        });
    </script>
</body>
</html> 