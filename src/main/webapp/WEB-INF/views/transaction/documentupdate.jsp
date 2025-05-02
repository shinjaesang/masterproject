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
                        <h6 class="mb-0">거래문서 수정</h6>
                    </div>

                    <!-- 문서 수정 폼 -->
                    <form id="documentForm" action="${pageContext.request.contextPath}/document/transaction/update.do" method="post">
                        <input type="hidden" name="documentId" value="${document.documentId}">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="documentId" class="form-label">문서번호</label>
                                <input type="text" class="form-control" id="documentId" value="${document.documentId}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label for="documentTitle" class="form-label">문서이름</label>
                                <input type="text" class="form-control" id="documentTitle" name="documentTitle" value="${document.documentTitle}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="documentType" class="form-label">문서유형</label>
                                <select class="form-select" id="documentType" name="documentType" required>
                                    <option value="">선택하세요</option>
                                    <option value="입고계약서" ${document.documentType == '입고계약서' ? 'selected' : ''}>입고계약서</option>
                                    <option value="출고계약서" ${document.documentType == '출고계약서' ? 'selected' : ''}>출고계약서</option>
                                    <option value="납품확인서" ${document.documentType == '납품확인서' ? 'selected' : ''}>납품확인서</option>
                                    <option value="일반영수증" ${document.documentType == '일반영수증' ? 'selected' : ''}>일반영수증</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="partnerName" class="form-label">거래처</label>
                                <input type="text" class="form-control" id="partnerName" name="partnerName" value="${document.partnerName}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="managerName" class="form-label">담당자</label>
                                <input type="text" class="form-control" id="managerName" name="managerName" value="${document.managerName}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="documentStatus" class="form-label">문서상태</label>
                                <select class="form-select" id="documentStatus" name="documentStatus" required>
                                    <option value="">선택하세요</option>
                                    <option value="유효" ${document.documentStatus == '유효' ? 'selected' : ''}>유효</option>
                                    <option value="만료" ${document.documentStatus == '만료' ? 'selected' : ''}>만료</option>
                                    <option value="폐기" ${document.documentStatus == '폐기' ? 'selected' : ''}>폐기</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <label for="documentContent" class="form-label">문서 내용</label>
                                <textarea class="form-control" id="documentContent" name="documentContent" rows="5" required>${document.documentContent}</textarea>
                            </div>
                            <div class="col-12">
                                <label for="documentFile" class="form-label">첨부파일</label>
                                <input type="file" class="form-control" id="documentFile" name="documentFile" multiple>
                                <div class="form-text">여러 파일을 선택할 수 있습니다.</div>
                                <c:if test="${not empty document.files}">
                                    <div class="mt-2">
                                        <h6>현재 첨부된 파일</h6>
                                        <ul class="list-unstyled">
                                            <c:forEach var="file" items="${document.files}">
                                                <li>
                                                    <i class="fa fa-file me-2"></i>${file.originalName}
                                                    <button type="button" class="btn btn-sm btn-danger ms-2" onclick="deleteFile('${file.fileId}')">
                                                        <i class="fa fa-trash"></i>
                                                    </button>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <button type="button" class="btn btn-secondary me-2" onclick="location.href='${pageContext.request.contextPath}/transaction/list.do'">
                                <i class="fa fa-times me-2"></i>취소
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
    $(document).ready(function() {
        // 페이지 로드 시 스피너 숨기기
        hideSpinner();

        // 폼 제출 처리
        $('#documentForm').on('submit', function(e) {
            e.preventDefault();
            
            // 폼 데이터 수집
            const formData = new FormData(this);
            
            // 서버로 데이터 전송
            fetch('${pageContext.request.contextPath}/document/transaction/update.do', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('문서가 성공적으로 수정되었습니다.');
                    location.href = '${pageContext.request.contextPath}/transaction/list.do';
                } else {
                    alert(data.message || '문서 수정에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('문서 수정 중 오류가 발생했습니다.');
            });
        });
    });

    // 파일 삭제 함수
    function deleteFile(fileId) {
        if (confirm('선택한 파일을 삭제하시겠습니까?')) {
            fetch('${pageContext.request.contextPath}/document/transaction/deleteFile.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'fileId=' + fileId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('파일이 성공적으로 삭제되었습니다.');
                    location.reload();
                } else {
                    alert(data.message || '파일 삭제에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('파일 삭제 중 오류가 발생했습니다.');
            });
        }
    }

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