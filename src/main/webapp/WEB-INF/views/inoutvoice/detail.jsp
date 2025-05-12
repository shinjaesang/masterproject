<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 입출고 전표 상세</title>
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
    <input type="hidden" id="currentEmpId" value="${loginUser.empId}">
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
                            <h3 class="mb-4">전표작업</h3>
                            <div class="table-responsive">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th class="col-2">전표번호</th>
                                            <td>${inOutVoice.inoutvoiceId}</td>
                                        </tr>
                                        <tr>
                                            <th>전표명</th>
                                            <td>${inOutVoice.inoutvoiceName}</td>
                                        </tr>
                                        <tr>
                                            <th>전표유형</th>
                                            <td>${inOutVoice.inoutvoiceType}</td>
                                        </tr>
                                        <tr>
                                            <th>주문번호</th>
                                            <td>${inOutVoice.orderId}</td>
                                        </tr>
                                        <tr>
                                            <th>작업자</th>
                                            <td>${inOutVoice.workerId}</td>
                                        </tr>
                                        <tr>
                                            <th>입고창고</th>
                                            <td>
                                                <c:out value="${inWarehouseName}" default="-"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>출고창고</th>
                                            <td>
                                                <c:out value="${outWarehouseName}" default="-"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>등록일</th>
                                            <td><fmt:formatDate value="${inOutVoice.createdAt}" pattern="yyyy-MM-dd"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 상품 목록/추가/삭제 UI 시작 -->
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <!-- 버튼을 상품 테이블 바로 위로 이동 -->
                            <div class="d-flex gap-2 align-items-center mb-2">
                                <button id="btnProcessSelected" type="button" class="btn btn-outline-primary btn-sm me-1">선택 처리</button>
                                <button id="btnDeleteSelected" type="button" class="btn btn-outline-danger btn-sm">선택 삭제</button>
                                <button id="btnAddProduct" class="btn btn-primary btn-sm ms-auto">상품추가</button>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered product-table align-middle text-center">
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" id="checkAll"></th>
                                            <th>상태</th>
                                            <th>처리</th>
                                            <th>삭제</th>
                                            <th>작업일</th>
                                            <th>작업자</th>
                                            <th>상품명</th>
                                            <th>옵션</th>
                                            <th>상품코드</th>
                                            <th>수량</th>
                                            <th>원가</th>
                                            <th>총원가</th>
                                            <th>판매가</th>
                                            <th>총판매가</th>
                                        </tr>
                                    </thead>
                                    <tbody id="productTableBody">
                                        <c:forEach var="item" items="${productList}" varStatus="status">
                                            <tr data-id="${item.inoutvoiceProductId}">
                                                <td>
                                                    <c:if test="${item.status != '처리완료'}">
                                                        <input type="checkbox" class="rowCheckbox" />
                                                    </c:if>
                                                </td>
                                                <td>${item.status}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${item.status == '처리대기'}">
                                                            <button class="btn btn-sm btn-primary btnProcess">처리</button>
                                                        </c:when>
                                                        <c:otherwise></c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${item.status != '처리완료'}">
                                                        <button class="btn btn-sm btn-danger btnDelete">삭제</button>
                                                    </c:if>
                                                </td>
                                                <td><fmt:formatDate value="${item.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                <td>${item.workerId}</td>
                                                <td>${item.productName}</td>
                                                <td>${item.optionValue}</td>
                                                <td>${item.productId}</td>
                                                <td>${item.quantity}</td>
                                                <td><fmt:formatNumber value="${item.costPrice}" pattern="#,#00"/></td>
                                                <td><fmt:formatNumber value="${item.quantity * item.costPrice}" pattern="#,#00"/></td>
                                                <td><fmt:formatNumber value="${item.sellingPrice}" pattern="#,#00"/></td>
                                                <td><fmt:formatNumber value="${item.quantity * item.sellingPrice}" pattern="#,#00"/></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <c:set var="sumQty" value="0"/>
                                        <c:set var="sumCost" value="0"/>
                                        <c:set var="sumTotalCost" value="0"/>
                                        <c:set var="sumSale" value="0"/>
                                        <c:set var="sumTotalSale" value="0"/>
                                        <c:forEach var="item" items="${productList}">
                                            <c:set var="sumQty" value="${sumQty + item.quantity}"/>
                                            <c:set var="sumCost" value="${sumCost + item.costPrice}"/>
                                            <c:set var="sumTotalCost" value="${sumTotalCost + (item.quantity * item.costPrice)}"/>
                                            <c:set var="sumSale" value="${sumSale + item.sellingPrice}"/>
                                            <c:set var="sumTotalSale" value="${sumTotalSale + (item.quantity * item.sellingPrice)}"/>
                                        </c:forEach>
                                        <tr>
                                            <td colspan="9" class="text-end fw-bold">합계</td>
                                            <td><fmt:formatNumber value="${sumQty}" pattern="#,#00"/></td>
                                            <td></td>
                                            <td><fmt:formatNumber value="${sumTotalCost}" pattern="#,#00"/></td>
                                            <td></td>
                                            <td><fmt:formatNumber value="${sumTotalSale}" pattern="#,#00"/></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 상품 목록/추가/삭제 UI 끝 -->
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
    document.addEventListener('DOMContentLoaded', function() {
        // form submit 방지
        var modalForm = document.querySelector('#productAddModal form');
        if (modalForm) {
            modalForm.addEventListener('submit', function(e) {
                e.preventDefault();
            });
        }

        // 상품추가 모달 검색 버튼 이벤트 위임
        var modalDiv = document.querySelector('#productAddModal');
        if (modalDiv) {
            modalDiv.addEventListener('click', function(e) {
                if (e.target.matches('button.btn-primary') && e.target.textContent.trim() === '검색') {
                    const type = document.getElementById('searchFilter').value;
                    const keyword = document.getElementById('searchKeyword').value.trim();
                    if (!keyword) {
                        // 검색어가 비어 있으면 전체 상품 조회
                        const url = `${pageContext.request.contextPath}/product/list`;
                        fetch(url, {
                            method: 'GET',
                            headers: { 'Accept': 'application/json' }
                        })
                        .then(res => res.json())
                        .then(data => {
                            console.log('상품 검색 결과:', data);
                            const tbody = document.getElementById('searchResultTbody');
                            tbody.innerHTML = '';
                            if (!data || data.length === 0) {
                                tbody.innerHTML = '<tr><td colspan="7" class="text-center">표시할 항목이 없습니다</td></tr>';
                                return;
                            }
                            data.forEach(p => {
                                const tr = document.createElement('tr');
                                tr.setAttribute('data-id', p.productId);
                                // 상품코드
                                const tdCode = document.createElement('td');
                                tdCode.textContent = p.productId ?? '';
                                tr.appendChild(tdCode);
                                // 상품명
                                const tdName = document.createElement('td');
                                tdName.textContent = p.productName ?? '';
                                tr.appendChild(tdName);
                                // 옵션
                                const tdOption = document.createElement('td');
                                tdOption.textContent = p.optionValue ?? '';
                                tr.appendChild(tdOption);
                                // 수량
                                const tdQty = document.createElement('td');
                                const inputQty = document.createElement('input');
                                inputQty.type = 'number';
                                inputQty.className = 'form-control form-control-sm';
                                inputQty.min = 1;
                                inputQty.value = 1;
                                tdQty.appendChild(inputQty);
                                tr.appendChild(tdQty);
                                // 원가
                                const tdCost = document.createElement('td');
                                tdCost.textContent = p.costPrice != null ? p.costPrice.toLocaleString() : '';
                                tr.appendChild(tdCost);
                                // 판매가
                                const tdPrice = document.createElement('td');
                                tdPrice.textContent = p.sellingPrice != null ? p.sellingPrice.toLocaleString() : '';
                                tr.appendChild(tdPrice);
                                // 공급처
                                const tdPartner = document.createElement('td');
                                tdPartner.textContent = p.partnerName ?? '';
                                tr.appendChild(tdPartner);
                                // 선택 버튼
                                const tdSelect = document.createElement('td');
                                const btnSelect = document.createElement('button');
                                btnSelect.type = 'button';
                                btnSelect.className = 'btn btn-outline-primary btn-sm';
                                btnSelect.textContent = '선택';
                                tdSelect.appendChild(btnSelect);
                                tr.appendChild(tdSelect);
                                tbody.appendChild(tr);
                            });
                        })
                        .catch(err => {
                            document.getElementById('searchResultTbody').innerHTML = '<tr><td colspan="7" class="text-center">표시할 항목이 없습니다</td></tr>';
                        });
                        return;
                    }
                    const cond = {};
                    if (type === 'code') cond.productId = keyword;
                    else if (type === 'name') cond.productName = keyword;
                    const url = `${pageContext.request.contextPath}/product/list?` + new URLSearchParams(cond);
                    console.log('상품 검색 요청 URL:', url);
                    fetch(url, {
                        method: 'GET',
                        headers: { 'Accept': 'application/json' }
                    })
                    .then(res => res.json())
                    .then(data => {
                        console.log('상품 검색 결과:', data);
                        const tbody = document.getElementById('searchResultTbody');
                        tbody.innerHTML = '';
                        if (!data || data.length === 0) {
                            tbody.innerHTML = '<tr><td colspan="7" class="text-center">표시할 항목이 없습니다</td></tr>';
                            return;
                        }
                        data.forEach(p => {
                            const tr = document.createElement('tr');
                            tr.setAttribute('data-id', p.productId);
                            // 상품코드
                            const tdCode = document.createElement('td');
                            tdCode.textContent = p.productId ?? '';
                            tr.appendChild(tdCode);
                            // 상품명
                            const tdName = document.createElement('td');
                            tdName.textContent = p.productName ?? '';
                            tr.appendChild(tdName);
                            // 옵션
                            const tdOption = document.createElement('td');
                            tdOption.textContent = p.optionValue ?? '';
                            tr.appendChild(tdOption);
                            // 수량
                            const tdQty = document.createElement('td');
                            const inputQty = document.createElement('input');
                            inputQty.type = 'number';
                            inputQty.className = 'form-control form-control-sm';
                            inputQty.min = 1;
                            inputQty.value = 1;
                            tdQty.appendChild(inputQty);
                            tr.appendChild(tdQty);
                            // 원가
                            const tdCost = document.createElement('td');
                            tdCost.textContent = p.costPrice != null ? p.costPrice.toLocaleString() : '';
                            tr.appendChild(tdCost);
                            // 판매가
                            const tdPrice = document.createElement('td');
                            tdPrice.textContent = p.sellingPrice != null ? p.sellingPrice.toLocaleString() : '';
                            tr.appendChild(tdPrice);
                            // 공급처
                            const tdPartner = document.createElement('td');
                            tdPartner.textContent = p.partnerName ?? '';
                            tr.appendChild(tdPartner);
                            // 선택 버튼
                            const tdSelect = document.createElement('td');
                            const btnSelect = document.createElement('button');
                            btnSelect.type = 'button';
                            btnSelect.className = 'btn btn-outline-primary btn-sm';
                            btnSelect.textContent = '선택';
                            tdSelect.appendChild(btnSelect);
                            tr.appendChild(tdSelect);
                            tbody.appendChild(tr);
                        });
                    })
                    .catch(err => {
                        document.getElementById('searchResultTbody').innerHTML = '<tr><td colspan="7" class="text-center">표시할 항목이 없습니다</td></tr>';
                    });
                }
                // 하단 테이블 '삭제' 버튼
                if (e.target.classList.contains('btnRemove')) {
                    const lowerTbody = document.getElementById('selectedProductTbody');
                    e.target.closest('tr').remove();
                    if (lowerTbody.querySelectorAll('tr').length === 0) {
                        lowerTbody.innerHTML = '<tr><td colspan="7" class="text-center">표시할 항목이 없습니다</td></tr>';
                    }
                }
                // 모달 '추가' 버튼
                if (e.target.textContent.trim() === '추가') {
                    const selectedRows = document.querySelectorAll('#selectedProductTbody tr');
                    const selectedProducts = [];
                    selectedRows.forEach(row => {
                        const tds = row.querySelectorAll('td');
                        if (tds.length < 7) return;
                        selectedProducts.push({
                            productId: tds[0].textContent.trim(),
                            productName: tds[1].textContent.trim(),
                            optionValue: tds[2].textContent.trim(),
                            quantity: parseInt(tds[3].textContent.trim(), 10),
                            costPrice: parseInt(tds[4].textContent.trim().replace(/,/g, ''), 10),
                            sellingPrice: parseInt(tds[5].textContent.trim().replace(/,/g, ''), 10)
                        });
                    });
                    if (selectedProducts.length === 0) return;
                    const inoutvoiceId = '${inOutVoice.inoutvoiceId}';
                    let addCount = 0;
                    selectedProducts.forEach(p => {
                        fetch('${pageContext.request.contextPath}/inout/addProduct.do', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: 'inoutvoiceId=' + encodeURIComponent(inoutvoiceId) + '&productId=' + encodeURIComponent(p.productId) + '&quantity=' + encodeURIComponent(p.quantity)
                        })
                        .then(res => res.json())
                        .then(data => {
                            addCount++;
                            if (addCount === selectedProducts.length) {
                                // 상품 추가 후, 전체 페이지 새로고침
                                location.reload();
                                // 모달 닫기
                                const modal = bootstrap.Modal.getInstance(document.getElementById('productAddModal'));
                                if (modal) modal.hide();
                            }
                        });
                    });
                }
            });
        }

        // 상단 테이블 '선택' 버튼 이벤트는 searchResultTbody에만 위임
        document.getElementById('searchResultTbody').addEventListener('click', function(e) {
            if (e.target.tagName === 'BUTTON' && e.target.textContent.trim() === '선택') {
                const tr = e.target.closest('tr');
                const tds = tr.querySelectorAll('td');
                const product = {
                    productId: tds[0] ? tds[0].textContent.trim() : '',
                    productName: tds[1] ? tds[1].textContent.trim() : '',
                    optionValue: tds[2] ? tds[2].textContent.trim() : '',
                    qty: tds[3] ? tds[3].querySelector('input')?.value || '1' : '1',
                    costPrice: tds[4] ? tds[4].textContent.trim().replace(/,/g, '') : '',
                    sellingPrice: tds[5] ? tds[5].textContent.trim() : '',
                    partnerName: tds[6] ? tds[6].textContent.trim() : ''
                };
                console.log('product:', product);
                const lowerTbody = document.getElementById('selectedProductTbody');
                let found = false;
                Array.from(lowerTbody.querySelectorAll('tr')).forEach(row => {
                    const id = row.querySelector('td:nth-child(1)')?.textContent.trim();
                    const opt = row.querySelector('td:nth-child(3)')?.textContent.trim();
                    if (id === product.productId && opt === product.optionValue) {
                        // 수량 누적
                        const qtyTd = row.querySelector('td:nth-child(4)');
                        const currentQty = parseInt(qtyTd.textContent.trim(), 10) || 0;
                        const addQty = parseInt(product.qty, 10) || 0;
                        qtyTd.textContent = currentQty + addQty;
                        found = true;
                    }
                });
                if (found) return;
                const emptyRow = lowerTbody.querySelector('tr td.text-center');
                if (emptyRow) lowerTbody.innerHTML = '';
                const newRow = document.createElement('tr');
                newRow.innerHTML =
                    '<td>' + product.productId + '</td>' +
                    '<td>' + product.productName + '</td>' +
                    '<td>' + product.optionValue + '</td>' +
                    '<td>' + product.qty + '</td>' +
                    '<td>' + (product.costPrice ? Number(product.costPrice).toLocaleString() : '') + '</td>' +
                    '<td>' + product.sellingPrice + '</td>' +
                    '<td>' + product.partnerName + '</td>' +
                    '<td><button type="button" class="btn btn-danger btn-sm btnRemove">삭제</button></td>';
                lowerTbody.appendChild(newRow);
            }
        });

        // 전체 선택 체크박스
        $('#checkAll').on('change', function() {
            $('.rowCheckbox').prop('checked', this.checked);
        });
        // 개별 체크박스 해제 시 전체선택 해제
        $(document).on('change', '.rowCheckbox', function() {
            if (!this.checked) $('#checkAll').prop('checked', false);
        });
        // 선택 처리
        $(document).on('click', '#btnProcessSelected', function() {
            const ids = $('.rowCheckbox:checked').closest('tr').map(function() {
                return $(this).data('id');
            }).get();
            if (ids.length === 0) return alert('처리할 상품을 선택하세요.');
            $.post({
                url: '${pageContext.request.contextPath}/inout/processProduct.do',
                data: { 'ids': ids },
                traditional: true,
                success: function(res) {
                    if (res.success) {
                        alert('처리 완료!');
                        location.reload();
                    } else {
                        alert('처리 실패: ' + (res.error || '')); 
                    }
                }
            });
        });
        // 선택 삭제
        $(document).on('click', '#btnDeleteSelected', function() {
            const ids = $('.rowCheckbox:checked').closest('tr').map(function() {
                return $(this).data('id');
            }).get();
            if (ids.length === 0) return alert('삭제할 상품을 선택하세요.');
            if (!confirm('정말 삭제하시겠습니까?')) return;
            $.post({
                url: '${pageContext.request.contextPath}/inout/deleteProduct.do',
                data: { 'ids': ids },
                traditional: true,
                success: function(res) {
                    if (res.success) {
                        alert('삭제 완료!');
                        location.reload();
                    } else {
                        alert('삭제 실패: ' + (res.error || ''));
                    }
                }
            });
        });
        // 개별 처리 버튼
        $(document).on('click', '.btnProcess', function() {
            const id = $(this).closest('tr').data('id');
            $.post({
                url: '${pageContext.request.contextPath}/inout/processProduct.do',
                data: { 'ids': [id] },
                traditional: true,
                success: function(res) {
                    if (res.success) {
                        alert('처리 완료!');
                        location.reload();
                    } else {
                        alert('처리 실패: ' + (res.error || ''));
                    }
                }
            });
        });
        // 개별 삭제 버튼
        $(document).on('click', '.btnDelete', function() {
            const id = $(this).closest('tr').data('id');
            if (!confirm('정말 삭제하시겠습니까?')) return;
            $.post({
                url: '${pageContext.request.contextPath}/inout/deleteProduct.do',
                data: { 'ids': [id] },
                traditional: true,
                success: function(res) {
                    if (res.success) {
                        alert('삭제 완료!');
                        location.reload();
                    } else {
                        alert('삭제 실패: ' + (res.error || ''));
                    }
                }
            });
        });

        // 상품 목록 전체를 서버에서 받아와 테이블 갱신
        function reloadProductList(newlyAddedProducts) {
            const inoutvoiceId = '${inOutVoice.inoutvoiceId}';
            fetch('${pageContext.request.contextPath}/inout/getProductList.do?inoutvoiceId=' + inoutvoiceId)
                .then(res => res.json())
                .then(productList => {
                    const tbody = document.getElementById('productTableBody');
                    tbody.innerHTML = '';
                    let sumQty = 0, sumTotalCost = 0, sumTotalSale = 0;
                    productList.forEach(item => {
                        const tr = document.createElement('tr');
                        tr.setAttribute('data-id', item.inoutvoiceProductId);
                        const isPending = item.status === '처리대기';
                        // 문자열 숫자 변환
                        const qty = item.qty !== undefined ? Number(item.qty) : (item.quantity !== undefined ? Number(item.quantity) : 0);
                        const costPrice = item.costPrice !== undefined ? Number(item.costPrice) : 0;
                        const sellingPrice = item.sellingPrice !== undefined ? Number(item.sellingPrice) : 0;
                        const totalCost = qty * costPrice;
                        const totalSale = qty * sellingPrice;
                        sumQty += qty;
                        sumTotalCost += totalCost;
                        sumTotalSale += totalSale;
                        tr.innerHTML =
                            `<td><input type="checkbox" class="rowCheckbox"></td>` +
                            `<td>${item.status || ''}</td>` +
                            `<td>${isPending ? '<button class="btn btn-primary btnProcess">처리</button>' : ''}</td>` +
                            `<td>${isPending ? '<button class="btn btn-sm btn-danger btnDelete">삭제</button>' : ''}</td>` +
                            `<td><fmt:formatDate value="${item.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>` +
                            `<td>${item.workerId}</td>` +
                            `<td>${item.productName || ''}</td>` +
                            `<td>${item.optionValue || ''}</td>` +
                            `<td>${item.productId || ''}</td>` +
                            `<td>${qty || ''}</td>` +
                            `<td><fmt:formatNumber value="${costPrice}" pattern="#,#00"/></td>` +
                            `<td><fmt:formatNumber value="${totalCost}" pattern="#,#00"/></td>` +
                            `<td><fmt:formatNumber value="${sellingPrice}" pattern="#,#00"/></td>` +
                            `<td><fmt:formatNumber value="${totalSale}" pattern="#,#00"/></td>`;
                        tbody.appendChild(tr);
                    });
                    // 합계 등 추가 렌더링 필요시 여기에 작성
                });
        }

        // 상품 추가 버튼 이벤트 (임시로 mock 데이터 추가)
        document.getElementById('btnAddProduct').addEventListener('click', function() {
            var modal = new bootstrap.Modal(document.getElementById('productAddModal'));
            modal.show();
        });

        // 다운로드/업로드/바코드등록 버튼 이벤트 (임시)
        document.getElementById('btnDownload').addEventListener('click', function() {
            alert('다운로드 기능은 추후 구현됩니다.');
        });
        document.getElementById('btnUpload').addEventListener('click', function() {
            alert('업로드 기능은 추후 구현됩니다.');
        });
        document.getElementById('btnBarcode').addEventListener('click', function() {
            alert('바코드등록 기능은 추후 구현됩니다.');
        });
        // 페이지 로드시 상품 렌더링
        reloadProductList();

        function deleteInOutVoice(inoutvoiceId) {
            if (confirm('정말로 삭제하시겠습니까?')) {
                location.href = '${pageContext.request.contextPath}/inout/delete.do?inoutvoiceId=' + inoutvoiceId;
            }
        }

        // 메인 테이블 처리 버튼 이벤트
        document.getElementById('productTableBody').addEventListener('click', function(e) {
            if (e.target.classList.contains('btnProcess')) {
                const tr = e.target.closest('tr');
                // 상태/처리 열을 "처리완료"로 변경
                tr.querySelector('td:nth-child(2)').textContent = '처리완료';
                tr.querySelector('td:nth-child(3)').textContent = '처리완료';
                // 작업일에 오늘 날짜 입력
                const today = new Date();
                const yyyy = today.getFullYear();
                const mm = String(today.getMonth() + 1).padStart(2, '0');
                const dd = String(today.getDate()).padStart(2, '0');
                tr.querySelector('td:nth-child(5)').textContent = `${yyyy}-${mm}-${dd}`;
                // 작업자에 EMPID 입력
                const empId = document.getElementById('currentEmpId').value;
                tr.querySelector('td:nth-child(6)').textContent = empId;
                // 처리/삭제 버튼 숨김
                tr.querySelector('td:nth-child(3)').innerHTML = '';
                tr.querySelector('td:nth-child(4)').innerHTML = '';
            }
        });

        function updateSelectButtons() {
            // 체크된 .rowCheckbox 개수 확인
            const checkedCount = document.querySelectorAll('.rowCheckbox:checked').length;
            document.getElementById('btnProcessSelected').disabled = checkedCount === 0;
            document.getElementById('btnDeleteSelected').disabled = checkedCount === 0;
        }
        // 체크박스 변경 시마다 버튼 활성화/비활성화
        $(document).on('change', '.rowCheckbox, #checkAll', updateSelectButtons);
        // 페이지 로드시 초기 상태 반영
        $(document).ready(updateSelectButtons);
    });
    </script>

    <!-- 상품추가 모달 시작 -->
    <div class="modal fade" id="productAddModal" tabindex="-1" aria-labelledby="productAddModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="productAddModalLabel">상품 추가</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form class="mb-2">
              <div class="row g-2 align-items-center">
                <div class="col-auto">
                  <label class="form-label mb-0">검색 조건</label>
                </div>
                <div class="col-auto">
                  <select class="form-select form-select-sm" id="searchFilter">
                    <option value="code">상품코드</option>
                    <option value="name">상품명</option>
                  </select>
                </div>
                <div class="col-auto">
                  <input type="text" class="form-control form-control-sm" id="searchKeyword" placeholder="검색어 입력">
                </div>
                <div class="col-auto">
                  <button type="button" class="btn btn-primary btn-sm">검색</button>
                </div>
              </div>
            </form>
            <div class="table-responsive mb-2" style="max-height: 350px; overflow-y: auto;">
              <table class="table table-bordered align-middle text-center" style="background:#f8fafc;">
                <thead>
                  <tr>
                    <th>상품코드</th>
                    <th>상품명</th>
                    <th>옵션</th>
                    <th>수량</th>
                    <th>원가</th>
                    <th>판매가</th>
                    <th>공급처</th>
                    <th>선택</th>
                  </tr>
                </thead>
                <tbody id="searchResultTbody">
                  <tr><td colspan="7" class="text-center">표시할 항목이 없습니다</td></tr>
                </tbody>
              </table>
            </div>
            <!-- 하단(선택된 상품) 테이블을 모달 내부로 이동 -->
            <div class="table-responsive">
              <table class="table table-bordered align-middle text-center">
                <thead>
                  <tr>
                    <th>상품코드</th>
                    <th>상품명</th>
                    <th>옵션</th>
                    <th>수량</th>
                    <th>원가</th>
                    <th>판매가</th>
                    <th>공급처</th>
                    <th>삭제</th>
                  </tr>
                </thead>
                <tbody id="selectedProductTbody">
                  <tr><td colspan="7" class="text-center">표시할 항목이 없습니다</td></tr>
                </tbody>
              </table>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary">추가</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
          </div>
        </div>
      </div>
    </div>
    <!-- 상품추가 모달 끝 -->
</body>
</html> 