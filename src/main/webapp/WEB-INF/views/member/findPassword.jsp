<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .login-title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }
        .form-control {
            height: 45px;
            border-radius: 5px;
        }
        .btn-primary {
            height: 45px;
            border-radius: 5px;
            font-weight: 500;
        }
        .form-text {
            text-align: center;
            margin-top: 20px;
        }
        .form-text a {
            color: #007bff;
            text-decoration: none;
        }
        .form-text a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container-fluid position-relative bg-white d-flex p-0">
    <div class="container-fluid">
        <div class="row h-100 align-items-center justify-content-center">
            <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                <div class="login-container">
                    <h3 class="login-title">비밀번호 찾기</h3>
                    <form action="${pageContext.request.contextPath}/member/findPassword.do" method="post">
                        <div class="mb-3">
                            <label for="empId" class="form-label">사원번호</label>
                            <input type="text" class="form-control" id="empId" name="empId" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <button type="submit" class="btn btn-primary w-100">비밀번호 찾기</button>
                        </div>
                        <div class="form-text">
                            <a href="${pageContext.request.contextPath}/member/loginPage.do">로그인 페이지로 돌아가기</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html>
