<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title>Stockmaster - 주문관리</title>
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

			<!-- Orders Management Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light text-center rounded p-4">
					<div class="d-flex align-items-center justify-content-between mb-4">
						<h6 class="mb-0">주문 관리</h6>
					</div>

					<!-- 검색 조건 입력 폼 -->
					<form class="row g-3" id="searchForm" action="${pageContext.request.contextPath}/order/list.do" method="get">
						<div class="col-md-6">
							<label for="orderId" class="form-label">주문번호</label>
							<input type="text" class="form-control" id="orderId" name="orderId" placeholder="주문번호" value="${param.orderId}">
						</div>
						<div class="col-md-6">
							<label for="partnerName" class="form-label">거래처</label>
							<input type="text" class="form-control" id="partnerName" name="partnerName" placeholder="거래처" value="${param.partnerName}">
						</div>
						<div class="col-md-6">
							<label for="partnerType" class="form-label">거래처 유형</label>
							<select class="form-select" id="partnerType" name="partnerType">
								<option value="">전체</option>
								<option value="판매처" ${param.partnerType == '판매처' ? 'selected' : ''}>판매처</option>
								<option value="공급처" ${param.partnerType == '공급처' ? 'selected' : ''}>공급처</option>
							</select>
						</div>
						<div class="col-md-6">
							<label for="startDate" class="form-label">시작일</label>
							<input type="date" class="form-control" id="startDate" name="startDate" value="${param.startDate}">
						</div>
						<div class="col-md-6">
							<label for="endDate" class="form-label">종료일</label>
							<input type="date" class="form-control" id="endDate" name="endDate" value="${param.endDate}">
						</div>
						<div class="col-md-6">
							<label for="productName" class="form-label">상품명</label>
							<input type="text" class="form-control" id="productName" name="productName" placeholder="상품명" value="${param.productName}">
						</div>
						<div class="col-md-3">
							<label for="minPrice" class="form-label">최소 판매가</label>
							<input type="number" class="form-control" id="minPrice" name="minPrice" placeholder="최소 판매가" value="${param.minPrice}">
						</div>
						<div class="col-md-3">
							<label for="maxPrice" class="form-label">최대 판매가</label>
							<input type="number" class="form-control" id="maxPrice" name="maxPrice" placeholder="최대 판매가" value="${param.maxPrice}">
						</div>
						<div class="col-12 d-flex justify-content-end mt-3">
							<button type="submit" class="btn btn-primary me-2">
								<i class="fa fa-search me-2"></i>검색
							</button>
							<button type="button" onclick="location.href='register.do'" class="btn btn-success">
								<i class="fa fa-plus me-2"></i>주문 추가
							</button>
						</div>
					</form>

					<!-- 총 주문건수 및 판매금액 표시 영역 -->
					<div class="d-flex justify-content-start mb-2 mt-4">
						<small class="text-muted me-3">주문건수: ${orderCount}건</small>
						<c:if test="${user.hasPriceViewPermission}">
							<small class="text-muted">판매금액: <fmt:formatNumber value="${totalPrice}" pattern="#,###" />원</small>
						</c:if>
					</div>

					<form action="deleteSelectedOrders.do" method="post">
						<div class="d-flex justify-content-start mb-2">
							<button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('선택한 주문을 삭제하시겠습니까?')">
								<i class="fa fa-trash me-2"></i>일괄삭제
							</button>
						</div>

						<div class="table-responsive">
							<table class="table text-start align-middle table-bordered table-hover mb-0">
								<thead>
									<tr class="text-dark">
										<th scope="col"><input class="form-check-input" type="checkbox" id="selectAll"></th>
										<th scope="col">주문번호</th>
										<th scope="col">판매처</th>
										<th scope="col">공급처</th>
										<th scope="col">상품코드</th>
										<th scope="col">상품명</th>
										<th scope="col">옵션</th>
										<th scope="col">수량</th>
										<th scope="col">판매가</th>
										<th scope="col">주문상태</th>
										<th scope="col">등록일</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="order" items="${orderList}">
										<tr>
											<td><input class="form-check-input order-checkbox" type="checkbox" name="orderIds" value="${order.orderId}"></td>
											<td>${order.orderId}</td>
											<td>${order.partnerType == '판매처' ? order.partnerName : ''}</td>
											<td>${order.partnerType == '공급처' ? order.partnerName : ''}</td>
											<td>${order.productId}</td>
											<td>${order.productName}</td>
											<td>${order.optionValue}</td>
											<td>${order.quantity}</td>
											<td><fmt:formatNumber value="${order.sellingPrice}" pattern="#,###" /></td>
											<td>${order.stockStatus}</td>
											<td><fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd" /></td>
											<td>
												<div class="d-flex justify-content-center gap-2">
													<button type="button" class="btn btn-sm btn-warning" onclick="location.href='${pageContext.request.contextPath}/update.do?orderId=${order.orderId}'">
														<i class="fa fa-edit me-1"></i>수정
													</button>
													<button type="button" class="btn btn-sm btn-danger" onclick="deleteOrder('${order.orderId}')">
														<i class="fa fa-trash me-1"></i>삭제
													</button>
												</div>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</form>
				</div>
			</div>
			<!-- Orders Management End -->

			<!-- Footer Start -->
			<jsp:include page="../common/footer.jsp" />
			<!-- Footer End -->
		</div>
		<!-- Content End -->

		<!-- Back to Top -->
		<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
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

	<!-- Page specific Javascript -->
	<script>
	$(document).ready(function() {
		// 체크박스 전체 선택/해제
		$("#selectAll").change(function() {
			$(".order-checkbox").prop('checked', $(this).prop("checked"));
		});

		// 판매가 음수 입력 방지
		$("#minPrice, #maxPrice").on("input", function() {
			if (this.value < 0) this.value = 0;
		});
	});

	// 주문 삭제 함수
	function deleteOrder(orderId) {
		if (confirm('선택한 주문을 삭제하시겠습니까?')) {
			fetch('${pageContext.request.contextPath}/deleteOrder.do?orderId=' + orderId, {
				method: 'POST'
			})
			.then(response => response.json())
			.then(data => {
				if (data.success) {
					alert('주문이 성공적으로 삭제되었습니다.');
					location.reload();
				} else {
					alert(data.message || '주문 삭제에 실패했습니다.');
				}
			})
			.catch(error => {
				console.error('Error:', error);
				alert('주문 삭제 중 오류가 발생했습니다.');
			});
		}
	}
	</script>
</body>
</html>