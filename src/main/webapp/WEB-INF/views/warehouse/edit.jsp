<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 창고 수정</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .register-title { font-size: 2rem; font-weight: bold; margin-bottom: 2rem; }
        .form-label { font-weight: 500; }
        .form-section { max-width: 900px; margin: 0 auto; }
        .form-control, .form-select { border-radius: 0; }
        textarea.form-control { min-height: 120px; }
        .btn-black { background: #111; color: #fff; border: none; }
        .btn-black:hover { background: #222; color: #fff; }
        .btn-cancel { background: #fff; color: #111; border: 1px solid #bbb; }
        .btn-cancel:hover { background: #f8f9fa; color: #111; }
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
            <div class="form-section bg-light rounded p-5">
                <div class="register-title mb-4">창고 수정</div>
                <form id="warehouseEditForm">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label class="form-label">창고명</label>
                            <input type="text" class="form-control" name="warehouseName" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">위치</label>
                            <input type="text" class="form-control" name="location" required>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label class="form-label">담당자</label>
                            <input type="text" class="form-control" name="manager">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">연락처</label>
                            <input type="text" class="form-control" name="phone">
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label class="form-label">창고유형</label>
                            <select class="form-select" name="type">
                                <option value="">선택</option>
                                <option value="OWN">일반창고</option>
                                <option value="3PL">위탁창고</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">사용여부</label>
                            <select class="form-select" name="useYn">
                                <option value="Y">사용</option>
                                <option value="N">미사용</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">비고</label>
                        <textarea class="form-control" name="note" placeholder="추가 정보를 입력하세요"></textarea>
                    </div>
                    <div class="text-end">
                        <button type="button" class="btn btn-cancel me-2" onclick="history.back()">취소</button>
                        <button type="submit" class="btn btn-black">수정</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Content End -->
</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script>
$(function() {
    function getParam(name) {
        let url = new URL(window.location.href);
        return url.searchParams.get(name);
    }
    var warehouseId = getParam('warehouseId');
    if (warehouseId) {
        $.ajax({
            url: "${pageContext.request.contextPath}/warehouse/" + warehouseId,
            method: "GET",
            dataType: "json",
            success: function(data) {
                console.log(data); // 실제 데이터 확인
                if(data) {
                    $('input[name=warehouseName]').val(data.warehouseName);
                    $('input[name=location]').val(data.warehouseAddress);
                    $('input[name=manager]').val(data.managerName);
                    $('input[name=phone]').val(data.contactInfo);
                    $('select[name=type]').val(data.warehouseType);
                    if(data.useYn) $('select[name=useYn]').val(data.useYn);
                    if(data.note) $('textarea[name=note]').val(data.note);
                }
            }
        });
    }
    $('#warehouseEditForm').on('submit', function(e) {
        e.preventDefault();
        var param = {
            warehouseId: warehouseId,
            warehouseName: $('input[name=warehouseName]').val(),
            warehouseAddress: $('input[name=location]').val(),
            managerName: $('input[name=manager]').val(),
            contactInfo: $('input[name=phone]').val(),
            warehouseType: $('select[name=type]').val()
        };
        $.ajax({
            url: "${pageContext.request.contextPath}/warehouse/update",
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify(param),
            success: function(res) {
                alert('수정이 완료되었습니다.');
                window.location.href = "${pageContext.request.contextPath}/warehouse/warehouse.do";
            },
            error: function() {
                alert('수정에 실패했습니다.');
            }
        });
    });
});
</script>
</body>
</html> 