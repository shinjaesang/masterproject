<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
 
 <c:set var="paging" value="${ requestScope.paging }" />
 <%-- 검색 조건이 있을 때 쿼리스트링에 추가 --%>
 <c:set var="queryParams" value="" />
 <c:if test="${not empty startDate}">
     <c:set var="queryParams" value="${queryParams}&startDate=${startDate}" />
 </c:if>
 <c:if test="${not empty endDate}">
     <c:set var="queryParams" value="${queryParams}&endDate=${endDate}" />
 </c:if>
 <c:if test="${not empty documentTitle}">
     <c:set var="queryParams" value="${queryParams}&documentTitle=${documentTitle}" />
 </c:if>
 <c:if test="${not empty documentType}">
     <c:set var="queryParams" value="${queryParams}&documentType=${documentType}" />
 </c:if>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<div class="d-flex justify-content-center mt-4">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <!-- 맨 처음 페이지 -->
            <li class="page-item <c:if test='${paging.currentPage == 1}'>disabled</c:if>'">
                <a class="page-link" href="${paging.urlMapping}?page=1${queryParams}" tabindex="-1">
                    &laquo;
                </a>
            </li>
            <!-- 이전 페이지 -->
            <li class="page-item <c:if test='${paging.currentPage == 1}'>disabled</c:if>'">
                <a class="page-link" href="${paging.urlMapping}?page=${paging.currentPage-1}${queryParams}" tabindex="-1">
                    &lt;
                </a>
            </li>
            <!-- 페이지 번호 -->
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                <c:choose>
                    <c:when test="${p == paging.currentPage}">
                        <li class="page-item active">
                            <a class="page-link" href="#">${p}</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="${paging.urlMapping}?page=${p}${queryParams}">${p}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <!-- 다음 페이지 -->
            <li class="page-item <c:if test='${paging.currentPage == paging.maxPage}'>disabled</c:if>'">
                <a class="page-link" href="${paging.urlMapping}?page=${paging.currentPage+1}${queryParams}">
                    &gt;
                </a>
            </li>
            <!-- 맨 끝 페이지 -->
            <li class="page-item <c:if test='${paging.currentPage == paging.maxPage}'>disabled</c:if>'">
                <a class="page-link" href="${paging.urlMapping}?page=${paging.maxPage}${queryParams}">
                    &raquo;
                </a>
            </li>
        </ul>
    </nav>
</div>

<style>
.pagination .page-item.active .page-link {
    background-color: #09f;
    color: #fff;
    border-color: #09f;
    font-weight: bold;
}
.pagination .page-link {
    color: #09f;
    border: 1px solid #09f;
    background: #fff;
}
.pagination .page-item.disabled .page-link {
    color: #ccc;
    border-color: #eee;
    background: #fff;
}
</style>
</body>
</html>