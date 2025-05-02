<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 입출고 전표조회</title>
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
        <!-- Sidebar Start -->
        <jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
            <!-- Navbar End -->

            <!-- InOutVoice List Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">입출고 전표조회</h6>
                            
                            <!-- Search Filters -->
                            <form class="row g-3 mb-4" action="${pageContext.request.contextPath}/inout/search.do" method="post">
                                <div class="col-md-6">
                                    <label for="startDate" class="form-label">조회 기간</label>
                                    <div class="input-group">
                                        <input type="date" class="form-control" id="startDate" name="startDate" value="${param.startDate}">
                                        <span class="input-group-text">~</span>
                                        <input type="date" class="form-control" id="endDate" name="endDate" value="${param.endDate}">
                                    </div>
                                </div>
                                
                                <div class="col-md-3">
                                    <label for="documentTitle" class="form-label">전표제목</label>
                                    <input type="text" class="form-control" id="documentTitle" name="documentTitle" placeholder="전표제목 입력" value="${param.documentTitle}">
                                </div>
                                
                                <div class="col-md-3">
                                    <label for="documentType" class="form-label">전표유형</label>
                                    <select id="documentType" name="documentType" class="form-select">
                                        <option value="all" ${param.documentType == 'all' ? 'selected' : ''}>전체</option>
                                        <option value="입고" ${param.documentType == '입고' ? 'selected' : ''}>입고</option>
                                        <option value="출고" ${param.documentType == '출고' ? 'selected' : ''}>출고</option>
                                    </select>
                                </div>
                                
                                <div class="col-12 text-end">
                                    <button type="submit" class="btn btn-primary">검색</button>
                                    <button type="button" class="btn btn-dark ms-2" id="btnDownload">다운로드</button>
                                </div>
                            </form>
                            
                            <div class="mb-3">
                                <a href="${pageContext.request.contextPath}/inout/register.do" class="btn btn-sm btn-secondary">전표생성</a>
                            </div>
                            
                            <!-- InOutVoice List Table -->
                            <div class="table-responsive">
                                <table class="table text-center align-middle table-bordered table-hover mb-0">
                                    <thead>
                                        <tr class="text-dark">
                                            <th scope="col"><input class="form-check-input" type="checkbox" id="selectAll"></th>
                                            <th scope="col">전표번호</th>
                                            <th scope="col">전표명</th>
                                            <th scope="col">전표유형</th>
                                            <th scope="col">주문번호</th>
                                            <th scope="col">작업자</th>
                                            <th scope="col">창고</th>
                                            <th scope="col">등록일</th>
                                            <th scope="col">상세</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${not empty inOutVoiceList}">
                                            <c:forEach items="${inOutVoiceList}" var="item" varStatus="status">
                                                <tr>
                                                    <td><input class="form-check-input" type="checkbox" name="selectedItems" value="${item.inoutvoiceId}"></td>
                                                    <td>${item.inoutvoiceId}</td>
                                                    <td>${item.inoutvoiceName}</td>
                                                    <td>${item.inoutvoiceType}</td>
                                                    <td>${item.orderId}</td>
                                                    <td>${item.workerId}</td>
                                                    <td>${item.warehouseId}</td>
                                                    <td><fmt:formatDate value="${item.createdAt}" pattern="yyyy-MM-dd"/></td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/inout/detail.do?inoutvoiceId=${item.inoutvoiceId}" class="btn btn-sm btn-primary">상세</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${empty inOutVoiceList}">
                                            <tr>
                                                <td colspan="9" class="text-center">데이터가 없습니다.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Pagination -->
                            <div class="d-flex justify-content-center mt-4">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                        <li class="page-item">
                                            <a class="page-link" href="#" aria-label="First">
                                                <span aria-hidden="true">&laquo;&laquo;</span>
                                            </a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="#" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item">
                                            <a class="page-link" href="#" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                        <li class="page-item">
                                            <a class="page-link" href="#" aria-label="Last">
                                                <span aria-hidden="true">&raquo;&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- InOutVoice List End -->
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
        // 전체 선택 체크박스
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.getElementsByName('selectedItems');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });

        // 다운로드 버튼
        document.getElementById('btnDownload').addEventListener('click', function() {
            const selectedItems = Array.from(document.getElementsByName('selectedItems'))
                .filter(checkbox => checkbox.checked)
                .map(checkbox => checkbox.value);
            
            if (selectedItems.length === 0) {
                alert('다운로드할 항목을 선택해주세요.');
                return;
            }

            // TODO: 엑셀 다운로드 API 호출
            console.log('Selected items:', selectedItems);
        });
    </script>
</body>
</html> 