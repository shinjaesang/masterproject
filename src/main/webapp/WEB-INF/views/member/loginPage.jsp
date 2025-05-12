<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
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
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }
        .input-group input {
            width: 100%;
            padding: 12px 16px;
            padding-right: 40px; /* 아이콘을 위한 공간 */
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .input-group .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666;
            padding: 4px;
            background: none;
            border: none;
            outline: none;
        }
        .input-group .toggle-password:hover {
            color: #007bff;
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
            margin-top: 10px;
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

        function togglePassword(inputId, button) {
            const input = document.getElementById(inputId);
            const icon = button.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
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
            <div class="input-group">
                <input type="text" name="empId" placeholder="아이디" required>
            </div>
            <div class="input-group">
                <input type="password" name="empPwd" id="empPwd" placeholder="비밀번호" required>
                <button type="button" class="toggle-password" onclick="togglePassword('empPwd', this)">
                    <i class="fa fa-eye"></i>
                </button>
            </div>
            <button type="submit">로그인</button>
            <div class="bottom-link">
                <a href="${pageContext.request.contextPath}/member/findPassword.do">비밀번호를 잊으셨나요?</a>
            </div>
        </form>
    </div>
</body>
</html>
