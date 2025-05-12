<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 거래문서 등록</title>
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
        <!-- Sidebar Start -->
        <jsp:include page="../common/sidebar.jsp" />
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <jsp:include page="../common/navbar.jsp" />
            <!-- Navbar End -->

            <!-- 거래문서 등록 시작 -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h4 class="mb-0" style="font-size: 24px; font-weight: 600;">거래문서 등록</h4>
                    </div>

                    <form id="registerForm" action="${pageContext.request.contextPath}/transaction/register.do" method="post" enctype="multipart/form-data">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="docName" class="form-label">문서이름</label>
                                <input type="text" class="form-control" id="docName" name="docName" required>
                            </div>
                            <div class="col-md-6">
                                <label for="docType" class="form-label">문서유형</label>
                                <select class="form-select" id="docType" name="docType" required>
                                    <option value="">선택하세요</option>
                                    <option value="입고계약서">입고계약서</option>
                                    <option value="출고계약서">출고계약서</option>
                                    <option value="납품확인서">납품확인서</option>
                                    <option value="영수증">일반영수증</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="relatedPartyId" class="form-label">거래처</label>
                                <select class="form-select" id="relatedPartyId" name="relatedPartyId" required>
                                    <option value="">선택하세요</option>
                                    <option value="PART001">ABC물산</option>
                                    <option value="PART002">XYZ상사</option>
                                    <option value="PART003">DEF산업</option>
                                    <option value="PART004">GHI무역</option>
                                    <option value="PART005">JKL상사</option>
                                    <option value="PART006">MNO물류</option>
                                    <option value="PART007">PQR전자</option>
                                    <option value="PART008">STU무역</option>
                                    <option value="PART009">VWX산업</option>
                                    <option value="PART010">YZA물산</option>
                                    <option value="PART011">BCD전자</option>
                                    <option value="PART012">EFG무역</option>
                                    <option value="PART013">HIJ물류</option>
                                    <option value="PART014">KLM전자</option>
                                    <option value="PART015">NOP산업</option>
                                    <option value="PART016">XYZ테크</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="validUntil" class="form-label">유효기간</label>
                                <input type="date" class="form-control" id="validUntil" name="validUntil" required>
                            </div>
                            <div class="col-md-6">
                                <label for="uploadedBy" class="form-label">작성자</label>
                                <input type="text" class="form-control" id="uploadedBy" name="uploadedBy" value="${sessionScope.loginUser.empName}" readonly>
                                <input type="hidden" name="uploadedBy" value="${sessionScope.loginUser.empId}">
                            </div>
                            <div class="col-12">
                                <label for="content" class="form-label">비고</label>
                                <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                            </div>
                            <div class="col-12">
                                <label for="attachedFile" class="form-label">첨부파일</label>
                                <input type="file" class="form-control" id="attachedFile" name="attachedFile">
                            </div>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <button type="button" class="btn btn-secondary me-2" onclick="history.back()">
                                <i class="fa fa-times me-2"></i>취소
                            </button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fa fa-save me-2"></i>저장
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- 거래문서 등록 끝 -->

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
        // 폼 제출 이벤트 처리
        $('#registerForm').on('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const fileInput = document.getElementById('attachedFile');
            
            if (fileInput.files.length > 0) {
                const file = fileInput.files[0];
                formData.append('attachedFile', file);
                formData.append('attachedFileName', file.name); // 첨부파일명 추가
            }
            
            fetch('${pageContext.request.contextPath}/transaction/register.do', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('거래문서가 등록되었습니다.');
                    window.location.href = '${pageContext.request.contextPath}/transaction/list.do';
                } else {
                    alert('거래문서 등록에 실패했습니다: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('거래문서 등록 중 오류가 발생했습니다.');
            });
        });
    });
    </script>
</body>
</html>