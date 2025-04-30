<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 주문 수정</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="재고관리 ERP 시스템" name="keywords">
    <meta content="효율적인 재고 관리를 위한 Stockmaster ERP 시스템" name="description">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">

    <!-- Critical CSS -->
    <style>
        /* 필수적인 스타일만 인라인으로 포함 */
        .spinner-border{display:inline-block;width:2rem;height:2rem;vertical-align:text-bottom;border:.25em solid currentColor;border-right-color:transparent;border-radius:50%;animation:spinner-border .75s linear infinite}
        @keyframes spinner-border{to{transform:rotate(360deg)}}
        #spinner{opacity:0;visibility:hidden;transition:opacity .5s ease-out,visibility 0s linear .5s;z-index:99999}
        #spinner.show{transition:opacity .5s ease-out,visibility 0s linear 0s;visibility:visible;opacity:1}
        .content { opacity: 0; transition: opacity 0.3s ease-in; }
        .content.show { opacity: 1; }
    </style>

    <!-- Preload Critical JavaScript -->
    <script>
        // 페이지 로드 타임아웃 설정
        let loadTimeout;
        
        // 스피너 제어 함수
        function hideSpinner() {
            const spinner = document.getElementById('spinner');
            const content = document.querySelector('.content');
            if (spinner) {
                spinner.classList.remove('show');
                setTimeout(() => {
                    spinner.style.display = 'none';
                    if (content) {
                        content.classList.add('show');
                    }
                }, 500);
            }
        }

        function showSpinner() {
            const spinner = document.getElementById('spinner');
            if (spinner) {
                spinner.style.display = 'flex';
                spinner.classList.add('show');
            }
        }

        // 페이지 로드 실패 시 처리
        function handleLoadError() {
            hideSpinner();
            alert('페이지 로드에 실패했습니다. 새로고침을 시도해주세요.');
        }

        // 페이지 로드 감시
        document.addEventListener('DOMContentLoaded', function() {
            loadTimeout = setTimeout(handleLoadError, 10000);
        });

        window.addEventListener('load', function() {
            clearTimeout(loadTimeout);
            hideSpinner();
        });

        // 페이지 로드 실패 시
        window.addEventListener('error', function(e) {
            if (e.target.tagName === 'SCRIPT' || e.target.tagName === 'LINK') {
                handleLoadError();
            }
        }, true);
    </script>

    <!-- Async CSS Loading -->
    <link rel="preload" href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" as="style" onload="this.onload=null;this.rel='stylesheet'">
    <link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
    <link rel="preload" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
    <link rel="preload" href="${pageContext.request.contextPath}/resources/css/style.css" as="style" onload="this.onload=null;this.rel='stylesheet'">

    <!-- Fallback for CSS Loading -->
    <noscript>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    </noscript>
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
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-warehouse me-2"></i>Stockmaster</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <img class="rounded-circle" src="${pageContext.request.contextPath}/resources/img/user.jpg" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0"><%= session.getAttribute("username") != null ? session.getAttribute("username") : "재고마스터" %></h6>
                        <span><%= session.getAttribute("role") != null ? session.getAttribute("role") : "Admin" %></span>
                    </div>
                </div>
                <div class="navbar-nav w-100">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>대시보드</a>
                    <a href="${pageContext.request.contextPath}/notices.jsp" class="nav-item nav-link"><i class="fa fa-bullhorn me-2"></i>공지사항</a>
                    <a href="${pageContext.request.contextPath}/inventory.jsp" class="nav-item nav-link"><i class="fa fa-boxes me-2"></i>재고관리</a>
                    <a href="${pageContext.request.contextPath}/warehouse.jsp" class="nav-item nav-link"><i class="fa fa-warehouse me-2"></i>창고관리</a>
                    <a href="${pageContext.request.contextPath}/products.jsp" class="nav-item nav-link"><i class="fa fa-barcode me-2"></i>상품관리</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-shopping-cart me-2"></i>주문관리</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="${pageContext.request.contextPath}/orderlist.do" class="dropdown-item">주문 내역 조회</a>
                            <a href="${pageContext.request.contextPath}/orderregister.do" class="dropdown-item">주문 등록</a>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/inbound-outbound.jsp" class="nav-item nav-link"><i class="fa fa-truck me-2"></i>입출고관리</a>
                    <a href="${pageContext.request.contextPath}/vendors.jsp" class="nav-item nav-link"><i class="fa fa-handshake me-2"></i>거래처관리</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-file-alt me-2"></i>결재문서</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="${pageContext.request.contextPath}/approval-documents.jsp" class="dropdown-item">결재문서 조회</a>
                            <a href="${pageContext.request.contextPath}/approval-documentsregister.jsp" class="dropdown-item">기안문서 작성</a>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/approval-management.jsp" class="nav-item nav-link"><i class="fa fa-file-signature me-2"></i>거래문서관리</a>
                    <a href="${pageContext.request.contextPath}/statistics.jsp" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>통계분석</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-cog me-2"></i>설정</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="${pageContext.request.contextPath}/users.jsp" class="dropdown-item">사용자 관리</a>
                            <a href="${pageContext.request.contextPath}/categories.jsp" class="dropdown-item">카테고리 관리</a>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout.jsp" class="nav-item nav-link"><i class="fa fa-sign-out-alt me-2"></i>로그아웃</a>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand d-flex d-lg-none me-4">
                    <h2 class="text-primary mb-0"><i class="fa fa-warehouse"></i></h2>
                </a>
                <a href="#" class="sidebar-toggler flex-shrink-0">
                    <i class="fa fa-bars"></i>
                </a>
                <form class="d-none d-md-flex ms-4">
                    <input class="form-control border-0" type="search" placeholder="주문 검색">
                </form>
                <div class="navbar-nav align-items-center ms-auto">
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fa fa-envelope me-lg-2"></i>
                            <span class="d-none d-lg-inline-flex">메시지</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="#" class="dropdown-item">
                                <div class="d-flex align-items-center">
                                    <img class="rounded-circle" src="${pageContext.request.contextPath}/resources/img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                    <div class="ms-2">
                                        <h6 class="fw-normal mb-0">재고 부족 알림</h6>
                                        <small>15분 전</small>
                                    </div>
                                </div>
                            </a>
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item text-center">모든 메시지 보기</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fa fa-bell me-lg-2"></i>
                            <span class="d-none d-lg-inline-flex">알림</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="#" class="dropdown-item">
                                <h6 class="fw-normal mb-0">재고 부족: 제품 A</h6>
                                <small>15분 전</small>
                            </a>
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item">
                                <h6 class="fw-normal mb-0">신규 주문 등록</h6>
                                <small>30분 전</small>
                            </a>
                            <hr class="dropdown-divider">
                            <a href="#" class="dropdown-item text-center">모든 알림 보기</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <img class="rounded-circle me-lg-2" src="${pageContext.request.contextPath}/resources/img/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <span class="d-none d-lg-inline-flex"><%= session.getAttribute("username") != null ? session.getAttribute("username") : "재고마스터" %></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                            <a href="#" class="dropdown-item">내 프로필</a>
                            <a href="#" class="dropdown-item">설정</a>
                            <a href="${pageContext.request.contextPath}/logout.jsp" class="dropdown-item">로그아웃</a>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->

            <!-- Order Edit Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">주문 수정 (주문번호: ${order.orderId})</h6>
                    </div>

                    <!-- 주문 수정 폼 -->
                    <form class="row g-3" action="${pageContext.request.contextPath}/updateOrder.do" method="post">
                        <!-- 주문번호 (숨김 필드) -->
                        <input type="hidden" name="orderId" value="${order.orderId}">

                        <!-- 거래처 유형 선택 -->
                        <div class="col-md-6">
                            <label for="transactionType" class="form-label">거래처 유형</label>
                            <select class="form-control" id="transactionType" name="transactionType" required>
                                <option value="" disabled>거래처 유형 선택</option>
                                <option value="wholesale" ${order.customerType == 'wholesale' ? 'selected' : ''}>공급처</option>
                                <option value="retail" ${order.customerType == 'retail' ? 'selected' : ''}>판매처</option>
                            </select>
                        </div>

                        <!-- 거래처 선택 -->
                        <div class="col-md-6">
                            <label for="client" class="form-label">거래처</label>
                            <select class="form-control" id="client" name="client" required>
                                <option value="" disabled>거래처 선택</option>
                                <c:forEach var="client" items="${clients}">
                                    <option value="${client.id}" ${order.customerCode == client.id ? 'selected' : ''}>${client.name} (${client.id})</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- 상품명 -->
                        <div class="col-md-6">
                            <label for="productName" class="form-label">상품명</label>
                            <input type="text" class="form-control" id="productName" name="productName" value="${order.productName}" required>
                        </div>

                        <!-- 옵션 -->
                        <div class="col-md-6">
                            <label for="option" class="form-label">옵션</label>
                            <input type="text" class="form-control" id="option" name="option" value="${order.option}">
                        </div>

                        <!-- 수량 -->
                        <div class="col-md-6">
                            <label for="quantity" class="form-label">수량</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="${order.quantity}" required>
                        </div>

                        <!-- 판매가 -->
                        <div class="col-md-6">
                            <label for="price" class="form-label">판매가</label>
                            <input type="number" class="form-control" id="price" name="price" min="0" value="${order.price}" required>
                        </div>

                        <!-- 담당자명 -->
                        <div class="col-md-6">
                            <label for="managerName" class="form-label">담당자명</label>
                            <input type="text" class="form-control" id="managerName" name="managerName" value="${order.customerContactName}" required>
                        </div>

                        <!-- 담당자 연락처 -->
                        <div class="col-md-6">
                            <label for="managerContact" class="form-label">담당자 연락처</label>
                            <input type="text" class="form-control" id="managerContact" name="managerContact" value="${order.customerContactPhone}" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required>
                        </div>

                        <!-- 거래처 주소지 -->
                        <div class="col-12">
                            <label for="address" class="form-label">거래처 주소지</label>
                            <input type="text" class="form-control" id="address" name="address" value="${order.customerAddress}" required>
                        </div>

                        <!-- 버튼 -->
                        <div class="col-12 d-flex justify-content-end mt-3">
                            <button type="button" class="btn btn-secondary me-2" onclick="cancelEdit()">취소</button>
                            <button type="submit" class="btn btn-primary">저장</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- Order Edit End -->

            <!-- Footer Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded-top p-4">
                    <div class="row">
                        <div class="col-12 col-sm-6 text-center text-sm-start">
                            © <a href="#">Stockmaster</a>, All Rights Reserved.
                        </div>
                        <div class="col-12 col-sm-6 text-center text-sm-end">
                            Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>

    <!-- Optimized JavaScript Loading -->
    <script defer src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JavaScript -->
    <script>
        // 드롭다운 메뉴 초기화
        document.addEventListener('DOMContentLoaded', function() {
            var dropdowns = document.querySelectorAll('.dropdown-toggle');
            dropdowns.forEach(function(dropdown) {
                dropdown.addEventListener('click', function(e) {
                    e.preventDefault();
                    var menu = this.nextElementSibling;
                    menu.classList.toggle('show');
                });
            });

            // 드롭다운 외부 클릭시 닫기
            document.addEventListener('click', function(e) {
                if (!e.target.matches('.dropdown-toggle')) {
                    var dropdowns = document.querySelectorAll('.dropdown-menu.show');
                    dropdowns.forEach(function(dropdown) {
                        dropdown.classList.remove('show');
                    });
                }
            });
        });

        // 페이지 기능 초기화
        const initPage = () => {
            initFormValidation();
            initFormSubmission();
        };

        // 폼 유효성 검사 초기화
        const initFormValidation = () => {
            // 가격 입력 필드 유효성 검사
            const priceInput = document.getElementById('price');
            if (priceInput) {
                priceInput.addEventListener('input', function() {
                    if (this.value < 0) this.value = 0;
                });
            }

            // 수량 입력 필드 유효성 검사
            const quantityInput = document.getElementById('quantity');
            if (quantityInput) {
                quantityInput.addEventListener('input', function() {
                    if (this.value < 1) this.value = 1;
                });
            }

            // 연락처 형식 검사
            const contactInput = document.getElementById('managerContact');
            if (contactInput) {
                contactInput.addEventListener('input', function() {
                    this.value = this.value.replace(/[^0-9-]/g, '');
                    if (this.value.length === 11) {
                        this.value = this.value.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
                    }
                });
            }
        };

        // 폼 제출 처리 초기화
        const initFormSubmission = () => {
            const form = document.querySelector('form[action="${pageContext.request.contextPath}/updateOrder.do"]');
            if (form) {
                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    if (confirm('주문을 수정하시겠습니까?')) {
                        showSpinner();
                        this.submit();
                    }
                });
            }
        };

        // 취소 버튼 처리
        function cancelEdit() {
            if (confirm('수정을 취소하시겠습니까? 변경사항이 저장되지 않습니다.')) {
                window.location.href = '${pageContext.request.contextPath}/orderlist.do';
            }
        }

        // 페이지 로드 시 초기화
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initPage);
        } else {
            initPage();
        }
    </script>
</body>

</html>