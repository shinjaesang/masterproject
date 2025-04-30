<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@ include file="../include/header.jsp" %> --%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<title>Stockmaster - 주문 등록</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="재고관리 ERP 시스템" name="keywords">
<meta content="효율적인 재고 관리를 위한 Stockmaster ERP 시스템" name="description">

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

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

<!-- Critical CSS -->
<style>
	.spinner-border {
		display: inline-block;
		width: 2rem;
		height: 2rem;
		vertical-align: text-bottom;
		border: .25em solid currentColor;
		border-right-color: transparent;
		border-radius: 50%;
		animation: spinner-border .75s linear infinite;
	}

	@keyframes spinner-border {
		to {
			transform: rotate(360deg);
		}
	}

	#spinner {
		opacity: 0;
		visibility: hidden;
		transition: opacity .5s ease-out, visibility 0s linear .5s;
		z-index: 99999;
	}

	#spinner.show {
		transition: opacity .5s ease-out, visibility 0s linear 0s;
		visibility: visible;
		opacity: 1;
	}

	.content {
		opacity: 0;
		transition: opacity 0.3s ease-in;
	}

	.content.show {
		opacity: 1;
	}
</style>

<!-- Initial Scripts -->
<script>
	// 페이지 로드 시 실행될 초기화 함수
	function initializePage() {
		hideSpinner();
	}

	// 스피너 제어 함수
	function showSpinner() {
		document.getElementById('spinner').classList.add('show');
	}

	function hideSpinner() {
		document.getElementById('spinner').classList.remove('show');
		document.querySelector('.content').classList.add('show');
	}

	// DOMContentLoaded 이벤트에서 초기화 실행
	document.addEventListener('DOMContentLoaded', initializePage);

	// 페이지가 완전히 로드된 후 실행
	window.onload = function() {
		hideSpinner();
	};
</script>
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

			<!-- Order Registration Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light text-center rounded p-4">
					<div class="d-flex align-items-center justify-content-between mb-4">
						<h6 class="mb-0">주문 등록</h6>
					</div>

					<!-- 주문 등록 폼 -->
					<form class="row g-3" action="registerOrder.do" method="post">
						<!-- 거래처 유형 선택 -->
						<div class="col-md-6">
							<label for="transactionType" class="form-label">거래처 유형</label> <select
								class="form-control" id="transactionType" name="transactionType"
								required>
								<option value="" disabled selected>거래처 유형 선택</option>
								<option value="wholesale">공급처</option>
								<option value="retail">판매처</option>
							</select>
						</div>

						<!-- 거래처 선택 -->
						<div class="col-md-6">
							<label for="client" class="form-label">거래처</label> <select
								class="form-control" id="client" name="client" required>
								<option value="" disabled selected>거래처 선택</option>
								<c:forEach var="client" items="${clients}">
									<option value="${client.id}">${client.name}
										(${client.id})</option>
								</c:forEach>
							</select>
						</div>

						<!-- 상품명 -->
						<div class="col-md-6">
							<label for="productName" class="form-label">상품명</label> <input
								type="text" class="form-control" id="productName"
								name="productName" placeholder="상품명 입력" required>
						</div>

						<!-- 옵션 -->
						<div class="col-md-6">
							<label for="option" class="form-label">옵션</label> <input
								type="text" class="form-control" id="option" name="option"
								placeholder="옵션 입력 (예: 색상: 블랙)">
						</div>

						<!-- 수량 -->
						<div class="col-md-6">
							<label for="quantity" class="form-label">수량</label> <input
								type="number" class="form-control" id="quantity" name="quantity"
								min="1" placeholder="수량 입력" required>
						</div>

						<!-- 판매가 -->
						<div class="col-md-6">
							<label for="price" class="form-label">판매가</label> <input
								type="number" class="form-control" id="price" name="price"
								min="0" placeholder="판매가 입력" required>
						</div>

						<!-- 담당자명 -->
						<div class="col-md-6">
							<label for="managerName" class="form-label">담당자명</label> <input
								type="text" class="form-control" id="managerName"
								name="managerName" placeholder="담당자명 입력" required>
						</div>

						<!-- 담당자 연락처 -->
						<div class="col-md-6">
							<label for="managerContact" class="form-label">담당자 연락처</label> <input
								type="text" class="form-control" id="managerContact"
								name="managerContact" placeholder="010-XXXX-XXXX"
								pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required>
						</div>

						<!-- 거래처 주소지 -->
						<div class="col-12">
							<label for="address" class="form-label">거래처 주소지</label> <input
								type="text" class="form-control" id="address" name="address"
								placeholder="거래처 주소지 입력" required>
						</div>

						<!-- 버튼 -->
						<div class="col-12 d-flex justify-content-end mt-3">
							<button type="button" class="btn btn-secondary me-2"
								onclick="cancelRegistration()">취소</button>
							<button type="submit" class="btn btn-primary">등록</button>
						</div>
					</form>

					<!-- JavaScript -->
					<script>
						// 취소 버튼 클릭 시 처리
						function cancelRegistration() {
							if (isFormModified()) {
								if (confirm('입력하신 내용이 저장되지 않습니다. 주문 조회 페이지로 이동하시겠습니까?')) {
									navigateToOrders();
								}
							} else {
								navigateToOrders();
							}
						}

						// 주문 조회 페이지로 이동
						function navigateToOrders() {
							window.location.href = '${pageContext.request.contextPath}/order/list.do';
						}

						// 폼 수정 여부 확인
						function isFormModified() {
							return $('form input, form select').filter(function() {
								return $(this).val() !== '';
							}).length > 0;
						}

						// 입력값 검증
						document.getElementById("price").addEventListener("input", function() {
							if (this.value < 0) this.value = 0;
						});

						document.getElementById("quantity").addEventListener("input", function() {
							if (this.value < 1) this.value = 1;
						});
					</script>
				</div>
			</div>
			<!-- Order Registration End -->

			<!-- Footer Start -->
			<jsp:include page="../common/footer.jsp" />
			<!-- Footer End -->
		</div>
		<!-- Content End -->

		<!-- Back to Top -->
		<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i
			class="bi bi-arrow-up"></i></a>
	</div>

	<!-- Additional JavaScript Libraries -->
	<script src="${pageContext.request.contextPath}/resources/lib/chart/chart.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/waypoints/waypoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/moment.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/moment-timezone.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

	<!-- Template Javascript -->
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>

</html>

<%-- <%@ include file="../include/footer.jsp" %>  --%>