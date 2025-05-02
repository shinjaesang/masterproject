<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 공지사항 상세</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .notice-title { font-size: 2rem; font-weight: bold; margin-bottom: 1.5rem; }
        .notice-info { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .notice-content { min-height: 300px; padding: 20px; border: 1px solid #dee2e6; border-radius: 5px; }
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
                            <h4 class="mb-0">공지사항 상세</h4>
                            <button class="btn btn-secondary" type="button" onclick="history.back()">목록으로</button>
                        </div>
                        <div class="notice-info">
                            <div class="row">
                                <div class="col-md-8">
                                    <h5 class="mb-3">${notice.title}</h5>
                                </div>
                                <div class="col-md-4 text-end">
                                    <small class="text-muted">
                                        조회수: ${notice.viewCount}
                                    </small>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <small class="text-muted">
                                        작성자: ${notice.authorName} (${notice.author})
                                    </small>
                                </div>
                                <div class="col-md-6 text-end">
                                    <small class="text-muted">
                                        작성일: <fmt:formatDate value="${notice.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </small>
                                </div>
                            </div>
                        </div>
                        <div class="notice-content mb-4">
                            ${notice.content}
                        </div>
                        <c:if test="${not empty notice.attachedFile}">
                            <div class="mb-4">
                                <h6>첨부파일</h6>
                                <div class="border rounded p-2">
                                    <i class="fas fa-paperclip me-2"></i>
                                    <a href="${pageContext.request.contextPath}/notice/download/${notice.postId}" class="text-decoration-none">
                                        첨부파일 다운로드
                                    </a>
                                </div>
                            </div>
                        </c:if>
                        <div class="text-center">
                            <c:if test="${sessionScope.loginUser.empId eq notice.author}">
                                <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/notice/edit.do?postId=${notice.postId}'">수정</button>
                                <button type="button" class="btn btn-danger" onclick="deleteNotice()">삭제</button>
                            </c:if>
                            <button type="button" class="btn btn-secondary" onclick="history.back()">목록</button>
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
function deleteNotice() {
    if(confirm('정말 삭제하시겠습니까?')) {
        $.ajax({
            url: "${pageContext.request.contextPath}/notice/delete/${notice.postId}",
            method: "DELETE",
            success: function(res) {
                if(res > 0) {
                    alert('삭제되었습니다.');
                    window.location.href = "${pageContext.request.contextPath}/notice/list.do";
                } else {
                    alert('삭제에 실패했습니다.');
                }
            }
        });
    }
}
</script>
</body>
</html> 