<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 거래문서함</title>
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

            <!-- 거래문서 관리 시작 -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">거래문서함</h6>
                    </div>

                    <!-- 검색 조건 입력 폼 -->
                    <form class="row g-3" id="searchForm" action="${pageContext.request.contextPath}/transaction/list.do" method="get">
                        <div class="col-md-6">
                            <label for="tdocId" class="form-label">문서번호</label>
                            <input type="text" class="form-control" id="tdocId" name="tdocId" placeholder="문서번호" value="${param.tdocId}">
                        </div>
                        <div class="col-md-6">
                            <label for="docName" class="form-label">문서이름</label>
                            <input type="text" class="form-control" id="docName" name="docName" placeholder="문서이름" value="${param.docName}">
                        </div>
                        <div class="col-md-6">
                            <label for="docType" class="form-label">문서유형</label>
                            <select class="form-select" id="docType" name="docType">
                                <option value="">전체</option>
                                <option value="입고계약서" ${param.docType == '입고계약서' ? 'selected' : ''}>입고계약서</option>
                                <option value="출고계약서" ${param.docType == '출고계약서' ? 'selected' : ''}>출고계약서</option>
                                <option value="납품확인서" ${param.docType == '납품확인서' ? 'selected' : ''}>납품확인서</option>
                                <option value="일반영수증" ${param.docType == '일반영수증' ? 'selected' : ''}>일반영수증</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="relatedPartyId" class="form-label">거래처</label>
                            <input type="text" class="form-control" id="relatedPartyId" name="relatedPartyId" placeholder="거래처" value="${param.relatedPartyId}">
                        </div>
                        <div class="col-md-6">
                            <label for="uploaderName" class="form-label">작성자</label>
                            <input type="text" class="form-control" id="uploaderName" name="uploaderName" placeholder="작성자명을 입력하세요" value="${param.uploaderName}">
                        </div>
                        <div class="col-md-6">
                            <label for="status" class="form-label">문서상태</label>
                            <select class="form-select" id="status" name="status">
                                <option value="">전체</option>
                                <option value="유효" ${param.status == '유효' ? 'selected' : ''}>유효</option>
                                <option value="만료" ${param.status == '만료' ? 'selected' : ''}>만료</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="uploadedAt" class="form-label">작성일</label>
                            <input type="date" class="form-control" id="uploadedAt" name="uploadedAt" value="${param.uploadedAt}">
                        </div>
                        <div class="col-12 d-flex justify-content-end mt-3">
                            <button type="submit" class="btn btn-primary me-2">
                                <i class="fa fa-search me-2"></i>검색
                            </button>
                            <button type="button" onclick="location.href='register.do'" class="btn btn-success">
                                <i class="fa fa-plus me-2"></i>문서 추가
                            </button>
                        </div>
                    </form>

                    <div class="d-flex justify-content-start mb-2 mt-4">
                        <button type="button" class="btn btn-sm btn-danger" onclick="deleteSelectedDocuments()">
                            <i class="fa fa-trash me-2"></i>일괄삭제
                        </button>
                    </div>

                    <div class="table-responsive" style="overflow-x: auto; min-width: 100%;">
                        <table class="table text-start align-middle table-bordered table-hover mb-0" style="min-width: 1200px;">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col" style="width: 50px;"><input class="form-check-input" type="checkbox" id="selectAll"></th>
                                    <th scope="col" style="width: 100px;">문서번호</th>
                                    <th scope="col" style="width: 200px;">문서제목</th>
                                    <th scope="col" style="width: 120px;">문서유형</th>
                                    <th scope="col" style="width: 150px;">거래처</th>
                                    <th scope="col" style="width: 120px;">유효기간</th>
                                    <th scope="col" style="width: 100px;">문서상태</th>
                                    <th scope="col" style="width: 120px;">작성일</th>
                                    <th scope="col" style="width: 100px;">작성자</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="transaction" items="${transactionList}">
                                    <tr>
                                        <td style="white-space: nowrap;"><input class="form-check-input document-checkbox" type="checkbox" name="documentIds" value="${transaction.tdocId}"></td>
                                        <td style="white-space: nowrap;">${transaction.tdocId}</td>
                                        <td style="white-space: nowrap;">
                                            <a href="${pageContext.request.contextPath}/transaction/detail.do?tdocId=${transaction.tdocId}" 
                                               class="text-decoration-none fw-bold" style="text-decoration: underline !important;">
                                                ${transaction.docName}
                                            </a>
                                        </td>
                                        <td style="white-space: nowrap;">${transaction.docType}</td>
                                        <td style="white-space: nowrap;">${transaction.partnerName}</td>
                                        <td style="white-space: nowrap;"><fmt:formatDate value="${transaction.validUntil}" pattern="yyyy-MM-dd" /></td>
                                        <td style="white-space: nowrap;">${transaction.status}</td>
                                        <td style="white-space: nowrap;"><fmt:formatDate value="${transaction.uploadedAt}" pattern="yyyy-MM-dd" /></td>
                                        <td style="white-space: nowrap;">${transaction.uploaderName}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- 거래문서 관리 끝 -->

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
        // 체크박스 전체 선택/해제
        $("#selectAll").change(function() {
            $(".document-checkbox").prop('checked', $(this).prop("checked"));
        });

        // 페이지 로드 시 스피너 숨기기
        hideSpinner();
    });

    // 스피너 제어 함수
    function showSpinner() {
        $('#spinner').addClass('show');
    }

    function hideSpinner() {
        $('#spinner').removeClass('show');
        $('.content').addClass('show');
    }

    // 선택된 문서 일괄 삭제 함수
    function deleteSelectedDocuments() {
        const selectedDocuments = $('.document-checkbox:checked').map(function() {
            return $(this).val();
        }).get();

        if (selectedDocuments.length === 0) {
            alert('삭제할 문서를 선택해주세요.');
            return;
        }

        if (confirm('선택한 ' + selectedDocuments.length + '개의 문서를 삭제하시겠습니까?')) {
            const documentIds = selectedDocuments.join(',');
            
            fetch('${pageContext.request.contextPath}/document/transaction/delete.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'documentIds=' + documentIds
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('선택한 문서가 성공적으로 삭제되었습니다.');
                    location.reload();
                } else {
                    alert(data.message || '문서 삭제에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('문서 삭제 중 오류가 발생했습니다.');
            });
        }
    }

    // 단일 문서 삭제 함수
    function deleteDocument(documentId) {
        if (confirm('선택한 문서를 삭제하시겠습니까?')) {
            fetch('${pageContext.request.contextPath}/document/transaction/delete.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'documentId=' + documentId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('문서가 성공적으로 삭제되었습니다.');
                    location.reload();
                } else {
                    alert(data.message || '문서 삭제에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('문서 삭제 중 오류가 발생했습니다.');
            });
        }
    }
    </script>
</body>
</html>