<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 입출고 전표생성</title>
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
    
    <style>
        .form-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px dashed #ccc;
        }
    </style>
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

            <!-- InOutVoice Register Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h3 class="mb-4">입고전표생성</h3>
                            
                            <div class="form-container">
                                <form id="inoutForm" action="${pageContext.request.contextPath}/inout/inregister.do" method="post">
                                    <div class="row mb-4">
                                        <div class="col-md-3">
                                            <label for="warehouseId" class="form-label">입고 창고 선택</label>
                                        </div>
                                        <div class="col-md-9">
                                            <select id="warehouseId" name="warehouseId" class="form-select" required>
                                                <option value="">입고 창고를 선택하세요</option>
                                                <c:forEach items="${warehouseList}" var="warehouse">
                                                    <option value="${warehouse.warehouseId}">${warehouse.warehouseName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-3">
                                            <label for="inoutvoiceType" class="form-label">전표유형</label>
                                        </div>
                                        <div class="col-md-9">
                                            <select id="inoutvoiceType" name="inoutvoiceType" class="form-select" required>
                                                <option value="입고">입고</option>
                                                <!-- <option value="입고">입고</option>
                                                <option value="출고">출고</option> -->
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-3">
                                            <label for="inoutvoiceName" class="form-label">전표제목</label>
                                        </div>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="inoutvoiceName" name="inoutvoiceName" placeholder="전표제목을 입력하세요" required>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-3">
                                            <label for="workerId" class="form-label">작업자 ID</label>
                                        </div>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="workerId" name="workerId" placeholder="작업자 ID를 입력하세요" required>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-3">
                                            <label for="orderId" class="form-label">주문번호</label>
                                        </div>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="orderId" name="orderId" placeholder="주문번호를 입력하세요" required>
                                        </div>
                                    </div>
                                    
                                    <div class="d-flex justify-content-center mt-5">
                                        <button type="submit" class="btn btn-primary mx-2">저장</button>
                                        <button type="button" class="btn btn-dark mx-2" id="btnCancel">닫기</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- InOutVoice Register End -->
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
        // 닫기 버튼 클릭 이벤트
        document.getElementById('btnCancel').addEventListener('click', function() {
            location.href = "${pageContext.request.contextPath}/inout/list.do";
        });
        
        // 폼 제출 이벤트
        document.getElementById('inoutForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // 필수 입력 필드 검증
            const inoutvoiceName = document.getElementById('inoutvoiceName').value.trim();
            const warehouseId = document.getElementById('warehouseId').value;
            const inoutvoiceType = document.getElementById('inoutvoiceType').value;
            const orderId = document.getElementById('orderId').value.trim();
            const workerId = document.getElementById('workerId').value.trim();
            
            if (!warehouseId) {
                alert('창고를 선택해주세요.');
                return false;
            }
            
            if (!inoutvoiceType) {
                alert('전표유형을 선택해주세요.');
                return false;
            }
            
            if (!inoutvoiceName) {
                alert('전표제목을 입력해주세요.');
                return false;
            }
            
            if (!orderId) {
                alert('주문번호를 입력해주세요.');
                return false;
            }
            
            if (!workerId) {
                alert('작업자 ID를 입력해주세요.');
                return false;
            }
            
            // 폼 제출
            this.submit();
        });
        
        // 전표유형 변경 이벤트
        document.getElementById('inoutvoiceType').addEventListener('change', function() {
            const inoutvoiceName = document.getElementById('inoutvoiceName');
            const type = this.value;
            
            if (!inoutvoiceName.value) {
                switch(type) {
                    case '입고':
                        inoutvoiceName.placeholder = '입고 전표제목을 입력하세요';
                        break;
                    case '출고':
                        inoutvoiceName.placeholder = '출고 전표제목을 입력하세요';
                        break;
                    default:
                        inoutvoiceName.placeholder = '전표제목을 입력하세요';
                }
            }
        });

        // 사이드바 메뉴 활성화
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.nav-link.dropdown-toggle').forEach(el => {
                el.classList.remove('active');
            });
            
            const inoutMenu = document.querySelector('.nav-link.dropdown-toggle:nth-of-type(8)');
            if (inoutMenu) {
                inoutMenu.classList.add('active');
            }
        });
    </script>
</body>
</html> 