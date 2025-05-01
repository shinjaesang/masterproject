<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <style>
        .container { max-width: 400px; margin: 60px auto; background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); padding: 32px; }
        .form-label { font-weight: 500; }
        .btn-primary { width: 100%; }
        .input-group-text { cursor: pointer; }
    </style>
</head>
<body>
<div class="container">
    <h4 class="mb-4 text-center">비밀번호 변경</h4>
    <form id="pwChangeForm">
        <div class="mb-3">
            <label for="currentPwd" class="form-label">현재 비밀번호</label>
            <div class="input-group">
                <input type="password" class="form-control" id="currentPwd" name="currentPwd" required>
                <span class="input-group-text" onclick="togglePassword('currentPwd', this)"><i class="fa fa-eye"></i></span>
            </div>
        </div>
        <div class="mb-3">
            <label for="newPwd" class="form-label">새 비밀번호</label>
            <div class="input-group">
                <input type="password" class="form-control" id="newPwd" name="newPwd" required>
                <span class="input-group-text" onclick="togglePassword('newPwd', this)"><i class="fa fa-eye"></i></span>
            </div>
        </div>
        <div class="mb-3">
            <label for="confirmPwd" class="form-label">새 비밀번호 확인</label>
            <div class="input-group">
                <input type="password" class="form-control" id="confirmPwd" name="confirmPwd" required>
                <span class="input-group-text" onclick="togglePassword('confirmPwd', this)"><i class="fa fa-eye"></i></span>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">변경</button>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function togglePassword(inputId, el) {
        const input = document.getElementById(inputId);
        const icon = el.querySelector('i');
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
    $(function() {
        $('#pwChangeForm').on('submit', function(e) {
            e.preventDefault();
            const currentPwd = $('#currentPwd').val();
            const newPwd = $('#newPwd').val();
            const confirmPwd = $('#confirmPwd').val();
            if (!currentPwd || !newPwd || !confirmPwd) {
                alert('모든 항목을 입력해주세요.');
                return;
            }
            if (newPwd !== confirmPwd) {
                alert('새 비밀번호가 일치하지 않습니다.');
                return;
            }
            $.ajax({
                url: '${pageContext.request.contextPath}/member/changePassword.do',
                type: 'POST',
                dataType: 'text',
                data: {
                    currentPwd: currentPwd,
                    newPwd: newPwd
                },
                success: function(response) {
                    if (response === 'success') {
                        alert('비밀번호가 변경되었습니다.');
                        window.location.href = '${pageContext.request.contextPath}/member/mypage.do?empId=${sessionScope.loginUser.empId}';
                    } else {
                        alert(response.replace('fail:', ''));
                    }
                },
                error: function() {
                    alert('비밀번호 변경 중 오류가 발생했습니다.');
                }
            });
        });
    });
</script>
</body>
</html> 