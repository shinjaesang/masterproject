<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 거래처관리</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .partner-title { font-size: 2rem; font-weight: bold; margin-bottom: 1.5rem; }
        .filter-section { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .table th, .table td { text-align: center; vertical-align: middle; }
        .table th { background: #f8f9fa; }
        .btn-black { background: #111; color: #fff; border: none; }
        .btn-black:hover { background: #222; color: #fff; }
        .btn-gray { background: #f8f9fa; color: #111; border: 1px solid #bbb; }
        .btn-gray:hover { background: #e9ecef; color: #111; }
        .pagination { justify-content: center; }
        /* 버튼 글자 가로 정렬 */
        .btn {
            writing-mode: horizontal-tb !important;
            text-orientation: mixed !important;
            white-space: nowrap !important;
        }
        @media (max-width: 576px) {
            .btn {
                min-width: 60px;
                font-size: 12px;
                padding: 6px 12px;
                white-space: nowrap;
            }
            .d-flex {
                flex-wrap: nowrap;
            }
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
                            <h4 class="mb-0">거래처관리</h4>
                            <button class="btn btn-success" type="button" id="btnRegisterPartner"><i class="fa fa-plus me-1"></i>신규거래처등록</button>
                        </div>
            <!-- 검색 필터 -->
            <div class="filter-section mb-3">
                <form class="row g-2 align-items-end" id="searchForm">
                    <div class="col-md-2">
                                    <label class="form-label">거래처명</label>
                                    <input type="text" class="form-control" name="partnerName" placeholder="거래처명 입력">
                    </div>
                    <div class="col-md-2">
                                    <label class="form-label">거래처 유형</label>
                        <select class="form-select" name="partnerType">
                            <option value="">전체</option>
                                        <option value="공급처">공급처</option>
                                        <option value="판매처">판매처</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                                    <label class="form-label">사업자번호</label>
                                    <input type="text" class="form-control" name="businessRegNo" placeholder="사업자번호 입력">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">담당자</label>
                                    <input type="text" class="form-control" name="managerName" placeholder="이름 입력">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">연락처</label>
                                    <input type="text" class="form-control" name="contactInfo" placeholder="연락처 입력">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">거래상태</label>
                                    <select class="form-select" name="transactionStatus">
                                        <option value="">전체</option>
                                        <option value="Active">거래중</option>
                                        <option value="Inactive">거래중지</option>
                        </select>
                    </div>
                                <div class="col-md-2 text-end">
                                    <button class="btn btn-primary w-100" type="button" id="btnSearch">검색</button>
                    </div>
                </form>
            </div>
            <!-- 데이터 테이블 -->
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                                    <th>거래처코드</th>
                        <th>거래처명</th>
                                    <th>거래처유형</th>
                                    <th>사업자번호</th>
                                    <th>담당자</th>
                                    <th>연락처</th>
                                    <th>이메일</th>
                                    <th>주소</th>
                                    <th>대표자명</th>
                                    <th>법인형태</th>
                                    <th>거래상태</th>
                                    <th>담당사원번호</th>
                                    <th>관리</th>
                    </tr>
                    </thead>
                                <tbody id="partnerTableBody">
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
function loadPartnerList() {
    var params = {
        partnerName: $('input[name=partnerName]').val(),
        partnerType: $('select[name=partnerType]').val(),
        businessRegNo: $('input[name=businessRegNo]').val(),
        managerName: $('input[name=managerName]').val(),
        contactInfo: $('input[name=contactInfo]').val(),
        transactionStatus: $('select[name=transactionStatus]').val()
    };
    $.ajax({
        url: "${pageContext.request.contextPath}/partner/list",
        method: "GET",
        data: params,
        dataType: "json",
        success: function(data) {
            var html = "";
            if(data.length === 0) {
                html = "<tr><td colspan='12'>등록된 거래처가 없습니다.</td></tr>";
            } else {
                $.each(data, function(i, p) {
                    html += "<tr>";
                    html += "<td>" + (p.partnerId || '') + "</td>";
                    html += "<td>" + (p.partnerName || '') + "</td>";
                    html += "<td>" + (p.partnerType || '') + "</td>";
                    html += "<td>" + (p.businessRegNo || '') + "</td>";
                    html += "<td>" + (p.managerName || '-') + "</td>";
                    html += "<td>" + (p.contactInfo || '-') + "</td>";
                    html += "<td>" + (p.email || '-') + "</td>";
                    html += "<td>" + (p.partnerAddress || '-') + "</td>";
                    html += "<td>" + (p.representativeName || '-') + "</td>";
                    html += "<td>" + (p.corporateType || '-') + "</td>";
                    html += "<td>" + (p.transactionStatus === 'Active' ? '거래중' : '거래중지') + "</td>";
                    html += "<td>" + (p.empid || '-') + "</td>";
                    html += "<td>";
                    html += "<button class='btn btn-outline-primary btn-sm btn-edit-partner me-1' data-id='" + (p.partnerId || '') + "'>수정</button>";
                    html += "<button class='btn btn-outline-danger btn-sm btn-delete-partner' data-id='" + (p.partnerId || '') + "'>삭제</button>";
                    html += "</td>";
                    html += "</tr>";
                });
            }
            $("#partnerTableBody").html(html);
        }
    });
}

$(function() {
    loadPartnerList();

    $('#btnRegisterPartner').on('click', function() {
        window.location.href = "${pageContext.request.contextPath}/partner/register.do";
    });

    // 검색 버튼 클릭
    $('#btnSearch').on('click', function() {
        loadPartnerList();
    });

    // 수정 버튼 클릭
    $('#partnerTableBody').on('click', '.btn-edit-partner', function() {
        var pid = $(this).data('id');
        if (!pid) {
            alert('partnerId가 없습니다!');
            return;
        }
        window.location.href = "${pageContext.request.contextPath}/partner/edit.do?partnerId=" + encodeURIComponent(pid);
    });

    // 삭제 버튼 클릭
    $('#partnerTableBody').on('click', '.btn-delete-partner', function() {
        if(confirm('정말 삭제하시겠습니까?')) {
            var pid = $(this).data('id');
            $.ajax({
                url: "${pageContext.request.contextPath}/partner/delete/" + pid,
                method: "DELETE",
                success: function(res) {
                    if(res > 0) {
                        alert('삭제되었습니다.');
                        loadPartnerList();
                    } else {
                        alert('삭제에 실패했습니다.');
                    }
                }
            });
        }
    });
});
</script>
</body>
</html>