<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 공지사항 등록</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .notice-title { font-size: 2rem; font-weight: bold; margin-bottom: 1.5rem; }
        .form-section { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .ck-editor__editable { min-height: 300px; }
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
                            <h4 class="mb-0">공지사항 등록</h4>
                            <button class="btn btn-secondary" type="button" onclick="history.back()">목록으로</button>
                        </div>
                        <form id="noticeForm" method="post" action="${pageContext.request.contextPath}/notice/write.do">
                            <div class="form-section">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label class="form-label">제목</label>
                                        <input type="text" class="form-control" name="title" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">내용</label>
                                        <textarea id="content" name="content" required></textarea>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">작성자</label>
                                        <input type="text" class="form-control" name="author" value="${sessionScope.loginUser.empId}" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center">
                                <button type="button" id="btnSubmit" class="btn btn-primary">등록</button>
                                <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                            </div>
                        </form>
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
<!-- CKEditor 5 -->
<script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>
<script>
let editor;

$(function() {
    // CKEditor 초기화
    ClassicEditor
        .create(document.querySelector('#content'), {
            toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|', 'outdent', 'indent'],
            language: 'ko'
        })
        .then(newEditor => {
            editor = newEditor;
            console.log('Editor was initialized');
        })
        .catch(error => {
            console.error('There was a problem initializing the editor:', error);
        });

    // 등록 버튼 클릭 이벤트
    $('#btnSubmit').on('click', function() {
        // 필수 입력값 검사
        var title = $('input[name=title]').val().trim();
        var content = editor.getData().trim();
        
        if (!title) {
            alert('제목을 입력해주세요.');
            return;
        }
        
        if (!content) {
            alert('내용을 입력해주세요.');
            return;
        }
        
        // CKEditor 내용을 textarea에 설정
        $('#content').val(content);
        
        // 폼 제출
        var form = $('#noticeForm');
        form.attr('method', 'post');
        form.attr('action', '${pageContext.request.contextPath}/notice/write.do');
        form.submit();
    });
});
</script>
</body>
</html> 