<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 계정 권한 관리</title>
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
        .search-filters {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .user-table th {
            background-color: #f8f9fa;
        }
        .action-menu {
            position: fixed;
            background: white;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 8px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            z-index: 9999;
            display: none;
        }
        .action-menu button {
            display: block;
            width: 100%;
            padding: 8px 16px;
            text-align: left;
            border: none;
            background: none;
            cursor: pointer;
            white-space: nowrap;
        }
        .action-menu button:hover {
            background-color: #f8f9fa;
        }
        .action-item {
            min-width: 150px;
        }
        .text-danger {
            color: #dc3545;
        }
        .action-dots {
            letter-spacing: -1px;
            font-size: 18px;
        }
        .user-row {
            cursor: pointer;
        }
        .user-row:hover {
            background-color: #f8f9fa;
        }
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            display: inline-block;
        }
        .status-active {
            background-color: #28a745;
            color: white;
        }
        .status-inactive {
            background-color: #dc3545;
            color: white;
        }
        /* 모달 스타일 */
        .modal-content {
            border-radius: 8px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.16);
        }
        .modal-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            border-radius: 8px 8px 0 0;
        }
        .modal-footer {
            background-color: #f8f9fa;
            border-top: 1px solid #dee2e6;
            border-radius: 0 0 8px 8px;
        }
        .modal-body {
            padding: 20px;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        .form-select {
            border-radius: 4px;
            border: 1px solid #ced4da;
            padding: 8px 12px;
        }
        .form-select:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
            border-color: #0a58ca;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5c636a;
            border-color: #565e64;
        }
        /* Custom Modal Styles */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .modal-container {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.16);
            z-index: 1001;
            min-width: 400px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #dee2e6;
        }

        .modal-title {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 500;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            padding: 0;
            color: #6c757d;
        }

        .modal-close:hover {
            color: #343a40;
        }

        .modal-body {
            margin-bottom: 20px;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            padding-top: 15px;
            border-top: 1px solid #dee2e6;
        }

        /* 상태 뱃지 스타일 */
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            display: inline-block;
        }

        .status-active {
            background-color: #28a745;
            color: white;
        }

        .status-inactive {
            background-color: #dc3545;
            color: white;
        }

        /* 아이콘 스타일 */
        .text-success {
            color: #28a745 !important;
        }

        .text-danger {
            color: #dc3545 !important;
        }

        .fa-check-circle, .fa-times-circle {
            font-size: 1.2rem;
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

            <!-- Auth Management Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h4 class="mb-0">계정 권한 관리</h4>
                            <small class="text-muted">사용자 계정의 권한을 관리할 수 있습니다.</small>
                        </div>
                        <button class="btn btn-success" type="button" onclick="location.href='${pageContext.request.contextPath}/member/enrollPage.do'">
                            <i class="fa fa-plus me-1"></i>신규 사용자 등록
                        </button>
                    </div>
                </div>

                <!-- Tab Menu -->
                <div class="bg-light rounded p-3 mb-4">
                    <div class="nav nav-pills d-inline-flex text-center">
                        <button class="nav-link active flex-fill me-1" 
                                onclick="location.href='${pageContext.request.contextPath}/authority/list.do'">
                            사용자 관리
                        </button>
                        <button class="nav-link flex-fill me-1" 
                                onclick="location.href='${pageContext.request.contextPath}/authority/role.do'">
                            역할 관리
                        </button>
                        <button class="nav-link flex-fill" 
                                onclick="location.href='${pageContext.request.contextPath}/authority/log.do'">
                            권한 변경 로그
                        </button>
                    </div>
                </div>

                <!-- Search Filters -->
                <div class="bg-light rounded p-4">
                    <div class="row g-3">
                        <div class="col-md-2">
                            <input type="text" class="form-control" id="searchName" placeholder="사용자 이름">
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" id="searchDepartment">
                                <option value="">부서 선택</option>
                                <option value="경영지원부">경영지원부</option>
                                <option value="개발부">개발부</option>
                                <option value="물류부">물류부</option>
                                <option value="영업부">영업부</option>
                                <option value="인사부">인사부</option>
                                <option value="재무부">재무부</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" id="searchPosition">
                                <option value="">직급 선택</option>
                                <option value="사원">사원</option>
                                <option value="대리">대리</option>
                                <option value="과장">과장</option>
                                <option value="부장">부장</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" id="searchRole">
                                <option value="">역할 선택</option>
                                <option value="관리자">관리자</option>
                                <option value="재고관리자">재고관리자</option>
                                <option value="거래처관리자">거래처관리자</option>
                                <option value="일반사용자">일반사용자</option>
                                <option value="결재자">결재자</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-primary w-100" onclick="filterUsers()">
                                <i class="fas fa-search me-2"></i>검색
                            </button>
                        </div>
                    </div>
                </div>

                <!-- User Table -->
                <div class="bg-light rounded p-4 mt-4">
                    <div class="table-responsive">
                        <table class="table table-hover user-table">
                            <thead>
                                <tr>
                                    <th>사용자</th>
                                    <th>부서</th>
                                    <th>직급</th>
                                    <th>이메일 주소</th>
                                    <th>상태</th>
                                    <th>가입일</th>
                                    <th>역할</th>
                                    <th>작업</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty userList}">
                                        <c:forEach var="user" items="${userList}">
                                            <tr class="user-row" data-user-id="${user.empId}">
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div>
                                                            <div class="fw-bold">${user.empName}</div>
                                                            <c:if test="${not empty user.lastLoginDate}">
                                                                <div class="text-muted small">마지막 사용: ${user.lastLoginDate}</div>
                                                            </c:if>
                                                            <div class="text-muted small">${user.adminYN eq 'Y' ? '관리자' : '일반사용자'}</div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${user.department}</td>
                                                <td>${user.job}</td>
                                                <td>${user.email}</td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:choose>
                                                            <c:when test="${user.isActive eq 'Y'}">
                                                                <i class="fas fa-check-circle text-success me-2" id="statusIcon_${user.empId}"></i>
                                                                <span class="status-badge status-active" id="statusText_${user.empId}">활성</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fas fa-times-circle text-danger me-2" id="statusIcon_${user.empId}"></i>
                                                                <span class="status-badge status-inactive" id="statusText_${user.empId}">비활성</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                                <td><fmt:formatDate value="${user.hireDate}" pattern="yyyy/MM/dd"/></td>
                                                <td>${user.adminYN eq 'Y' ? '관리자' : '일반사용자'}</td>
                                                <td>
                                                    <button class="btn btn-link text-dark p-0" onclick="showActionMenu(event, '${user.empId}')">
                                                        <i class="fas fa-ellipsis-v"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8" class="text-center py-4">
                                                <div class="text-muted">
                                                    <i class="fas fa-info-circle me-2"></i>등록된 사용자가 없습니다.
                                                </div>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Auth Management End -->

            <!-- Footer Start -->
            <jsp:include page="../common/footer.jsp" />
            <!-- Footer End -->
        </div>
        <!-- Content End -->

        <!-- Employee Edit Modal -->
        <div class="modal-overlay" id="employeeEditModalOverlay"></div>
        <div class="modal-container" id="employeeEditModal">
            <div class="modal-header">
                <h5 class="modal-title">사원 정보 수정</h5>
                <button type="button" class="modal-close" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="employeeEditForm">
                    <input type="hidden" id="editEmpId" name="empId">
                    <div class="mb-3">
                        <label for="editEmpName" class="form-label">이름</label>
                        <input type="text" class="form-control" id="editEmpName" name="empName" required>
                    </div>
                    <div class="mb-3">
                        <label for="editDepartment" class="form-label">부서</label>
                        <select class="form-select" id="editDepartment" name="department" required>
                            <option value="">부서 선택</option>
                            <option value="경영지원부">경영지원부</option>
                            <option value="개발부">개발부</option>
                            <option value="물류부">물류부</option>
                            <option value="영업부">영업부</option>
                            <option value="인사부">인사부</option>
                            <option value="재무부">재무부</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editJob" class="form-label">직급</label>
                        <select class="form-select" id="editJob" name="job" required>
                            <option value="">직급 선택</option>
                            <option value="사원">사원</option>
                            <option value="대리">대리</option>
                            <option value="과장">과장</option>
                            <option value="부장">부장</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editEmail" class="form-label">이메일</label>
                        <input type="email" class="form-control" id="editEmail" name="email" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeModal()">취소</button>
                <button type="button" class="btn btn-primary" onclick="saveEmployeeInfo()">저장</button>
            </div>
        </div>

        <!-- Action Menu -->
        <div id="actionMenu" class="action-menu">
            <button onclick="editEmployee(currentEmpId)" class="action-item">
                <i class="fas fa-edit me-2"></i>정보 수정
            </button>
            <button onclick="deleteUser(currentEmpId)" class="action-item text-danger">
                <i class="fas fa-trash-alt me-2"></i>사용자 삭제
            </button>
        </div>

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top">
            <i class="bi bi-arrow-up"></i>
        </a>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
        let currentEmpId = null;

        // 사용자 필터링 함수
        function filterUsers() {
            const name = document.getElementById('searchName').value.toLowerCase();
            const department = document.getElementById('searchDepartment').value;
            const position = document.getElementById('searchPosition').value;
            const role = document.getElementById('searchRole').value;

            document.querySelectorAll('.user-table tbody tr').forEach(row => {
                const userName = row.querySelector('.fw-bold').textContent.toLowerCase();
                const userDepartment = row.querySelector('td:nth-child(2)').textContent;
                const userPosition = row.querySelector('td:nth-child(3)').textContent;
                const userRole = row.querySelector('td:nth-child(5)').textContent;

                const matchName = userName.includes(name);
                const matchDepartment = !department || userDepartment === department;
                const matchPosition = !position || userPosition === position;
                const matchRole = !role || userRole === role;

                row.style.display = matchName && matchDepartment && matchPosition && matchRole ? '' : 'none';
            });
        }

        // 작업 메뉴 표시
        function showActionMenu(event, empId) {
            event.preventDefault();
            event.stopPropagation();
            currentEmpId = empId;
            
            const menu = document.getElementById('actionMenu');
            const clickedButton = event.target.closest('button');
            const buttonRect = clickedButton.getBoundingClientRect();
            
            menu.style.display = 'block';
            menu.style.top = buttonRect.bottom + 'px';
            menu.style.right = '10px';

            // 메뉴가 화면 아래로 넘어가는 경우 위치 조정
            const menuRect = menu.getBoundingClientRect();
            if (menuRect.bottom > window.innerHeight) {
                menu.style.top = (buttonRect.top - menuRect.height) + 'px';
            }

            // 다른 곳 클릭시 메뉴 닫기
            document.addEventListener('click', hideActionMenu);
        }

        // 작업 메뉴 숨기기
        function hideActionMenu() {
            document.getElementById('actionMenu').style.display = 'none';
            document.removeEventListener('click', hideActionMenu);
        }

        // 모달 열기
        function openModal() {
            document.getElementById('employeeEditModalOverlay').style.display = 'block';
            document.getElementById('employeeEditModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
        }

        // 모달 닫기
        function closeModal() {
            document.getElementById('employeeEditModalOverlay').style.display = 'none';
            document.getElementById('employeeEditModal').style.display = 'none';
            document.body.style.overflow = '';
        }

        // 사원 정보 수정 페이지로 이동
        function editEmployee(empId) {
            window.location.href = '${pageContext.request.contextPath}/member/editMember.do?empId=' + empId;
            hideActionMenu();
        }

        // 사원 정보 저장
        function saveEmployeeInfo() {
            const empId = document.getElementById('editEmpId').value;
            const empName = document.getElementById('editEmpName').value;
            const department = document.getElementById('editDepartment').value;
            const job = document.getElementById('editJob').value;
            const email = document.getElementById('editEmail').value;

            if (!empName || !department || !job || !email) {
                alert('모든 필드를 입력해주세요.');
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/authority/updateEmployee.do',
                type: 'POST',
                data: {
                    empId: empId,
                    empName: empName,
                    department: department,
                    job: job,
                    email: email
                },
                success: function(response) {
                    if(response === 'success') {
                        alert('사원 정보가 성공적으로 수정되었습니다.');
                        closeModal();
                        // 페이지 새로고침
                        location.reload();
                    } else {
                        alert('사원 정보 수정에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    alert('사원 정보 수정 중 오류가 발생했습니다.');
                    console.error('Error:', error);
                }
            });
        }

        // 사용자 삭제
        function deleteUser(empId) {
            if (confirm('정말로 이 사용자를 삭제하시겠습니까?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/authority/deleteUser.do',
                    type: 'POST',
                    data: { empId: empId },
                    success: function(response) {
                        if(response.success) {
                            alert(response.message);
                            // 삭제된 사용자 행을 테이블에서 제거
                            $(`tr[data-user-id="${empId}"]`).remove();
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('사용자 삭제 중 오류가 발생했습니다.');
                        console.error('Error:', error);
                    }
                });
                hideActionMenu();
            }
        }

        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            // 스피너 숨기기
            $('#spinner').removeClass('show');
            
            // 컨텐츠 표시
            $('.content').addClass('show');

            // Enter 키 검색 지원
            document.querySelectorAll('.search-filters input, .search-filters select').forEach(element => {
                element.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        filterUsers();
                    }
                });
            });

            // 상태 변경 이벤트 리스너 추가
            window.addEventListener('userStatusChanged', function(e) {
                const { empId, isActive } = e.detail;
                updateUserStatusUI(empId, isActive);
            });
        });

        // 사용자 상태 UI 업데이트 함수
        function updateUserStatusUI(empId, isActive) {
            const statusIcon = document.getElementById(`statusIcon_${empId}`);
            const statusText = document.getElementById(`statusText_${empId}`);
            
            if (isActive === 'Y') {
                statusIcon.className = 'fas fa-check-circle text-success me-2';
                statusText.className = 'status-badge status-active';
                statusText.textContent = '활성';
            } else {
                statusIcon.className = 'fas fa-times-circle text-danger me-2';
                statusText.className = 'status-badge status-inactive';
                statusText.textContent = '비활성';
            }
        }

        // 사용자 상태 변경 이벤트 발생 함수
        function notifyStatusChange(empId, isActive) {
            const event = new CustomEvent('userStatusChanged', {
                detail: { empId, isActive }
            });
            window.dispatchEvent(event);
        }
    </script>
</body>
</html> 