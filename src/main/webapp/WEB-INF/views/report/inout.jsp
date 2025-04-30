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
    // 표
    document.getElementById('inoutTableBody').innerHTML = '<tr class="no-data"><td colspan="5" class="text-center text-muted">데이터가 없습니다</td></tr>';
    // 차트
    if (productInoutChart) { productInoutChart.destroy(); productInoutChart = null; }
    if (warehouseStockChart) { warehouseStockChart.destroy(); warehouseStockChart = null; }
    document.getElementById('productInoutNoData').style.display = '';
    document.getElementById('warehouseStockNoData').style.display = '';
}

function renderTableAndCharts(data) {
    // 표
    const tbody = document.getElementById('inoutTableBody');
    tbody.innerHTML = '';
    if (!data.table || data.table.length === 0) {
        tbody.innerHTML = '<tr class="no-data"><td colspan="5" class="text-center text-muted">데이터가 없습니다</td></tr>';
    } else {
        data.table.forEach(row => {
            tbody.innerHTML += `<tr>
                <td>${row.date}</td>
                <td class="in">${row.in}</td>
                <td class="out">${row.out}</td>
                <td>${row.stock}</td>
                <td class="${row.rateClass}">${row.rate}</td>
            </tr>`;
        });
    }
    // 차트
    if (productInoutChart) productInoutChart.destroy();
    if (warehouseStockChart) warehouseStockChart.destroy();
    if (data.productChart && data.productChart.labels.length > 0) {
        document.getElementById('productInoutNoData').style.display = 'none';
        const ctx1 = document.getElementById('productInoutChart').getContext('2d');
        productInoutChart = new Chart(ctx1, {
            type: 'bar',
            data: data.productChart,
            options: { responsive: true, plugins: { legend: { position: 'top' } } }
        });
    } else {
        document.getElementById('productInoutNoData').style.display = '';
    }
    if (data.warehouseChart && data.warehouseChart.labels.length > 0) {
        document.getElementById('warehouseStockNoData').style.display = 'none';
        const ctx2 = document.getElementById('warehouseStockChart').getContext('2d');
        warehouseStockChart = new Chart(ctx2, {
            type: 'pie',
            data: data.warehouseChart,
            options: { responsive: true, plugins: { legend: { position: 'right' } } }
        });
    } else {
        document.getElementById('warehouseStockNoData').style.display = '';
    }
}

// 검색 버튼 클릭 시 샘플 데이터로 표/차트 갱신
$(function() {
    clearTableAndCharts();
    $('#searchForm button[type="button"]').on('click', function() {
        // 실제로는 Ajax로 데이터 받아오면 됨
        const sample = {
            table: [
                {date:'2024-02-03', in:'1,200 개', out:'900 개', stock:'2,000 개', rate:'10 %', rateClass:'plus'},
                {date:'2024-02-02', in:'900 개', out:'1,000 개', stock:'1,700 개', rate:'-5 %', rateClass:'minus'},
                {date:'2024-02-01', in:'800 개', out:'700 개', stock:'1,800 개', rate:'3 %', rateClass:'plus'}
            ],
            productChart: {
                labels: ['스마트폰', '태블릿', '스마트워치'],
                datasets: [
                    { label: '입고량', data: [1200, 900, 700], backgroundColor: '#27ae60' },
                    { label: '출고량', data: [900, 800, 600], backgroundColor: '#e74c3c' }
                ]
            },
            warehouseChart: {
                labels: ['서울 창고', '부산 창고', '대구 창고', '인천 창고', '광주 창고'],
                datasets: [{
                    data: [400, 300, 250, 200, 150],
                    backgroundColor: ['#3b5998', '#27ae60', '#f1c40f', '#e74c3c', '#5dade2']
                }]
            }
        };
        renderTableAndCharts(sample);
    });
});
</script>
</body>
</html> 