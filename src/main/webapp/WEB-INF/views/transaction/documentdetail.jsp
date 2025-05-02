<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 거래문서 상세</title>
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
        .modal-content {
            max-width: 800px;
            margin: 0 auto;
        }
        .modal-body {
            padding: 20px;
        }
        .detail-label {
            font-weight: bold;
            color: #666;
        }
        .detail-value {
            margin-bottom: 15px;
        }
        .file-list {
            list-style: none;
            padding-left: 0;
        }
        .file-list li {
            margin-bottom: 5px;
        }
        .file-list i {
            margin-right: 5px;
            color: #666;
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

            <!-- 거래문서 상세보기 시작 -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">거래문서 상세</h6>
                    </div>

                    <form id="documentForm">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="tdocId" class="form-label">문서번호</label>
                                <input type="text" class="form-control" id="tdocId" value="${transaction.tdocId}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="docName" class="form-label">문서이름</label>
                                <input type="text" class="form-control" id="docName" value="${transaction.docName}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="docType" class="form-label">문서유형</label>
                                <input type="text" class="form-control" id="docType" value="${transaction.docType}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="partnerName" class="form-label">거래처</label>
                                <input type="text" class="form-control" id="partnerName" value="${transaction.partnerName}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="uploaderName" class="form-label">작성자</label>
                                <input type="text" class="form-control" id="uploaderName" value="${transaction.uploaderName}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="status" class="form-label">문서상태</label>
                                <input type="text" class="form-control" id="status" value="${transaction.status}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="validUntil" class="form-label">유효기간</label>
                                <input type="text" class="form-control" id="validUntil" value="<fmt:formatDate value="${transaction.validUntil}" pattern="yyyy-MM-dd" />" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="uploadedAt" class="form-label">작성일</label>
                                <input type="text" class="form-control" id="uploadedAt" value="<fmt:formatDate value="${transaction.uploadedAt}" pattern="yyyy-MM-dd" />" readonly>
                            </div>
                            <div class="col-12">
                                <label for="content" class="form-label">문서 내용</label>
                                <textarea class="form-control" id="content" rows="5" readonly>${transaction.content}</textarea>
                            </div>
                            <div class="col-12">
                                <label class="form-label">첨부파일</label>
                                <div class="form-control" style="height: auto;">
                                    <c:choose>
                                        <c:when test="${not empty transaction.attachedFile}">
                                            <a href="${pageContext.request.contextPath}/transaction/download.do?tdocId=${transaction.tdocId}" 
                                               class="text-decoration-none" 
                                               style="color: #0d6efd;">
                                                <i class="fa fa-file me-2"></i>첨부파일 다운로드
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">첨부된 파일이 없습니다.</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <button type="button" class="btn btn-secondary me-2" onclick="history.back()">
                                <i class="fa fa-times me-2"></i>닫기
                            </button>
                            <button type="button" class="btn btn-warning" onclick="location.href='${pageContext.request.contextPath}/transaction/update.do?tdocId=${transaction.tdocId}'">
                                <i class="fa fa-edit me-2"></i>수정
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- 거래문서 상세보기 끝 -->

            <!-- Footer Start -->
            <jsp:include page="../common/footer.jsp" />
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
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

    <!-- Page specific Javascript -->
    <script>
    $(document).ready(function() {
        // 페이지 로드 시 스피너 숨기기
        setTimeout(function() {
            hideSpinner();
        }, 500);

        // 창 크기 조정
        window.resizeTo(900, 800);
    });

    // 스피너 제어 함수
    function showSpinner() {
        $('#spinner').addClass('show');
    }

    function hideSpinner() {
        $('#spinner').removeClass('show');
        $('.content').addClass('show');
    }
    </script>
</body>
</html>