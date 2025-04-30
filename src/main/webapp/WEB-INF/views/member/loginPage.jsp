<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            width: 360px;
        }
        .login-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .role-buttons {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
            gap: 10px;
        }
        .role-buttons button {
            flex: 1;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #007bff;
            background-color: #ffffff;
            color: #007bff;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }
        .role-buttons button.active,
        .role-buttons button:hover {
            background-color: #007bff;
            color: #ffffff;
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 12px 16px;
            margin: 8px 0 20px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
        }
        .login-container button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            border: none;
            color: white;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }
        .login-container button[type="submit"]:hover {
            background-color: #0056b3;
        }
        .login-container .bottom-link {
            margin-top: 16px;
            text-align: center;
        }
        .login-container .bottom-link a {
            color: #007bff;
            text-decoration: none;
            display: block;
            margin: 8px 0;
        }
        .login-container .bottom-link a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function selectRole(role) {
            document.getElementById('userRole').value = role;

            // 버튼 스타일 변경
            const buttons = document.querySelectorAll('.role-buttons button');
            buttons.forEach(btn => btn.classList.remove('active'));

            if(role === 'admin') {
                document.getElementById('adminBtn').classList.add('active');
            } else if(role === 'employee') {
                document.getElementById('employeeBtn').classList.add('active');
            }
        }
    </script>
</head>
<body>
    <div class="login-container">
        <h2>로그인</h2>
        <div class="role-buttons">
            <button type="button" id="adminBtn" onclick="selectRole('admin')">관리자</button>
            <button type="button" id="employeeBtn" onclick="selectRole('employee')">사원</button>
        </div>
        <form action="login.do" method="post">
            <input type="hidden" id="userRole" name="userRole" value="employee">
            <input type="text" name="empId" placeholder="아이디" required>
            <input type="password" name="empPwd" placeholder="비밀번호" required>
            <div class="mb-3">
                <button type="submit" class="btn btn-primary w-100">로그인</button>
            </div>
            <div class="form-text">
                <a href="${pageContext.request.contextPath}/member/findPassword.do">비밀번호를 잊으셨나요?</a>
            </div>
        </form>
    </div>
</body>
</html>
