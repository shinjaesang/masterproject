<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<title>Stockmaster - 주문 수정</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="재고관리 ERP 시스템" name="keywords">
<meta content="효율적인 재고 관리를 위한 Stockmaster ERP 시스템" name="description">

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Favicon -->
<link
	href="${pageContext.request.contextPath}/resources/img/favicon.ico"
	rel="icon">

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
/* 필수적인 스타일만 인라인으로 포함 */
.spinner-border {
	display: inline-block;
	width: 2rem;
	height: 2rem;
	vertical-align: text-bottom;
	border: .25em solid currentColor;
	border-right-color: transparent;
	border-radius: 50%;
	animation: spinner-border .75s linear infinite
}

@keyframes spinner-border {
	to { transform: rotate(360deg); }
}
#spinner {
	opacity: 0;
	visibility: hidden;
	transition: opacity .5s ease-out, visibility 0s linear .5s;
	z-index: 99999
}

#spinner.show {
	transition: opacity .5s ease-out, visibility 0s linear 0s;
	visibility: visible;
	opacity: 1
}

.content {
	opacity: 0;
	transition: opacity 0.3s ease-in;
}

.content.show {
	opacity: 1;
}

input[readonly] { background-color: #e9ecef !important; color: #212529 !important; opacity: 1 !important; }

.order-row-flex {
	display: flex;
	flex-wrap: wrap;
	gap: 16px;
	align-items: center;
}

.order-row-flex>.col-md-6, .order-row-flex>.col-md-12 {
	flex: 1 1 0;
	min-width: 200px;
	margin-bottom: 0;
}

@media ( max-width : 900px) {
	.order-row-flex {
		flex-direction: column;
	}
}
</style>

<script>
function initializePage() { hideSpinner(); }
function showSpinner() { document.getElementById('spinner').classList.add('show'); }
function hideSpinner() { document.getElementById('spinner').classList.remove('show'); document.querySelector('.content').classList.add('show'); }
document.addEventListener('DOMContentLoaded', initializePage);
window.onload = function() { hideSpinner(); };
</script>
</head>

<body>
	<div class="container-fluid position-relative bg-white d-flex p-0">
		<!-- Spinner Start -->
		<div id="spinner"
			class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
			<div class="spinner-border text-primary"
				style="width: 3rem; height: 3rem;" role="status">
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

			<!-- Order Update Start -->
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light text-center rounded p-4">
					<div class="d-flex align-items-center justify-content-between mb-4">
						<h4 class="mb-0">주문 수정</h4>
						<div style="font-size:1rem; color:#666;">
							주문번호: <span style="font-weight:bold;">${order.orderId}</span>
							&nbsp;|&nbsp;
							주문일자: <span><fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						</div>
					</div>

					<!-- 주문 수정 폼 -->
					<form class="row g-3" action="updateOrder.do" method="post" id="orderForm">
						<input type="hidden" name="orderId" value="${order.orderId}">
						<input type="hidden" name="orderStatus" value="${order.orderStatus}">
						<!-- 주문 유형 선택 -->
						<div class="col-md-6">
							<label for="orderType" class="form-label">주문 유형</label>
							<select class="form-control" id="orderType" name="orderType" required>
								<option value="" disabled>주문 유형 선택</option>
								<option value="발주" <c:if test="${order.orderType eq '발주'}">selected</c:if>>발주</option>
								<option value="수주" <c:if test="${order.orderType eq '수주'}">selected</c:if>>수주</option>
							</select>
						</div>
						<!-- 거래처 선택 -->
						<div class="col-md-6">
							<label for="partnerId" class="form-label">거래처</label>
							<select class="form-control" id="partnerId" name="partnerId" required>
								<option value="" disabled>거래처 선택</option>
								<c:forEach var="partner" items="${partnerList}">
									<option value="${partner.partnerId}" <c:if test="${order.partnerId eq partner.partnerId}">selected</c:if>>${partner.partnerName}</option>
								</c:forEach>
							</select>
						</div>
						<!-- 상품 목록 테이블 -->
						<div class="col-12">
							<div class="card">
								<div class="card-header d-flex justify-content-between align-items-center">
									<h6 class="mb-0">상품 목록</h6>
									<button type="button" class="btn btn-primary btn-sm" onclick="addProductRow()">
										<i class="fa fa-plus"></i> 상품 추가
									</button>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table" id="productTable">
											<thead>
												<tr>
													<th>상품코드</th>
													<th>상품명</th>
													<th>옵션</th>
													<th>원가</th>
													<th>판매가</th>
													<th>수량</th>
													<th>관리</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${order.items}">
													<tr>
														<td><input type="text" class="form-control product-code" value="${item.productId}" required></td>
														<td><input type="text" class="form-control product-name" value="${item.productName}" readonly></td>
														<td><input type="text" class="form-control product-option" value="${item.optionValue}" readonly></td>
														<td><input type="number" class="form-control product-cost" value="${item.costPrice}" readonly></td>
														<td><input type="number" class="form-control product-price" value="${item.sellingPrice}" readonly></td>
														<td><input type="number" class="form-control product-quantity" value="${item.quantity}" min="1" required></td>
														<td><button type="button" class="btn btn-danger btn-sm" onclick="removeProductRow(this)"><i class="fa fa-trash"></i></button></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- 버튼 -->
						<div class="col-12 d-flex justify-content-end mt-3">
							<button type="button" class="btn btn-secondary me-2" onclick="cancelUpdate()">취소</button>
							<button type="submit" class="btn btn-primary">저장</button>
						</div>
					</form>
				</div>
			</div>
			<!-- Order Update End -->

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
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

	<!-- Custom JavaScript -->
	<script>
	$(document).ready(function() {
		// 거래처 목록 로딩
		function loadPartnerList(partnerType) {
			$.ajax({
				url: "${pageContext.request.contextPath}/partner/list",
				method: "GET",
				dataType: "json",
				success: function(data) {
					var html = '<option value="">거래처를 선택하세요</option>';
					$.each(data, function(i, partner) {
						if (!partnerType || partner.partnerType === partnerType) {
							html += '<option value="' + partner.partnerId + '" ' + (partner.partnerId == '${order.partnerId}' ? 'selected' : '') + '>' + partner.partnerName + '</option>';
						}
					});
					$('#partnerId').html(html);
				}
			});
		}
		// 주문 유형 변경 시 거래처 목록 필터링 및 드롭다운 활성화
		$('#orderType').on('change', function() {
			var orderType = $(this).val();
			var partnerType = '';
			if (orderType === '발주') {
				partnerType = '공급처';
			} else if (orderType === '수주') {
				partnerType = '판매처';
			}
			loadPartnerList(partnerType);
			$('#partnerId').prop('disabled', false);
		});
		// 상품 코드 입력 후 포커스 아웃 시 상품 정보 조회
		$(document).on('blur', '.product-code', function() {
			getProductInfo(this);
		});
		// 상품 코드 입력 후 엔터 시 상품 정보 조회
		$(document).on('keypress', '.product-code', function(e) {
			if (e.which === 13) {
				e.preventDefault();
				getProductInfo(this);
			}
		});
	});
	function addProductRow() {
		var row = `
			<tr>
				<td><input type="text" class="form-control product-code" required></td>
				<td><input type="text" class="form-control product-name" readonly></td>
				<td><input type="text" class="form-control product-option" readonly></td>
				<td><input type="number" class="form-control product-cost" readonly></td>
				<td><input type="number" class="form-control product-price" readonly></td>
				<td><input type="number" class="form-control product-quantity" min="1" value="1" required></td>
				<td><button type="button" class="btn btn-danger btn-sm" onclick="removeProductRow(this)"><i class="fa fa-trash"></i></button></td>
			</tr>
		`;
		$('#productTable tbody').append(row);
	}
	function getProductInfo(input) {
		const productId = input.value;
		if (!productId) return;
		$.ajax({
			url: '${pageContext.request.contextPath}/order/product-info.do',
			type: 'GET',
			data: { productId: productId },
			success: function(response) {
				if (response.status === 'success') {
					const row = $(input).closest('tr');
					row.find('.product-name').val(response.productName);
					row.find('.product-option').val(response.optionValue);
					row.find('.product-cost').val(response.costPrice);
					row.find('.product-price').val(response.sellingPrice);
					row.find('.product-quantity').val('1');
				} else {
					alert(response.message || '상품 정보를 찾을 수 없습니다.');
					input.value = '';
				}
			},
			error: function() {
				alert('상품 정보 조회 중 오류가 발생했습니다.');
				input.value = '';
			}
		});
	}
	function removeProductRow(button) {
		$(button).closest('tr').remove();
	}
	$('#orderForm').on('submit', function(e) {
		e.preventDefault();
		if (!$('#orderType').val()) {
			alert('주문 유형을 선택해주세요.');
			return;
		}
		if (!$('#partnerId').val()) {
			alert('거래처를 선택해주세요.');
			return;
		}
		var formData = {
			orderId: $('input[name="orderId"]').val(),
			orderType: $('#orderType').val(),
			partnerId: $('#partnerId').val(),
			orderStatus: $('input[name="orderStatus"]').val(), 
			items: []
		};
		var hasItems = false;
		$('#productTable tbody tr').each(function() {
			var row = $(this);
			var productCode = row.find('.product-code').val();
			var quantity = row.find('.product-quantity').val();
			if (productCode && quantity) {
				hasItems = true;
				formData.items.push({
					productId: productCode,
					quantity: parseInt(quantity)
				});
			}
		});
		if (!hasItems) {
			alert('최소 하나 이상의 상품을 등록해주세요.');
			return;
		}
		$.ajax({
			url: '${pageContext.request.contextPath}/order/updateOrder.do',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(formData),
			success: function(response) {
				if (response.status === 'success') {
					alert('주문이 수정되었습니다.');
					window.location.href = '${pageContext.request.contextPath}/order/list.do';
				} else {
					alert(response.message || '주문 수정에 실패했습니다.');
				}
			},
			error: function() {
				alert('주문 수정 중 오류가 발생했습니다.');
			}
		});
	});
	function cancelUpdate() {
		history.back();
	}
	</script>
</body>

</html>