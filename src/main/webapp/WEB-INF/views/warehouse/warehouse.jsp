<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 창고관리</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .warehouse-title { font-size: 2rem; font-weight: bold; margin-bottom: 1.5rem; }
        .filter-section { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .table th, .table td { text-align: center; vertical-align: middle; }
        .table th { background: #f8f9fa; }
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
                            <h4 class="mb-0">창고관리</h4>
                            <button class="btn btn-success" type="button" id="btnRegisterWarehouse"><i class="fa fa-plus me-1"></i>신규창고등록</button>
                        </div>
                        <!-- 검색 필터 -->
                        <div class="filter-section mb-3">
                            <form class="row g-2 align-items-end" id="searchForm">
                                <div class="col-md-3">
                                    <label class="form-label">창고명</label>
                                    <input type="text" class="form-control" name="warehouseName" placeholder="창고명 입력">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">위치</label>
                                    <input type="text" class="form-control" name="location" placeholder="주소/지역명 입력">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">담당자</label>
                                    <input type="text" class="form-control" name="manager" placeholder="이름 입력">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">연락처</label>
                                    <input type="text" class="form-control" name="phone" placeholder="연락처 입력">
                                </div>
                                <!-- <div class="col-md-2">
                                    <label class="form-label">창고유형</label>
                                    <select class="form-select" name="type">
                                        <option value="">전체</option>
                                        <option>일반창고</option>
                                        <option>냉장창고</option>
                                        <option>위탁창고</option>
                                        <option>기타</option>
                                    </select>
                                </div> -->
                                <div class="col-md-2">
                                    <label class="form-label">사용여부</label>
                                    <select class="form-select" name="useYn">
                                        <option value="">전체</option>
                                        <option>사용</option>
                                        <option>미사용</option>
                                    </select>
                                </div>
                                <!-- <div class="col-md-2">
                                    <label class="form-label">등록일</label>
                                    <input type="date" class="form-control" name="regDate">
                                </div> -->
                                <div class="col-md-2 text-end">
                                    <button class="btn btn-primary w-100" type="button">검색</button>
                                </div>
                            </form>
                        </div>
                        <!-- 데이터 테이블 -->
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>창고코드</th>
                                    <th>창고명</th>
                                    <th>위치</th>
                                    <th>담당자</th>
                                    <th>연락처</th>
                                    <th>창고유형</th>
                                    <th>사용여부</th>
                                    <th>관리</th>
                                </tr>
                                </thead>
                                <tbody id="warehouseTableBody">
                                <!-- JS로 동적 렌더링 -->
                                </tbody>
                            </table>
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
function loadWarehouseList() {
    var params = {
        warehouseName: $('input[name=warehouseName]').val(),
        warehouseAddress: $('input[name=location]').val(),
        managerName: $('input[name=manager]').val(),
        contactInfo: $('input[name=phone]').val(),
        warehouseType: $('select[name=type]').val()
    };
    $.ajax({
        url: "${pageContext.request.contextPath}/warehouse/list",
        method: "GET",
        data: params,
        dataType: "json",
        success: function(data) {
            var html = "";
            if(data.length === 0) {
                html = "<tr><td colspan='10'>등록된 창고가 없습니다.</td></tr>";
            } else {
                $.each(data, function(i, w) {
                    html += "<tr>";
                    html += "<td>" + w.warehouseId + "</td>";
                    html += "<td>" + w.warehouseName + "</td>";
                    html += "<td>" + (w.warehouseAddress || '-') + "</td>";
                    html += "<td>" + (w.managerName || '-') + "</td>";
                    html += "<td>" + (w.contactInfo || '-') + "</td>";
                    html += "<td>" + (w.warehouseType || '-') + "</td>";
                    html += "<td>사용</td>";
                    html += "<td>";
                    html += "<div class='d-flex justify-content-center gap-2'>";
                    html += "<button class='btn btn-outline-primary btn-sm btn-edit-warehouse' data-id='" + w.warehouseId + "'>수정</button>";
                    html += "<button class='btn btn-outline-danger btn-sm btn-delete-warehouse' data-id='" + w.warehouseId + "'>삭제</button>";
                    html += "</div>";
                    html += "</td>";
                    html += "</tr>";
                });
            }
            $("#warehouseTableBody").html(html);
        }
    });
}

$(function() {
    loadWarehouseList();

    $('#btnRegisterWarehouse').on('click', function() {
        window.location.href = "${pageContext.request.contextPath}/warehouse/register.do";
    });

    // 동적으로 생성된 버튼 이벤트 위임
    $('#warehouseTableBody').on('click', '.btn-edit-warehouse', function() {
        var wid = $(this).data('id');
        window.location.href = "${pageContext.request.contextPath}/warehouse/edit.do?warehouseId=" + wid;
    });

    // 삭제 버튼 이벤트 위임
    $('#warehouseTableBody').on('click', '.btn-delete-warehouse', function() {
        var wid = $(this).data('id');
        if(confirm('정말로 이 창고를 삭제하시겠습니까?')) {
            $.ajax({
                url: "${pageContext.request.contextPath}/warehouse/delete",
                method: "GET",
                data: { id: wid },
                success: function(res) {
                    if(res === "success") {
                        alert('창고가 삭제되었습니다.');
                        loadWarehouseList();
                    } else {
                        alert('삭제에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    alert('삭제 중 오류가 발생했습니다.');
                }
            });
        }
    });

    // 검색 버튼 클릭 시 (검색 조건은 추가 구현 필요)
    $('#searchForm button[type=button]').on('click', function() {
        loadWarehouseList();
    });
});
</script>
</body>
</html> 