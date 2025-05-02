<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 거래처 수정</title>
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
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">거래처 수정</h4>
                </div>
                <form id="partnerEditForm">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label class="form-label">거래처코드</label>
                            <input type="text" class="form-control" name="partnerId" readonly>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">담당자ID(사원번호)</label>
                            <input type="text" class="form-control" name="empid" required>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label class="form-label">거래처명</label>
                            <input type="text" class="form-control" name="partnerName" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">거래처 유형</label>
                            <select class="form-select" name="partnerType" required>
                                <option value="">선택</option>
                                <option value="공급처">공급처</option>
                                <option value="판매처">판매처</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label class="form-label">사업자등록번호</label>
                            <input type="text" class="form-control" name="businessRegNo" placeholder="000-00-00000">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">대표자명</label>
                            <input type="text" class="form-control" name="representativeName" placeholder="대표자명을 입력하세요">
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label class="form-label">담당자</label>
                            <input type="text" class="form-control" name="managerName" placeholder="담당자명을 입력하세요">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">연락처</label>
                            <input type="text" class="form-control" name="contactInfo" placeholder="000-0000-0000">
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label class="form-label">이메일</label>
                            <input type="email" class="form-control" name="email" placeholder="example@email.com">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">법인형태</label>
                            <select class="form-select" name="corporateType">
                                <option value="">선택</option>
                                <option value="주식회사">주식회사</option>
                                <option value="유한회사">유한회사</option>
                                <option value="합자회사">합자회사</option>
                                <option value="합명회사">합명회사</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">주소</label>
                        <input type="text" class="form-control" name="partnerAddress" placeholder="주소를 입력하세요">
                    </div>
                    <div class="mb-4">
                        <label class="form-label">거래상태</label>
                        <select class="form-select" name="transactionStatus">
                            <option value="Active">거래중</option>
                            <option value="Inactive">거래중지</option>
                        </select>
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
    var partnerId = getParam('partnerId');
    if (!partnerId) {
        alert('잘못된 접근입니다. partnerId가 없습니다.');
        return;
    }
    $.ajax({
        url: "${pageContext.request.contextPath}/partner/" + partnerId,
        method: "GET",
        dataType: "json",
        success: function(data) {
            if(data) {
                $('input[name=partnerId]').val(data.partnerId);
                $('input[name=empid]').val(data.empid);
                $('input[name=partnerName]').val(data.partnerName);
                $('select[name=partnerType]').val(data.partnerType);
                $('input[name=businessRegNo]').val(data.businessRegNo);
                $('input[name=representativeName]').val(data.representativeName);
                $('input[name=managerName]').val(data.managerName);
                $('input[name=contactInfo]').val(data.contactInfo);
                $('input[name=email]').val(data.email);
                $('select[name=corporateType]').val(data.corporateType);
                $('input[name=partnerAddress]').val(data.partnerAddress);
                $('select[name=transactionStatus]').val(data.transactionStatus);
            } else {
                alert('해당 거래처 정보를 찾을 수 없습니다.');
            }
        },
        error: function() {
            alert('거래처 정보를 불러오지 못했습니다.');
        }
    });
    $('#partnerEditForm').on('submit', function(e) {
        e.preventDefault();
        var param = {
            partnerId: $('input[name=partnerId]').val(),
            partnerName: $('input[name=partnerName]').val(),
            partnerType: $('select[name=partnerType]').val(),
            empid: $('input[name=empid]').val(),
            managerName: $('input[name=managerName]').val(),
            contactInfo: $('input[name=contactInfo]').val(),
            email: $('input[name=email]').val(),
            partnerAddress: $('input[name=partnerAddress]').val(),
            businessRegNo: $('input[name=businessRegNo]').val(),
            representativeName: $('input[name=representativeName]').val(),
            corporateType: $('select[name=corporateType]').val(),
            transactionStatus: $('select[name=transactionStatus]').val()
        };
        $.ajax({
            url: "${pageContext.request.contextPath}/partner/update",
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify(param),
            success: function(res) {
                alert('수정이 완료되었습니다.');
                window.location.href = "${pageContext.request.contextPath}/partner/partner.do";
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