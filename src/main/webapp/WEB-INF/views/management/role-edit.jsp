<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 역할 편집</title>
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
        .permission-section {
            max-height: 400px;
            overflow-y: auto;
        }
        .permission-group {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }
        .permission-group:last-child {
            border-bottom: none;
        }
        .btn-user-edit {
            min-width: 120px;
        }
        .form-label {
            font-weight: 600;
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

            <!-- Edit Role Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h4 class="mb-4">역할 편집</h4>
                            <form id="roleForm">
                                <input type="hidden" id="roleId" name="roleId" value="${role.id}">
                                <div class="mb-3">
                                    <label for="roleName" class="form-label">역할명</label>
                                    <input type="text" class="form-control" id="roleName" name="roleName" value="${role.name}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="roleDescription" class="form-label">설명</label>
                                    <textarea class="form-control" id="roleDescription" name="roleDescription" rows="3" required>${role.description}</textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">사용자</label>
                                    <div class="d-flex align-items-center mb-2">
                                        <span id="selectedUserCount" class="me-2">선택된 사용자: ${role.userCount}명</span>
                                        <button type="button" class="btn btn-primary btn-user-edit" onclick="openUserEdit()">
                                            <i class="fas fa-users me-2"></i>사용자 변경
                                        </button>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">권한 설정</label>
                                    <div class="permission-section">
                                        <!-- 거래처 관리 -->
                                        <div class="permission-group">
                                            <h6 class="mb-3">거래처 관리</h6>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="PARTNER_EDIT" id="partnerEdit" ${role.permissions.contains('PARTNER_EDIT') ? 'checked' : ''}>
                                                <label class="form-check-label" for="partnerEdit">거래처 등록/수정</label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="PARTNER_DELETE" id="partnerDelete" ${role.permissions.contains('PARTNER_DELETE') ? 'checked' : ''}>
                                                <label class="form-check-label" for="partnerDelete">거래처 삭제</label>
                                            </div>
                                        </div>

                                        <!-- 결재문서 관리 -->
                                        <div class="permission-group">
                                            <h6 class="mb-3">결재문서 관리</h6>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="APPROVAL_EDIT" id="approvalEdit" ${role.permissions.contains('APPROVAL_EDIT') ? 'checked' : ''}>
                                                <label class="form-check-label" for="approvalEdit">결재문서 작성/수정/회수</label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="APPROVAL_PROCESS" id="approvalProcess" ${role.permissions.contains('APPROVAL_PROCESS') ? 'checked' : ''}>
                                                <label class="form-check-label" for="approvalProcess">결재문서 처리</label>
                                            </div>
                                        </div>

                                        <!-- 공지사항 관리 -->
                                        <div class="permission-group">
                                            <h6 class="mb-3">공지사항 관리</h6>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="NOTICE_EDIT" id="noticeEdit" ${role.permissions.contains('NOTICE_EDIT') ? 'checked' : ''}>
                                                <label class="form-check-label" for="noticeEdit">공지사항 작성/수정/삭제</label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="NOTICE_EMERGENCY" id="noticeEmergency" ${role.permissions.contains('NOTICE_EMERGENCY') ? 'checked' : ''}>
                                                <label class="form-check-label" for="noticeEmergency">긴급 공지사항 설정</label>
                                            </div>
                                        </div>

                                        <!-- 상품 관리 -->
                                        <div class="permission-group">
                                            <h6 class="mb-3">상품 관리</h6>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="PRODUCT_EDIT" id="productEdit" ${role.permissions.contains('PRODUCT_EDIT') ? 'checked' : ''}>
                                                <label class="form-check-label" for="productEdit">상품 등록/수정</label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="PRODUCT_DELETE" id="productDelete" ${role.permissions.contains('PRODUCT_DELETE') ? 'checked' : ''}>
                                                <label class="form-check-label" for="productDelete">상품 삭제</label>
                                            </div>
                                        </div>

                                        <!-- 입출고 관리 -->
                                        <div class="permission-group">
                                            <h6 class="mb-3">입출고 관리</h6>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="INVENTORY_SLIP_EDIT" id="inventorySlipEdit" ${role.permissions.contains('INVENTORY_SLIP_EDIT') ? 'checked' : ''}>
                                                <label class="form-check-label" for="inventorySlipEdit">입출고 전표 등록/수정</label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="INVENTORY_SLIP_DELETE" id="inventorySlipDelete" ${role.permissions.contains('INVENTORY_SLIP_DELETE') ? 'checked' : ''}>
                                                <label class="form-check-label" for="inventorySlipDelete">입출고 전표 삭제</label>
                                            </div>
                                        </div>

                                        <!-- 재고 관리 -->
                                        <div class="permission-group">
                                            <h6 class="mb-3">재고 관리</h6>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="STOCK_ADJUST" id="stockAdjust" ${role.permissions.contains('STOCK_ADJUST') ? 'checked' : ''}>
                                                <label class="form-check-label" for="stockAdjust">재고 조정</label>
                                            </div>
                                        </div>

                                        <!-- 창고 관리 -->
                                        <div class="permission-group">
                                            <h6 class="mb-3">창고 관리</h6>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="WAREHOUSE_EDIT" id="warehouseEdit" ${role.permissions.contains('WAREHOUSE_EDIT') ? 'checked' : ''}>
                                                <label class="form-check-label" for="warehouseEdit">창고 등록/수정</label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="WAREHOUSE_DELETE" id="warehouseDelete" ${role.permissions.contains('WAREHOUSE_DELETE') ? 'checked' : ''}>
                                                <label class="form-check-label" for="warehouseDelete">창고 삭제</label>
                                            </div>
                                        </div>

                                        <!-- 기타 -->
                                        <div class="permission-group">
                                            <h6 class="mb-3">기타</h6>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="ACCOUNT_MANAGE" id="accountManage" ${role.permissions.contains('ACCOUNT_MANAGE') ? 'checked' : ''}>
                                                <label class="form-check-label" for="accountManage">계정 관리</label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="SALES_VIEW" id="salesView" ${role.permissions.contains('SALES_VIEW') ? 'checked' : ''}>
                                                <label class="form-check-label" for="salesView">매출 정보 조회</label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="EMERGENCY_CONTACT" id="emergencyContact" ${role.permissions.contains('EMERGENCY_CONTACT') ? 'checked' : ''}>
                                                <label class="form-check-label" for="emergencyContact">비상연락망 수정</label>
                                            </div>
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="checkbox" name="permissions" value="USER_INFO_EDIT" id="userInfoEdit" ${role.permissions.contains('USER_INFO_EDIT') ? 'checked' : ''}>
                                                <label class="form-check-label" for="userInfoEdit">사용자 정보 수정</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <button type="button" class="btn btn-secondary me-2" onclick="location.href='${pageContext.request.contextPath}/authority/role.do'">취소</button>
                                    <button type="button" class="btn btn-primary" onclick="saveRole()">저장</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Edit Role End -->

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
        // 사용자 편집 창 열기
        function openUserEdit() {
        	const width = 800;
            const height = 600;
            const left = (screen.width - width) / 2;
            const top = (screen.height - height) / 2;
            
            window.open('${pageContext.request.contextPath}/authority/roleuseredit.do?roleId=${role.id}', 
                       '사용자 선택', 
                       `width=600,height=750,left=${left},top=${top},resizable=yes`);
        }

        // 역할 저장
        function saveRole() {
            const formData = {
                roleId: $('#roleId').val(),
                roleName: $('#roleName').val(),
                description: $('#roleDescription').val(),
                permissions: [],
                userCount: parseInt($('#selectedUserCount').text().match(/\d+/)[0])
            };

            // 선택된 권한 수집
            $('input[name="permissions"]:checked').each(function() {
                formData.permissions.push($(this).val());
            });

            // 유효성 검사
            if (!formData.roleName) {
                alert('역할명을 입력해주세요.');
                return;
            }
            if (!formData.description) {
                alert('설명을 입력해주세요.');
                return;
            }
            if (formData.permissions.length === 0) {
                alert('하나 이상의 권한을 선택해주세요.');
                return;
            }

            // AJAX 요청
            $.ajax({
                url: '${pageContext.request.contextPath}/authority/role/edit.do',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    alert('역할이 성공적으로 수정되었습니다.');
                    location.href = '${pageContext.request.contextPath}/authority/role.do';
                },
                error: function(xhr, status, error) {
                    alert('역할 수정 중 오류가 발생했습니다.');
                }
            });
        }

        // 페이지 로드 시 스피너 숨기기
        $(document).ready(function() {
            $('#spinner').removeClass('show');
        });

        // 사용자 선택 결과 처리 (팝업에서 호출)
        function handleUserSelection(selectedCount) {
            $('#selectedUserCount').text(`선택된 사용자: ${selectedCount}명`);
        }
    </script>
</body>
</html>