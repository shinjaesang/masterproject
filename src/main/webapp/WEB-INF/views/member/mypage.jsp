<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 정보 관리</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="${pageContext.request.contextPath}/resources/img/favicon.ico" rel="icon">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
    <style>
        .mypage-title { font-size: 2rem; font-weight: bold; margin-bottom: 1.5rem; }
        .mypage-section { background: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .mypage-form-group { margin-bottom: 15px; }
        .mypage-label { font-weight: 500; color: #333; }
        .mypage-input { width: 100%; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px; }
        .mypage-input:focus { border-color: #80bdff; box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25); }
        .mypage-btn { padding: 8px 20px; border-radius: 4px; font-weight: 500; }
        .mypage-btn-primary { background: #007bff; border: none; color: #fff; }
        .mypage-btn-primary:hover { background: #0069d9; }
        .mypage-btn-outline { border: 1px solid #007bff; color: #007bff; background: transparent; }
        .mypage-btn-outline:hover { background: #007bff; color: #fff; }
    </style>
</head>
<body>
<div class="container-fluid position-relative bg-white d-flex p-0">
    <!-- Sidebar Start -->
    <jsp:include page="../common/sidebar.jsp" />
    <!-- Sidebar End -->
    <!-- Content Start -->
    <div class="content">
        <!-- Navbar Start -->
        <jsp:include page="../common/navbar.jsp" />
        <!-- Navbar End -->
        <div class="container-fluid pt-4 px-4">
            <div class="row g-4">
                <div class="col-12">
                    <div class="bg-light rounded h-100 p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">내 정보 관리</h4>
                        </div>

                        <!-- 개인정보 설정 -->
                        <div class="mypage-section">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h5 class="mb-0">개인정보 설정</h5>
                                <button type="button" class="btn btn-outline-primary" id="editToggleBtn">
                                    <i class="fas fa-edit me-1"></i>수정하기
                                </button>
                            </div>
                            <form id="personalInfoForm">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mypage-form-group">
                                            <label class="mypage-label" for="name">이름</label>
                                            <input type="text" class="form-control mypage-input" id="name" value="${member.empName}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mypage-form-group">
                                            <label class="mypage-label" for="email">이메일</label>
                                            <input type="email" class="form-control mypage-input" id="email" value="${member.email}" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mypage-form-group">
                                            <label class="mypage-label" for="phone">전화번호</label>
                                            <input type="text" class="form-control mypage-input" id="phone" value="${member.phone}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mypage-form-group">
                                            <label class="mypage-label" for="address">주소</label>
                                            <input type="text" class="form-control mypage-input" id="address" value="${member.address}" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-end mt-4" id="saveButtonContainer" style="display: none;">
                                    <button type="button" class="btn btn-primary" id="saveBtn">저장하기</button>
                                    <button type="button" class="btn btn-secondary ms-2" id="cancelBtn">취소</button>
                                </div>
                            </form>
                        </div>

                        <!-- 보안 설정 -->
                        <div class="mypage-section">
                            <h5 class="mb-3">보안 설정</h5>
                            <div class="mypage-form-group">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="autoLogout">
                                    <label class="form-check-label" for="autoLogout">
                                        자동 로그아웃 <small class="text-muted">(일정 시간 동안 활동이 없으면 자동 로그아웃)</small>
                                    </label>
                                </div>
                            </div>
                            <div class="text-end">
                                <button type="button" class="btn mypage-btn mypage-btn-outline" id="pwChange">비밀번호 변경</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Content End -->
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script>
    $(document).ready(function() {
        let originalValues = {};
        
        // 수정하기 버튼 클릭 이벤트
        $('#editToggleBtn').click(function() {
            const isEditing = $(this).hasClass('editing');
            
            if (!isEditing) {
                // 수정 모드로 전환
                $(this).addClass('editing');
                $(this).html('<i class="fas fa-times me-1"></i>수정취소');
                
                // 원래 값 저장
                originalValues = {
                    email: $('#email').val(),
                    phone: $('#phone').val(),
                    address: $('#address').val()
                };
                
                // 입력 필드 활성화 (이름 제외)
                $('#email, #phone, #address').prop('readonly', false);
                
                // 저장 버튼 표시
                $('#saveButtonContainer').show();
            } else {
                // 수정 취소
                $(this).removeClass('editing');
                $(this).html('<i class="fas fa-edit me-1"></i>수정하기');
                
                // 원래 값으로 복원
                $('#email').val(originalValues.email);
                $('#phone').val(originalValues.phone);
                $('#address').val(originalValues.address);
                
                // 입력 필드 비활성화
                $('#email, #phone, #address').prop('readonly', true);
                
                // 저장 버튼 숨김
                $('#saveButtonContainer').hide();
            }
        });
        
        // 취소 버튼 클릭 이벤트
        $('#cancelBtn').click(function() {
            $('#editToggleBtn').click(); // 수정 취소 버튼 클릭과 동일한 효과
        });
        
        // 저장 버튼 클릭 이벤트
        $('#saveBtn').click(function() {
            // 이메일 유효성 검사
            const email = $('#email').val();
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert('올바른 이메일 형식이 아닙니다.');
                return;
            }
            const phone = $('#phone').val();
            const address = $('#address').val();
            $.ajax({
                url: '${pageContext.request.contextPath}/member/updateMyInfo.do',
                type: 'POST',
                data: {
                    email: email,
                    phone: phone,
                    address: address
                },
                success: function(response) {
                    if(response === 'success') {
                        alert('개인정보가 저장되었습니다.');
                        $('#editToggleBtn').click(); // 수정 모드 종료
                    } else {
                        alert('개인정보 저장에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    alert('개인정보 저장 중 오류가 발생했습니다.');
                }
            });
        });

        // 비밀번호 변경 버튼 클릭 시 passwordChange.do로 이동
        $('#pwChange').click(function() {
            window.location.href = '${pageContext.request.contextPath}/member/passwordChange.do';
        });
    });
</script>
</body>
</html> 