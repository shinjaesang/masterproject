<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 거래문서 수정</title>
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

            <!-- 거래문서 수정 시작 -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h4 class="mb-0" style="font-size: 24px; font-weight: 600;">거래문서 수정</h4>
                    </div>

                    <form id="documentForm" action="${pageContext.request.contextPath}/transaction/update.do" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="tdocId" value="${transaction.tdocId}">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="tdocId" class="form-label">문서번호</label>
                                <input type="text" class="form-control" id="tdocId" value="${transaction.tdocId}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="docName" class="form-label">문서이름</label>
                                <input type="text" class="form-control" id="docName" name="docName" value="${transaction.docName}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="docType" class="form-label">문서유형</label>
                                <select class="form-select" id="docType" name="docType" required>
                                    <option value="">선택하세요</option>
                                    <option value="입고계약서" ${transaction.docType == '입고계약서' ? 'selected' : ''}>입고계약서</option>
                                    <option value="출고계약서" ${transaction.docType == '출고계약서' ? 'selected' : ''}>출고계약서</option>
                                    <option value="납품확인서" ${transaction.docType == '납품확인서' ? 'selected' : ''}>납품확인서</option>
                                    <option value="영수증" ${transaction.docType == '영수증' ? 'selected' : ''}>일반영수증</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="relatedPartyId" class="form-label">거래처</label>
                                <select class="form-select" id="relatedPartyId" name="relatedPartyId" required>
                                    <c:forEach var="partner" items="${partnerList}">
                                        <option value="${partner.partnerId}" ${partner.partnerId == transaction.relatedPartyId ? 'selected' : ''}>
                                            ${partner.partnerName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="uploaderName" class="form-label">작성자</label>
                                <input type="text" class="form-control" id="uploaderName" value="${transaction.uploaderName}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="status" class="form-label">문서상태</label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="유효" ${transaction.status == '유효' ? 'selected' : ''}>유효</option>
                                    <option value="만료" ${transaction.status == '만료' ? 'selected' : ''}>만료</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="validUntil" class="form-label">유효기간</label>
                                <input type="date" class="form-control" id="validUntil" name="validUntil" 
                                       value="<fmt:formatDate value="${transaction.validUntil}" pattern="yyyy-MM-dd" />" required>
                            </div>
                            <div class="col-md-6">
                                <label for="uploadedAt" class="form-label">작성일</label>
                                <input type="text" class="form-control" id="uploadedAt" 
                                       value="<fmt:formatDate value="${transaction.uploadedAt}" pattern="yyyy-MM-dd" />" readonly>
                            </div>
                            <div class="col-12">
                                <label for="content" class="form-label">문서 내용</label>
                                <textarea class="form-control" id="content" name="content" rows="5">${transaction.content}</textarea>
                            </div>
                            <div class="col-12">
                                <label class="form-label">첨부파일</label>
                                <div class="form-control" style="height: auto;">
                                    <c:choose>
                                        <c:when test="${not empty transaction.attachedFile}">
                                            <div class="mb-2">
                                                <a href="${pageContext.request.contextPath}/transaction/download.do?tdocId=${transaction.tdocId}" 
                                                   class="text-decoration-none" style="color: #0d6efd;">
                                                    <i class="fa fa-file me-2"></i>현재 첨부파일 다운로드
                                                </a>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                    <input type="file" class="form-control" id="attachedFile" name="attachedFile">
                                    <div class="form-text">새로운 파일을 선택하면 기존 파일이 대체됩니다.</div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <button type="button" class="btn btn-secondary me-2" onclick="location.href='list.do'">
                                <i class="fa fa-times me-2"></i>닫기
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fa fa-save me-2"></i>저장
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- 거래문서 수정 끝 -->

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
    // 스피너 제어 함수
    function showSpinner() {
        $('#spinner').addClass('show');
    }

    function hideSpinner() {
        $('#spinner').removeClass('show');
        $('.content').addClass('show');
    }

    $(document).ready(function() {
        // 페이지 로드 시 스피너 숨기기
        setTimeout(function() {
            hideSpinner();
        }, 100);

        // 폼 제출 처리
        $('#documentForm').on('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const fileInput = document.getElementById('attachedFile');
            
            if (fileInput.files.length > 0) {
                const file = fileInput.files[0];
                formData.append('attachedFile', file);
                formData.append('attachedFileName', file.name); // 첨부파일명 추가
            }
            
            fetch('${pageContext.request.contextPath}/transaction/update.do', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('거래문서가 수정되었습니다.');
                    window.location.href = '${pageContext.request.contextPath}/transaction/detail.do?tdocId=${transaction.tdocId}';
                } else {
                    alert('거래문서 수정에 실패했습니다: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('거래문서 수정 중 오류가 발생했습니다.');
            });
        });
    });
    </script>
</body>
</html>