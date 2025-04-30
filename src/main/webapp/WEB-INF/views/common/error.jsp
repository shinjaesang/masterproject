<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%-- isErrorPage="true" : 다른 jsp 페이지의 에러를 넘겨받아서 에러 출력 처리용 페이지에 사용하는 속성임 
	반드시 표기해야 함
	이 속성이 있어야, jsp 내장객체 중 exception 객체 사용할 수 있음
--%>    
<%-- <%@ taglib uri="https://jakarta.ee/jsp/jstl/core" prefix="c" %> --%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재고마스터 - 오류</title>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f0f0f0;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .error-container {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            max-width: 500px;
            width: 90%;
        }

        .error-icon {
            font-size: 4rem;
            color: #e74a3b;
            margin-bottom: 1.5rem;
        }

        .error-title {
            color: #343a40;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }

        .error-message {
            color: #666;
            margin-bottom: 2rem;
            line-height: 1.6;
            font-size: 1.1rem;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 1rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 0.8rem 1.5rem;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <div class="error-container">
        <i class="fas fa-exclamation-circle error-icon"></i>
        <h2 class="error-title">오류가 발생했습니다</h2>
        
        <div class="error-message">
            <c:set var="e" value="<%= exception %>" />
            <c:choose>
                <c:when test="${!empty e}">
                    <p>${e.message}</p>
                </c:when>
                <c:when test="${!empty requestScope.message}">
                    <p>${requestScope.message}</p>
                </c:when>
                <c:otherwise>
                    <p>알 수 없는 오류가 발생했습니다. 다시 시도해주세요.</p>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="button-container">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                <i class="fas fa-home"></i>메인으로
            </a>
            <a href="javascript:history.back()" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i>이전으로
            </a>
        </div>
    </div>
</body>
</html>