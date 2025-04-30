<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>first</title>
<style type="text/css">
table th { background-color: #9ff; }
table#outer { border: 2px solid navy; }
</style>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
function validate() {
    // 입력값 유효성 검사
    var pwdValue = $('#userPwd').val();
    var pwdValue2 = document.getElementById('userPwd2').value;

    // 암호와 암호확인 일치 여부
    if (pwdValue !== pwdValue2) {
        alert('암호와 암호확인이 일치하지 않습니다. 다시 입력하세요.');
        $('#userPwd').val('');
        $('#userPwd2').val('');
        $('#userPwd').focus();
        return false;
    }

    // 암호 형식 검증 (최소 8자, 영문+숫자 포함)
    var pwdRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
    if (pwdValue && !pwdRegex.test(pwdValue)) {
        alert('암호는 최소 8자 이상이며, 영문자와 숫자를 포함해야 합니다.');
        $('#userPwd').val('');
        $('#userPwd2').val('');
        $('#userPwd').focus();
        return false;
    }

    return true;
}

window.onload = function() {
    var photofile = document.getElementById('photofile');
    photofile.addEventListener('change', function(event) {
        const files = event.currentTarget.files;
        const file = files[0];
        console.log(file.name);

        const photo = document.getElementById('photo');
        const reader = new FileReader();
        reader.onload = (e) => {
            photo.setAttribute('src', e.target.result);
            photo.setAttribute('data-file', file.name);
        };
        reader.readAsDataURL(file);
    });
};
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h1 align="center">내 정보 보기 페이지</h1>
<br>
<form action="${pageContext.request.contextPath}/mupdate.do" method="post" onsubmit="return validate();" enctype="multipart/form-data">
<input type="hidden" name="originalPwd" value="${requestScope.member.userPwd}">
<input type="hidden" name="ofile" value="${requestScope.ofile}">
<table id="outer" align="center" width="700" cellspacing="5" cellpadding="0">
    <tr><th colspan="2">등록된 회원님의 정보는 아래와 같습니다. <br>수정할 내용이 있으면 변경하고, 수정하기 버튼을 누르세요.</th></tr>
    <tr><th width="120">*아이디</th>
        <td><input type="text" name="userId" id="userId" value="${requestScope.member.userId}" readonly></td></tr>
    <tr><th>사진첨부</th>
        <td>
        <c:if test="${!empty requestScope.member.photoFileName}">
            <div id="myphoto" style="margin:0; width:150px; height:160px; padding:0; border:1px solid navy;">
                <img src="${pageContext.servletContext.contextPath}/resources/photoFiles/${requestScope.member.photoFileName}" id="photo" 
                    style="width:150px;height:160px;border:1px solid navy;display:block;margin:0;padding:0;" 
                    alt="사진을 드래그 드롭하세요.">
            </div> <br>
            ${requestScope.ofile} <br>
            변경할 사진 선택 : <input type="file" id="photofile" name="photofile">
        </c:if>
        <c:if test="${empty requestScope.member.photoFileName}">
            <div id="myphoto" style="margin:0; width:150px; height:160px; padding:0; border:1px solid navy;">
                <img src="${pageContext.servletContext.contextPath}/resources/images/photo1.jpg" id="photo" 
                    style="width:150px;height:160px;border:1px solid navy;display:block;margin:0;padding:0;" 
                    alt="사진을 드래그 드롭하세요.">
            </div> <br>
            사진 선택 : <input type="file" id="photofile" name="photofile">
        </c:if>
        </td></tr>
    <tr><th>*암호</th>
        <td><input type="password" name="userPwd" id="userPwd"></td></tr>
    <tr><th>*암호확인</th>
        <td><input type="password" id="userPwd2"></td></tr>
    <tr><th>*이름</th>
        <td><input type="text" name="userName" id="userName" value="${requestScope.member.userName}" readonly></td></tr>
    <tr><th>*성별</th>
        <td>
            <c:if test="${requestScope.member.gender eq 'M'}">
                <input type="radio" name="gender" value="M" checked> 남자 &nbsp;
                <input type="radio" name="gender" value="F"> 여자 
            </c:if>
            <c:if test="${requestScope.member.gender eq 'F'}">
                <input type="radio" name="gender" value="M"> 남자 &nbsp;
                <input type="radio" name="gender" value="F" checked> 여자 
            </c:if>
        </td></tr>
    <tr><th>*나이</th>
        <td><input type="number" name="age" min="19" max="100" value="${member.age}"></td></tr>
    <tr><th>*전화번호</th>
        <td><input type="tel" name="phone" value="${member.phone}"></td></tr>
    <tr><th>*이메일</th>
        <td><input type="email" name="email" value="${member.email}"></td></tr>
    <tr><th colspan="2">
        <input type="submit" value="수정하기"> &nbsp;
        <input type="reset" value="수정취소"> &nbsp;
        <c:url var="mdel" value="${pageContext.request.contextPath}/mdelete.do">
            <c:param name="userId" value="${requestScope.member.userId}"/>
        </c:url>
        <a href="${mdel}">탈퇴하기</a> &nbsp;
        <a href="${pageContext.request.contextPath}/main.do">Home</a>
    </th></tr>
</table>
</form>
<hr style="clear:both">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>