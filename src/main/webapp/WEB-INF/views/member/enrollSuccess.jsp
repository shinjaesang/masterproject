<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 등록 완료</title>
<style>
    body {
        font-family: '맑은 고딕', sans-serif;
        background-color: #f9f9f9;
    }
    .container {
        width: 600px;
        margin: 100px auto;
        background-color: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        text-align: center;
    }
    h2 {
        color: #333;
        margin-bottom: 30px;
    }
    .success-message {
        color: #28a745;
        font-size: 18px;
        margin-bottom: 30px;
    }
    .btn-group {
        margin-top: 30px;
    }
    .btn {
        display: inline-block;
        padding: 10px 20px;
        margin: 0 10px;
        border-radius: 5px;
        text-decoration: none;
        font-weight: bold;
        cursor: pointer;
    }
    .btn-login {
        background-color: #007bff;
        color: white;
    }
    .btn-main {
        background-color: #6c757d;
        color: white;
    }
    .btn:hover {
        opacity: 0.9;
    }
</style>
</head>
<body>

<div class="container">
    <h2>사용자 등록 완료</h2>
    <div class="success-message">
        ${message}
    </div>
    <div class="btn-group">
        <a href="loginPage.do" class="btn btn-login">로그인 페이지로 이동</a>
        <a href="../common/main.do" class="btn btn-main">메인 페이지로 이동</a>
    </div>
</div>

</body>
</html> 