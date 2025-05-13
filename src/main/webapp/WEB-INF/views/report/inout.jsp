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
        .chart-area { 
            background: #fff; 
            border: 1px solid #e0e0e0; 
            border-radius: 8px; 
            padding: 1.5rem;
            height: 400px;
            position: relative;
        }
        .chart-title { 
            font-size: 1.1rem; 
            font-weight: 600; 
            margin-bottom: 1rem;
            color: #333;
        }
        .chart-container {
            position: relative;
            height: calc(100% - 40px);
            width: 100%;
        }
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
                                    <input type="date" class="form-control" name="startDate" required>
                                    <span class="input-group-text">~</span>
                                    <input type="date" class="form-control" name="endDate" required>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">카테고리</label>
                                <select class="form-select" name="category">
                                    <option value="">전체</option>
                                    <option>전자부품</option>
                                    <option>전자제품</option>
                                    <option>가전제품</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">정렬</label>
                                <select class="form-select" name="sort">
                                    <option>날짜순</option>
                                    <option>입고량순</option>
                                    <option>출고량순</option>
                                </select>
                            </div>
                            <div class="col-md-1 text-end">
                                <button class="btn btn-primary w-100" type="button" id="searchBtn">검색</button>
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
                                    <th>재고율</th>
                                </tr>
                                </thead>
                                <tbody id="inoutTableBody">
                                <tr class="no-data"><td colspan="5" class="text-center text-muted">데이터가 없습니다</td></tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- 차트 영역 -->
                        <div class="row g-4">
                            <div class="col-12">
                                <div class="chart-area">
                                    <div class="chart-title">입출고 추이</div>
                                    <div class="chart-container">
                                        <canvas id="inoutChart"></canvas>
                                    </div>
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
<script>
let inoutChart = null;

function clearTableAndCharts() {
    document.getElementById('inoutTableBody').innerHTML = '<tr class="no-data"><td colspan="5" class="text-center text-muted">데이터가 없습니다</td></tr>';
    if (inoutChart) {
        inoutChart.destroy();
    }
    
    const ctx = document.getElementById('inoutChart').getContext('2d');
    inoutChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [],
            datasets: [
                {
                    label: '입고량',
                    data: [],
                    borderColor: '#27ae60',
                    backgroundColor: 'rgba(39, 174, 96, 0.1)',
                    tension: 0.4,
                    fill: true
                },
                {
                    label: '출고량',
                    data: [],
                    borderColor: '#e74c3c',
                    backgroundColor: 'rgba(231, 76, 60, 0.1)',
                    tension: 0.4,
                    fill: true
                },
                {
                    label: '재고량',
                    data: [],
                    borderColor: '#3498db',
                    backgroundColor: 'rgba(52, 152, 219, 0.1)',
                    tension: 0.4,
                    fill: true
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                },
                tooltip: {
                    mode: 'index',
                    intersect: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '수량'
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: '날짜'
                    }
                }
            }
        }
    });
}

function updateChart(chartData) {
    const ctx = document.getElementById('inoutChart').getContext('2d');
    
    if (inoutChart) {
        inoutChart.destroy();
    }

    inoutChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: chartData.labels,
            datasets: [
                {
                    label: '입고량',
                    data: chartData.inData,
                    borderColor: '#27ae60',
                    backgroundColor: 'rgba(39, 174, 96, 0.1)',
                    tension: 0.4,
                    fill: true
                },
                {
                    label: '출고량',
                    data: chartData.outData,
                    borderColor: '#e74c3c',
                    backgroundColor: 'rgba(231, 76, 60, 0.1)',
                    tension: 0.4,
                    fill: true
                },
                {
                    label: '재고량',
                    data: chartData.stockData,
                    borderColor: '#3498db',
                    backgroundColor: 'rgba(52, 152, 219, 0.1)',
                    tension: 0.4,
                    fill: true
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                },
                tooltip: {
                    mode: 'index',
                    intersect: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '수량'
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: '날짜'
                    }
                }
            }
        }
    });
}

$(function() {
    clearTableAndCharts();
    
    // 현재 날짜 설정
    const today = new Date();
    const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
    const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);
    
    // 날짜 형식 변환 함수
    function formatDate(date) {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    }
    
    // 기본 날짜 설정
    $('input[name="startDate"]').val(formatDate(firstDay));
    $('input[name="endDate"]').val(formatDate(lastDay));
    
    // 검색 버튼 클릭 이벤트
    $('#searchBtn').on('click', function() {
        const startDate = $('input[name="startDate"]').val();
        const endDate = $('input[name="endDate"]').val();
        
        if (!startDate || !endDate) {
            alert('시작일과 종료일을 모두 입력해주세요.');
            return;
        }

        const params = {
            startDate: startDate,
            endDate: endDate,
            category: $('select[name="category"]').val(),
            sort: $('select[name="sort"]').val()
        };
        
        console.log('검색 파라미터:', params);

        // 표 데이터 조회
        $.ajax({
            url: '${pageContext.request.contextPath}/report/inout/data',
            type: 'GET',
            data: params,
            dataType: 'json',
            success: function(tableData) {
                console.log('서버 응답 데이터:', tableData);
                
                const tbody = $('#inoutTableBody').empty();
                
                if (!tableData || tableData.length === 0) {
                    tbody.append('<tr class="no-data"><td colspan="5" class="text-center text-muted">데이터가 없습니다</td></tr>');
                    return;
                }
                
                tableData.forEach(function(row, index) {
                    console.log(`[${index}] 행 데이터:`, row);
                    
                    // null 체크 및 기본값 설정
                    const statDate = row.stat_date || '';
                    const inAmount = row.inAmount || 0;
                    const outAmount = row.outAmount || 0;
                    const stockAmount = row.stockAmount || 0;
                    const rate = row.rate || 0;
                    
                    // HTML 생성 (변수 이스케이프)
                    const html = 
                        '<tr>' +
                        '<td>' + statDate + '</td>' +
                        '<td class="in">' + inAmount.toLocaleString() + ' 개</td>' +
                        '<td class="out">' + outAmount.toLocaleString() + ' 개</td>' +
                        '<td class="stock">' + stockAmount.toLocaleString() + ' 개</td>' +
                        '<td class="rate">' + (rate ? rate.toFixed(2) + '%' : '-') + '</td>' +
                        '</tr>';
                    
                    tbody.append(html);
                });
            },
            error: function(xhr, status, error) {
                console.error('데이터 조회 중 오류 발생:', status, error);
                console.error('서버 응답:', xhr.responseText);
                alert('데이터를 불러오는 중 오류가 발생했습니다.');
            }
        });

        // 차트 데이터 조회
        $.ajax({
            url: '${pageContext.request.contextPath}/report/inout/chart',
            type: 'GET',
            data: params,
            dataType: 'json',
            success: function(chartData) {
                console.log('차트 데이터:', chartData);
                
                if (!chartData || !chartData.labels || chartData.labels.length === 0) {
                    console.warn('차트 데이터가 없습니다.');
                    return;
                }
                
                updateChart(chartData);
            },
            error: function(xhr, status, error) {
                console.error('차트 데이터 조회 중 오류 발생:', status, error);
                console.error('서버 응답:', xhr.responseText);
            }
        });
    });
    
    // 페이지 로드 시 자동으로 검색 실행
    $('#searchBtn').trigger('click');
});
</script>
</body>
</html> 