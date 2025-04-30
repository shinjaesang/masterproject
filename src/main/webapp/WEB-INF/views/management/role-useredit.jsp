<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>사용자 선택</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet">

<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	background-color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
}

.wrapper {
	width: 600px; /* 고정 폭 */
	height: 750px; /* 고정 높이 */
	padding: 15px;
	background: #fff;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
	display: flex;
	flex-direction: column;
	gap: 15px;
	overflow: hidden; /* 넘치는 경우 스크롤 없이 숨김 */
}

.search-section {
	background: white;
	padding: 15px;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.table-section {
	background: white;
	padding: 15px;
	border-radius: 5px;
	flex: 1;
	display: flex;
	flex-direction: column;
	min-height: 300px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.table-container {
	flex: 1;
	overflow-y: auto;
	margin-top: 15px;
}

.action-section {
	background: white;
	padding: 15px;
	border-radius: 5px;
	box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
}

.form-control:focus, .form-select:focus {
	box-shadow: none;
	border-color: #009CFF;
}

.table {
	margin-bottom: 0;
}

.table th {
	background-color: #f8f9fa;
	position: sticky;
	top: 0;
	z-index: 1;
}
</style>
</head>

<body>
	<div class="wrapper">
		<!-- Search Section Start -->
		<div class="search-section">
			<div class="row g-3">
				<div class="col-md-3">
					<input type="text" class="form-control" id="searchName"
						placeholder="이름">
				</div>
				<div class="col-md-3">
					<select class="form-select" id="searchPosition">
						<option value="">직급 선택</option>
						<option value="사원">사원</option>
						<option value="대리">대리</option>
						<option value="과장">과장</option>
						<option value="부장">부장</option>
					</select>
				</div>
				<div class="col-md-3">
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
				<div class="col-md-3">
					<button type="button" class="btn btn-primary w-100"
						onclick="filterUsers()">
						<i class="fas fa-search me-2"></i>검색
					</button>
				</div>
			</div>
		</div>
		<!-- Search Section End -->

		<!-- Table Section Start -->
		<div class="table-section">
			<div class="d-flex justify-content-between align-items-center mb-3">
				<div>
					<button type="button" class="btn btn-sm btn-outline-primary me-2"
						onclick="selectAll()">전체선택</button>
					<button type="button" class="btn btn-sm btn-outline-secondary"
						onclick="deselectAll()">전체해제</button>
				</div>
				<div>
					<span class="text-muted">선택된 사용자: <span id="selectedCount">0</span>명
					</span>
				</div>
			</div>
			<div class="table-container">
				<table class="table table-hover">
					<thead>
						<tr>
							<th style="width: 50px;"><input class="form-check-input"
								type="checkbox" id="checkAll"></th>
							<th>이름</th>
							<th>직급</th>
							<th>부서</th>
							<th>이메일</th>
						</tr>
					</thead>
					<tbody id="userTableBody">
						<c:forEach items="${users}" var="user">
							<tr>
								<td><input class="form-check-input user-checkbox"
									type="checkbox" value="${user.id}"
									${selectedUsers.contains(user.id) ? 'checked' : ''}></td>
								<td>${user.name}</td>
								<td>${user.position}</td>
								<td>${user.department}</td>
								<td>${user.email}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<!-- Table Section End -->

		<!-- Action Section Start -->
		<div class="action-section">
			<div class="d-flex justify-content-end">
				<button type="button" class="btn btn-secondary me-2"
					onclick="window.close()">취소</button>
				<button type="button" class="btn btn-primary"
					onclick="saveSelection()">저장</button>
			</div>
		</div>
		<!-- Action Section End -->
	</div>

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Page Specific Javascript -->
	<script>
		// 전체 선택
		function selectAll() {
			$('.user-checkbox').prop('checked', true);
			updateSelectedCount();
		}

		// 전체 해제
		function deselectAll() {
			$('.user-checkbox').prop('checked', false);
			updateSelectedCount();
		}

		// 선택된 사용자 수 업데이트
		function updateSelectedCount() {
			const count = $('.user-checkbox:checked').length;
			$('#selectedCount').text(count);
		}

		// 선택 저장
		function saveSelection() {
			const selectedUsers = [];
			$('.user-checkbox:checked').each(function() {
				selectedUsers.push($(this).val());
			});

			// AJAX 요청
			$
					.ajax({
						url : '${pageContext.request.contextPath}/authority/role/save-users.do',
						type : 'POST',
						contentType : 'application/json',
						data : JSON.stringify({
							roleId : '${param.roleId}',
							userIds : selectedUsers
						}),
						success : function(response) {
							// 부모 창의 사용자 수 업데이트
							if (window.opener && !window.opener.closed) {
								window.opener
										.handleUserSelection(selectedUsers.length);
							}
							window.close();
						},
						error : function(xhr, status, error) {
							alert('사용자 선택 저장 중 오류가 발생했습니다.');
						}
					});
		}

		// 검색 기능
		function filterUsers() {
			const name = $('#searchName').val().toLowerCase();
			const position = $('#searchPosition').val();
			const department = $('#searchDepartment').val();

			$('#userTableBody tr')
					.each(
							function() {
								const $row = $(this);
								const rowName = $row.find('td:eq(1)').text()
										.toLowerCase();
								const rowPosition = $row.find('td:eq(2)')
										.text();
								const rowDepartment = $row.find('td:eq(3)')
										.text();

								if (rowName.includes(name)
										&& (position === '' || rowPosition === position)
										&& (department === '' || rowDepartment === department)) {
									$row.show();
								} else {
									$row.hide();
								}
							});
		}

		// 이벤트 리스너 등록
		$(document)
				.ready(
						function() {
							// 체크박스 전체 선택/해제
							$('#checkAll').change(
									function() {
										$('.user-checkbox').prop('checked',
												$(this).prop('checked'));
										updateSelectedCount();
									});

							// 개별 체크박스 변경
							$('.user-checkbox')
									.change(
											function() {
												updateSelectedCount();
												// 모든 체크박스가 선택되었는지 확인
												const allChecked = $('.user-checkbox:not(:checked)').length === 0;
												$('#checkAll').prop('checked',
														allChecked);
											});

							// 검색 입력 이벤트
							$('#searchName, #searchPosition, #searchDepartment')
									.on('keyup', filterUsers);

							// 초기 선택된 사용자 수 표시
							updateSelectedCount();

							// 엔터 키 이벤트 처리
							$('#searchName').keypress(function(e) {
								if (e.which === 13) {
									filterUsers();
								}
							});
						});
	</script>
</body>
</html>