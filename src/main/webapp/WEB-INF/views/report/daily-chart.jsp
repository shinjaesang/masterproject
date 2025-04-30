<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 일별매출차트</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .filter-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .sales-table th {
            background-color: #e9ecef;
            font-weight: 600;
            text-align: center;
        }
        .alert-custom {
            background: #fff3f3;
            color: #e74c3c;
            border: 1px solid #f5c6cb;
            font-size: 15px;
            margin-bottom: 10px;
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
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">일별상품매출통계</h4>
                        </div>
                        <!-- 안내문구 -->
                        <div class="alert alert-custom" role="alert">
                            <i class="fa fa-exclamation-circle me-2"></i> 당일 데이터는 익일 반영됩니다.
                        </div>
                        <!-- 검색 필터 -->
                        <div class="filter-section mb-3">
                            <form class="row g-2 align-items-end" id="searchForm">
                                <div class="col-md-3">
                                    <label class="form-label">검색기간</label>
                                    <div class="input-group">
                                        <select class="form-select" name="dateType" style="max-width: 90px;">
                                            <option>발주일</option>
                                            <option>등록일</option>
                                        </select>
                                        <input type="date" class="form-control" name="startDate" id="startDate">
                                        <span class="input-group-text">~</span>
                                        <input type="date" class="form-control" name="endDate" id="endDate">
                                    </div>
                                    <div class="mt-2 d-flex gap-1 flex-wrap">
                                        <button type="button" class="btn btn-outline-secondary btn-sm quick-date" data-type="today">오늘</button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm quick-date" data-type="yesterday">어제</button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm quick-date" data-type="thisweek">이번주</button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm quick-date" data-type="lastweek">저번주</button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm quick-date" data-type="thismonth">이번달</button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm quick-date" data-type="lastmonth">저번달</button>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">판매처</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="seller" placeholder="전체">
                                        <button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>
                                        <button class="btn btn-outline-secondary" type="button">상세선택</button>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">공급처</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="supplier" placeholder="전체">
                                        <button class="btn btn-outline-secondary" type="button"><i class="fa fa-search"></i></button>
                                        <button class="btn btn-outline-secondary" type="button">상세선택</button>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">정렬</label>
                                    <select class="form-select" name="sort">
                                        <option>수량▶상품명</option>
                                        <option>상품명▶수량</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">조회</label>
                                    <select class="form-select" name="queryType">
                                        <option>수량조회</option>
                                        <option>금액조회</option>
                                    </select>
                                </div>
                                <div class="col-md-1">
                                    <label class="form-label">카테고리</label>
                                    <select class="form-select" name="category">
                                        <option value="">전체</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.code}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-12 text-end mt-2">
                                    <button class="btn btn-success" type="button" style="min-width:120px;" onclick="downloadExcel()"><i class="fa fa-download me-1"></i>다운로드</button>
                                    <button class="btn btn-primary ms-2" type="button" onclick="searchData()">검색</button>
                                </div>
                            </form>
                        </div>
                        <!-- 테이블 -->
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover sales-table align-middle">
                                <thead>
                                <tr>
                                    <th>상품코드</th>
                                    <th>연동코드</th>
                                    <th>로케이션</th>
                                    <th>이미지</th>
                                    <th>상품명</th>
                                    <th>원가</th>
                                    <th>원가수량</th>
                                    <th>판매가</th>
                                    <th>판매가수량</th>
                                    <th>현재고</th>
                                    <th>접수</th>
                                    <th>송장</th>
                                    <th>접수+송장</th>
                                    <th>기간접수수량</th>
                                    <th>기간송장수량</th>
                                    <th>기간배송수량</th>
                                    <th>차트</th>
                                    <th>차트상세</th>
                                    <th>일자</th>
                                </tr>
                                </thead>
                                <tbody id="salesTableBody">
                                <!-- 데이터가 동적으로 로드됩니다 -->
                                </tbody>
                            </table>
                        </div>
                        <!-- 페이지네이션: 테이블 하단 중앙 -->
                        <div class="d-flex justify-content-center align-items-center mt-3">
                            <nav aria-label="Page navigation">
                                <ul class="pagination pagination-sm mb-0">
                                    <li class="page-item disabled"><a class="page-link" href="#">&laquo;</a></li>
                                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item disabled"><a class="page-link" href="#">&raquo;</a></li>
                                </ul>
                            </nav>
                            <div class="input-group input-group-sm ms-3" style="width: 100px;">
                                <select class="form-select form-select-sm">
                                    <option selected>300</option>
                                    <option>100</option>
                                    <option>200</option>
                                </select>
                            </div>
                        </div>
                        <div class="text-center text-muted mt-2">표시할 행이 없습니다</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Content End -->
</div>
<!-- JS 라이브러리 및 검색/테이블 스크립트는 필요시 추가 -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script>
// 빠른 날짜 선택 버튼 기능
function setQuickDate(type) {
    const today = new Date();
    let start, end;
    switch(type) {
        case 'today':
            start = end = today;
            break;
        case 'yesterday':
            start = end = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 1);
            break;
        case 'thisweek': {
            const day = today.getDay() === 0 ? 7 : today.getDay();
            start = new Date(today.getFullYear(), today.getMonth(), today.getDate() - day + 1);
            end = today;
            break;
        }
        case 'lastweek': {
            const day = today.getDay() === 0 ? 7 : today.getDay();
            end = new Date(today.getFullYear(), today.getMonth(), today.getDate() - day);
            start = new Date(end.getFullYear(), end.getMonth(), end.getDate() - 6);
            break;
        }
        case 'thismonth':
            start = new Date(today.getFullYear(), today.getMonth(), 1);
            end = today;
            break;
        case 'lastmonth':
            start = new Date(today.getFullYear(), today.getMonth() - 1, 1);
            end = new Date(today.getFullYear(), today.getMonth(), 0);
            break;
        default:
            start = end = today;
    }
    document.getElementById('startDate').value = start.toISOString().split('T')[0];
    document.getElementById('endDate').value = end.toISOString().split('T')[0];
    searchData();
}

document.addEventListener('DOMContentLoaded', function() {
    // ... 기존 코드 ...
    document.querySelectorAll('.quick-date').forEach(btn => {
        btn.addEventListener('click', function() {
            setQuickDate(this.dataset.type);
        });
    });
});
// ... 기존 코드 ...
</script>
</body>
</html> 