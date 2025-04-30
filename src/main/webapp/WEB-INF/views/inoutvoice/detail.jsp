<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 입출고전표상세</title>
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
                            <div class="esc-hint">
                                전체 화면을 종료하려면 <kbd>Esc</kbd> 키를 누르세요.
                            </div>
                            
                            <h3 class="mb-4">입출고전표상세</h3>
                            
                            <div class="table-responsive mb-4">
                                <table class="table table-bordered detail-table">
                                    <tbody>
                                        <tr>
                                            <th>생성일</th>
                                            <td>2025.04.01</td>
                                            <th>작업자</th>
                                            <td>DevSync</td>
                                            <th>입고창고</th>
                                            <td>정상</td>
                                            <th>전표유형</th>
                                            <td>입고</td>
                                        </tr>
                                        <tr>
                                            <th>반품</th>
                                            <td>-</td>
                                            <th>출고창고</th>
                                            <td>-</td>
                                            <th>이동창고</th>
                                            <td>-</td>
                                            <th>상태</th>
                                            <td>완료</td>
                                        </tr>
                                        <tr>
                                            <th>제목</th>
                                            <td colspan="7">[DevSync] 250401 입고전표 테스트</td>
                                        </tr>
                                        <tr>
                                            <th>메모</th>
                                            <td colspan="7" class="memo-field"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class="mb-3">
                                <button class="btn btn-sm btn-outline-secondary" id="btnAddProduct">상품추가</button>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover text-center product-table">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" class="form-check-input" id="selectAll"></th>
                                            <th>공급처</th>
                                            <th>상품코드</th>
                                            <th>공급자상품명</th>
                                            <th>바코드</th>
                                            <th>상품명</th>
                                            <th>옵션</th>
                                            <th>수량</th>
                                            <th>원가</th>
                                            <th>총원가</th>
                                            <th>판매가</th>
                                            <th>총판매가</th>
                                            <th>작업자</th>
                                            <th>현재고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><input type="checkbox" class="form-check-input product-select"></td>
                                            <td>애플</td>
                                            <td>S1234</td>
                                            <td>AP7</td>
                                            <td>AP7WH</td>
                                            <td>Airpods Pro 7</td>
                                            <td>white</td>
                                            <td>1000</td>
                                            <td>15,000</td>
                                            <td>15,000,000</td>
                                            <td>79,000</td>
                                            <td>79,000,000</td>
                                            <td>DevSync</td>
                                            <td>100</td>
                                        </tr>
                                        <tr>
                                            <td><input type="checkbox" class="form-check-input product-select"></td>
                                            <td>애플</td>
                                            <td>S1235</td>
                                            <td>AU7</td>
                                            <td>AU7BK</td>
                                            <td>Airpods Ultra 7</td>
                                            <td>black</td>
                                            <td>1500</td>
                                            <td>30,000</td>
                                            <td>45,000,000</td>
                                            <td>149,000</td>
                                            <td>223,500,000</td>
                                            <td>DevSync</td>
                                            <td>150</td>
                                        </tr>
                                        <tr>
                                            <td><input type="checkbox" class="form-check-input product-select"></td>
                                            <td>삼성</td>
                                            <td>S1236</td>
                                            <td>MB7</td>
                                            <td>MB7GR</td>
                                            <td>Magsafe 7</td>
                                            <td>grey</td>
                                            <td>2000</td>
                                            <td>20,000</td>
                                            <td>40,000,000</td>
                                            <td>99,000</td>
                                            <td>198,000,000</td>
                                            <td>DevSync</td>
                                            <td>200</td>
                                        </tr>
                                        <tr>
                                            <td><input type="checkbox" class="form-check-input product-select"></td>
                                            <td>소니</td>
                                            <td>S1237</td>
                                            <td>SP7</td>
                                            <td>SP7BL</td>
                                            <td>Sony Pro 7</td>
                                            <td>blue</td>
                                            <td>700</td>
                                            <td>40,000</td>
                                            <td>28,000,000</td>
                                            <td>179,000</td>
                                            <td>125,300,000</td>
                                            <td>DevSync</td>
                                            <td>70</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-primary mx-2" id="btnSave">저장</button>
                                <button type="button" class="btn btn-dark mx-2" id="btnClose">닫기</button>
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
    </script>
</body>
</html> 