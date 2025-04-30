<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>창고 상세 정보</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>창고 상세 정보</h2>
        <table class="table table-bordered mt-3">
            <tr>
                <th>창고 ID</th>
                <td>${warehouse.warehouseId}</td>
            </tr>
            <tr>
                <th>창고명</th>
                <td>${warehouse.warehouseName}</td>
            </tr>
            <tr>
                <th>유형</th>
                <td>${warehouse.warehouseType}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td>${warehouse.warehouseAddress}</td>
            </tr>
            <tr>
                <th>면적</th>
                <td>${warehouse.warehouseArea} ㎡</td>
            </tr>
            <tr>
                <th>담당자 ID</th>
                <td>${warehouse.empid}</td>
            </tr>
            <tr>
                <th>담당자 이름</th>
                <td>${warehouse.managerName}</td>
            </tr>
            <tr>
                <th>연락처</th>
                <td>${warehouse.contactInfo}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${warehouse.email}</td>
            </tr>
        </table>
        <a href="warehouse.do" class="btn btn-secondary">목록으로</a>
        <a href="edit.do?warehouseId=${warehouse.warehouseId}" class="btn btn-primary">수정</a>
    </div>
</body>
</html> 