<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>stockmaster - 사용자 관리</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .member-title { font-size: 2rem; font-weight: bold; margin-bottom: 1.5rem; }
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
                            <h4 class="mb-0">사용자 관리</h4>
                            <button class="btn btn-success" type="button" onclick="location.href='${pageContext.request.contextPath}/member/enrollPage.do'">
                                <i class="fa fa-plus me-1"></i>신규 사용자 등록
                            </button>
                        </div>
                        <!-- 검색 필터 -->
                        <div class="filter-section mb-3">
                            <form class="row g-2 align-items-end" id="searchForm">
                                <div class="col-md-3">
                                    <label class="form-label">이름/사번</label>
                                    <input type="text" class="form-control" name="keyword" placeholder="이름, 사번, 부서명 검색">
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">부서</label>
                                    <select class="form-select" name="department">
                                        <option value="">부서 선택</option>
                                        <option value="대리">대리</option>
                                        <option value="과장">과장</option>
                                        <option value="사원">사원</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">직급</label>
                                    <select class="form-select" name="job">
                                        <option value="">직급 선택</option>
                                        <option value="대리">대리</option>
                                        <option value="과장">과장</option>
                                        <option value="사원">사원</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">상태</label>
                                    <select class="form-select" name="status">
                                        <option value="">상태 선택</option>
                                        <option value="활성">활성</option>
                                        <option value="대기">대기</option>
                                    </select>
                                </div>
                                <div class="col-md-3 text-end">
                                    <button class="btn btn-primary w-100" type="button" onclick="alert('검색 기능 구현 예정')">검색</button>
                                </div>
                            </form>
                        </div>
                        <!-- 데이터 테이블 -->
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th><input type="checkbox"></th>
                                    <th>이름</th>
                                    <th>사원번호</th>
                                    <th>부서</th>
                                    <th>이메일</th>
                                    <th>입사일</th>
                                    <th>상태</th>
                                    <th>관리</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${memberList}" var="member">
                                    <tr>
                                        <td><input type="checkbox" name="selectedMembers" value="${member.empId}"></td>
                                        <td>${member.empName}</td>
                                        <td>${member.empId}</td>
                                        <td>${member.department}</td>
                                        <td>${member.email}</td>
                                        <td><fmt:formatDate value="${member.hireDate}" pattern="yyyy-MM-dd"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${member.isActive eq 'Y'}">활성</c:when>
                                                <c:otherwise>대기</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button class="btn btn-outline-primary btn-sm" onclick="alert('수정 기능 구현 예정')">수정</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty memberList}">
                                    <tr>
                                        <td colspan="8" class="text-center">조회된 사용자가 없습니다.</td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                        <!-- 총 사용자 수 -->
                        <div class="mt-3">총 사용자 수 : ${totalCount}</div>
                        <!-- 페이지네이션 -->
                        <div class="mt-4">
                            <c:import url="/WEB-INF/views/common/pagingView.jsp" />
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
</body>
</html>
