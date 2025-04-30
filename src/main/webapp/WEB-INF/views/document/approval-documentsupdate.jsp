<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기안문서 수정</title>
<link rel="stylesheet" href="/resources/css/approval.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="approval-container">
        <h2>기안문서 수정</h2>
        
        <form action="/approval/updateDocument" method="post" id="documentForm">
            <input type="hidden" name="documentId" value="${document.documentId}">
            
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" value="${document.title}" required>
            </div>
            
            <div class="form-group">
                <label for="documentType">문서 종류</label>
                <select id="documentType" name="documentType">
                    <option value="EXPENSE" ${document.documentType == 'EXPENSE' ? 'selected' : ''}>지출결의서</option>
                    <option value="VACATION" ${document.documentType == 'VACATION' ? 'selected' : ''}>휴가신청서</option>
                    <option value="REPORT" ${document.documentType == 'REPORT' ? 'selected' : ''}>보고서</option>
                    <option value="CONTRACT" ${document.documentType == 'CONTRACT' ? 'selected' : ''}>계약서</option>
                    <option value="STOCK_IN" ${document.documentType == 'STOCK_IN' ? 'selected' : ''}>입고신청서</option>
                    <option value="STOCK_OUT" ${document.documentType == 'STOCK_OUT' ? 'selected' : ''}>출고신청서</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" rows="10" required>${document.content}</textarea>
            </div>
            
            <div class="form-group">
                <label>결재선</label>
                <div class="approver-list">
                    <c:forEach items="${approvers}" var="approver" varStatus="status">
                        <div class="approver-item">
                            <input type="hidden" name="approverIds" value="${approver.employeeId}">
                            <span>${approver.name} (${approver.position})</span>
                            <button type="button" class="remove-approver">삭제</button>
                        </div>
                    </c:forEach>
                </div>
                <button type="button" id="addApprover">결재자 추가</button>
            </div>
            
            <div class="form-group">
                <label>첨부파일</label>
                <input type="file" name="attachments" multiple>
                <div class="current-files">
                    <c:forEach items="${attachments}" var="file">
                        <div class="file-item">
                            ${file.originalName}
                            <button type="button" class="remove-file" data-file-id="${file.fileId}">삭제</button>
                        </div>
                    </c:forEach>
                </div>
            </div>
            
            <div class="button-group">
                <button type="submit" class="submit-btn">수정하기</button>
                <button type="button" class="cancel-btn" onclick="history.back()">취소</button>
            </div>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            // 결재자 삭제
            $('.remove-approver').click(function() {
                $(this).closest('.approver-item').remove();
            });
            
            // 결재자 추가 모달 열기
            $('#addApprover').click(function() {
                // 결재자 검색 및 추가 모달 표시 로직
                openApproverModal();
            });
            
            // 파일 삭제
            $('.remove-file').click(function() {
                const fileId = $(this).data('file-id');
                if(confirm('파일을 삭제하시겠습니까?')) {
                    $.ajax({
                        url: '/approval/removeFile/' + fileId,
                        type: 'POST',
                        success: function(response) {
                            if(response.success) {
                                $(this).closest('.file-item').remove();
                            }
                        }
                    });
                }
            });
            
            // 폼 제출 전 유효성 검사
            $('#documentForm').submit(function(e) {
                if($('#title').val().trim() === '') {
                    alert('제목을 입력해주세요.');
                    e.preventDefault();
                    return;
                }
                
                if($('#content').val().trim() === '') {
                    alert('내용을 입력해주세요.');
                    e.preventDefault();
                    return;
                }
                
                if($('.approver-item').length === 0) {
                    alert('최소 한 명의 결재자를 지정해주세요.');
                    e.preventDefault();
                    return;
                }
            });
        });
        
        function openApproverModal() {
            // 결재자 검색 모달 구현
            // 모달에서 사용자 검색 및 선택 기능 구현
        }
    </script>
</body>
</html>