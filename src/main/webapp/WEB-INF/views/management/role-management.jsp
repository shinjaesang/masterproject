<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 역할 관리</title>
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

    <style>
        .role-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .role-header {
            margin-bottom: 15px;
        }
        .role-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        .role-description {
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 15px;
        }
        .role-stats {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            color: #6c757d;
            font-size: 13px;
        }
        .role-actions {
            display: flex;
            gap: 10px;
        }
        .btn-edit {
            color: #0d6efd;
            background: none;
            border: 1px solid #0d6efd;
            padding: 5px 15px;
            border-radius: 5px;
        }
        .btn-delete {
            color: #dc3545;
            background: none;
            border: 1px solid #dc3545;
            padding: 5px 15px;
            border-radius: 5px;
        }
        .btn-edit:hover {
            background: #0d6efd;
            color: white;
        }
        .btn-delete:hover {
            background: #dc3545;
            color: white;
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

            <!-- Role Management Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="mb-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h4 class="mb-0">역할 관리</h4>
                        <small class="text-muted">시스템의 역할과 권한을 관리할 수 있습니다.</small>
                    </div>
                    <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/authority/roleadd.do'">
                        <i class="fas fa-plus me-2"></i>새 역할 추가
                    </button>
                </div>

                <!-- Tab Menu -->
                <div class="bg-light rounded p-3 mb-4">
                    <div class="nav nav-pills d-inline-flex text-center">
                        <button class="nav-link flex-fill me-1" 
                                onclick="location.href='${pageContext.request.contextPath}/authority/list.do'">
                            사용자 관리
                        </button>
                        <button class="nav-link active flex-fill me-1" 
                                onclick="location.href='${pageContext.request.contextPath}/authority/role.do'">
                            역할 관리
                        </button>
                        <button class="nav-link flex-fill" 
                                onclick="location.href='${pageContext.request.contextPath}/authority/log.do'">
                            권한 변경 로그
                        </button>
                    </div>
                </div>

                <!-- Role List -->
                <div class="row">
                    <!-- 관리자 역할 -->
                    <div class="col-md-4">
                        <div class="role-card">
                            <div class="role-header">
                                <div class="role-title">관리자</div>
                                <div class="role-description">시스템의 모든 기능을 관리하고 접근할 수 있는 최고 권한을 가진 역할입니다.</div>
                            </div>
                            <div class="role-stats">
                                <span><i class="fas fa-users me-1"></i>사용자 3명</span>
                                <span><i class="fas fa-key me-1"></i>권한 12개</span>
                            </div>
                            <div class="role-actions">
                                <button class="btn-edit" onclick="editRole('ADMIN')">
                                    <i class="fas fa-edit me-1"></i>편집
                                </button>
                                <button class="btn-delete" onclick="deleteRole('ADMIN')">
                                    <i class="fas fa-trash me-1"></i>삭제
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- 재고관리자 역할 -->
                    <div class="col-md-4">
                        <div class="role-card">
                            <div class="role-header">
                                <div class="role-title">재고관리자</div>
                                <div class="role-description">재고 관련 기능을 관리하고 접근할 수 있는 권한을 가진 역할입니다.</div>
                            </div>
                            <div class="role-stats">
                                <span><i class="fas fa-users me-1"></i>사용자 5명</span>
                                <span><i class="fas fa-key me-1"></i>권한 8개</span>
                            </div>
                            <div class="role-actions">
                                <button class="btn-edit" onclick="editRole('STOCK_MANAGER')">
                                    <i class="fas fa-edit me-1"></i>편집
                                </button>
                                <button class="btn-delete" onclick="deleteRole('STOCK_MANAGER')">
                                    <i class="fas fa-trash me-1"></i>삭제
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- 거래처관리자 역할 -->
                    <div class="col-md-4">
                        <div class="role-card">
                            <div class="role-header">
                                <div class="role-title">거래처관리자</div>
                                <div class="role-description">거래처 관련 기능을 관리하고 접근할 수 있는 권한을 가진 역할입니다.</div>
                            </div>
                            <div class="role-stats">
                                <span><i class="fas fa-users me-1"></i>사용자 4명</span>
                                <span><i class="fas fa-key me-1"></i>권한 6개</span>
                            </div>
                            <div class="role-actions">
                                <button class="btn-edit" onclick="editRole('VENDOR_MANAGER')">
                                    <i class="fas fa-edit me-1"></i>편집
                                </button>
                                <button class="btn-delete" onclick="deleteRole('VENDOR_MANAGER')">
                                    <i class="fas fa-trash me-1"></i>삭제
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- 일반사용자 역할 -->
                    <div class="col-md-4">
                        <div class="role-card">
                            <div class="role-header">
                                <div class="role-title">일반사용자</div>
                                <div class="role-description">기본적인 시스템 기능에 접근할 수 있는 일반 사용자 역할입니다.</div>
                            </div>
                            <div class="role-stats">
                                <span><i class="fas fa-users me-1"></i>사용자 15명</span>
                                <span><i class="fas fa-key me-1"></i>권한 4개</span>
                            </div>
                            <div class="role-actions">
                                <button class="btn-edit" onclick="editRole('USER')">
                                    <i class="fas fa-edit me-1"></i>편집
                                </button>
                                <button class="btn-delete" onclick="deleteRole('USER')">
                                    <i class="fas fa-trash me-1"></i>삭제
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- 결재자 역할 -->
                    <div class="col-md-4">
                        <div class="role-card">
                            <div class="role-header">
                                <div class="role-title">결재자</div>
                                <div class="role-description">결재 관련 기능을 수행할 수 있는 권한을 가진 역할입니다.</div>
                            </div>
                            <div class="role-stats">
                                <span><i class="fas fa-users me-1"></i>사용자 7명</span>
                                <span><i class="fas fa-key me-1"></i>권한 5개</span>
                            </div>
                            <div class="role-actions">
                                <button class="btn-edit" onclick="editRole('APPROVER')">
                                    <i class="fas fa-edit me-1"></i>편집
                                </button>
                                <button class="btn-delete" onclick="deleteRole('APPROVER')">
                                    <i class="fas fa-trash me-1"></i>삭제
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Role Management End -->
            
            
            <!-- Role Permission Matrix Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light rounded p-4">
                    <h5 class="mb-4">역할 권한 매트릭스</h5>
                     <h5 class="mb-4">권한 항목</h5>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead class="bg-light">
                                <tr>
                                    <th scope="col" style="min-width: 150px;">권한 / 항목</th>
                                    <th scope="col" style="min-width: 120px;">관리자</th>
                                    <th scope="col" style="min-width: 120px;">재고관리자</th>
                                    <th scope="col" style="min-width: 120px;">거래처관리자</th>
                                    <th scope="col" style="min-width: 120px;">일반사용자</th>
                                    <th scope="col" style="min-width: 120px;">결재자</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="fw-bold">매출 정보 조회</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-success">✓</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">재고 관리</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">거래처 등록/수정</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">거래처 삭제</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">거래처 등록/수정</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">창고 등록/수정</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">창고 삭제</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">공지사항 관리</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-success">✓</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">긴급 공지사항 설정</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">상품 등록/수정</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">상품 삭제</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">재고 조정</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">입출고 전표 등록/수정</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">입출고 전표 삭제</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">결재문서 작성/수정/회수</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">결재문서 처리</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">비상연락망 수정</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                    <td class="text-danger">✗</td>
                                </tr>
                                <tr>
                                    <td class="fw-bold">사용자 정보 수정</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                    <td class="text-success">✓</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Role Permission Matrix End -->
            
            

            <!-- Footer Start -->
            <jsp:include page="../common/footer.jsp" />
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top">
            <i class="bi bi-arrow-up"></i>
        </a>
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

    <!-- Page Specific Javascript -->
    <script>
        // 역할 편집 함수
        function editRole(roleId) {
            location.href = '${pageContext.request.contextPath}/authority/roleedit.do?id=' + roleId;
        }

        // 역할 삭제 함수
        function deleteRole(roleId) {
            if (confirm('정말로 이 역할을 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
                // TODO: 역할 삭제 API 호출
                alert('역할 삭제 기능은 준비 중입니다.');
            }
        }

        // 페이지 로드 시 스피너 숨기기
        $(document).ready(function() {
            $('#spinner').removeClass('show');
            $('.content').addClass('show');
        });
    </script>
</body>
</html>