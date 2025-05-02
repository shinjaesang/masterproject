<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 입출고 전표 상세</title>
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
        .detail-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #ddd;
            padding: 10px 15px;
            margin-bottom: 20px;
        }
        .detail-table th {
            width: 15%;
            background-color: #f8f9fa;
        }
        .memo-field {
            min-height: 80px;
        }
        .product-table th {
            background-color: #f8f9fa;
        }
        .esc-hint {
            background-color: #495057;
            color: white;
            padding: 8px 15px;
            text-align: right;
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

            <!-- InOutVoice Detail Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            
                            
                            <h3 class="mb-4">입출고전표상세</h3>
                            
                            <div class="row mb-4">
                                <div class="col-12 text-end">
                                    <a href="${pageContext.request.contextPath}/inout/list.do" class="btn btn-secondary">목록</a>
                                    <a href="${pageContext.request.contextPath}/inout/update.do?inoutvoiceId=${inOutVoice.inoutvoiceId}" class="btn btn-primary ms-2">수정</a>
                                    <button type="button" class="btn btn-danger ms-2" onclick="deleteInOutVoice('${inOutVoice.inoutvoiceId}')">삭제</button>
                                </div>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th class="col-2">전표번호</th>
                                            <td>${inOutVoice.inoutvoiceId}</td>
                                        </tr>
                                        <tr>
                                            <th>전표명</th>
                                            <td>${inOutVoice.inoutvoiceName}</td>
                                        </tr>
                                        <tr>
                                            <th>전표유형</th>
                                            <td>${inOutVoice.inoutvoiceType}</td>
                                        </tr>
                                        <tr>
                                            <th>주문번호</th>
                                            <td>${inOutVoice.orderId}</td>
                                        </tr>
                                        <tr>
                                            <th>작업자</th>
                                            <td>${inOutVoice.workerId}</td>
                                        </tr>
                                        <tr>
                                            <th>창고</th>
                                            <td>${inOutVoice.warehouseId}</td>
                                        </tr>
                                        <tr>
                                            <th>등록일</th>
                                            <td><fmt:formatDate value="${inOutVoice.createdAt}" pattern="yyyy-MM-dd"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- InOutVoice Detail End -->
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
            const checkboxes = document.querySelectorAll('.product-select');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });
        
        // 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
        document.querySelectorAll('.product-select').forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                const allChecked = Array.from(document.querySelectorAll('.product-select')).every(cb => cb.checked);
                document.getElementById('selectAll').checked = allChecked;
            });
        });

        // 상품 추가 버튼 이벤트
        document.getElementById('btnAddProduct').addEventListener('click', function() {
            alert('상품 검색 팝업이 열립니다.');
            // TODO: 상품 검색 팝업 구현
        });
        
        // 저장 버튼 이벤트
        document.getElementById('btnSave').addEventListener('click', function() {
            alert('전표가 저장되었습니다.');
            location.href = "${pageContext.request.contextPath}/inout/list.do";
        });
        
        // 닫기 버튼 이벤트
        document.getElementById('btnClose').addEventListener('click', function() {
            location.href = "${pageContext.request.contextPath}/inout/list.do";
        });
        
        // ESC 키 이벤트 리스너
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                location.href = "${pageContext.request.contextPath}/inout/list.do";
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

        function deleteInOutVoice(inoutvoiceId) {
            if (confirm('정말로 삭제하시겠습니까?')) {
                location.href = '${pageContext.request.contextPath}/inout/delete.do?inoutvoiceId=' + inoutvoiceId;
            }
        }
    </script>
</body>
</html> 