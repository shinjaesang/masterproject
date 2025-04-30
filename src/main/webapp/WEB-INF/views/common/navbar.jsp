<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <i class="fa fa-bell me-lg-2"></i>
                <span class="d-none d-lg-inline-flex">알림</span>
            </a>
            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                <a href="#" class="dropdown-item">
                    <h6 class="fw-normal mb-0">재고 부족: 제품 A</h6>
                    <small>15분 전</small>
                </a>
                <hr class="dropdown-divider">
                <a href="#" class="dropdown-item">
                    <h6 class="fw-normal mb-0">신규 주문 등록</h6>
                    <small>30분 전</small>
                </a>
                <hr class="dropdown-divider">
                <a href="#" class="dropdown-item text-center">모든 알림 보기</a>
            </div>
        </div>
        <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <img class="rounded-circle me-lg-2" src="${pageContext.request.contextPath}/resources/img/user.jpg" alt="User Profile" style="width: 40px; height: 40px;">
                <span class="d-none d-lg-inline-flex">재고마스터</span>
            </a>
            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                <a href="#" class="dropdown-item">내 프로필</a>
                <a href="#" class="dropdown-item">설정</a>
                <a href="#" class="dropdown-item">로그아웃</a>
            </div>
        </div>
    </div>
</nav> 