<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 전자문서 조회</title>
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

    <!-- Critical CSS -->
    <style>
        .spinner-border {
            display: inline-block;
            width: 2rem;
            height: 2rem;
            vertical-align: text-bottom;
            border: .25em solid currentColor;
            border-right-color: transparent;
            border-radius: 50%;
            animation: spinner-border .75s linear infinite;
        }

        @keyframes spinner-border {
            to {
                transform: rotate(360deg);
            }
        }

        #spinner {
            opacity: 0;
            visibility: hidden;
            transition: opacity .5s ease-out, visibility 0s linear .5s;
            z-index: 99999;
        }

        #spinner.show {
            transition: opacity .5s ease-out, visibility 0s linear 0s;
            visibility: visible;
            opacity: 1;
        }

        .content {
            opacity: 0;
            transition: opacity 0.3s ease-in;
        }

        .content.show {
            opacity: 1;
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

            <!-- 전자문서 조회 시작 -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h5 class="mb-0">전자문서 조회</h5>
                        <a href="${pageContext.request.contextPath}/document/register.do" class="btn btn-primary">
                            <i class="fa fa-plus me-2"></i>새 문서 작성
                        </a>
                    </div>

                    <!-- 검색 조건 입력 폼 -->
                    <form class="row g-3 align-items-center mb-3" action="${pageContext.request.contextPath}/document/list.do" method="get">
                        <!-- 문서번호 입력 -->
                        <div class="col-auto">
                            <label for="documentNo" class="visually-hidden">문서번호</label>
                            <input type="text" class="form-control" id="documentNo" name="documentNo" 
                                placeholder="문서번호" value="${param.documentNo}">
                        </div>
                        <!-- 제목 입력 -->
                        <div class="col-auto">
                            <label for="title" class="visually-hidden">제목</label>
                            <input type="text" class="form-control" id="title" name="title" 
                                placeholder="제목" value="${param.title}">
                        </div>
                        <!-- 기안자 입력 -->
                        <div class="col-auto">
                            <label for="writer" class="visually-hidden">기안자</label>
                            <input type="text" class="form-control" id="writer" name="writer" 
                                placeholder="기안자" value="${param.writer}">
                        </div>
                        <!-- 부서 입력 -->
                        <div class="col-auto">
                            <label for="department" class="visually-hidden">부서</label>
                            <input type="text" class="form-control" id="department" name="department" 
                                placeholder="부서" value="${param.department}">
                        </div>
                        <!-- 문서유형 선택 -->
                        <div class="col-auto">
                            <label for="documentType" class="visually-hidden">문서유형</label>
                            <select class="form-select" id="documentType" name="documentType">
                                <option value="">문서유형 선택</option>
                                <option value="EXPENSE" ${param.documentType == 'EXPENSE' ? 'selected' : ''}>지출결의서</option>
                                <option value="DRAFT" ${param.documentType == 'DRAFT' ? 'selected' : ''}>품의서</option>
                                <option value="REPORT" ${param.documentType == 'REPORT' ? 'selected' : ''}>보고서</option>
                                <option value="CONTRACT" ${param.documentType == 'CONTRACT' ? 'selected' : ''}>계약서</option>
                                <option value="PROPOSAL" ${param.documentType == 'PROPOSAL' ? 'selected' : ''}>기안서</option>
                                <option value="INBOUND" ${param.documentType == 'INBOUND' ? 'selected' : ''}>입고요청서</option>
                                <option value="OUTBOUND" ${param.documentType == 'OUTBOUND' ? 'selected' : ''}>출고요청서</option>
                            </select>
                        </div>
                        <!-- 기안일자 범위: 시작 날짜 -->
                        <div class="col-auto">
                            <label for="startDate" class="visually-hidden">기안일자 (시작)</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" 
                                value="${param.startDate}">
                        </div>
                        <!-- 기안일자 범위 표시: ~ -->
                        <div class="col-auto d-flex align-items-center">
                            <span>~</span>
                        </div>
                        <!-- 기안일자 범위: 종료 날짜 -->
                        <div class="col-auto">
                            <label for="endDate" class="visually-hidden">기안일자 (종료)</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" 
                                value="${param.endDate}">
                        </div>
                        <!-- 문서상태 선택 -->
                        <div class="col-auto">
                            <label for="status" class="visually-hidden">상태</label>
                            <select class="form-select" id="status" name="status">
                                <option value="">전체 상태</option>
                                <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>결재 대기</option>
                                <option value="COMPLETED" ${param.status == 'COMPLETED' ? 'selected' : ''}>결재 완료</option>
                                <option value="REJECTED" ${param.status == 'REJECTED' ? 'selected' : ''}>반려</option>
                                <option value="TEMP" ${param.status == 'TEMP' ? 'selected' : ''}>임시 저장</option>
                            </select>
                        </div>
                        <!-- 검색 버튼 -->
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary">
                                <i class="fa fa-search me-2"></i>검색
                            </button>
                        </div>
                    </form>

                    <!-- 문서 목록 테이블 -->
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">문서번호</th>
                                    <th scope="col">제목</th>
                                    <th scope="col">문서유형</th>
                                    <th scope="col">기안자</th>
                                    <th scope="col">부서</th>
                                    <th scope="col">기안일</th>
                                    <th scope="col">결재기한</th>
                                    <th scope="col">상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${documents}" var="doc">
                                    <tr>
                                        <td>${doc.documentNo}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/document/view/${doc.id}" class="text-dark">
                                                ${doc.title}
                                                <c:if test="${doc.attachmentCount > 0}">
                                                    <i class="fas fa-paperclip text-secondary"></i>
                                                </c:if>
                                            </a>
                                        </td>
                                        <td>${doc.documentType}</td>
                                        <td>${doc.writerName}</td>
                                        <td>${doc.department}</td>
                                        <td><fmt:formatDate value="${doc.createdDate}" pattern="yyyy-MM-dd"/></td>
                                        <td><fmt:formatDate value="${doc.dueDate}" pattern="yyyy-MM-dd"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${doc.status eq 'PENDING'}">
                                                    <span class="badge bg-warning">대기</span>
                                                </c:when>
                                                <c:when test="${doc.status eq 'COMPLETED'}">
                                                    <span class="badge bg-success">완료</span>
                                                </c:when>
                                                <c:when test="${doc.status eq 'REJECTED'}">
                                                    <span class="badge bg-danger">반려</span>
                                                </c:when>
                                                <c:when test="${doc.status eq 'TEMP'}">
                                                    <span class="badge bg-secondary">임시</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- 페이지네이션 -->
                    <div class="d-flex justify-content-center mt-4">
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- 전자문서 조회 끝 -->

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

            // 검색 기능
            $('#searchBtn').click(function() {
                performSearch();
            });

            // 상태 필터 변경 시 검색
            $('#statusFilter').change(function() {
                performSearch();
            });

            // 검색어 입력 필드에서 엔터 키 입력 시 검색
            $('#searchKeyword').keypress(function(e) {
                if (e.which == 13) {
                    performSearch();
                }
            });

            // 검색 수행 함수
            function performSearch() {
                showSpinner();
                const searchType = $('#searchType').val();
                const searchKeyword = $('#searchKeyword').val();
                const status = $('#statusFilter').val();

                // 검색 요청
                $.ajax({
                    url: '${pageContext.request.contextPath}/document/search.do',
                    type: 'GET',
                    data: {
                        searchType: searchType,
                        keyword: searchKeyword,
                        status: status
                    },
                    success: function(response) {
                        hideSpinner();
                        // TODO: 검색 결과 처리
                        console.log('검색 결과:', response);
                    },
                    error: function(xhr, status, error) {
                        hideSpinner();
                        console.error('검색 실패:', error);
                        alert('검색 중 오류가 발생했습니다.');
                    }
                });
            }

            // 스피너 제어 함수
            function showSpinner() {
                $('#spinner').addClass('show');
            }

            function hideSpinner() {
                $('#spinner').removeClass('show');
                $('.content').addClass('show');
            }
        });
    </script>
</body>
</html>