<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 세금계산서 조회</title>
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
        .invoice-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .invoice-header {
            margin-bottom: 15px;
        }
        .invoice-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
        }
        .invoice-details {
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 15px;
        }
        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }
        .invoice-table th, .invoice-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .invoice-table th {
            background-color: #f2f2f2;
            position: sticky;
            top: 0;
        }
        .table-responsive {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        .details {
            display: none;
            margin-top: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .btn-view {
            color: #0d6efd;
            background: none;
            border: 1px solid #0d6efd;
            padding: 5px 15px;
            border-radius: 5px;
        }
        .btn-view:hover {
            background: #0d6efd;
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

            <!-- Invoice Inquiry Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="mb-4 d-flex justify-content-between align-items-center">
                    <div>
                        <h4 class="mb-0">세금계산서 조회</h4>
                        <small class="text-muted">Invoice Ninja API를 통해 세금계산서를 조회합니다.</small>
                    </div>
                </div>

                <!-- 탭 메뉴 추가 -->
                <ul class="nav nav-tabs mb-4">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/transaction/taxdomesticlist.do">
                            <i class="fa fa-file-invoice me-2"></i>세금계산서
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/transaction/taxforeignlist.do">
                            <i class="fa fa-file-invoice-dollar me-2"></i>Invoice
                        </a>
                    </li>
                </ul>

                <!-- 검색 필터 영역 -->
                <div class="row mb-3">
                    <div class="col-md-2">
                        <input type="date" class="form-control" id="searchDate" placeholder="발행일자">
                    </div>
                    <div class="col-md-3">
                        <input type="text" class="form-control" id="searchClient" placeholder="거래처명">
                    </div>
                    <div class="col-md-3">
                        <input type="text" class="form-control" id="searchItem" placeholder="제품명">
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" id="searchStatus">
                            <option value="">발행구분</option>
                            <option value="issued">발행완료</option>
                            <option value="not_issued">미발행</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-primary w-100" id="btnSearch">검색</button>
                    </div>
                </div>
                <!-- Invoice List -->
                <div class="row">
                    <div class="col-12">
                        <div class="invoice-card">
                            <div class="invoice-header">
                                <div class="invoice-title">세금계산서 목록</div>
                            </div>
                            <!-- <div class="table-responsive">
                                <table class="invoice-table" id="invoiceTable">
                                    <thead>
                                        <tr>
                                            <th>송장번호</th>
                                            <th>발행일자</th>
                                            <th>거래처</th>
                                            <th>제품명</th>
                                            <th>수량</th>
                                            <th>단가</th>
                                            <th>공급가액</th>
                                            <th>세액</th>
                                            <th>총액</th>
                                            <th>발행상태</th>
                                            <th>담당자</th>
                                            <th>비고</th>
                                        </tr>
                                    </thead>
                                    <tbody id="invoiceTableBody"></tbody>
                                </table>
                            </div> -->
                            
                            <div class="container table-container">
        <h2>${pageTitle}</h2>
        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>
        <table class="table table-striped" id="invoiceTable">
            <thead>
                <tr>
                    <th>문서 ID</th>
                    <th>문서 번호</th>
                    <th>문서 유형</th>
                    <th>클라이언트 ID</th>
                    <th>업로더</th>
                    <th>상태</th>
                    <th>날짜</th>
                </tr>
            </thead>
            <tbody id="invoiceTableBody">
                <!-- AJAX로 데이터 동적 로드 -->
            </tbody>
        </table>
    </div>
                            
                            <div id="invoiceDetails" class="details"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Invoice Inquiry End -->

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
		
		 function loadInvoices() {
		        $.ajax({
		            url: 'http://invoice-ninja-url/api/v1/invoices',
		            method: 'GET',
		            headers: {
		                'X-API-TOKEN': 'your-B6miqPRE13GCyMSw5UfgMOfgKKyE8glgEeIMBXgwVLPzzc9hIXy5yieoHLgS1Wig-token'
		            },
		            success: function(response) {
		                let tbody = $('#invoiceTable tbody');
		                tbody.empty();
		                response.data.forEach(invoice => {
		                    const supplyAmount = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(invoice.amount - (invoice.tax || 0));
		                    const taxAmount = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(invoice.tax || 0);
		                    const totalAmount = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(invoice.amount);
		                    const statusText = invoice.status === 'issued' ? '발행완료' : '미발행';

		                    const items = invoice.invoice_items || [];
		                    const productName = items.map(item => item.product_key).join(', ');
		                    const quantity = items.map(item => item.quantity).join(', ');
		                    const unitPrice = items.map(item => new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(item.cost)).join(', ');

		                    tbody.append(`
		                        <tr>
		                            <td>${invoice.invoice_number}</td>
		                            <td>${invoice.date}</td>
		                            <td>${invoice.client_name || invoice.client_id}</td>
		                            <td>${productName}</td>
		                            <td>${quantity}</td>
		                            <td>${unitPrice}</td>
		                            <td>${supplyAmount}</td>
		                            <td>${taxAmount}</td>
		                            <td>${totalAmount}</td>
		                            <td>${statusText}</td>
		                            <td>${invoice.user_name || '담당자'}</td>
		                            <td><a href="#" class="text-primary" onclick="viewInvoiceDetails('${invoice.id}')" style="text-decoration: none;">[상세보기]</a></td>
		                        </tr>
		                    `);
		                });
		            },
		            error: function(error) {
		                alert('송장 조회 실패: ' + error.responseText);
		            }
		        });
		    }
		
		 
		 
		// 송장 세부 정보 조회
	        function viewInvoiceDetails(invoiceId) {
	            $.ajax({
	                url: `http://invoice-ninja-url/api/v1/invoices/${invoiceId}`,
	                method: 'GET',
	                headers: {
	                    'X-API-TOKEN': 'B6miqPRE13GCyMSw5UfgMOfgKKyE8glgEeIMBXgwVLPzzc9hIXy5yieoHLgS1Wig'
	                },
	                success: function(response) {
	                	let items = response.data.invoice_items || [];
	                	let itemNotes = items.map(function(item){return item.notes;}).join(', ');
	                	let details = 
	                	    <h5>송장 세부 정보</h5>
	                	    <p><strong>송장 번호:</strong> \${response.data.invoice_number}</p>
	                	    <p><strong>금액:</strong> \${Number(response.data.amount).toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' })}</p>
	                	    <p><strong>클라이언트 ID:</strong> \${response.data.client_id}</p>
	                	    <p><strong>발행일:</strong> \${response.data.date}</p>
	                	    <p><strong>항목:</strong> \${itemNotes}</p>
	                	
	                    $('#invoiceDetails').html(details).show();
	                },
	                error: function(error) {
	                    alert('세부 정보 조회 실패: ' + error.responseText);
	                }
	            });
	        }
		 
		 
		 
        
        // invoice ninja
        $(document).ready(function() {
            $.ajax({
                url: '/transactions/taxdomesticapilist.do',
                method: 'GET',
                dataType: 'json',
                success: function(data) {
                    let tableBody = $('#invoiceTableBody');
                    tableBody.empty();
                    if (data && Array.isArray(data) && data.length > 0) {
                        $.each(data, function(index, invoice) {
                            let row = `<tr>
                                <td>${invoice.tdocId || '-'}</td>
                                <td>${invoice.docName || '-'}</td>
                                <td>${invoice.docType || '-'}</td>
                                <td>${invoice.relatedPartyId || '-'}</td>
                                <td>${invoice.uploaderName || '-'}</td>
                                <td>${invoice.status || '-'}</td>
                                <td>${invoice.uploadedAt || '-'}</td>
                            </tr>`;
                            tableBody.append(row);
                        });
                    } else {
                        tableBody.html('<tr><td colspan="7">데이터가 없습니다.</td></tr>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('데이터 로드 실패:', error);
                    $('#invoiceTableBody').html('<tr><td colspan="7">데이터 로드 중 오류가 발생했습니다.</td></tr>');
                }
            });
        });

        
        $(document).ready(function() {
            $('#spinner').removeClass('show');
            $('.content').addClass('show');

            // 기존 송장 목록 불러오기
            loadInvoices();
        
        
         // 다른 API 호출
            $.ajax({
                url: '/transactions/taxdomesticapilist.do',
                method: 'GET',
                dataType: 'json',
                success: function(data) {
                    let tableBody = $('#invoiceTableBody');
                    tableBody.empty();
                    if (data && Array.isArray(data) && data.length > 0) {
                        $.each(data, function(index, invoice) {
                            let row = `<tr>
                                <td>${invoice.tdocId || '-'}</td>
                                <td>${invoice.docName || '-'}</td>
                                <td>${invoice.docType || '-'}</td>
                                <td>${invoice.relatedPartyId || '-'}</td>
                                <td>${invoice.uploaderName || '-'}</td>
                                <td>${invoice.status || '-'}</td>
                                <td>${invoice.uploadedAt || '-'}</td>
                            </tr>`;
                            tableBody.append(row);
                        });
                    } else {
                        tableBody.html('<tr><td colspan="7">데이터가 없습니다.</td></tr>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('데이터 로드 실패:', error);
                    $('#invoiceTableBody').html('<tr><td colspan="7">데이터 로드 중 오류가 발생했습니다.</td></tr>');
                }
            });
        });
        
        
      

        
    </script>
</body>
</html>