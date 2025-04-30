<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 거래처 목록</title>
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
            <div class="partner-title mb-4">거래처 목록</div>
            <!-- 검색 필터 -->
            <div class="filter-section mb-3">
                <form class="row g-2 align-items-end" id="searchForm">
                    <div class="col-md-2">
                        <label class="form-label">거래처</label>
                        <select class="form-select" name="partnerGroup">
                            <option value="">거래처그룹</option>
                            <option>그룹A</option>
                            <option>그룹B</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">거래처유형</label>
                        <select class="form-select" name="partnerType">
                            <option value="">전체</option>
                            <option>공급처</option>
                            <option>판매처</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">검색조건</label>
                        <select class="form-select" name="searchCondition">
                            <option value="">검색</option>
                            <option>거래처명</option>
                            <option>담당자</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">검색어</label>
                        <div class="d-flex align-items-end gap-3" style="flex-wrap: nowrap;">
                            <input type="text" class="form-control" name="searchKeyword" placeholder="검색어를 입력해 주세요.">
                            <button class="btn btn-primary btn-md px-4" style="min-width: 80px; white-space: nowrap;" type="button">검색</button>
                            <button class="btn btn-black btn-md px-4 ms-1" style="min-width: 80px; white-space: nowrap;" type="button">다운로드</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="mb-2">
                <button class="btn btn-gray" type="button"><a href="${pageContext.request.contextPath}/partner/register.do" class="text-primary">거래처 등록</a></button>
            </div>
            <!-- 데이터 테이블 -->
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>수정</th>
                        <th>거래처 코드</th>
                        <th>거래처명</th>
                        <th>거래처 담당자</th>
                        <th>거래처 담당 연락처</th>
                        <th>지역</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><a href="${pageContext.request.contextPath}/partner/edit.do" class="text-primary">수정</a></td>
                        <td>10019</td>
                        <td>하이닉스</td>
                        <td>김닉스</td>
                        <td>010-3541-1231</td>
                        <td>서울</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!-- 페이징 -->
            <div class="d-flex justify-content-center align-items-center mt-3">
                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item disabled"><a class="page-link" href="#"><<</a></li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item disabled"><a class="page-link" href="#">/ 1</a></li>
                        <li class="page-item disabled"><a class="page-link" href="#">>></a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <!-- Content End -->
</div>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html>