<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>Stockmaster - 문서 상세조회</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
        }
        body {
            font-family: 'Heebo', '맑은 고딕', 'Malgun Gothic', Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 0;
            margin: 0;
            min-height: 100vh;
        }
        .main-wrap {
            max-width: 900px;
            margin: 30px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 0 16px rgba(0,0,0,0.08);
            padding: 32px 32px 24px 32px;
            overflow-y: auto;
        }
        .doc-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 12px;
            margin-bottom: 24px;
        }
        .doc-table th, .doc-table td {
            background: #f6f8fa;
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 1rem;
        }
        .doc-table th {
            width: 140px;
            color: #555;
            font-weight: 600;
            background: #e9ecef;
        }
        .status-badge {
            padding: 5px 12px;
            border-radius: 4px;
            font-size: 0.95em;
            font-weight: 500;
        }
        .status-waiting { background-color: #ffc107; color: #000; }
        .status-approved { background-color: #28a745; color: #fff; }
        .status-rejected { background-color: #dc3545; color: #fff; }
        .status-recalled { background-color: #6c757d; color: #fff; }
        .content-area {
            margin-bottom: 24px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            min-height: 120px;
        }
        .attach-list {
            margin-top: 10px;
            padding: 12px 16px;
            background: #f6f8fa;
            border-radius: 8px;
        }
        .button-area {
            margin-top: 16px;
            text-align: right;
        }
        .button-area .btn {
            min-width: 90px;
            margin-left: 8px;
        }
        @media (max-width: 1000px) {
            .main-wrap { max-width: 99vw; padding: 10px; }
            .doc-table th, .doc-table td { font-size: 0.95rem; padding: 8px 6px; }
        }
    </style>
</head>
<body>
    <div class="main-wrap">
        <h2 class="mb-4" style="font-weight:700;">문서 상세</h2>
        <table class="doc-table">
            <tr>
                <th>문서 번호</th>
                <td>${document.docId}</td>
            </tr>
            <tr>
                <th>제목</th>
                <td>${document.title}</td>
            </tr>
            <tr>
                <th>문서 유형</th>
                <td>${document.documentFormat}</td>
            </tr>
            <tr>
                <th>기안자</th>
                <td>${document.department} / ${document.job} / ${document.empName}</td>
                <th>기안일자</th>
                <td><fmt:formatDate value="${document.draftDate}" pattern="yyyy-MM-dd"/></td>
            </tr>
            <tr>
                <th>검토자</th>
                <td>
                    검토자 수: ${fn:length(document.reviewers)}<br/>
                    <c:forEach items="${document.reviewers}" var="reviewer">
                        <div>
                            ${reviewer.department} / ${reviewer.job} / ${reviewer.empName}
                        </div>
                    </c:forEach>
                   
                </td>
                <th>검토일자</th>
                <td>
                    <c:choose>
                        <c:when test="${empty document.reviewDate}">미처리</c:when>
                        <c:otherwise><fmt:formatDate value="${document.reviewDate}" pattern="yyyy-MM-dd"/></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>결재자</th>
                <td>
                    결재자 수: ${fn:length(document.approvers)}<br/>
                    <c:forEach items="${document.approvers}" var="approver">
                        <div>
                            ${approver.department} / ${approver.job} / ${approver.empName}
                        </div>
                    </c:forEach>
                    
                </td>
                <th>결재일자</th>
                <td>
                    <c:choose>
                        <c:when test="${empty document.approvalDate}">미처리</c:when>
                        <c:otherwise><fmt:formatDate value="${document.approvalDate}" pattern="yyyy-MM-dd"/></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>참조자</th>
                <td colspan="3">
                    참조자 수: ${fn:length(document.references)}
                    <button type="button" class="btn btn-sm btn-outline-primary float-end" onclick="openReferenceEditModal()">편집</button><br/>
                    <c:forEach items="${document.references}" var="ref">
                        <div>
                            ${ref.department} / ${ref.job} / ${ref.empName}
                        </div>
                    </c:forEach>
                </td>
            </tr>
            <tr>
                <th>문서상태</th>
                <td>
                    <c:choose>
                        <c:when test="${document.approvalStatus eq '발송'}">
                            <span class="status-badge status-waiting">발송</span>
                        </c:when>
                        <c:when test="${document.approvalStatus eq '결재대기'}">
                            <span class="status-badge status-waiting">결재대기</span>
                        </c:when>
                        <c:when test="${document.approvalStatus eq '승인'}">
                            <span class="status-badge status-approved">승인</span>
                        </c:when>
                        <c:when test="${document.approvalStatus eq '반려'}">
                            <span class="status-badge status-rejected">반려</span>
                        </c:when>
                        <c:when test="${document.approvalStatus eq '회수'}">
                            <span class="status-badge status-recalled">회수</span>
                        </c:when>
                    </c:choose>
                </td>
            </tr>
        </table>
        <div class="content-area">
            <h5 style="font-weight:600;">내용</h5>
            <div style="white-space:pre-line;">${document.content}</div>
        </div>
        <div class="attach-list">
            <h6 style="font-weight:600;">첨부파일</h6>
            <c:choose>
                <c:when test="${empty attachments}">
                    <span>첨부된 파일이 없습니다.</span>
                </c:when>
                <c:otherwise>
                    <ul style="margin:0; padding-left:18px;">
                        <c:forEach items="${attachments}" var="file">
                            <li>
                                <a href="${pageContext.request.contextPath}/document/download/${file.fileId}">
                                    ${file.originalFileName}
                                </a>
                                <span style="color:#888; font-size:0.95em;">(${file.fileSize} bytes)</span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="button-area">
            <button class="btn btn-secondary" onclick="window.close()">닫기</button>
            <c:if test="${document.approvalStatus eq '발송'}">
                <a href="${pageContext.request.contextPath}/document/update/${document.docId}" class="btn btn-primary">수정</a>
                <button class="btn btn-warning" onclick="recallDocument('${document.docId}')">회수</button>
            </c:if>
        </div>
    </div>
    <!-- 참조자 편집 모달 -->
    <div class="modal fade" id="referenceEditModal" tabindex="-1" aria-labelledby="referenceEditModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="referenceEditModalLabel">참조자 편집</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <!-- 추후 구현: 참조자 목록 수정 폼 -->
            <p>참조자 수정 기능은 추후 구현 예정입니다.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-primary" disabled>저장</button>
          </div>
        </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // 창 크기 자동 조정 (팝업일 경우)
        window.onload = function() {
            if(window.outerWidth < 900 || window.outerHeight < 700) {
                window.resizeTo(950, 800);
            }
        }
        function recallDocument(docId) {
            if (confirm('문서를 회수하시겠습니까?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/document/recall/' + docId,
                    type: 'POST',
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            window.location.reload();
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert('문서 회수 중 오류가 발생했습니다.');
                    }
                });
            }
        }
        function openReferenceEditModal() {
            var modal = new bootstrap.Modal(document.getElementById('referenceEditModal'));
            modal.show();
        }
    </script>
</body>
</html>