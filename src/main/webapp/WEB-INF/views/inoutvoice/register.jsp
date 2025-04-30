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
                            <h3 class="mb-4">입출고전표생성</h3>
                            
                            <div class="form-container">
                                <form id="inoutForm" action="${pageContext.request.contextPath}/inout/register.do" method="post">
                                    <div class="row mb-4">
                                        <div class="col-md-3">
                                            <label for="status" class="form-label">창고</label>
                                        </div>
                                        <div class="col-md-6">
                                            <select id="status" name="status" class="form-select">
                                                <option value="normal" selected>정상</option>
                                                <option value="return">반품</option>
                                                <option value="defective">불량</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="returnCheck" name="returnCheck">
                                                <label class="form-check-label" for="returnCheck">반품</label>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-3">
                                            <label for="documentType" class="form-label">전표유형</label>
                                        </div>
                                        <div class="col-md-9">
                                            <select id="documentType" name="documentType" class="form-select">
                                                <option value="in" selected>입고</option>
                                                <option value="out">출고</option>
                                                <option value="move">이동</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-3">
                                            <label for="documentTitle" class="form-label">전표제목</label>
                                        </div>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="documentTitle" name="documentTitle" placeholder="전표제목을 입력하세요">
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
            const documentTitle = document.getElementById('documentTitle').value.trim();
            if (!documentTitle) {
                alert('전표제목을 입력해주세요.');
                return false;
            }
            
            // 폼 제출
            this.submit();
        });
        
        // 반품 체크박스 이벤트
        document.getElementById('returnCheck').addEventListener('change', function() {
            const statusSelect = document.getElementById('status');
            if (this.checked) {
                statusSelect.value = 'return';
            } else {
                statusSelect.value = 'normal';
            }
        });
        
        // 상태 선택 이벤트
        document.getElementById('status').addEventListener('change', function() {
            const returnCheck = document.getElementById('returnCheck');
            if (this.value === 'return') {
                returnCheck.checked = true;
            } else {
                returnCheck.checked = false;
            }
        });
        
        // 전표유형 변경 이벤트
        document.getElementById('documentType').addEventListener('change', function() {
            // 필요한 경우 전표유형에 따라 UI 요소 변경
            const documentTitle = document.getElementById('documentTitle');
            const type = this.value;
            
            if (!documentTitle.value) {
                if (type === 'in') {
                    documentTitle.placeholder = '입고 전표제목을 입력하세요';
                } else if (type === 'out') {
                    documentTitle.placeholder = '출고 전표제목을 입력하세요';
                } else {
                    documentTitle.placeholder = '이동 전표제목을 입력하세요';
                }
            }
        });

        // 사이드바 메뉴 활성화
        document.addEventListener('DOMContentLoaded', function() {
            // 다른 메뉴의 active 클래스를 제거
            document.querySelectorAll('.nav-link.dropdown-toggle').forEach(el => {
                el.classList.remove('active');
            });
            
            // 입출고관리 메뉴에 active 클래스 추가
            const inoutMenu = document.querySelector('.nav-link.dropdown-toggle:nth-of-type(8)');
            if (inoutMenu) {
                inoutMenu.classList.add('active');
            }
        });
    </script>
</body>
</html> 