<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Stockmaster - 사원 정보 수정</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Heebo', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header h1 {
            font-size: 24px;
            font-weight: 600;
            color: #333;
        }

        .form-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -15px;
        }

        .form-col {
            flex: 0 0 50%;
            padding: 0 15px;
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #495057;
        }

        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

        .form-control:focus {
            border-color: #80bdff;
            outline: 0;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }

        .form-select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
            background-color: #fff;
            cursor: pointer;
        }

        .form-select:focus {
            border-color: #80bdff;
            outline: 0;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.15s ease-in-out;
        }

        .btn-primary {
            background-color: #0d6efd;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #0b5ed7;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: #fff;
        }

        .btn-secondary:hover {
            background-color: #5c636a;
        }

        .btn-danger {
            background-color: #dc3545;
            color: #fff;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .btn-group {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .spinner {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255,255,255,0.8);
            z-index: 9999;
        }

        .spinner-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }

        .spinner-icon {
            width: 3rem;
            height: 3rem;
            border: 0.25em solid #0d6efd;
            border-right-color: transparent;
            border-radius: 50%;
            animation: spinner-border 0.75s linear infinite;
        }

        @keyframes spinner-border {
            to { transform: rotate(360deg); }
        }

        .back-to-top {
            position: fixed;
            right: 30px;
            bottom: 30px;
            width: 40px;
            height: 40px;
            background-color: #0d6efd;
            color: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .back-to-top.show {
            opacity: 1;
        }

        .back-to-top:hover {
            background-color: #0b5ed7;
            color: #fff;
        }
    </style>
</head>

<body>
    <!-- Spinner -->
    <div class="spinner" id="spinner">
        <div class="spinner-content">
            <div class="spinner-icon"></div>
        </div>
    </div>

    <!-- Header -->
    <div class="header">
        <h1>사원 정보 수정</h1>
        <button class="btn btn-secondary" onclick="history.back()">
            <i class="fas fa-arrow-left"></i> 뒤로가기
        </button>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="form-container">
            <form id="editMemberForm" action="${pageContext.request.contextPath}/member/updateMember.do" method="post">
                <input type="hidden" name="empId" value="${member.empId}">
                
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="empName" class="form-label">이름</label>
                            <input type="text" class="form-control" id="empName" name="empName" value="${member.empName}" required>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="email" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="email" name="email" value="${member.email}" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="department" class="form-label">부서</label>
                            <select class="form-select" id="department" name="department" required>
                                <option value="">부서 선택</option>
                                <option value="경영지원부" <c:if test="${member.department eq '경영지원부'}">selected</c:if>>경영지원부</option>
                                <option value="개발부" <c:if test="${member.department eq '개발부'}">selected</c:if>>개발부</option>
                                <option value="물류부" <c:if test="${member.department eq '물류부'}">selected</c:if>>물류부</option>
                                <option value="영업부" <c:if test="${member.department eq '영업부'}">selected</c:if>>영업부</option>
                                <option value="인사부" <c:if test="${member.department eq '인사부'}">selected</c:if>>인사부</option>
                                <option value="재무부" <c:if test="${member.department eq '재무부'}">selected</c:if>>재무부</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="job" class="form-label">직급</label>
                            <select class="form-select" id="job" name="job" required>
                                <option value="">직급 선택</option>
                                <option value="사원" <c:if test="${member.job eq '사원'}">selected</c:if>>사원</option>
                                <option value="대리" <c:if test="${member.job eq '대리'}">selected</c:if>>대리</option>
                                <option value="과장" <c:if test="${member.job eq '과장'}">selected</c:if>>과장</option>
                                <option value="부장" <c:if test="${member.job eq '부장'}">selected</c:if>>부장</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-col">
                        <div class="form-group">
                            <label for="hireDate" class="form-label">입사일</label>
                            <input type="date" class="form-control" id="hireDate" name="hireDate" value="${member.hireDate}" required>
                        </div>
                    </div>
                    <div class="form-col">
                        <div class="form-group">
                            <label for="isActive" class="form-label">계정 상태</label>
                            <select class="form-select" id="isActive" name="isActive" required>
                                <option value="Y" <c:if test="${member.isActive eq 'Y'}">selected</c:if>>활성</option>
                                <option value="N" <c:if test="${member.isActive eq 'N'}">selected</c:if>>비활성</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Back to Top Button -->
    <a href="#" class="back-to-top" id="backToTop">
        <i class="fas fa-arrow-up"></i>
    </a>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 스피너 숨기기
            document.getElementById('spinner').style.display = 'none';
            
            // 스크롤 이벤트 처리
            window.addEventListener('scroll', function() {
                const backToTop = document.getElementById('backToTop');
                if (window.pageYOffset > 100) {
                    backToTop.classList.add('show');
                } else {
                    backToTop.classList.remove('show');
                }
            });

            // Back to Top 버튼 클릭 이벤트
            document.getElementById('backToTop').addEventListener('click', function(e) {
                e.preventDefault();
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
        });

        function validateForm() {
            const empName = document.getElementById('empName').value;
            const email = document.getElementById('email').value;
            const department = document.getElementById('department').value;
            const job = document.getElementById('job').value;
            const hireDate = document.getElementById('hireDate').value;

            if (!empName || !email || !department || !job || !hireDate) {
                alert('모든 필수 항목을 입력해주세요.');
                return false;
            }

            // 이메일 형식 검사
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert('올바른 이메일 형식을 입력해주세요.');
                return false;
            }

            return true;
        }

        // 폼 제출 처리
        document.getElementById('editMemberForm').addEventListener('submit', function(e) {
            e.preventDefault();
            if (!validateForm()) {
                return;
            }

            const formData = {
                empId: document.querySelector('input[name="empId"]').value,
                empName: document.getElementById('empName').value,
                email: document.getElementById('email').value,
                department: document.getElementById('department').value,
                job: document.getElementById('job').value,
                hireDate: document.getElementById('hireDate').value,
                isActive: document.getElementById('isActive').value
            };

            // 스피너 표시
            document.getElementById('spinner').style.display = 'block';

            $.ajax({
                url: '${pageContext.request.contextPath}/member/updateMember.do',
                type: 'POST',
                data: formData,
                success: function(response) {
                    document.getElementById('spinner').style.display = 'none';
                    alert('사원 정보가 성공적으로 수정되었습니다.');
                    
                    // auth-management.jsp 페이지로 이동
                    window.location.href = '${pageContext.request.contextPath}/authority/list.do';
                },
                error: function(xhr, status, error) {
                    document.getElementById('spinner').style.display = 'none';
                    alert('사원 정보 수정 중 오류가 발생했습니다.');
                    console.error('Error:', error);
                }
            });
        });
    </script>
</body>
</html> 