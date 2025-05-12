<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
    <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
        <h2 class="text-primary mb-0"><i class="fa fa-warehouse"></i></h2>
    </a>
    <a href="#" class="sidebar-toggler flex-shrink-0">
        <i class="fa fa-bars"></i>
    </a>
    <form class="d-none d-md-flex ms-4">
        <input class="form-control border-0" type="search" placeholder="제품 또는 주문 검색">
    </form>
    <div class="navbar-nav align-items-center ms-auto">
        <c:choose>
            <c:when test="${not empty loginUser}">
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                        <i class="fa fa-user me-2"></i>${loginUser.empName}님
                    </a>
                    <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                        <a href="${pageContext.request.contextPath}/member/mypage.do?empId=${loginUser.empId}" class="dropdown-item">내 정보</a>
                        <a href="${pageContext.request.contextPath}/member/logout.do" class="dropdown-item">로그아웃</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="nav-item">
                    <a href="${pageContext.request.contextPath}/member/loginPage.do" class="nav-link">
                        <i class="fa fa-sign-in-alt me-2"></i>로그인
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</nav> 