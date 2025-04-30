<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신규 사용자 등록</title>
<style>
    body {
        font-family: '맑은 고딕', sans-serif;
        background-color: #f9f9f9;
    }
    .container {
        width: 800px;
        margin: 30px auto;
        background-color: #fff;
        padding: 30px 40px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    h2 {
        text-align: center;
        margin-bottom: 30px;
    }
    table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 15px;
    }
    th {
        text-align: left;
        padding: 5px 10px;
        font-size: 15px;
        color: #333;
    }
    td {
        padding: 5px 10px;
    }
    input[type="text"],
    input[type="password"],
    select,
    input[type="date"] {
        width: 100%;
        padding: 8px 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        box-sizing: border-box;
    }
    .address-group input[type="text"] {
        width: 48%;
        display: inline-block;
    }
    .address-group input[type="text"]:first-child {
        margin-right: 4%;
    }
    .btn-submit {
        width: 200px;
        padding: 12px;
        font-size: 16px;
        margin: 30px auto 0;
        display: block;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
    }
    .btn-submit:hover {
        background-color: #0056b3;
    }
</style>
<script>
function checkEmail() {
    var email = document.getElementById("email").value;
    if (email == "") {
        alert("이메일을 입력하세요.");
        return false;
    }
    
    $.ajax({
        url: "emailchk.do",
        type: "post",
        data: { email: email },
        success: function(result) {
            if (result == "ok") {
                alert("사용 가능한 이메일입니다.");
            } else {
                alert("이미 사용 중인 이메일입니다.");
                document.getElementById("email").value = "";
                document.getElementById("email").focus();
            }
        },
        error: function() {
            alert("이메일 중복 검사 중 오류가 발생했습니다.");
        }
    });
}
</script>
</head>
<body>

<div class="container">
    <h2>신규 사용자 등록</h2>

    <form action="enrollUser.do" method="post">
        <table>
            <tr>
                <th>이름</th>
                <td><input type="text" name="empName" placeholder="이름 입력"></td>
                <th>사원번호</th>
                <td><input type="text" name="empId" placeholder="사원번호 입력"></td>
            </tr>
            <tr>
                <th>부서</th>
                <td>
                    <select name="department">
                        <option value="">부서 선택 ▼</option>
                        <option value="인사팀">인사팀</option>
                        <option value="총무팀">총무팀</option>
                        <option value="재무팀">재무팀</option>
                        <option value="영업팀">영업팀</option>
                        <option value="마케팅팀">마케팅팀</option>
                        <option value="개발팀">개발팀</option>
                        <option value="디자인팀">디자인팀</option>
                        <option value="품질관리팀">품질관리팀</option>
                    </select>
                </td>
                <th>직급</th>
                <td>
                    <select name="job">
                        <option value="">직급 선택 ▼</option>
                        <option value="사원">사원</option>
                        <option value="대리">대리</option>
                        <option value="과장">과장</option>
                        <option value="차장">차장</option>
                        <option value="부장">부장</option>
                        <option value="이사">이사</option>
                        <option value="상무">상무</option>
                        <option value="전무">전무</option>
                        <option value="부사장">부사장</option>
                        <option value="사장">사장</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><input type="text" name="email" id="email" placeholder="이메일 입력" onblur="checkEmail()"></td>
                <th>전화번호</th>
                <td><input type="text" name="phone" placeholder="전화번호 입력"></td>
            </tr>
            <tr>
                <th>주민등록번호</th>
                <td><input type="text" name="empNo" placeholder="주민등록번호 입력"></td>
                <th>입사일</th>
                <td><input type="date" name="hireDate"></td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">
                    <input type="text" name="address" placeholder="주소 입력" style="width: 100%;">
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td><input type="password" name="empPwd" placeholder="비밀번호 입력"></td>
                <th>비밀번호 확인</th>
                <td><input type="password" name="confirmPassword" placeholder="비밀번호 입력"></td>
            </tr>
        </table>

        <button type="submit" class="btn-submit">사용자 등록</button>
    </form>
</div>

</body>
</html>
