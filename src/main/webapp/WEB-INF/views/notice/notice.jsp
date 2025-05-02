<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 공지사항</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .notice-title { font-size: 2rem; font-weight: bold; margin-bottom: 1.5rem; }
        .filter-section { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .table th, .table td { text-align: center; vertical-align: middle; }
        .table th { background: #f8f9fa; }
        .btn-black { background: #111; color: #fff; border: none; }
        .btn-black:hover { background: #222; color: #fff; }
        .btn-gray { background: #f8f9fa; color: #111; border: 1px solid #bbb; }
        .btn-gray:hover { background: #e9ecef; color: #111; }
        .pagination { justify-content: center; }
        .table-responsive {
            margin-top: 20px;
        }
        .search-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
        }
        .search-form .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
        }
        .search-form .form-control {
            height: 38px;
        }
        .search-form .btn {
            height: 38px;
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
                            <h4 class="mb-0">공지사항</h4>
                            <button class="btn btn-primary" type="button" id="btnWriteNotice">
                                <i class="fa fa-plus me-2"></i>새 공지사항
                            </button>
                        </div>
                        <!-- 검색 필터 -->
                        <div class="search-form mb-4">
                            <form id="searchForm" class="row g-3 align-items-end">
                                <div class="col-md-3">
                                    <label class="form-label">제목</label>
                                    <input type="text" class="form-control" id="title" name="title" placeholder="제목">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">작성자</label>
                                    <input type="text" class="form-control" id="author" name="author" placeholder="작성자">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">시작일</label>
                                    <input type="date" class="form-control" id="startDate" name="startDate">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">종료일</label>
                                    <input type="date" class="form-control" id="endDate" name="endDate">
                                </div>
                                <div class="col-md-2">
                                    <button type="button" class="btn btn-primary w-100" onclick="searchNotices()">검색</button>
                                </div>
                            </form>
                        </div>
                        <!-- 데이터 테이블 -->
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>번호</th>
                                    <th style="width: 40%">제목</th>
                                    <th>작성자</th>
                                    <th>작성일</th>
                                    <th>조회수</th>
                                    <th>관리</th>
                                </tr>
                                </thead>
                                <tbody id="noticeTableBody">
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
function loadNoticeList() {
    var params = {
        title: $('input[name=title]').val(),
        author: $('input[name=author]').val(),
        startDate: $('input[name=startDate]').val(),
        endDate: $('input[name=endDate]').val()
    };
    $.ajax({
        url: "${pageContext.request.contextPath}/notice/list",
        method: "GET",
        data: params,
        dataType: "json",
        success: function(data) {
            var html = "";
            if(data.length === 0) {
                html = "<tr><td colspan='6'>검색 결과가 없습니다.</td></tr>";
            } else {
                $.each(data, function(i, n) {
                    html += "<tr>";
                    html += "<td>" + (n.postId || '') + "</td>";
                    html += "<td class='text-start'>";
                    html += "<a href='${pageContext.request.contextPath}/notice/view.do?postId=" + n.postId + "'>";
                    html += n.title;
                    html += "</a>";
                    html += "</td>";
                    html += "<td>" + (n.authorName || n.author || '') + "</td>";
                    html += "<td>" + (n.createdAt ? new Date(n.createdAt).toLocaleDateString() : '') + "</td>";
                    html += "<td>" + (n.viewCount || '0') + "</td>";
                    html += "<td>";
                    html += "<button class='btn btn-outline-primary btn-sm btn-edit-notice me-1' data-id='" + (n.postId || '') + "'>수정</button>";
                    html += "<button class='btn btn-outline-danger btn-sm btn-delete-notice' data-id='" + (n.postId || '') + "'>삭제</button>";
                    html += "</td>";
                    html += "</tr>";
                });
            }
            $("#noticeTableBody").html(html);
        }
    });
}

$(function() {
    loadNoticeList();

    $('#btnWriteNotice').on('click', function() {
        window.location.href = "${pageContext.request.contextPath}/notice/write.do";
    });

    // 검색 버튼 클릭
    $('#btnSearch').on('click', function() {
        loadNoticeList();
    });

    // 수정 버튼 클릭
    $('#noticeTableBody').on('click', '.btn-edit-notice', function() {
        var postId = $(this).data('id');
        if (!postId) {
            alert('게시물 ID가 없습니다!');
            return;
        }
        window.location.href = "${pageContext.request.contextPath}/notice/edit.do?postId=" + postId;
    });

    // 삭제 버튼 클릭
    $('#noticeTableBody').on('click', '.btn-delete-notice', function() {
        if(confirm('정말 삭제하시겠습니까?')) {
            var postId = $(this).data('id');
            $.ajax({
                url: "${pageContext.request.contextPath}/notice/delete/" + postId,
                method: "DELETE",
                success: function(res) {
                    if(res > 0) {
                        alert('삭제되었습니다.');
                        loadNoticeList();
                    } else {
                        alert('삭제에 실패했습니다.');
                    }
                }
            });
        }
    });
});

function searchNotices() {
    const formData = {
        title: $('#title').val(),
        author: $('#author').val(),
        startDate: $('#startDate').val(),
        endDate: $('#endDate').val()
    };

    $.ajax({
        url: '${pageContext.request.contextPath}/notice/list',
        type: 'GET',
        data: formData,
        success: function(data) {
            displayNotices(data);
        },
        error: function(xhr, status, error) {
            console.error('Error searching notices:', error);
        }
    });
}

function displayNotices(notices) {
    const tbody = $('#noticeTableBody');
    tbody.empty();

    if (notices.length === 0) {
        tbody.append('<tr><td colspan="6" class="text-center">등록된 공지사항이 없습니다.</td></tr>');
        return;
    }

    notices.forEach(function(notice) {
        const row = $('<tr>');
        row.append($('<td>').text(notice.postId));
        
        const titleCell = $('<td class="text-start">');
        const titleLink = $('<a>')
            .attr('href', '${pageContext.request.contextPath}/notice/view.do?postId=' + notice.postId)
            .addClass('text-primary text-decoration-none')
            .text(notice.title);
        titleCell.append(titleLink);
        row.append(titleCell);
        
        row.append($('<td>').text(notice.authorName || notice.author));
        row.append($('<td>').text(formatDate(notice.createdAt)));
        row.append($('<td>').text(notice.viewCount));
        
        const actionCell = $('<td>');
        actionCell.append(
            $('<button>')
                .addClass('btn btn-outline-primary btn-sm btn-edit-notice me-1')
                .attr('data-id', notice.postId)
                .text('수정')
        );
        actionCell.append(
            $('<button>')
                .addClass('btn btn-outline-danger btn-sm btn-delete-notice')
                .attr('data-id', notice.postId)
                .text('삭제')
        );
        row.append(actionCell);
        
        tbody.append(row);
    });
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.getFullYear() + '-' + 
           String(date.getMonth() + 1).padStart(2, '0') + '-' + 
           String(date.getDate()).padStart(2, '0');
}
</script>
</body>
</html> 