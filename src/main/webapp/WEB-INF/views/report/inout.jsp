<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 입출고 통계</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .stat-title { font-size: 2rem; font-weight: bold; margin-bottom: 1.5rem; }
        .stat-table th, .stat-table td { text-align: center; vertical-align: middle; }
        .stat-table th { background: #f8f9fa; }
        .stat-table .in { color: #27ae60; font-weight: bold; }
        .stat-table .out, .stat-table .minus { color: #e74c3c; font-weight: bold; }
        .stat-table .plus { color: #27ae60; font-weight: bold; }
        .chart-area { background: #fff; border: 1px solid #e0e0e0; border-radius: 8px; padding: 1.5rem; }
        .chart-title { font-size: 1.1rem; font-weight: 600; margin-bottom: 0.5rem; }
    </style>
</head>
<body>
<div class="container-fluid position-relative bg-white d-flex p-0">
    <!-- Sidebar Start -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
    <!-- Sidebar End -->
    <!-- Content Start -->
    <div class="content">
        <!-- Navbar Start -->
        <jsp:include page="/WEB-INF/views/common/navbar.jsp"/>
        <!-- Navbar End -->
        <div class="container-fluid pt-4 px-4">
            <div class="row g-4">
                <div class="col-12">
                    <div class="bg-light rounded h-100 p-4">
                        <!-- <div class="stat-title mb-4">입출고 통계</div> -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">입출고 통계</h4>
                        </div>
                        <!-- 검색 필터 -->
                        <form class="row g-2 align-items-end mb-4" id="searchForm">
                            <div class="col-md-3">
                                <label class="form-label">기간</label>
                                <div class="input-group">
                                    <input type="date" class="form-control" name="startDate">
                                    <span class="input-group-text">~</span>
                                    <input type="date" class="form-control" name="endDate">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">창고</label>
                                <select class="form-select" name="warehouse">
                                    <option value="">전체</option>
                                    <option>서울 창고</option>
                                    <option>부산 창고</option>
                                    <option>대구 창고</option>
                                    <option>인천 창고</option>
                                    <option>광주 창고</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">카테고리</label>
                                <select class="form-select" name="category">
                                    <option value="">전체</option>
                                    <option>전자제품</option>
                                    <option>생활용품</option>
                                    <option>식품</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">상품명</label>
                                <input type="text" class="form-control" name="productName" placeholder="상품명 입력">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">정렬</label>
                                <select class="form-select" name="sort">
                                    <option>날짜순</option>
                                    <option>입고량순</option>
                                    <option>출고량순</option>
                                    <option>재고량순</option>
                                </select>
                            </div>
                            <div class="col-md-1 text-end">
                                <button class="btn btn-primary w-100" type="button">검색</button>
                            </div>
                        </form>
                        <!-- 표 -->
                        <div class="table-responsive mb-4">
                            <table class="table table-bordered stat-table">
                                <thead>
                                <tr>
                                    <th>날짜</th>
                                    <th>입고량</th>
                                    <th>출고량</th>
                                    <th>재고량</th>
                                    <th>증감률</th>
                                </tr>
                                </thead>
                                <tbody id="inoutTableBody">
                                <tr class="no-data"><td colspan="5" class="text-center text-muted">데이터가 없습니다</td></tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- 차트 영역 -->
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="chart-area">
                                    <div class="chart-title">상품별 입출고 현황</div>
                                    <canvas id="productInoutChart" height="220"></canvas>
                                    <div id="productInoutNoData" class="text-center text-muted mt-3">데이터가 없습니다</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="chart-area">
                                    <div class="chart-title">창고별 재고 현황</div>
                                    <canvas id="warehouseStockChart" height="220"></canvas>
                                    <div id="warehouseStockNoData" class="text-center text-muted mt-3">데이터가 없습니다</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Content End -->
</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<!-- 차트 샘플 스크립트 (데이터 연동 전용) -->
<script>
let productInoutChart = null;
let warehouseStockChart = null;

function clearTableAndCharts() {
    document.getElementById('inoutTableBody').innerHTML = '<tr class="no-data"><td colspan="5" class="text-center text-muted">데이터가 없습니다</td></tr>';
    if (productInoutChart) { productInoutChart.destroy(); productInoutChart = null; }
    if (warehouseStockChart) { warehouseStockChart.destroy(); warehouseStockChart = null; }
    document.getElementById('productInoutNoData').style.display = '';
    document.getElementById('warehouseStockNoData').style.display = '';
}

$(function() {
    clearTableAndCharts();
    const ctx = "${pageContext.request.contextPath}";
    $('#searchForm button[type="button"]').on('click', function() {
        // 1. 폼 데이터 수집
        const params = {
            startDate: $('input[name="startDate"]').val(),
            endDate: $('input[name="endDate"]').val(),
            warehouse: $('select[name="warehouse"]').val(),
            category: $('select[name="category"]').val(),
            productName: $('input[name="productName"]').val()
        };

        // 2. 표 데이터
        $.getJSON(ctx + '/report/inout/data', params, function(tableData) {
            const tbody = $('#inoutTableBody').empty();
            if (!tableData || tableData.length === 0) {
                tbody.append('<tr class="no-data"><td colspan="5" class="text-center text-muted">데이터가 없습니다</td></tr>');
            } else {
                tableData.forEach(row => {
                    tbody.append(
                        `<tr>
                            <td>${'$'}{row.date}</td>
                            <td class="in">${'$'}{row.inAmount.toLocaleString()} 개</td>
                            <td class="out">${'$'}{row.outAmount.toLocaleString()} 개</td>
                            <td>${'$'}{row.stockAmount.toLocaleString()} 개</td>
                            <td class="${'$'}{parseFloat(row.rate) >= 0 ? 'plus' : 'minus'}">${'$'}{row.rate}</td>
                        </tr>`
                    );
                });
            }
        });

        // 3. 상품별 차트 데이터
        $.getJSON(ctx + '/report/inout/product-chart', params, function(productData) {
            const labels = productData.map(d => d.productName);
            const inData = productData.map(d => d.inAmount);
            const outData = productData.map(d => d.outAmount);
            if (productInoutChart) productInoutChart.destroy();
            const ctx1 = document.getElementById('productInoutChart').getContext('2d');
            productInoutChart = new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        { label: '입고', data: inData, backgroundColor: '#27ae60' },
                        { label: '출고', data: outData, backgroundColor: '#e74c3c' }
                    ]
                },
                options: { responsive: true, plugins: { legend: { position: 'top' } } }
            });
            $('#productInoutNoData').toggle(labels.length === 0);
        });

        // 4. 창고별 차트 데이터
        $.getJSON(ctx + '/report/inout/warehouse-chart', { date: params.endDate }, function(warehouseData) {
            const labels = warehouseData.map(d => d.warehouseName);
            const stockData = warehouseData.map(d => d.stockAmount);
            if (warehouseStockChart) warehouseStockChart.destroy();
            const ctx2 = document.getElementById('warehouseStockChart').getContext('2d');
            warehouseStockChart = new Chart(ctx2, {
                type: 'pie',
                data: {
                    labels: labels,
                    datasets: [{ label: '재고', data: stockData, backgroundColor: ['#09f','#2ecc71','#f39c12','#e74c3c','#8e44ad'] }]
                },
                options: { responsive: true, plugins: { legend: { position: 'right' } } }
            });
            $('#warehouseStockNoData').toggle(labels.length === 0);
        });
    });
});
</script>
</body>
</html> 